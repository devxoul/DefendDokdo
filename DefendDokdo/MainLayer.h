//
//  MainLayer.h
//  DefendDokdo
//
//  Created by 전 수열 on 11. 11. 1..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class IntroLayer;
@class TutorialLayer;
@class GameScene;
@class InfoLayer;

@interface MainLayer : CCLayer {
    
    CCSprite *menuBgSprite;
    CCSprite *seaSprite;
    CCSprite *cloudSprite;
    CCSprite *dokdoSprite;
    CCSprite *sunSprite;
    
    CCMenuItemImage * mainmenu[3];
    
    CCMenuItemImage *arrow;
    CCMenuItemImage *menu_facebook;
    CCMenuItemImage *menu_ranking;
    CCMenuItemImage *menu_info;
    
    CCMenuItemImage *menu_setting;
    CCMenuItemImage *menu_back;
    
    CCMenu *settingMenu;
    CCMenu *arrowMenu;
    CCMenu *menu_more;    
    
}

+ (CCScene *)scene;

-(void)moveIntro:(id)sender;
-(void)moveGame:(id)sender;
-(void)moveSetting:(id)sender;


-(void)moveFacebook:(id)sender;
-(void)moveRank:(id)sender;
-(void)moveInfo:(id)sender;

@end

