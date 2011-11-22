//
//  Enemy.m
//  DefendDokdo
//
//  Created by 전 수열 on 11. 11. 1..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import "Enemy.h"
#import "Const.h"
#import "GameScene.h"
#import "Flag.h"

@interface Enemy(Private)
- (void)initBoatAnimation;
- (void)initFlightAnimation;
- (void)initSwimAnimation;
- (void)initWalkAnimation;
- (void)initAttackAnimation;
- (void)initCatchAnimation;
- (void)initFallAnimation;
- (void)initHitAnimation;
- (void)initDieAnimation;
- (void)initExplosionAnimation;

- (void)startBoating;
- (void)startFlight;
- (void)startSwimming;
- (void)startWalking;
- (void)startAttack;
- (void)startBeingCaught;
- (void)startFalling;
- (void)startBeingHit;
- (void)startDying;
- (void)startExplosion;

- (void)stopBoating;
- (void)stopFlight;
- (void)stopSwimming;
- (void)stopWalking;
- (void)stopAttack;
- (void)stopBeingCaught;
- (void)stopFalling;
- (void)stopBeingHit;
- (void)stopBeingHit:(id)sender;
- (void)stopDying;
- (void)stopDying:(id)sender;
- (void)stopExplosion;
- (void)stopExplosion:(id)sender;

- (void)stopCurrentAction;

- (float)getGroundY;
- (BOOL)getPlaneExists;
- (void)setPlaneExists;
@end


@implementation Enemy

@synthesize type, level;
@synthesize maxHp, hp, power, speed;
@synthesize x = _x, y = _y, dx, dy, boundingBox;

#pragma mark - initialize

- (id)initWithGameScene:(GameScene *)scene type:(NSInteger)_type level:(NSInteger)_level hp:(NSInteger)_hp power:(NSInteger)_power speed:(CGFloat)_speed
{
	if( self = [self init] )
	{
		gameScene = scene;
		
		type = _type;
		level = _level;
		
		gapX = (NSInteger)( arc4random() % 20 ) - 10;
		gapY = -1 * (NSInteger)( arc4random() % 20 );
		
		self.hp = self.maxHp = _hp;
		self.power = _power;
		self.speed = _speed;
		
		// 처음 방향 - 비행기 계속 날아갈 때 필요
		if( arc4random() % 2 )
		{
			self.x = -50;
			firstDirection = DIRECTION_STATE_LEFT;
		}
		else
		{
			self.x = 530;
			firstDirection = DIRECTION_STATE_RIGHT;
		}
		self.x += gapX;
		self.y = 320 + gapY;
		
		dx = dy = 0;
		
		enemySpr = [[CCSprite alloc] init];
		enemySpr.anchorPoint = ccp( 0.5f, 0 );
		[gameScene.gameLayer addChild:enemySpr z:Z_ENEMY];
		
		// 공통 애니메이션
		[self initWalkAnimation];
		[self initCatchAnimation];
		[self initFallAnimation];
		
		// 카미카제에만 해당하는 애니메이션
		if( type == ENEMY_TYPE_KAMIKAZE )
		{
			[self initFlightAnimation];
			[self initExplosionAnimation];
			
			[self startFlight];
		}
		else
		{
			[self initBoatAnimation];
			[self initSwimAnimation];
			[self initAttackAnimation];
			[self initHitAnimation];
			[self initDieAnimation];
			
			[self startBoating];
		}
	}
	
	return self;
}

- (void)initBoatAnimation
{
	[[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:[NSString stringWithFormat:@"enemy_%d_%d_boat.plist", type, level]];
	
	boatEnemySpr = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"enemy_%d_%d_boat_0.png", type, level]];
	boatEnemySpr.anchorPoint = ccp( 0.5f, 0 );
	
	boatBatchNode = [[CCSpriteBatchNode batchNodeWithFile:[NSString stringWithFormat:@"enemy_%d_%d_boat.png", type, level]] retain];
	[boatBatchNode addChild:boatEnemySpr];
	
	NSMutableArray *aniFrames = [[NSMutableArray alloc] init];
	for( NSInteger i = 0; i < 7; i++ )
	{
		CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"enemy_%d_%d_boat_%d.png", type, level, i]];
		[aniFrames addObject:frame];
	}
	
	CCAnimation *animation = [CCAnimation animationWithFrames:aniFrames delay:0.1f];
	boatAnimation = [[CCAnimate alloc] initWithAnimation:animation restoreOriginalFrame:NO];
}

- (void)initFlightAnimation
{
	[[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:[NSString stringWithFormat:@"enemy_%d_%d_flight.plist", ENEMY_TYPE_KAMIKAZE, level]];
	
	flightEnemySpr = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"enemy_%d_%d_flight_0.png", ENEMY_TYPE_KAMIKAZE, level]];
	flightEnemySpr.anchorPoint = ccp( 0.5f, 0 );
	
	flightBatchNode = [[CCSpriteBatchNode batchNodeWithFile:[NSString stringWithFormat:@"enemy_%d_%d_flight.png", ENEMY_TYPE_KAMIKAZE, level]] retain];
	[flightBatchNode addChild:flightEnemySpr];
	
	NSMutableArray *aniFrames = [[NSMutableArray alloc] init];
	for( NSInteger i = 0; i < 4; i++ )
	{
		CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"enemy_%d_%d_flight_%d.png", ENEMY_TYPE_KAMIKAZE, level, i]];
		[aniFrames addObject:frame];
	}
	
	CCAnimation *animation = [CCAnimation animationWithFrames:aniFrames delay:0.04f];
	flightAnimation = [[CCAnimate alloc] initWithAnimation:animation restoreOriginalFrame:NO];
}

- (void)initSwimAnimation
{
	[[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:[NSString stringWithFormat:@"enemy_%d_%d_swim.plist", type, level]];
	
	swimEnemySpr = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"enemy_%d_%d_swim_00.png", type, level]];
	swimEnemySpr.anchorPoint = ccp( 0.5f, 0 );
	
	swimBatchNode = [[CCSpriteBatchNode batchNodeWithFile:[NSString stringWithFormat:@"enemy_%d_%d_swim.png", type, level]] retain];
	[swimBatchNode addChild:swimEnemySpr];
	
	NSMutableArray *aniFrames = [[NSMutableArray alloc] init];
	for( int i = 0; i < 11; i++ )
	{
		CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"enemy_%d_%d_swim_%02d.png", type, level, i]];
		[aniFrames addObject:frame];
	}
	
	CCAnimation *animation = [CCAnimation animationWithFrames:aniFrames delay:0.08f];
	swimAnimation = [[CCAnimate alloc] initWithAnimation:animation restoreOriginalFrame:NO];
}

- (void)initWalkAnimation
{
	[[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:[NSString stringWithFormat:@"enemy_%d_%d_walk.plist", type, level]];
	
	walkEnemySpr = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"enemy_%d_%d_walk_0.png", type, level]];
	walkEnemySpr.anchorPoint = ccp( 0.5f, 0 );
	
	walkBatchNode = [[CCSpriteBatchNode batchNodeWithFile:[NSString stringWithFormat:@"enemy_%d_%d_walk.png", type, level]] retain];
	[walkBatchNode addChild:walkEnemySpr];
	
	NSMutableArray *aniFrames = [[NSMutableArray alloc] init];
	for( NSInteger i = 0; i < 4; i++ )
	{
		CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"enemy_%d_%d_walk_%d.png", type, level, i]];
		[aniFrames addObject:frame];
	}
	
	CCAnimation *animation = [CCAnimation animationWithFrames:aniFrames delay:0.08f];
	walkAnimation = [[CCAnimate alloc] initWithAnimation:animation restoreOriginalFrame:NO];
}

- (void)initAttackAnimation
{
	[[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:[NSString stringWithFormat:@"enemy_%d_%d_attack.plist", type, level]];
	
	attackEnemySpr = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"enemy_%d_%d_attack_0.png", type, level]];
	attackEnemySpr.anchorPoint = ccp( 0.5f, 0 );
	
	attackBatchNode = [[CCSpriteBatchNode batchNodeWithFile:[NSString stringWithFormat:@"enemy_%d_%d_attack.png", type, level]] retain];
	[attackBatchNode addChild:attackEnemySpr];
	
	NSMutableArray *aniFrames = [[NSMutableArray alloc] init];
	for( NSInteger i = 0; i < 7; i++ )
	{
		CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"enemy_%d_%d_attack_%d.png", type, level, i]];
		[aniFrames addObject:frame];
	}
	
	CCAnimation *animation = [CCAnimation animationWithFrames:aniFrames delay:0.08f];
	attackAnimation = [[CCAnimate alloc] initWithAnimation:animation restoreOriginalFrame:NO];
}

- (void)initCatchAnimation
{
	[[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:[NSString stringWithFormat:@"enemy_%d_%d_catch.plist", type, level]];
	
	catchEnemySpr = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"enemy_%d_%d_catch_0.png", type, level]];
	catchEnemySpr.anchorPoint = ccp( 0.5f, 0 );
	
	catchBatchNode = [[CCSpriteBatchNode batchNodeWithFile:[NSString stringWithFormat:@"enemy_%d_%d_catch.png", type, level]] retain];
	[catchBatchNode addChild:catchEnemySpr];
	
	NSMutableArray *aniFrames = [[NSMutableArray alloc] init];
	for( NSInteger i = 0; i < 10; i++ )
	{
		CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"enemy_%d_%d_catch_%d.png", type, level, i]];
		[aniFrames addObject:frame];
	}
	
	CCAnimation *animation = [CCAnimation animationWithFrames:aniFrames delay:0.08f];
	catchAnimation = [[CCAnimate alloc] initWithAnimation:animation restoreOriginalFrame:NO];
}

- (void)initFallAnimation
{
	[[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:[NSString stringWithFormat:@"enemy_%d_%d_fall.plist", type, level]];
	
	fallEnemySpr = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"enemy_%d_%d_fall_0.png", type, level]];
	fallEnemySpr.anchorPoint = ccp( 0.5f, 0 );
	
	fallBatchNode = [[CCSpriteBatchNode batchNodeWithFile:[NSString stringWithFormat:@"enemy_%d_%d_fall.png", type, level]] retain];
	[fallBatchNode addChild:fallEnemySpr];
	
	NSMutableArray *aniFrames = [[NSMutableArray alloc] init];
	for( NSInteger i = 0; i < 4; i++ )
	{
		CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"enemy_%d_%d_fall_%d.png", type, level, i]];
		[aniFrames addObject:frame];
	}
	
	CCAnimation *animation = [CCAnimation animationWithFrames:aniFrames delay:0.06f];
	fallAnimation = [[CCAnimate alloc] initWithAnimation:animation restoreOriginalFrame:NO];
}

- (void)initHitAnimation
{
	[[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:[NSString stringWithFormat:@"enemy_%d_%d_hit.plist", type, level]];
	
	hitEnemySpr = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"enemy_%d_%d_hit_0.png", type, level]];
	hitEnemySpr.anchorPoint = ccp( 0.5f, 0 );
	
	hitBatchNode = [[CCSpriteBatchNode batchNodeWithFile:[NSString stringWithFormat:@"enemy_%d_%d_hit.png", type, level]] retain];
	[hitBatchNode addChild:hitEnemySpr];
	
	NSMutableArray *aniFrames = [[NSMutableArray alloc] init];
	for( NSInteger i = 0; i < 1; i++ )
	{
		CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"enemy_%d_%d_hit_%d.png", type, level, i]];
		[aniFrames addObject:frame];
	}
	
	CCAnimation *animation = [CCAnimation animationWithFrames:aniFrames delay:0.3f];
	hitAnimation = [[CCAnimate alloc] initWithAnimation:animation restoreOriginalFrame:NO];
}

- (void)initDieAnimation
{
	[[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:[NSString stringWithFormat:@"enemy_%d_%d_die.plist", type, level]];
	
	dieEnemySpr = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"enemy_%d_%d_die_0.png", type, level]];
	dieEnemySpr.anchorPoint = ccp( 0.5f, 0 );
	
	dieBatchNode = [[CCSpriteBatchNode batchNodeWithFile:[NSString stringWithFormat:@"enemy_%d_%d_die.png", type, level]] retain];
	[dieBatchNode addChild:dieEnemySpr];
	
	NSMutableArray *aniFrames = [[NSMutableArray alloc] init];
	for( NSInteger i = 0; i < 8; i++ )
	{
		CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"enemy_%d_%d_die_%d.png", type, level, i]];
		[aniFrames addObject:frame];
	}
	
	CCAnimation *animation = [CCAnimation animationWithFrames:aniFrames delay:0.08f];
	dieAnimation = [[CCAnimate alloc] initWithAnimation:animation restoreOriginalFrame:NO];
}

- (void)initExplosionAnimation
{
	[[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:[NSString stringWithFormat:@"enemy_%d_%d_explosion.plist", ENEMY_TYPE_KAMIKAZE, level]];
	
	explosionEnemySpr = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"enemy_%d_%d_explosion_00.png", ENEMY_TYPE_KAMIKAZE, level]];
	explosionEnemySpr.anchorPoint = ccp( 0.5f, 0.2f );
	
	explosionBatchNode = [[CCSpriteBatchNode batchNodeWithFile:[NSString stringWithFormat:@"enemy_%d_%d_explosion.png", ENEMY_TYPE_KAMIKAZE, level]] retain];
	[explosionBatchNode addChild:explosionEnemySpr];
	
	NSMutableArray *aniFrames = [[NSMutableArray alloc] init];
	for( NSInteger i = 0; i < 30; i++ )
	{
		CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"enemy_%d_%d_explosion_%02d.png", ENEMY_TYPE_KAMIKAZE, level, i]];
		[aniFrames addObject:frame];
	}
	
	CCAnimation *animation = [CCAnimation animationWithFrames:aniFrames delay:0.03f];
	explosionAnimation = [[CCAnimate alloc] initWithAnimation:animation restoreOriginalFrame:NO];
}


#pragma mark - getter/setter

- (float)getX
{
	return _x;
}

- (void)setX:(float)x
{
	enemySpr.position = ccp( _x = x, _y );
}

- (float)getY
{
	return _y;
}

- (void)setY:(float)y
{
	enemySpr.position = ccp( _x, _y = y );
}

- (CGRect)getBoundingBox
{
	return CGRectMake( self.x - 20, self.y - 40, 40, 40 );
}

- (float)getGroundY
{
	if( self.x + gapX < FLAG_LEFT_X )
		return ( self.x + gapX - 110 ) * 31 / 23 + 50 + sinf( ( self.x + gapX ) / 10 ) * 3;
	
	if( FLAG_RIGHT_X < self.x + gapX )
		return -1 * ( self.x + gapX - 360 ) * 31 / 20 + 50 + cosf( ( self.x + gapX ) / 10 ) * 3;
	
	return TOP_Y;
}

- (BOOL)getPlaneExists
{
	return isFlightExists;
}

- (void)setPlaneExists:(BOOL)isExists
{
	isFlightExists = isExists;
	
	// 더이상 날아가지 않게
	if( !isExists )
	{
		[flightEnemySpr stopAllActions];
		[gameScene.gameLayer removeChild:flightBatchNode cleanup:YES];
		[flightBatchNode release];
		[flightEnemySpr release];
		[flightAnimation release];
	}
}


#pragma mark - update

- (void)update
{
	// 비행기 계속 날아가게
	if( isFlightExists && type == ENEMY_TYPE_KAMIKAZE && state != ENEMY_STATE_FLIGHT )
	{
		if( firstDirection == DIRECTION_STATE_LEFT ) // 왼쪽에서 시작
		{
			flightEnemySpr.position = ccp( flightEnemySpr.position.x + self.speed, PLANE_Y + gapY * 3 );
			
			// 화면 밖으로 나가면 제거
			if( flightEnemySpr.position.x < -50 )
				[self setPlaneExists:NO];
		}
		else // 오른쪽에서 시작
		{
			flightEnemySpr.position = ccp( flightEnemySpr.position.x - self.speed, PLANE_Y + gapY * 3 );

			// 화면 밖으로 나가면 제거
			if( flightEnemySpr.position.x > 530 )
				[self setPlaneExists:NO];
		}
	}
	
	switch( state )
	{
		case ENEMY_STATE_BOAT:
			if( self.x + gapX < DOKDO_LEFT_X )
			{
				boatEnemySpr.flipX = NO;
				self.x += self.speed;
				self.y = SEA_Y + gapY;
			}
			else if( self.x + gapX > DOKDO_RIGHT_X )
			{
				boatEnemySpr.flipX = YES;
				self.x -= self.speed;
				self.y = SEA_Y + gapY;
			}
			else
			{
				[self stopBoating];
				[self startWalking];
			}
			break;
			
		case ENEMY_STATE_FLIGHT:
			// 떨어뜨리기
			if( self.y + gapY - [self getGroundY] < 110 && ( DOKDO_LEFT_X < self.x + gapX && self.x + gapX < DOKDO_RIGHT_X ) )
			{
				fallWithNoDamage = YES;
				[self stopFlight];
				[self startFalling];
			}
			else
			{
				if( self.x + gapX < FLAG_X )
				{
					flightEnemySpr.flipX = NO;
					self.x += self.speed;
					self.y = PLANE_Y + gapY;
				}
				else
				{
					flightEnemySpr.flipX = YES;
					self.x -= self.speed;
					self.y = PLANE_Y + gapY;
				}

			}
			break;
			
		case ENEMY_STATE_SWIM:
			if( self.x + gapX < DOKDO_LEFT_X )
			{
				swimEnemySpr.flipX = NO;
				self.x += self.speed / 2;
				self.y = SEA_Y + gapY;
			}
			else if( self.x + gapX > DOKDO_RIGHT_X )
			{
				swimEnemySpr.flipX = YES;
				self.x -= self.speed / 2;
				self.y = SEA_Y + gapY;
			}
			else
			{
				[self stopSwimming];
				[self startWalking];
			}
			break;
			
		case ENEMY_STATE_WALK:		
			if( DOKDO_LEFT_X <= self.x + gapX && self.x + gapX < FLAG_LEFT_X )
			{
				walkEnemySpr.flipX = NO;
				self.x += self.speed / 2;
				self.y = ( self.x + gapX - 110 ) * 31 / 23 + 50 + sinf( ( self.x + gapX ) / 10 ) * 3 + gapY;
			}
			else if( FLAG_RIGHT_X < self.x + gapX && self.x + gapX <= DOKDO_RIGHT_X )
			{
				walkEnemySpr.flipX = YES;
				self.x -= self.speed / 2;
				self.y = -1 * ( self.x + gapX - 360 ) * 31 / 20 + 50 + cosf( ( self.x + gapX ) / 10 ) * 3 + gapY;
			}
			else
			{
				[self stopWalking];
				
				// 카미카제는 공격 없이 바로 폭발
				if( type != ENEMY_TYPE_KAMIKAZE )
					[self startAttack];
				else
					[self startExplosion];
			}
			break;
			
		case ENEMY_STATE_ATTACK:
			if( FLAG_LEFT_X <= self.x + gapX && self.x + gapX <= FLAG_X )
			{
				attackEnemySpr.flipX = NO;
//				gameScene.flag.hp -= self.power;
			}
			else if( FLAG_X <= self.x + gapX && self.x + gapX <= FLAG_RIGHT_X )
			{
				attackEnemySpr.flipX = YES;
//				gameScene.flag.hp -= self.power;
			}
			else
			{
				[self stopAttack];
			}
			break;
			
		case ENEMY_STATE_CATCH:
			break;
			
		case ENEMY_STATE_FALL:
			if( self.y - gapY >= SEA_Y )
			{
				dx -= AIR_RESISTANCE * dx;
				dy -= GRAVITY;
				
				self.x += dx;
				self.y += dy;
				
				// 땅에 철푸덕
				if( self.y - gapY < [self getGroundY] )
				{
					[self stopFalling];
					
					// 데미지 없이 떨어지는게 아니면 데미지를 입음
					if( !fallWithNoDamage )
					{
						[self beDamaged:-1 * dy]; // temp damage
					}
					// 데미지 없이 떨어짐
					else
					{
						[self startWalking];
						fallWithNoDamage = NO;
					}
				}
				
				// 입수
				else if( self.y - gapY <= SEA_Y )
				{
					dx = 0;
					dy *= WATER_RESISTANCE;
					
					// 데미지 없이 떨어지는게 아니면 데미지를 입음
					if( !fallWithNoDamage )
					{
						[self beDamaged:-1 * dy]; // temp damage
						if( self.hp <= 0 )
						{
							[self stopFalling];
							[self startDying];
						}
					}
				}
			}
			else
			{
				// 물에서 위로 올라가기
				if( self.y + dy - gapY <= SEA_Y )
				{
					NSLog( @"물 위로 올라가자 어푸어푸" );
					dy += BUOYANCY;
					self.y += dy;
				}
				// 수면 위로 뿅
				else
				{
					NSLog( @"수면위로 뿅" );
					[self stopFalling];
					[self startSwimming];
				}
			}
			break;
			
		case ENEMY_STATE_HIT:
			if( self.x + gapX < FLAG_X )
				hitEnemySpr.flipX = NO;
			else
				hitEnemySpr.flipX = YES;
			break;
			
		case ENEMY_STATE_DIE:
			if( self.x + gapX < FLAG_X )
				dieEnemySpr.flipX = NO;
			else
				dieEnemySpr.flipX = YES;
			
			// 물에서 죽으면 꼬르륵 하면서 물 밑으로 내려감
			if( self.x + gapX < DOKDO_LEFT_X || DOKDO_RIGHT_X < self.x + gapX )
			{
				self.y += dy;
				
				if( self.y + fallEnemySpr.contentSize.height + gapY < 0 )
					[self stopDying];
			}
			break;
	}
}


#pragma mark - start actions

- (void)startBoating
{
	state = ENEMY_STATE_BOAT;
	[enemySpr addChild:boatBatchNode];
	[boatEnemySpr runAction:[CCRepeatForever actionWithAction:boatAnimation]];
}

- (void)startFlight
{
	state = ENEMY_STATE_FLIGHT;
	[enemySpr addChild:flightBatchNode];
	[flightEnemySpr runAction:[CCRepeatForever actionWithAction:flightAnimation]];
	isFlightExists = YES;
}

- (void)startSwimming
{
	state = ENEMY_STATE_SWIM;
	[enemySpr addChild:swimBatchNode];
	[swimEnemySpr runAction:[CCRepeatForever actionWithAction:swimAnimation]];
}

- (void)startWalking
{
	state = ENEMY_STATE_WALK;
	[enemySpr addChild:walkBatchNode];
	[walkEnemySpr runAction:[CCRepeatForever actionWithAction:walkAnimation]];
}

- (void)startAttack
{
	state = ENEMY_STATE_ATTACK;
	[enemySpr addChild:attackBatchNode];
	[attackEnemySpr runAction:[CCRepeatForever actionWithAction:attackAnimation]];
}

- (void)startBeingCaught
{
	state = ENEMY_STATE_CATCH;
	[enemySpr addChild:catchBatchNode];
	[catchEnemySpr runAction:[CCRepeatForever actionWithAction:catchAnimation]];
}

- (void)startFalling
{
	state = ENEMY_STATE_FALL;
	[enemySpr addChild:fallBatchNode];
	[fallEnemySpr runAction:[CCRepeatForever actionWithAction:fallAnimation]];
}

- (void)startBeingHit
{
	state = ENEMY_STATE_HIT;
	[enemySpr addChild:hitBatchNode];
	[hitEnemySpr runAction:[CCSequence actions:hitAnimation, [CCCallFunc actionWithTarget:self selector:@selector(stopBeingHit:)], nil]];
}

- (void)startDying
{
	if( state == ENEMY_STATE_DIE ) return;
	
	state = ENEMY_STATE_DIE;
	
	// 물에서 죽으면 Fall 애니메이션으로 꼬르륵 거리면서 물 밑으로 내려감
	if( self.x + gapX < DOKDO_LEFT_X || DOKDO_RIGHT_X < self.x + gapX )
	{
		dy = -1 * GRAVITY;
		[enemySpr addChild:fallBatchNode];
		[fallEnemySpr runAction:[CCRepeatForever actionWithAction:fallAnimation]];
	}
	else
	{
		[enemySpr addChild:dieBatchNode];
		[dieEnemySpr runAction:[CCSequence actions:dieAnimation, [CCCallFunc actionWithTarget:self selector:@selector(stopDying:)], nil]];
	}
}

- (void)startExplosion
{
	state = ENEMY_STATE_EXPLOSION;
	[enemySpr addChild:explosionBatchNode];
	[explosionEnemySpr runAction:[CCSequence actions:explosionAnimation, [CCCallFunc actionWithTarget:self selector:@selector(stopExplosion:)], nil]];
}


#pragma mark - stop actions

- (void)stopBoating
{
	[boatEnemySpr stopAllActions];
	[enemySpr removeChild:boatBatchNode cleanup:YES];
}

- (void)stopFlight
{
	// enemySpr에서 제거하고 gameLayer에 추가해서 내린 후에도 계속 날아가게
	[enemySpr removeChild:flightBatchNode cleanup:NO];
	[gameScene.gameLayer addChild:flightBatchNode z:Z_PLANE];
	flightEnemySpr.position = ccp( self.x, PLANE_Y + gapY * 3 );
}

- (void)stopSwimming
{
	[swimEnemySpr stopAllActions];
	[enemySpr removeChild:swimBatchNode cleanup:NO];
}

- (void)stopWalking
{
	[walkEnemySpr stopAllActions];
	[enemySpr removeChild:walkBatchNode cleanup:NO];
}

- (void)stopAttack
{
	[attackEnemySpr stopAllActions];
	[enemySpr removeChild:attackBatchNode cleanup:NO];
}

- (void)stopBeingCaught
{
	[catchEnemySpr stopAllActions];
	[enemySpr removeChild:catchBatchNode cleanup:NO];
}

- (void)stopFalling
{
	[fallEnemySpr stopAllActions];
	[enemySpr removeChild:fallBatchNode cleanup:NO];
	dx = dy = 0;
}

- (void)stopBeingHit
{
	[hitEnemySpr stopAllActions];
	[enemySpr removeChild:hitBatchNode cleanup:NO];
}

- (void)stopBeingHit:(id)sender
{
	[self stopBeingHit];
	
	if( self.x + gapX < DOKDO_LEFT_X || DOKDO_RIGHT_X < self.x + gapX )
		[self startSwimming];
	else
		[self startWalking];
}

- (void)stopDying
{
	if( self.x + gapX < DOKDO_LEFT_X || DOKDO_RIGHT_X < self.x + gapX )
	{
		[fallEnemySpr stopAllActions];
		[enemySpr removeChild:fallBatchNode cleanup:NO];
	}
	else
	{
		[dieEnemySpr stopAllActions];
		[enemySpr removeChild:dieBatchNode cleanup:YES];
	}
	
	[gameScene.gameLayer removeChild:enemySpr cleanup:YES];
	
//	[self release];
}

- (void)stopDying:(id)sender
{
	[self stopDying];
}

- (void)stopExplosion
{
	[explosionEnemySpr stopAllActions];
	[enemySpr removeChild:explosionBatchNode cleanup:YES];
}

- (void)stopExplosion:(id)sender
{
	[self stopExplosion];
}

- (void)stopCurrentAction
{
	switch( state )
	{
		case ENEMY_STATE_BOAT:
			[self stopBoating];
			break;
			
		case ENEMY_STATE_FLIGHT:
			[self stopFlight];
			break;
			
		case ENEMY_STATE_SWIM:
			[self stopSwimming];
			break;
			
		case ENEMY_STATE_WALK:
			[self stopWalking];
			break;
			
		case ENEMY_STATE_ATTACK:
			[self stopAttack];
			break;
			
		case ENEMY_STATE_CATCH:
			[self stopBeingCaught];
			break;
			
		case ENEMY_STATE_FALL:
			[self stopFalling];
			break;
			
		case ENEMY_STATE_HIT:
			[self stopBeingHit];
			break;
			
		case ENEMY_STATE_DIE:
			[self stopDying];
			break;
			
		case ENEMY_STATE_EXPLOSION:
			[self stopExplosion];
			break;
	}
}


#pragma mark - public methods

- (void)applyForce:(float)x:(float)y
{
	if( state == ENEMY_STATE_CATCH || state == ENEMY_STATE_FALL || state == ENEMY_STATE_DIE )
		return;
	
	if( state != ENEMY_STATE_FALL )
	{
		[self stopCurrentAction];
		[self startFalling];
	}
	
	dx += x;
	dy += y;
}

- (void)beCaught
{
	[self stopCurrentAction];
	[self startBeingCaught];
}

- (void)beDamaged:(NSInteger)damage
{
	if( state == ENEMY_STATE_FLIGHT || state == ENEMY_STATE_DIE || state == ENEMY_STATE_EXPLOSION ) return;
	
	// 카미카제는 폭발
	if( type == ENEMY_TYPE_KAMIKAZE )
	{
		self.hp = 0;
		[self stopCurrentAction];
		[self startExplosion];
		return;
	}
	
	if( state != ENEMY_STATE_HIT )
		self.hp -= damage;
	
	[self stopCurrentAction];
	
	if( self.hp <= 0 )
	{
		[self startDying];
	}
	else
	{
		if( self.x + gapX < DOKDO_LEFT_X || DOKDO_RIGHT_X < self.x + gapX )
		{
			[self startSwimming];
		}
		else
		{
			[self startBeingHit];
		}
	}
}

- (void)beDamaged:(NSInteger)damage forceX:(NSInteger)forceX forceY:(NSInteger)forceY
{
	if( state == ENEMY_STATE_FLIGHT || state == ENEMY_STATE_FALL || state == ENEMY_STATE_DIE || state == ENEMY_STATE_EXPLOSION ) return;
	
	// 카미카제는 폭발
	if( type == ENEMY_TYPE_KAMIKAZE )
	{		
		self.hp = 0;
		[self stopCurrentAction];
		[self startExplosion];
		return;
	}
	
	if( state != ENEMY_STATE_HIT )
		self.hp -= damage;
	
	[self stopCurrentAction];
	
	if( self.hp <= 0 )
	{
		[self startDying];
	}
	else
	{
		fallWithNoDamage = YES;
		[self applyForce:forceX :forceY];
	}
}

@end
