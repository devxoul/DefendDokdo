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
    CCMenuItemImage *menu_back;
    CCMenu *backMenu;
    
    int resetState;
    CCMenu* reset_menu;
    CCSprite* popSpr;
    CCLabelTTF* label;
	
	CCSprite* set_yes_sound;
	CCSprite* set_no_sound;
	CCSprite* set_yes_vibration;		
	CCSprite* set_no_vibration;		

	CCMenuItemImage *set_reset;
	
	CCMenu *menu;
	
    CCSprite *menuBgSprite;
    CCSprite *seaSprite;
    CCSprite *cloudSprite;
    CCSprite *dokdoSprite;
    CCSprite *sunSprite;	
 
}

+ (CCScene *)scene;

-(void)back:(id)sender;

-(void)setSound;
-(void)setVibration;
-(void)setReset:(id)sender;

@end
