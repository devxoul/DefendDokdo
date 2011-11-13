//
//  Enemy.m
//  DefendDokdo
//
//  Created by 전 수열 on 11. 11. 1..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import "Enemy.h"
#import "Const.h"

@interface Enemy(Private)

@end


@implementation Enemy

@synthesize type, level, power, maxHp, hp, speed;
@synthesize enemySpr, boatSpr;
@synthesize x = _x, y = _y, dx, dy;

- (id)initWithType:(NSInteger)type level:(NSInteger)level
{
	if( self == [self init] )
	{
		self.x = arc4random() % 2 ? 0 : 480;
		self.y = 320;
		self.speed = 2;
		
		enemySpr = [[CCSprite alloc] initWithFile:@"dummy_enemy_0.png"];
		enemySpr.anchorPoint = ccp( 0.5f, 0 );
		
		boatSpr = [[CCSprite alloc] initWithFile:@"boat.png"];
		boatSpr.anchorPoint = ccp( 0.5f, 0 );
		
		dx = dy = 0;
	}
	
	return self;
}

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

- (void)applyForce:(float)force direction:(float)direction
{
	dx += force * cosf( direction );
	dy += force * sinf( direction );
}

- (void)applyForce:(float)x:(float)y
{
	dx += x;
	dy += y;
}

- (void)update
{
	switch( state )
	{
		case ENEMY_STATE_BOAT:
			if( self.x < DOKDO_LEFT_X )
			{
				self.boatSpr.flipX = YES;
				self.x += self.speed;
				self.y = SEA_Y + sinf( self.x / 10 ) * 3; // 둥실둥실
			}
			else if( self.x > DOKDO_RIGHT_X )
			{
				self.x -= self.speed;
				self.y = SEA_Y + sinf( self.x / 10 ) * 3; // 둥실둥실
			}
			else
			{
				state = ENEMY_STATE_WALK;
			}
			break;
			
		case ENEMY_STATE_SWIM:
			if( self.x < DOKDO_LEFT_X )
			{
				self.x += self.speed / 2;
				self.y = SEA_Y + sinf( self.x / 10 ) * 3; // 둥실둥실
			}
			else if( self.x > DOKDO_RIGHT_X )
			{
				self.x -= self.speed / 2;
				self.y = SEA_Y + sinf( self.x / 10 ) * 3; // 둥실둥실
			}
			else
			{
				state = ENEMY_STATE_WALK;
			}
			break;
			
		case ENEMY_STATE_WALK:
			if( DOKDO_LEFT_X <= self.x && self.x < FLAG_LEFT_X )
			{
				self.boatSpr.visible = NO;
				self.x += self.speed * cosf( atan2f( 23.0, 31.0 ) );
				self.y = ( self.x - 110 ) * 31 / 23 + 50;
			}
			else if( FLAG_RIGHT_X < self.x && self.x <= DOKDO_RIGHT_X )
			{
				self.enemySpr.flipX = YES;
				self.boatSpr.visible = NO;
				self.x += self.speed * cosf( atan2f( 20, -31.0 ) );
				self.y = -1 * ( self.x - 360 ) * 31 / 20 + 50;
			}
			break;
			
		case ENEMY_STATE_FLAG:
			break;
			
		case ENEMY_STATE_CATCH:
			break;
			
		case ENEMY_STATE_FALL:
			self.x += dx;
			self.y += dy;
			break;
			
		case ENEMY_STATE_HIT:
			break;
			
		case ENEMY_STATE_DIE:
			break;
	}
}

- (void)hitTestGround
{
	
}

@end
