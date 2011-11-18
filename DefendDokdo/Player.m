//
//  Player.m
//  DefendDokdo
//
//  Created by 전 수열 on 11. 11. 2..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import "Player.h"
#import "UserData.h"


@implementation Player

@synthesize power, maxMp, mp, mpSpeed;
@synthesize slots;

- (id)init
{
	if( self == [self init] )
	{
		NSInteger powerLevel = [[UserData userData] userAtkLevel];
		NSInteger maxMpLevel = [[UserData userData] userMaxMpLevel];
		NSInteger mpSpeedLevel = [[UserData userData] UserMpspeedLevel];
		mp = 0;
		
		slots = [[UserData userData] userSkillSlot];
	}
	
	return self;
}

- (void)update
{
	if (mp < maxMp) {
		mp += mpSpeed;
	}
}


@end
