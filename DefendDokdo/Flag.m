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
	
	flagSpr = [[CCSprite alloc]initWithFile:@"flag.png"];
	[flagSpr setPosition:ccp(245, 210)];
	[flagSpr setAnchorPoint:ccp(0.5f, 0.0f)];
	
	[scene addChild:flagSpr z:Z_FLAG];
}




@end
