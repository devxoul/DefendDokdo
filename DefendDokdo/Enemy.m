//
//  Enemy.m
//  DefendDokdo
//
//  Created by 전 수열 on 11. 11. 1..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import "Enemy.h"
#import "Const.h"
#import "GameLayer.h"

@interface Enemy(Private)
- (void)initBoatAnimation;
- (void)initSwimAnimation;
- (void)initWalkAnimation;
- (void)initAttackAnimation;
- (void)initCatchAnimation;
- (void)initFallAnimation;
- (void)initHitAnimation;
- (void)initDieAnimation;

- (void)startBoating;
- (void)startSwimming;
- (void)startWalking;
- (void)startAttack;
- (void)startBeingCaught;
- (void)startFalling;
- (void)startBeingHit;
- (void)startDying;

- (void)stopBoating;
- (void)stopSwimming;
- (void)stopWalking;
- (void)stopAttack;
- (void)stopBeingCaught;
- (void)stopFalling;
- (void)stopBeingHit;
- (void)stopBeingHit:(id)sender;
- (void)stopDying;
- (void)stopDying:(id)sender;

- (void)stopCurrentAction;

- (float)getGroundY;
@end


@implementation Enemy

@synthesize type, level, power, maxHp, hp, speed;
@synthesize x = _x, y = _y, dx, dy, boundingBox;

#pragma mark - initialize

- (id)initWithGameLayer:(GameLayer *)layer type:(NSInteger)_type level:(NSInteger)_level
{
	if( self = [self init] )
	{
		gameLayer = layer;
		
		self.type = _type;
		self.level = _level;
		self.power = 10; // temp
		self.hp = self.maxHp = 100; // temp
		self.x = arc4random() % 2 ? 0 : 480;
		self.y = 320;
		self.speed = 1;
		
		enemySpr = [[CCSprite alloc] init];
		enemySpr.anchorPoint = ccp( 0.5f, 0 );
		[gameLayer addChild:enemySpr z:Z_ENEMY];
		
		[self initBoatAnimation];
		[self initSwimAnimation];
		[self initWalkAnimation];
		[self initAttackAnimation];
		[self initCatchAnimation];
		[self initFallAnimation];
		[self initHitAnimation];
		[self initDieAnimation];
		
		dx = dy = 0;
		
		[self startBoating];
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
	if( self.x < FLAG_LEFT_X )
		return ( self.x - 110 ) * 31 / 23 + 50 + sinf( self.x / 10 ) * 3;
	
	if( FLAG_RIGHT_X < self.x )
		return -1 * ( self.x - 360 ) * 31 / 20 + 50 + cosf( self.x / 10 ) * 3;
	
	return TOP_Y;
}


#pragma mark - update

- (void)update
{
	switch( state )
	{
		case ENEMY_STATE_BOAT:
			if( self.x < DOKDO_LEFT_X )
			{
				boatEnemySpr.flipX = NO;
				self.x += self.speed;
				self.y = SEA_Y;
			}
			else if( self.x > DOKDO_RIGHT_X )
			{
				boatEnemySpr.flipX = YES;
				self.x -= self.speed;
				self.y = SEA_Y;
			}
			else
			{
				[self stopBoating];
				[self startWalking];
			}
			break;
			
		case ENEMY_STATE_SWIM:
			if( self.x < DOKDO_LEFT_X )
			{
				swimEnemySpr.flipX = NO;
				self.x += self.speed / 2;
				self.y = SEA_Y;
			}
			else if( self.x > DOKDO_RIGHT_X )
			{
				swimEnemySpr.flipX = YES;
				self.x -= self.speed / 2;
				self.y = SEA_Y;
			}
			else
			{
				[self stopSwimming];
				[self startWalking];
			}
			break;
			
		case ENEMY_STATE_WALK:			
			if( DOKDO_LEFT_X <= self.x && self.x < FLAG_LEFT_X )
			{
				walkEnemySpr.flipX = NO;
				self.x += self.speed / 2;
				self.y = ( self.x - 110 ) * 31 / 23 + 50 + sinf( self.x / 10 ) * 3;
			}
			else if( FLAG_RIGHT_X < self.x && self.x <= DOKDO_RIGHT_X )
			{
				walkEnemySpr.flipX = YES;
				self.x -= self.speed / 2;
				self.y = -1 * ( self.x - 360 ) * 31 / 20 + 50 + cosf( self.x / 10 ) * 3;
			}
			else
			{
				[self stopWalking];
				[self startAttack];
			}
			break;
			
		case ENEMY_STATE_ATTACK:
			if( FLAG_LEFT_X <= self.x && self.x <= FLAG_X )
			{
				attackEnemySpr.flipX = NO;
			}
			else if( FLAG_X <= self.x && self.x <= FLAG_RIGHT_X )
			{
				attackEnemySpr.flipX = YES;
			}
			else
			{
				[self stopAttack];
			}
			break;
			
		case ENEMY_STATE_CATCH:
			break;
			
		case ENEMY_STATE_FALL:
			if( self.y >= SEA_Y )
			{
				dx -= AIR_RESISTANCE * dx;
				dy -= GRAVITY;
				
				self.x += dx;
				self.y += dy;
				
				// 땅에 철푸덕
				if( self.y < [self getGroundY] )
				{
					[self stopFalling];
					[self beDamaged:-1 * dy]; // temp
				}
				
				// 입수
				else if( self.y <= SEA_Y )
				{
					dx = 0;
					dy *= WATER_RESISTANCE;
					
					self.hp -= 25;
					
					if( self.hp <= 0 )
					{
						[self stopFalling];
						[self startDying];
					}
				}
			}
			else
			{
				// 물 위로
				if( self.y + dy <= SEA_Y )
				{
					dy += BUOYANCY;
					self.y += dy;
				}
				else
				{
					[self stopFalling];
					[self startSwimming];
				}
			}
			break;
			
		case ENEMY_STATE_HIT:
			if( self.x < FLAG_X )
				hitEnemySpr.flipX = NO;
			else
				hitEnemySpr.flipX = YES;
			break;
			
		case ENEMY_STATE_DIE:
			if( self.x < FLAG_X )
				dieEnemySpr.flipX = NO;
			else
				dieEnemySpr.flipX = YES;
			
			// 물에서 죽으면 꼬르륵 하면서 물 밑으로 내려감
			if( self.x < DOKDO_LEFT_X || DOKDO_RIGHT_X < self.x )
			{
				self.y += dy;
				
				if( self.y + fallEnemySpr.contentSize.height < 0 )
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
	
	NSLog( @"die" );
	
	state = ENEMY_STATE_DIE;
	
	if( self.x < DOKDO_LEFT_X || DOKDO_RIGHT_X < self.x )
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


#pragma mark - stop actions

- (void)stopBoating
{
	[boatEnemySpr stopAllActions];
	[enemySpr removeChild:boatBatchNode cleanup:YES];
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
	
	if( self.x < DOKDO_LEFT_X || DOKDO_RIGHT_X < self.x )
		[self startSwimming];
	else
		[self startWalking];
}

- (void)stopDying
{	
	if( self.x < DOKDO_LEFT_X || DOKDO_RIGHT_X < self.x )
	{
		[fallEnemySpr stopAllActions];
		[enemySpr removeChild:fallBatchNode cleanup:NO];
	}
	else
	{
		[dieEnemySpr stopAllActions];
		[enemySpr removeChild:dieBatchNode cleanup:YES];
	}
	
	[gameLayer removeChild:enemySpr cleanup:YES];
	
    //	[self release];
}

- (void)stopDying:(id)sender
{
	[self stopDying];
}

- (void)stopCurrentAction
{
	switch( state )
	{
		case ENEMY_STATE_BOAT:
			[self stopBoating];
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
	if( state == ENEMY_STATE_DIE ) return;
	
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
	if( state == ENEMY_STATE_FALL || state == ENEMY_STATE_DIE ) return;
	
	if( state != ENEMY_STATE_HIT )
		self.hp -= damage;
	
	[self stopCurrentAction];
	
	if( self.hp <= 0 )
		[self startDying];
	else
		[self applyForce:forceX :forceY];
}

@end
