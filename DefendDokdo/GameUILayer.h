//
//  GameUILayer.h
//  DefendDokdo
//
//  Created by 전 수열 on 11. 11. 1..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GameScene.h"

@interface GameUILayer : CCLayer {
    
    //CCSPrite* hpgague;
    NSMutableArray* skills;
    CCSprite* hpBar;
    CCSprite* hpBarBg;
    
    CCSprite* mpBar;
    CCSprite* mpBarBg;

    CCSprite* hplabel;
    CCSprite* mplabel;
    
    GameScene* _gameScene;

    CCLabelTTF* hp;
    CCLabelTTF* mp;
    
    CCSprite* slot1Shadow;
    CCSprite* slot2Shadow;
    CCSprite* slot3Shadow;
    
    NSInteger slot1Count;
    NSInteger slot1MaxCount;
    
    NSInteger slot2Count;
    NSInteger slot2MaxCount;
    
    NSInteger slot3Count;
    NSInteger slot3MaxCount;
    
}

@property (retain, nonatomic) NSMutableArray* skills;


- (id)initWithScene:(GameScene* )gameScene;
- (void) update;
@end
