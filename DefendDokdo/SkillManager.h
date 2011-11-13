//
//  SkillManager.h
//  DefendDokdo
//
//  Created by 전 수열 on 11. 11. 2..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Const.h"


@class GameScene, Arrow, Stone;

@interface SkillManager : CCNode {
	GameScene *_gameScene;
    Stone* stone;    
    Arrow* arrow;
    NSInteger skillState;
}

@property (readwrite) NSInteger skillState;
@property (nonatomic, retain) Stone* stone;
@property (nonatomic, retain) Arrow* arrow;

- (void) createStone:(CGPoint)location;
- (void) createArrow:(CGPoint)location;
- (void) createEarthQuake;
- (id) initWithGameScene:(GameScene *)gameScene;
- (void) update;

@end
