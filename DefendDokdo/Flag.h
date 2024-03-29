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
    CGFloat maxHp;
	CGFloat hp;
	
	CCSpriteBatchNode *flagBatchNode;
	CCSprite *flagSpr;
	CCAnimate *flagAnimation;
}

- (void)init:(GameLayer*)scene;
- (void)update;
@property (nonatomic) NSInteger level;
@property (nonatomic) CGFloat maxHp;
@property (nonatomic) CGFloat hp;

@property (nonatomic, retain) CCSprite *flagSpr;

@end
