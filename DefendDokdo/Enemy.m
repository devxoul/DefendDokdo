//
//  Enemy.m
//  DefendDokdo
//
//  Created by 전 수열 on 11. 11. 1..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import "Enemy.h"


@implementation Enemy

@synthesize type, level, power, maxHp, hp, speed;
@synthesize enemySpr;
@synthesize x = _x, y = _y, dx, dy;

- (id)initWithType:(NSInteger)type level:(NSInteger)level
{
	if( self == [self init] )
	{
		enemySpr = [[CCSprite alloc] initWithFile:@"dummy_enemy_0.png"];
		enemySpr.anchorPoint = ccp( 0.5f, 1.0f );
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
	self.x += dx;
	self.y += dy;
}

- (void)hitTestGround
{
	
}

@end
