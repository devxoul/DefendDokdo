//
//  Player.h
//  DefendDokdo
//
//  Created by 전 수열 on 11. 11. 2..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class UserData, GameLayer, SkillData;

@interface Player : NSObject {
	NSInteger power;
	NSInteger maxMp;
	NSInteger mp;
	NSInteger mpSpeed;
	
	NSMutableArray *slots;
	
	NSInteger currentLoop;
	NSInteger mpFrequency;
}

@property (nonatomic) NSInteger power;
@property (nonatomic) NSInteger maxMp;
@property (nonatomic) NSInteger mp;
@property (nonatomic) NSInteger mpSpeed;

@property (nonatomic, retain) NSMutableArray *slots;

- (void)init:(GameLayer*)scene;
- (void)update;
@end
