	//
	//  UserData.h
	//  MartRush
	//
	//  Created by omniavinco on 11. 10. 13..
	//  Copyright (c) 2011년 Joyfl. All rights reserved.
	//

#import <Foundation/Foundation.h>
#import <GameKit/GameKit.h>


@interface UserData : NSObject
{
@public
    // game state 
    NSUInteger point;
	NSUInteger stageLevel;

	// user skill
	NSMutableDictionary* skillSlot;				// 슬롯 갯수 확인
	NSMutableDictionary* userSkillSlot;			// 슬롯 내부 스킬 확인
	
	NSUInteger stoneLevel;
	NSUInteger arrowLevel;
	NSUInteger hillLevel;
	NSUInteger earthquakeLevel; 
	
	// user upgrade levels
	NSUInteger flagLevel;
	NSUInteger userAtkLevel;
	NSUInteger userMaxMpLevel;
	NSUInteger userMPspeedLevel;
	
    // user setting value
	BOOL backSound;         // back ground sound
	BOOL vibration;         // 진동
	
	NSDictionary *stageInfo;
}

@property (readwrite) NSUInteger point;
@property (readwrite) NSUInteger stageLevel;

@property (readwrite, retain) NSMutableDictionary* skillSlot;
@property (readwrite, retain) NSMutableDictionary* userSkillSlot;

@property (readwrite) NSUInteger flagLevel;
@property (readwrite) NSUInteger userAtkLevel;
@property (readwrite) NSUInteger userMaxMpLevel;
@property (readwrite) NSUInteger userMPspeedLevel;

@property (readwrite) NSUInteger stoneLevel;
@property (readwrite) NSUInteger arrowLevel;
@property (readwrite) NSUInteger hillLevel;
@property (readwrite) NSUInteger earthquakeLevel;

@property (readwrite) BOOL backSound;
@property (readwrite) BOOL vibration;

@property (nonatomic, retain) NSDictionary* stageInfo;

+ (UserData *)userData;

+ (BOOL)isGameCenterAvailable;
+ (void)connectGameCenter;
+ (void)sendScore:(int)_score Of:(NSString *)type;

- (BOOL)saveToFile;
- (BOOL)removeToFile;
- (BOOL)setToFile;

	//GameCenter
+ (BOOL)isGameCenterAvailable;
+ (void)connectGameCenter;
+ (void)sendScore:(int)_score Of:(NSString *)type;
+ (void)showArchboardOnViewController:(UIViewController<GKAchievementViewControllerDelegate> *)controller;
+ (void)showLeaderboardOnViewController:(UIViewController<GKLeaderboardViewControllerDelegate> *)controller;

//- (BOOL)buyStage:(NSNumber *)stage;

@end
