//
//  UserData.m
//  DefendDokdo
//
//  Created by 전 수열 on 11. 11. 2..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import "UserData.h"
#import "Const.h"

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
			skillSlot = [[[NSMutableDictionary alloc] init] retain];
			
            [skillSlot setObject:[NSNumber numberWithBool:YES] forKey:@"1"];
            [skillSlot setObject:[NSNumber numberWithBool:NO] forKey:@"2"];
            [skillSlot setObject:[NSNumber numberWithBool:NO] forKey:@"3"];
		} else
            [skillSlot retain];
		
		userSkillSlot = [dict objectForKey:@"SlotInSkill"];
		
		if (!userSkillSlot) {
			userSkillSlot = [[[NSMutableDictionary alloc] init] retain];
            
            [userSkillSlot setObject:[NSNumber numberWithInteger:-1] forKey:@"1"];
            [userSkillSlot setObject:[NSNumber numberWithInteger:-1] forKey:@"2"];
            [userSkillSlot setObject:[NSNumber numberWithInteger:-1] forKey:@"3"];
			
            //			
            //			[userSkillSlot addObject:[NSNumber numberWithInteger:-1]];
            //			[userSkillSlot addObject:[NSNumber numberWithInteger:-1]];
            //			[userSkillSlot addObject:[NSNumber numberWithInteger:-1]];
		} else
            [userSkillSlot retain];
		
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

-(NSInteger)getSkillLevel:(NSInteger)skillType{
    NSInteger result = 0;
    
    switch (skillType) {
        case SKILL_STATE_STONE:
            result = stoneLevel;
            break;
        case SKILL_STATE_ARROW:
            result = arrowLevel;
            break;
        case SKILL_STATE_HEALING:
            result = hillLevel;
            break;
        case SKILL_STATE_EARTHQUAKE:
            result = earthquakeLevel;
            break;
            
    }
    return result;
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
	
	point = 10000000;
	
	stageLevel = 0;
	
	flagLevel = 0;
	userAtkLevel = 0;
	userMaxMpLevel = 0;
	userMPspeedLevel = 0;
	
	stoneLevel = 0;
	arrowLevel = 0;
	hillLevel = 0;
	earthquakeLevel = 0;
	
    
    skillSlot = [[[NSMutableDictionary alloc] init] retain];
    
    [skillSlot setObject:[NSNumber numberWithBool:YES] forKey:@"1"];
    [skillSlot setObject:[NSNumber numberWithBool:NO] forKey:@"2"];
    [skillSlot setObject:[NSNumber numberWithBool:NO] forKey:@"3"];
    
    
    
    userSkillSlot = [[[NSMutableDictionary alloc] init] retain];
    
    [userSkillSlot setObject:[NSNumber numberWithInteger:-1] forKey:@"1"];
    [userSkillSlot setObject:[NSNumber numberWithInteger:-1] forKey:@"2"];
    [userSkillSlot setObject:[NSNumber numberWithInteger:-1] forKey:@"3"];
    
	
    
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

#pragma mark - GameCenter

+ (BOOL)isGameCenterAvailable
{ 
	static NSInteger available = 0;
	switch (available) {
		case 1:
			return true;
			
		case 2:
			return false;
			
		default:
		{
			Class gcClass = (NSClassFromString(@"GKLocalPlayer"));
			NSString *reqSysVer = @"4.1";
			NSString *currSysVer = [[UIDevice currentDevice] systemVersion];
			BOOL osVersionSupported = ([currSysVer compare:reqSysVer options:NSNumericSearch] !=NSOrderedAscending);
			available = (gcClass && osVersionSupported)?1:2;
			return (gcClass && osVersionSupported);
		}
			break;
	}
}

+ (void)connectGameCenter
{
	static bool connected = NO;
	if (!connected)
	{
#ifdef DEBUGGING
		NSLog(@"게임센터 연결 시도");
#endif
		if([GKLocalPlayer localPlayer].authenticated == NO) //게임센터 로그인이 아직일때
			[[GKLocalPlayer localPlayer] authenticateWithCompletionHandler:^(NSError* error){
				if(error == NULL){
#ifdef DEBUGGING
					NSLog(@"게임센터 로그인 성공");
#endif
				} else {
#ifdef DEBUGGING
					NSLog(@"게임센터 로그인 에러");
#endif
				}
			}];
	}
}

+ (void)sendScore:(int)_score Of:(NSString *)type
{
	if ([GKLocalPlayer localPlayer].authenticated == YES)
	{
		GKScore* score = [[[GKScore alloc] initWithCategory:type]autorelease];
        // type : 게임센터에서 설정한 Leaderboard ID
		score.value = _score;
		
		/*
		 [[GKAchievementHandler defaultHandler] notifyAchievementTitle:@"NBank Point!"andMessage:[NSString stringWithFormat:@"NBank Point %d점을 기록하셨습니다.",_score]];*/
		NSString *title;
		NSString *message;
		if ([type isEqualToString:@"level"])
		{
			title = @"독도 지키기 성공!";
			message = [NSString stringWithFormat:@"%d일 째 독도 지키기 성공!", _score];
		}
		else
		{
		}
		if (title)
		{
            // 게임센터 노티 띄우기
			[GKNotificationBanner showBannerWithTitle:title message:message completionHandler:^{} ];
			
            // 점수 전송
			[score reportScoreWithCompletionHandler:^(NSError* error){
				if(error != NULL){
                    // Retain the score object and try again later (not shown).
					
				}
			}];
		}
	}
}

+ (void)showLeaderboardOnViewController:(UIViewController<GKLeaderboardViewControllerDelegate> *)controller
{
	GKLeaderboardViewController *leaderboardController = [[[GKLeaderboardViewController alloc] init]autorelease];
	if (leaderboardController != nil)
	{
		leaderboardController.leaderboardDelegate = controller;
		[controller presentModalViewController:leaderboardController animated: YES];
	}
}

+ (void)showArchboardOnViewController:(UIViewController<GKAchievementViewControllerDelegate> *)controller
{
	GKAchievementViewController *archiveController = [[[GKAchievementViewController alloc] init] autorelease];
	
	if (archiveController != nil)
	{
		archiveController.achievementDelegate = controller;
		
		[controller presentModalViewController:archiveController animated: YES];
	}
}


@end
