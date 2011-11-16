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
    
    NSInteger maxHp;
    NSInteger maxMp;
    
    NSInteger currentHp;
    NSInteger currentMp;
    
    GameScene* _gameScene;
    
}

@property (retain, nonatomic) NSMutableArray* skills;


- (id)initWithScene:(GameScene* )gameScene;
- (void) update;
@end
