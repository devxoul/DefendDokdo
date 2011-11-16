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
	NSMutableArray* skillSlot;
	NSDictionary* userSkill;	// 구매한 스킬과 레벨
	
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
@property (nonatomic, retain) NSDictionary* userSkill;

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
