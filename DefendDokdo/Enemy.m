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
#import "Player.h"
#import "SimpleAudioEngine.h"
#import "UserData.h"

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

- (void)initWaterEffectAnimation;

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

- (void)startWaterEffect;

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
- (void)stopExplosion;
- (void)stopCurrentAction;

- (void)stopWaterEffect;

- (void)attack;
- (void)onAttack:(id)sener;

- (CGFloat)getGroundY;
- (BOOL)getPlaneExists;
- (void)setPlaneExists;

- (void)remove;
@end


@implementation Enemy

@synthesize type, level, state;
@synthesize maxHp, hp, power, speed;
@synthesize x = _x, y = _y, dx, dy, boundingBox, touchBoundingBox, isPlaneExists;

#pragma mark - initialize

- (id)initWithGameScene:(GameScene *)scene type:(NSInteger)_type level:(NSInteger)_level hp:(NSInteger)_hp power:(NSInteger)_power speed:(CGFloat)_speed money:(NSInteger)_money
{
	if( self = [self init] )
	{
		gameScene = scene;
		
		type = _type;
		level = _level;
		
		gapX = (NSInteger)( arc4random() % 10 ) - 5;
		gapY = -1 * (NSInteger)( arc4random() % 20 );
		
		self.hp = self.maxHp = _hp;
		self.power = _power;
		self.speed = _speed;
		money = _money;
		
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
		
		hpGaugeBg = [[CCSprite alloc] initWithFile:@"enemyguage_bg.png"];
        hpGaugeBg.anchorPoint = ccp(0.0, 0.0);
		hpGaugeBg.position = ccp( -15.0, 50.0 );
        [enemySpr addChild:hpGaugeBg z:Z_ENEMY];
        
        hpGauge = [[CCSprite alloc] initWithFile:@"enemyguage.png"];
        hpGauge.anchorPoint = ccp(0.0, 0.0);
		hpGauge.position = ccp( -15.0, 50.0 );
        [enemySpr addChild:hpGauge z:Z_ENEMY];
		
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
			
			[self initWaterEffectAnimation];
			
			[self startBoating];
		}
	}
	
	return self;
}


#pragma mark - init animations

- (void)initBoatAnimation
{
	[[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:[NSString stringWithFormat:@"enemy_%d_%d_idle.plist", type, level]];
	
	boatEnemySpr = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"enemy_%d_%d_idle_0.png", type, level]];
	boatEnemySpr.anchorPoint = ccp( 0.5f, 0 );
	
	boatBatchNode = [[CCSpriteBatchNode batchNodeWithFile:[NSString stringWithFormat:@"enemy_%d_%d_idle.png", type, level]] retain];
	[boatBatchNode addChild:boatEnemySpr];
	
	NSMutableArray *aniFrames = [[[NSMutableArray alloc] init] autorelease];
	for( NSInteger i = 0; i < 1; i++ )
	{
		CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"enemy_%d_%d_idle_%d.png", type, level, i]];
		[aniFrames addObject:frame];
	}
	
	CCAnimation *animation = [CCAnimation animationWithFrames:aniFrames delay:0.1f];
	boatAnimation = [[CCAnimate alloc] initWithAnimation:animation restoreOriginalFrame:NO];
	
	boatSpr = [[CCSprite alloc] initWithFile:@"boat.png"];
	boatSpr.anchorPoint = ccp( 0.5f, -0.5f );
}

- (void)initFlightAnimation
{
	[[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"plane.plist"];
	
	flightEnemySpr = [CCSprite spriteWithSpriteFrameName:@"plane.png"];
	flightEnemySpr.anchorPoint = ccp( 0.5f, 0 );
	
	flightBatchNode = [[CCSpriteBatchNode batchNodeWithFile:@"plane.png"] retain];
	[flightBatchNode addChild:flightEnemySpr];
	
	NSMutableArray *aniFrames = [[[NSMutableArray alloc] init] autorelease];
	for( NSInteger i = 0; i < 1; i++ )
	{
		CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"plane.png", ENEMY_TYPE_KAMIKAZE, level, i]];
		[aniFrames addObject:frame];
	}
	
	CCAnimation *animation = [CCAnimation animationWithFrames:aniFrames delay:0.08f];
	flightAnimation = [[CCAnimate alloc] initWithAnimation:animation restoreOriginalFrame:NO];
}

- (void)initSwimAnimation
{
	[[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:[NSString stringWithFormat:@"enemy_%d_%d_swim.plist", type, level]];
	
	swimEnemySpr = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"enemy_%d_%d_swim_0.png", type, level]];
	swimEnemySpr.anchorPoint = ccp( 0.5f, 0 );
	
	swimBatchNode = [[CCSpriteBatchNode batchNodeWithFile:[NSString stringWithFormat:@"enemy_%d_%d_swim.png", type, level]] retain];
	[swimBatchNode addChild:swimEnemySpr];
	
	NSMutableArray *aniFrames = [[[NSMutableArray alloc] init] autorelease];
	for( int i = 0; i < 8; i++ )
	{
		CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"enemy_%d_%d_swim_%d.png", type, level, i]];
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
	
	NSMutableArray *aniFrames = [[[NSMutableArray alloc] init] autorelease];
	for( NSInteger i = 0; i < 8; i++ )
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
	
	NSMutableArray *aniFrames = [[[NSMutableArray alloc] init] autorelease];
	for( NSInteger i = 0; i < 4; i++ )
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
	
	NSMutableArray *aniFrames = [[[NSMutableArray alloc] init] autorelease];
	for( NSInteger i = 0; i < 4; i++ )
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
	
	NSMutableArray *aniFrames = [[[NSMutableArray alloc] init] autorelease];
	for( NSInteger i = 0; i < 3; i++ )
	{
		CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"enemy_%d_%d_fall_%d.png", type, level, i]];
		[aniFrames addObject:frame];
	}
	
	CCAnimation *animation = [CCAnimation animationWithFrames:aniFrames delay:0.08f];
	fallAnimation = [[CCAnimate alloc] initWithAnimation:animation restoreOriginalFrame:NO];
}

- (void)initHitAnimation
{
	[[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:[NSString stringWithFormat:@"enemy_%d_%d_hit.plist", type, level]];
	
	hitEnemySpr = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"enemy_%d_%d_hit_0.png", type, level]];
	hitEnemySpr.anchorPoint = ccp( 0.5f, 0 );
	
	hitBatchNode = [[CCSpriteBatchNode batchNodeWithFile:[NSString stringWithFormat:@"enemy_%d_%d_hit.png", type, level]] retain];
	[hitBatchNode addChild:hitEnemySpr];
	
	NSMutableArray *aniFrames = [[[NSMutableArray alloc] init] autorelease];
	for( NSInteger i = 0; i < 6; i++ )
	{
		CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"enemy_%d_%d_hit_%d.png", type, level, i]];
		[aniFrames addObject:frame];
	}
	
	CCAnimation *animation = [CCAnimation animationWithFrames:aniFrames delay:0.08f];
	hitAnimation = [[CCAnimate alloc] initWithAnimation:animation restoreOriginalFrame:NO];
}

- (void)initDieAnimation
{
	[[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:[NSString stringWithFormat:@"enemy_%d_%d_fall.plist", type, level]];
	
	dieEnemySpr = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"enemy_%d_%d_fall_0.png", type, level]];
	dieEnemySpr.anchorPoint = ccp( 0.5f, 0 );
	
	dieBatchNode = [[CCSpriteBatchNode batchNodeWithFile:[NSString stringWithFormat:@"enemy_%d_%d_fall.png", type, level]] retain];
	[dieBatchNode addChild:dieEnemySpr];
	
	NSMutableArray *aniFrames = [[[NSMutableArray alloc] init] autorelease];
	for( NSInteger i = 0; i < 3; i++ )
	{
		CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"enemy_%d_%d_fall_%d.png", type, level, i]];
		[aniFrames addObject:frame];
	}
	
	CCAnimation *animation = [CCAnimation animationWithFrames:aniFrames delay:0.08f];
	dieAnimation = [[CCAnimate alloc] initWithAnimation:animation restoreOriginalFrame:NO];
}

- (void)initExplosionAnimation
{
	[[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:[NSString stringWithFormat:@"enemy_%d_%d_explosion.plist", ENEMY_TYPE_KAMIKAZE, level]];
	
	explosionEnemySpr = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"enemy_%d_%d_explosion_0.png", ENEMY_TYPE_KAMIKAZE, level]];
	explosionEnemySpr.anchorPoint = ccp( 0.5f, 0.2f );
	
	explosionBatchNode = [[CCSpriteBatchNode batchNodeWithFile:[NSString stringWithFormat:@"enemy_%d_%d_explosion.png", ENEMY_TYPE_KAMIKAZE, level]] retain];
	[explosionBatchNode addChild:explosionEnemySpr];
	
	NSMutableArray *aniFrames = [[[NSMutableArray alloc] init] autorelease];
	for( NSInteger i = 0; i < 9; i++ )
	{
		CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"enemy_%d_%d_explosion_%d.png", ENEMY_TYPE_KAMIKAZE, level, i]];
		[aniFrames addObject:frame];
	}
	
	CCAnimation *animation = [CCAnimation animationWithFrames:aniFrames delay:0.08f];
	explosionAnimation = [[CCAnimate alloc] initWithAnimation:animation restoreOriginalFrame:NO];
}


#pragma mark - init effects

- (void)initWaterEffectAnimation
{
	[[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"effect_water.plist"];
	
	waterEffectSpr = [CCSprite spriteWithSpriteFrameName:@"effect_water_0.png"];
	waterEffectSpr.anchorPoint = ccp( 0.5f, 0 );
	
	waterEffectBatchNode = [[CCSpriteBatchNode batchNodeWithFile:@"effect_water.png"] retain];
	[waterEffectBatchNode addChild:waterEffectSpr];
	
	NSMutableArray *aniFrames = [[[NSMutableArray alloc] init] autorelease];
	for( NSInteger i = 0; i < 8; i++ )
	{
		CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"effect_water_%d.png", i]];
		[aniFrames addObject:frame];
	}
	
	CCAnimation *animation = [CCAnimation animationWithFrames:aniFrames delay:0.08f];
	waterEffectAnimation = [[CCAnimate alloc] initWithAnimation:animation restoreOriginalFrame:NO];
}

#pragma mark - getter/setter

- (CGFloat)getX
{
	return _x;
}

- (void)setX:(CGFloat)x
{
	enemySpr.position = ccp( _x = x, _y );
}

- (CGFloat)getY
{
	return _y;
}

- (void)setY:(CGFloat)y
{
	enemySpr.position = ccp( _x, _y = y );
}


- (CGRect)getBoundingBox
{
	return CGRectMake( self.x - 40, self.y - 30, 60, 60 );
}

- (CGRect)getTouchBoundingBox
{
	return CGRectMake( self.x - 30, self.y, 60, 60 );
}

+ (CGFloat)getGroundY:(CGFloat)x
{
	if( x < FLAG_LEFT_X )
		return ( x - 110 ) * 34 / 27 + 60 + sinf( x / 10 ) * 3;
	
	else if( FLAG_LEFT_X <= x && x <= FLAG_RIGHT_X )
		return TOP_Y;
	
	else
		return -1 * ( x - 360 ) * 31 / 25 + 70 + cosf( x / 10 ) * 3;
	
	return SEA_Y;
}

- (CGFloat)getGroundY
{
	return [Enemy getGroundY:self.x + gapX];
}

- (BOOL)getIsPlaneExists
{
	return isPlaneExists;
}

- (void)setIsPlaneExists:(BOOL)isExists
{
	isPlaneExists = isExists;
	
	// 더이상 날아가지 않게
	if( !isExists )
	{
		[flightEnemySpr stopAllActions];
		[gameScene.gameLayer removeChild:flightBatchNode cleanup:YES];
	}
}


#pragma mark - update

- (void)update
{    
    CGFloat width = 30.0 * (CGFloat)hp / (CGFloat)maxHp;
	if( width < 0 ) width = 0;
    [hpGauge setTextureRect:CGRectMake(0, 0, width, 2)];
	
	// 비행기 계속 날아가게
	if( isPlaneExists && type == ENEMY_TYPE_KAMIKAZE && state != ENEMY_STATE_FLIGHT )
	{
		if( firstDirection == DIRECTION_STATE_LEFT ) // 왼쪽에서 시작
		{
			flightEnemySpr.position = ccp( flightEnemySpr.position.x + self.speed, PLANE_Y + gapY * 3 );
			
			// 화면 밖으로 나가면 제거
			if( flightEnemySpr.position.x > 530 )
				isPlaneExists = NO;
		}
		else // 오른쪽에서 시작
		{
			flightEnemySpr.position = ccp( flightEnemySpr.position.x - self.speed, PLANE_Y + gapY * 3 );
			
			// 화면 밖으로 나가면 제거
			if( flightEnemySpr.position.x < -50 )
				isPlaneExists = NO;
		}
	}
	
	switch( state )
	{
		case ENEMY_STATE_BOAT:
			if( self.x + gapX < DOKDO_LEFT_X )
			{
				boatEnemySpr.flipX = NO;
				boatSpr.flipX = NO;
				self.x += self.speed;
				self.y = SEA_Y + sinf( self.x / 8 ) * 3 + gapY;
			}
			else if( self.x + gapX > DOKDO_RIGHT_X )
			{
				boatEnemySpr.flipX = YES;
				boatSpr.flipX = YES;
				self.x -= self.speed;
				self.y = SEA_Y + sinf( self.x / 8 ) * 3 + gapY;
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
					self.y = PLANE_Y + gapY * 3;
				}
				else
				{
					flightEnemySpr.flipX = YES;
					self.x -= self.speed;
					self.y = PLANE_Y + gapY * 3;
				}
			}
			break;
			
		case ENEMY_STATE_SWIM:
			if( self.x + gapX < DOKDO_LEFT_X )
			{
				swimEnemySpr.flipX = NO;
				self.x += self.speed / 2;
				self.y = SEA_Y + gapY - 5;
			}
			else if( self.x + gapX > DOKDO_RIGHT_X )
			{
				swimEnemySpr.flipX = YES;
				self.x -= self.speed / 2;
				self.y = SEA_Y + gapY - 5;
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
				self.y = [self getGroundY] + gapY;
			}
			else if( FLAG_RIGHT_X < self.x + gapX && self.x + gapX <= DOKDO_RIGHT_X )
			{
				walkEnemySpr.flipX = YES;
				self.x -= self.speed / 2;
				self.y = [self getGroundY] + gapY;
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
			self.y = TOP_Y;
			
			if( FLAG_LEFT_X <= self.x + gapX && self.x + gapX <= FLAG_X )
			{
				attackEnemySpr.flipX = NO;
			}
			else if( FLAG_X <= self.x + gapX && self.x + gapX <= FLAG_RIGHT_X )
			{
				attackEnemySpr.flipX = YES;
			}
			else
			{
				[self stopAttack];
			}
			break;
			
		case ENEMY_STATE_CATCH:
			if( self.x < FLAG_X )
				catchEnemySpr.flipX = NO;
			else
				catchEnemySpr.flipX = YES;
			break;
			
		case ENEMY_STATE_FALL:
			if( self.x < FLAG_X )
				fallEnemySpr.flipX = NO;
			else
				fallEnemySpr.flipX = YES;
			
			if( self.y - gapY >= SEA_Y )
			{
				dx -= AIR_RESISTANCE * dx;
				dy -= GRAVITY;
				
				self.x += dx;
				self.y += dy;
				
				if( self.x < 0 ) self.x = 0;
				else if( self.x > 480 ) self.x = 480;
				
				// 땅에 철푸덕
				if( self.y - gapY < [self getGroundY] )
				{
					[self stopFalling];
					
					// 데미지 없이 떨어지는게 아니면
					if( !fallWithNoDamage )
					{
						// 일반 타입의 경우 데미지를 입음
						if( type != ENEMY_TYPE_KAMIKAZE )
						{
							NSLog( @"사용자 공격력 : %d", gameScene.player.power );
							NSLog( @"dy : %f", dy );
							[self beDamaged:abs( (NSInteger)( gameScene.player.power * dy * 0.2 ) )];
						}
						
						// 카미카제는 바로 폭발함
						else
						{
							[self startExplosion];
							return;
						}
					}
					
					// 데미지 없이 떨어짐 - 비행기에서 떨어질 때 등
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
					
					// 데미지 없이 떨어지는게 아니면
					if( !fallWithNoDamage )
					{
						// 일반 타입의 경우 데미지를 입음
						if( type != ENEMY_TYPE_KAMIKAZE )
						{
							[self beDamaged:abs( (NSInteger)( gameScene.player.power * dy * 0.1 ) )];
						}
						
						// 카미카제는 바로 폭발함
						else
						{
							NSLog( @"퍼엉" );
							[self stopFalling];
							[self startExplosion];
							return;
						}
					}
					
					[self startWaterEffect];
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
				
				if( self.y + 30 + gapY < 0 )
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
	[enemySpr addChild:boatSpr];
}

- (void)startFlight
{
	state = ENEMY_STATE_FLIGHT;
	[enemySpr addChild:flightBatchNode];
	[flightEnemySpr runAction:[CCRepeatForever actionWithAction:flightAnimation]];
	isPlaneExists = YES;
}

- (void)startSwimming
{
	if( state == ENEMY_STATE_SWIM ) return;
	
	state = ENEMY_STATE_SWIM;
	[enemySpr addChild:swimBatchNode];
	[swimEnemySpr runAction:[CCRepeatForever actionWithAction:swimAnimation]];
}

- (void)startWalking
{
	if( state == ENEMY_STATE_WALK ) return;
	
	state = ENEMY_STATE_WALK;
	[enemySpr addChild:walkBatchNode];
	[walkEnemySpr runAction:[CCRepeatForever actionWithAction:walkAnimation]];
}

- (void)startAttack
{
	if( state == ENEMY_STATE_ATTACK ) return;
	
	state = ENEMY_STATE_ATTACK;
	[enemySpr addChild:attackBatchNode];
	[attackEnemySpr runAction:[CCRepeatForever actionWithAction:[CCSequence actions:attackAnimation, [CCCallFunc actionWithTarget:self selector:@selector(onAttack:)] , nil]]];
}

- (void)startBeingCaught
{
	if( state == ENEMY_STATE_CATCH ) return;
	
	state = ENEMY_STATE_CATCH;
	[enemySpr addChild:catchBatchNode];
	[catchEnemySpr runAction:[CCRepeatForever actionWithAction:catchAnimation]];
}

- (void)startFalling
{
	if( state == ENEMY_STATE_FALL ) return;
	
	dx = dy = 0;
	
	state = ENEMY_STATE_FALL;
	[enemySpr addChild:fallBatchNode];
	[fallEnemySpr runAction:fallAnimation];
}

- (void)startBeingHit
{
	NSLog( @"startBeingHit" );
	
	if( state == ENEMY_STATE_HIT )
		[self stopBeingHit];
	
	state = ENEMY_STATE_HIT;
	[enemySpr addChild:hitBatchNode];
	[hitEnemySpr runAction:[CCSequence actions:hitAnimation, [CCCallFunc actionWithTarget:self selector:@selector(stopBeingHit:)], nil]];
}

- (void)startDying
{
	if( state == ENEMY_STATE_DIE ) return;
	
	state = ENEMY_STATE_DIE;
	
	[enemySpr addChild:dieBatchNode];
	
	// 물에서 죽으면 Fall 애니메이션으로 꼬르륵 거리면서 물 밑으로 내려감
	if( self.x + gapX < DOKDO_LEFT_X || DOKDO_RIGHT_X < self.x + gapX )
	{
		dy = -1 * GRAVITY;
		[dieEnemySpr runAction:fallAnimation];
	}
	else
	{
		[dieEnemySpr runAction:[CCSequence actions:dieAnimation, [CCCallFunc actionWithTarget:self selector:@selector(stopDying)], nil]];
	}
}

- (void)startExplosion
{
	state = ENEMY_STATE_EXPLOSION;
	[enemySpr addChild:explosionBatchNode];
	[explosionEnemySpr runAction:[CCSequence actions:explosionAnimation, [CCCallFunc actionWithTarget:self selector:@selector(stopExplosion)], nil]];
	
	if( fabs( self.x + gapX - FLAG_X ) <= EXPLOSION_ARRANGE )
		[self attack];
}


#pragma mark - start effects

- (void)startWaterEffect
{
	NSLog( @"첨벙" );
	if( [UserData userData].backSound )
		[[SimpleAudioEngine sharedEngine] playEffect:@"effect_water.mp3"];
	if( isWaterEffectRunning ) return;
	isWaterEffectRunning = YES;
	waterEffectBatchNode.position = ccp( self.x, self.y );
	[gameScene.gameLayer addChild:waterEffectBatchNode z:Z_ENEMY];
	[waterEffectSpr runAction:[CCSequence actions:waterEffectAnimation, [CCCallFunc actionWithTarget:self selector:@selector(stopWaterEffect)], nil]];
}


#pragma mark - stop actions

- (void)stopBoating
{
	[boatEnemySpr stopAllActions];
	[enemySpr removeChild:boatBatchNode cleanup:YES];
	[enemySpr removeChild:boatSpr cleanup:NO];
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
}

- (void)stopBeingHit
{
	[hitEnemySpr stopAllActions];
	[enemySpr removeChild:hitBatchNode cleanup:NO];
	
	NSLog( @"stopBeingHit" );
}

- (void)stopBeingHit:(id)sender
{
	[self stopBeingHit];
	
	NSLog( @"stopBeingHit:sender" );
	
	if( self.x + gapX < DOKDO_LEFT_X || DOKDO_RIGHT_X < self.x + gapX )
		[self startSwimming];
	else
		[self startWalking];
}

- (void)stopDying
{
	[dieEnemySpr stopAllActions];
	[enemySpr removeChild:dieBatchNode cleanup:YES];
	[gameScene.gameLayer removeChild:enemySpr cleanup:YES];
	[self remove];
}

- (void)stopExplosion
{
	[explosionEnemySpr stopAllActions];
	[enemySpr removeChild:explosionBatchNode cleanup:YES];
	[self remove];
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


#pragma mark - stop effects

- (void)stopWaterEffect
{
	isWaterEffectRunning = NO;
	[waterEffectSpr stopAllActions];
	[gameScene.gameLayer removeChild:waterEffectBatchNode cleanup:NO];
}


#pragma mark - attack

- (void)attack
{
	NSLog( @"공격!" );
	gameScene.flag.hp -= power;
	
	if( type == ENEMY_TYPE_KAMIKAZE )
		explodeItself = YES;
}

- (void)onAttack:(id)sener
{
	[self attack];
}


#pragma mark - public methods

- (void)applyForce:(CGFloat)x:(CGFloat)y
{
	if( state == ENEMY_STATE_FALL || state == ENEMY_STATE_DIE )
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
	if( state == ENEMY_STATE_FLIGHT || state == ENEMY_STATE_DIE || state == ENEMY_STATE_EXPLOSION ) return;
	
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
		[self startDying];
	else
		[self startBeingHit];
}

- (void)beDamaged:(NSInteger)damage forceX:(NSInteger)forceX forceY:(NSInteger)forceY
{
	if( state == ENEMY_STATE_FLIGHT || state == ENEMY_STATE_FALL || state == ENEMY_STATE_HIT || state == ENEMY_STATE_DIE || state == ENEMY_STATE_EXPLOSION ) return;
	
	// 카미카제는 폭발
	if( type == ENEMY_TYPE_KAMIKAZE )
	{
		self.hp = 0;
		[self stopCurrentAction];
		[self startExplosion];
		return;
	}
	
	NSLog( @"현재 상태는?? %d", state );
	
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

#pragma mark - remove

- (void)remove
{
	if( !explodeItself )
		gameScene.money += money;
	
	state = ENEMY_STATE_REMOVE;
}

@end
