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
    NSUInteger money;

    // user setting value
    BOOL backSound;         // back ground sound
    BOOL vibration;         // 진동
    
    NSDictionary *stageInfo;
}

//@property (readwrite) NSUInteger money;
//@property (readwrite) BOOL backSound;
//@property (readwrite) BOOL vibration;
//@property (readonly) NSDictionary *stageInfo;

+ (UserData *)userData;

- (BOOL)saveToFile;
- (BOOL)removeToFile;
- (BOOL)setToFile;

- (BOOL)buyStage:(NSNumber *)stage;

@end
