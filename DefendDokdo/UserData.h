//
//  UserData.h
//  MartRush
//
//  Created by omniavinco on 11. 10. 13..
//  Copyright (c) 2011년 Joyfl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserData : NSObject
{
@public
    // game state 
    NSUInteger point;
	NSUInteger stageLevel;

	// user skill
	NSMutableArray* skillSlot;				// 슬롯 갯수 확인
	NSMutableArray* userSkillSlot;	// 슬롯 내부 스킬 확인
	NSMutableArray* userSkill;				// 스킬 레벨
	
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

@property (nonatomic, retain) NSMutableArray* skillSlot;
@property (nonatomic, retain) NSMutableArray* userSkillSlot;
@property (nonatomic, retain) NSMutableArray* userSkill;

@property (readwrite) NSUInteger flagLevel;
@property (readwrite) NSUInteger userAtkLevel;
@property (readwrite) NSUInteger userMaxMpLevel;
@property (readwrite) NSUInteger UserMpspeedLevel;

@property (readwrite) BOOL backSound;
@property (readwrite) BOOL vibration;

@property (nonatomic, retain) NSDictionary* stageInfo;

+ (UserData *)userData;

- (BOOL)saveToFile;
- (BOOL)removeToFile;
- (BOOL)setToFile;

//- (BOOL)buyStage:(NSNumber *)stage;

@end
