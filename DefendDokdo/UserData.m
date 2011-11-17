//
//  UserData.m
//  DefendDokdo
//
//  Created by 전 수열 on 11. 11. 2..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import "UserData.h"


@implementation UserData

@synthesize point, stageLevel;
@synthesize skillSlot, userSkill, userSkillSlot;
@synthesize flagLevel, userAtkLevel, userMaxMpLevel, UserMpspeedLevel;
@synthesize backSound, vibration;
@synthesize stageInfo;

+ (UserData *)userData
{
    static UserData *ret;
    
    if (!ret)
    {
        ret = [[UserData alloc] init];
    }
    
    return ret;
}

- (id)init
{
    if (self = [super init])
    {
        NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:[(NSString *)[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"UserData.plist"]];
		
		point = [[dict objectForKey:@"point"] integerValue];
        
        if (!point) {
            point = 0;
        }
		
		stageLevel = [[dict objectForKey:@"userStageLevel"] integerValue];
		
		if (!stageLevel) {
			stageLevel = 0;
		}
		
		
				
		stageInfo = [[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"StageList" ofType:@"plist"]] retain];

		if (!dict) 
		{
			backSound = YES;
			vibration = YES;
		}
		else
		{
			backSound = [[dict objectForKey:@"sound"] boolValue];        
			vibration = [[dict objectForKey:@"vibration"] boolValue];				
		}
        
		
		[self saveToFile];
        
        return self;
    }
    
    return nil;
}

- (BOOL)saveToFile
{
	
}

- (BOOL)removeToFile
{
	
}

- (BOOL)setToFile
{
	
}


@end
