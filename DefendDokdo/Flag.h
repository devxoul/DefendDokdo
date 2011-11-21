//
//  Flag.h
//  DefendDokdo
//
//  Created by 전 수열 on 11. 11. 1..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class GameLayer, UserData, SkillData;

@interface Flag : NSObject {

	NSInteger level;
    NSInteger maxHp;
	NSInteger hp;
	
	CCSprite *flagSpr;
}

- (void)init:(GameLayer*)scene;

@property (nonatomic) NSInteger level;
@property (nonatomic) NSInteger maxHp;
@property (nonatomic) NSInteger hp;

@property (nonatomic, retain) CCSprite *flagSpr;

@end
