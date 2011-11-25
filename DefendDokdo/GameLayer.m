//
//  GameLayer.m
//  DefendDokdo
//
//  Created by 전 수열 on 11. 11. 1..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import "GameLayer.h"
#import "Enemy.h"
#import "ControlManager.h"
#import "GameScene.h"


@implementation GameLayer

- (id)initWithScene:(GameScene *)scene_
{
	if (self = [self init])
	{
		scene = scene_;
		controlManager = scene.controlManager;
	}
	return self;
}

- (id)init
{
	if( self = [super init] )
	{   
		[self setContentSize:CGSizeMake(480.f, 290.f)];
		[self setAnchorPoint:CGPointZero];
		self.isTouchEnabled = YES;
	}
	
	return self;
}

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	if( scene.nGameState == GAMESTATE_PAUSE )
		return;
	
	for (UITouch *touch in touches)
	{
		CGPoint targetPoint = [[CCDirector sharedDirector] convertToGL:[touch locationInView: [touch view]]];
		Enemy *e = nil;
		for (NSUInteger i = 0, j = scene.enemies.count;i < j;i++) {
			e = [scene.enemies objectAtIndex:i];
			if (CGRectContainsPoint(e.touchBoundingBox, targetPoint) && e.state != ENEMY_STATE_FLIGHT && e.state != ENEMY_STATE_DIE && e.state != ENEMY_STATE_EXPLOSION)
			{
				if (![controlManager manageObject:e WithTouch:touch] )
					i = j;
				[e beCaught];
				break;
			}
		}
	}
}

- (void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	if( scene.nGameState == GAMESTATE_PAUSE )
		return;
	
	for (UITouch *touch in touches)
	{
		if (![controlManager moveManagedObjectOfTouch:touch]) return;
	}
}

- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	if( scene.nGameState == GAMESTATE_PAUSE )
		return;
	
	for (UITouch *touch in touches)
	{
		Enemy *e = [controlManager stopManagingObjectOfTouch:touch];
		if (!e) return;
	}
}

@end
