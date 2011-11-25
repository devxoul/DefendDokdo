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


@class GameScene, Arrow;

@interface SkillManager : CCNode {
	GameScene *_gameScene;
    NSInteger skillState;
    Arrow *arrow;
    NSMutableArray *stoneArray;
    NSInteger earthQuakeCount;
    
    CCSprite* healSpr;
    CCAnimate* healingAnimation;
    
    NSInteger earthQuakeSlot;
    NSInteger stoneSlot;
    NSInteger healSlot;
    NSInteger arrowSlot;
    
    CCSpriteBatchNode* healBatchNode;
}

@property (readwrite) NSInteger skillState;
@property (readonly, retain) Arrow *arrow;
@property (readonly, retain) NSMutableArray *stoneArray;

- (id) initWithGameScene:(GameScene *)gameScene;

- (void) createStone:(CGPoint)location;
- (void) createArrow:(CGPoint)location;
- (void) createEarthQuake;
- (void) update;
- (void) endQuake:(id)sender;
- (void) shakyPlus:(id)sender;
- (void) shakyMinus:(id)sender;
- (void) doHeal;
- (void) initHealingAnimation;

- (BOOL) useMp:(CGFloat)mp;

@end
