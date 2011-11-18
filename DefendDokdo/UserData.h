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
	NSMutableArray* userSkillSlot;			// 슬롯 내부 스킬 확인
	
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

@property (nonatomic, retain) NSMutableArray* skillSlot;
@property (nonatomic, retain) NSMutableArray* userSkillSlot;

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

- (BOOL)saveToFile;
- (BOOL)removeToFile;
- (BOOL)setToFile;

//- (BOOL)buyStage:(NSNumber *)stage;

@end
