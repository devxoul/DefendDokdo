//
//  Player.m
//  DefendDokdo
//
//  Created by 전 수열 on 11. 11. 2..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import "Player.h"
#import "GameLayer.h"

#import "UserData.h"
#import "SkillData.h"
#import "Const.h"


@implementation Player

@synthesize power, maxMp, mp, mpSpeed;
@synthesize slots;


- (void)init:(GameLayer*)scene
{
	NSInteger powerLevel = [[UserData userData] userAtkLevel];
	power = [[SkillData skillData] getUpgradeInfo: UPGRADE_TYPE_ATTACK:powerLevel];
	
	NSInteger maxMpLevel = [[UserData userData] userMaxMpLevel];
	maxMp = [[SkillData skillData] getUpgradeInfo:UPGRADE_TYPE_MAXMP :maxMpLevel];
	
	NSInteger mpSpeedLevel = [[UserData userData] userMPspeedLevel];
	mpSpeed = [[SkillData skillData] getUpgradeInfo:UPGRADE_TYPE_REGENMP :mpSpeedLevel];

	mp = 0;
	slots = [[UserData userData] userSkillSlot];
	
	mpFrequency = 50;
}

- (void)update
{
	if (mp < maxMp && ( currentLoop++ ) % mpFrequency == 0) {
		mp += 1;
	}
}


@end
