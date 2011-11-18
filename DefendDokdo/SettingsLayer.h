//
//  SettingsLayer.h
//  DefendDokdo
//
//  Created by 전 수열 on 11. 11. 1..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class UserData, MainLayer;

@interface SettingsLayer : CCLayer {

	CCSprite *settingBgSprite;
    CCSprite *setOff[2];
    
    CCMenuItemImage *menu_back;
    CCMenu *backMenu;
    
    int resetState;
    CCMenu* reset_menu;
    CCSprite* popSpr;
    CCLabelTTF* label;
 
}

+ (CCScene *)scene;

-(void)back:(id)sender;

-(void)setSound:(id)sender;
-(void)setVibration:(id)sender;
-(void)setReset:(id)sender;

@end
