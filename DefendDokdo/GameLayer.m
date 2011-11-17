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
	if (self == [self init])
	{
		scene = scene_;
		controlManager = scene.controlManager;
	}
	return self;
}

- (id)init
{
	if( self == [super init] )
	{   
        [self setContentSize:CGSizeMake(480.f, 290.f)];
        [self setAnchorPoint:CGPointZero];
		self.isTouchEnabled = YES;
	}
	
	return self;
}

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	for (UITouch *touch in touches)
	{
		CGPoint targetPoint = [[CCDirector sharedDirector] convertToGL:[touch locationInView: [touch view]]];
		Enemy *e = nil;
		for (e in scene.enemies) {
			if (CGRectContainsPoint(e.boundingBox, targetPoint))
			{
				if (![controlManager manageObject:e WithTouch:touch]) return;
#warning TODO: change enemy state to CATCH
				break;
			}
		}
		//if (e) [enemies removeObject:e];
	}
}

- (void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	for (UITouch *touch in touches)
	{
		if (![controlManager moveManagedObjectOfTouch:touch]) return;
	}
}

- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	for (UITouch *touch in touches)
	{
		Enemy *e = [controlManager stopManagingObjectOfTouch:touch];
		if (!e) return;
		[scene.enemies addObject:e];
#warning TODO: change enemy state to FALL
	}
}

@end
