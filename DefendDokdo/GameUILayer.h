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
	
	CCLabelTTF *moneyLabel;

    CCLabelTTF* hp;
    CCLabelTTF* mp;
    
    CCLabelTTF* slot1MpLabel;    
    CCLabelTTF* slot2MpLabel;
    CCLabelTTF* slot3MpLabel;
    
    CCSprite* slot1Shadow;
    CCSprite* slot2Shadow;
    CCSprite* slot3Shadow;
    
    /*    
    CCSprite* slot1MpShadow;
    CCSprite* slot2MpShadow;
    CCSprite* slot3MpShadow;
    */  
    NSInteger slot1Count;
    NSInteger slot1MaxCount;
    
    NSInteger slot2Count;
    NSInteger slot2MaxCount;
    
    NSInteger slot3Count;
    NSInteger slot3MaxCount;
    

	CCSprite *pauseBg;
	CCMenuItemImage *pauseBtn;
	CCMenu *pauseMenu;

    NSInteger slotState;
    
    NSInteger slot1Mp;
    NSInteger slot2Mp;
    NSInteger slot3Mp;
}

@property (retain, nonatomic) NSMutableArray* skills;


@property (readwrite)NSInteger slot1Count;
@property (readonly)NSInteger slot1MaxCount;

@property (readwrite)NSInteger slot2Count;
@property (readonly)NSInteger slot2MaxCount;

@property (readwrite)NSInteger slot3Count;
@property (readonly) NSInteger slot3MaxCount;

@property (readwrite) NSInteger slotState;

- (id)initWithScene:(GameScene* )gameScene;
- (void) update;
@end
