//
//  Flag.m
//  DefendDokdo
//
//  Created by 전 수열 on 11. 11. 1..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import "Flag.h"
#import "Const.h"
#import "GameLayer.h"

#import "UserData.h"
#import "SkillData.h"

@implementation Flag

@synthesize level, maxHp, hp;
@synthesize flagSpr;

- (void)init:(GameLayer*)scene
{
	level = [[UserData userData] flagLevel];
	maxHp = [[SkillData skillData] getUpgradeInfo:UPGRADE_TYPE_FLAG :level];
	hp = maxHp;
	
	[[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"flag.plist"];
	
	flagSpr = [CCSprite spriteWithSpriteFrameName:@"flag_0.png"];
	[flagSpr setPosition:ccp(FLAG_X, FLAG_Y)];
	[flagSpr setAnchorPoint:ccp(0.5f, 0.0f)];
		
	flagBatchNode = [[CCSpriteBatchNode batchNodeWithFile:@"flag.png"] retain];
	[flagBatchNode addChild:flagSpr];
	
	NSMutableArray *aniFrames = [[NSMutableArray alloc] init];
	for( NSInteger i = 0; i < 6; i++ )
	{
		CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"flag_%d.png", i]];
		[aniFrames addObject:frame];
	}
	
	CCAnimation *animation = [CCAnimation animationWithFrames:aniFrames delay:0.1f];
	flagAnimation = [[CCAnimate alloc] initWithAnimation:animation restoreOriginalFrame:NO];
	
	[scene addChild:flagBatchNode z:Z_FLAG];
	[flagSpr runAction:[CCRepeatForever actionWithAction:flagAnimation]];
}

- (void) update{
    hp=hp-0.1;
}


@end
