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
@synthesize skillSlot, userSkillSlot;
@synthesize flagLevel, userAtkLevel, userMaxMpLevel, userMPspeedLevel;
@synthesize stoneLevel, hillLevel, earthquakeLevel, arrowLevel;
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
		
		point = [[dict objectForKey:@"Point"] integerValue];
		
		if (!point) {
			point = 0;
		}
		
		stageLevel = [[dict objectForKey:@"UserStageLevel"] integerValue];
		
		if (!stageLevel) {
			stageLevel = 0;
		}
		
		flagLevel = [[dict objectForKey:@"FlagLevel"] integerValue];
		
		if (!flagLevel) {
			flagLevel = 0;
		}
		
		userAtkLevel = [[dict objectForKey:@"UserAtkLevel"] integerValue];
		
		if (!userAtkLevel) {
			userAtkLevel = 0;
		}
		
		userMaxMpLevel = [[dict objectForKey:@"UserMaxMPLevel"] integerValue];
		
		if (!userMaxMpLevel) {
			userMaxMpLevel = 0;
		}
		
		userMPspeedLevel = [[dict objectForKey:@"UserMPSpeedLevel"] integerValue];
		
		if (!userMPspeedLevel) {
			userMPspeedLevel = 0;
		}
		
		stoneLevel = [[dict objectForKey:@"StoneLevel"] integerValue];
		
		if (!stoneLevel) {
			stoneLevel = 0;
		}
		
		arrowLevel = [[dict objectForKey:@"ArrowLevel"] integerValue];
		
		if (!arrowLevel) {
			arrowLevel = 0;
		}
		
		hillLevel = [[dict objectForKey:@"HillingLevel"] integerValue];
		
		if (!hillLevel) {
			hillLevel = 0;
		}
		
		earthquakeLevel = [[dict objectForKey:@"EarthQuakeLevel"] integerValue];
		
		if (!earthquakeLevel) {
			earthquakeLevel = 0;
		}
		
		skillSlot = [dict objectForKey:@"BuySkillSlot"];
		
		if (!skillSlot) {
			skillSlot = [NSMutableArray array];
			
			[skillSlot addObject:[NSNumber numberWithBool:YES]];
			[skillSlot addObject:[NSNumber numberWithBool:NO]];
			[skillSlot addObject:[NSNumber numberWithBool:NO]];			
		}
		
		userSkillSlot = [dict objectForKey:@"SlotInSkill"];
		
		if (!userSkillSlot) {
			userSkillSlot = [NSMutableArray array];
			
			[userSkillSlot addObject:[NSNumber numberWithInteger:-1]];
			[userSkillSlot addObject:[NSNumber numberWithInteger:-1]];
			[userSkillSlot addObject:[NSNumber numberWithInteger:-1]];
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
	NSMutableDictionary *dict = [NSMutableDictionary dictionary];
	
	[dict setObject:[NSNumber numberWithInteger:point] forKey:@"Point"];
	[dict setObject:[NSNumber numberWithInteger:stageLevel] forKey:@"UserStageLevel"];
	
	[dict setObject:[NSNumber numberWithInteger:flagLevel] forKey:@"FlagLevel"];
	[dict setObject:[NSNumber numberWithInteger:userAtkLevel] forKey:@"UserAtkLevel"];
	[dict setObject:[NSNumber numberWithInteger:userMaxMpLevel] forKey:@"UserMaxMPLevel"];
	[dict setObject:[NSNumber numberWithInteger:userMPspeedLevel] forKey:@"UserMPSpeedLevel"];
	
	[dict setObject:[NSNumber numberWithInteger:stoneLevel] forKey:@"StoneLevel"];
	[dict setObject:[NSNumber numberWithInteger:arrowLevel] forKey:@"ArrowLevel"];
	[dict setObject:[NSNumber numberWithInteger:hillLevel] forKey:@"HillingLevel"];
	[dict setObject:[NSNumber numberWithInteger:earthquakeLevel] forKey:@"EarthQuakeLevel"];
	
	[dict setObject:skillSlot forKey:@"BuySkillSlot"];
	[dict setObject:userSkillSlot forKey:@"SlotInSkill"];	
	
	return [dict writeToFile:[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"UserData.plist"] atomically:YES];
	
}

- (BOOL)removeToFile
{
	NSString* path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] 
										stringByAppendingFormat:@"/UserData.plist"];
	
	if ([[NSFileManager defaultManager] fileExistsAtPath:path])
		[[NSFileManager defaultManager] removeItemAtPath:path error:nil];
	
	point = 0;
	
	stageLevel = 0;
	
	flagLevel = 0;
	userAtkLevel = 0;
	userMaxMpLevel = 0;
	userMPspeedLevel = 0;
	
	stoneLevel = 0;
	arrowLevel = 0;
	hillLevel = 0;
	earthquakeLevel = 0;
	
	skillSlot = [NSMutableArray arrayWithObjects:[NSNumber numberWithBool:YES], [NSNumber numberWithBool:NO], [NSNumber numberWithBool:NO], nil];
	
	userSkillSlot = [NSMutableArray arrayWithObjects:[NSNumber numberWithInteger:-1], 
									 [NSNumber numberWithInteger:-1], [NSNumber numberWithInteger:-1], nil];
	
	stageInfo = [[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"StageList" ofType:@"plist"]] retain];
	
	return YES;	
}

- (BOOL)setToFile
{
	NSMutableDictionary *dict = [NSMutableDictionary dictionary];
	
	[dict setObject:[NSNumber numberWithBool:backSound] forKey:@"sound"];
	[dict setObject:[NSNumber numberWithBool:vibration] forKey:@"vibration"];
	
	return [dict writeToFile:[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"UserData.plist"] atomically:YES];
}


@end
