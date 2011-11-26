//
//  UpgradeLayer.h
//  DefendDokdo
//
//  Created by 전 수열 on 11. 11. 1..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface UpgradeLayer : CCLayer <UIAlertViewDelegate> {
   
    CCSprite *upgradeBgSprite;
    CCSprite *tab1BgSprite;
    CCSprite *tab2BgSprite;
    CCSprite *tab3BgSprite;
    CCSprite *itemSlotBgSprite;
    
    CCSprite *lock1;//위에 슬롯 자물쇠
    CCSprite *lock2;
    CCSprite *lock3;
    
    CCSprite *slot1;//위에 슬롯 터치 확인할 스프라이트 
    CCSprite *slot2;
    CCSprite *slot3;
    
    CCSprite *slot_stone1;
    CCSprite *slot_stone2;
    CCSprite *slot_stone3;
    
    CCSprite *slot_arrow1;
    CCSprite *slot_arrow2;
    CCSprite *slot_arrow3;

    CCSprite *slot_hill1;
    CCSprite *slot_hill2;
    CCSprite *slot_hill3;
    
    CCSprite *slot_earthquake1;
    CCSprite *slot_earthquake2;
    CCSprite *slot_earthquake3;
   
    CCSprite *slotItem1; //메뉴버튼 옆에 아이콘처럼 들어갈 사진 
    CCSprite *slotItem2;
    CCSprite *slotItem3;
    CCSprite *slotItem4;
    CCSprite *slotItem5;
    CCSprite *slotItem6;
    CCSprite *slotItem7;
    CCSprite *slotItem8;
    CCSprite *slotItem9;
    CCSprite *slotItem10;
    CCSprite *slotItem11;
    CCSprite *slotItem12;
    
    CCMenuItemImage *menu_back;
    CCMenuItemImage *tab1;
    CCMenuItemImage *tab2;
    CCMenuItemImage *tab3;
    
    CCMenuItemImage *upgradeMenuItem1;
    CCMenuItemImage *upgradeMenuItem2;
    CCMenuItemImage *upgradeMenuItem3;
    CCMenuItemImage *upgradeMenuItem4;
    
    CCMenuItemImage *selectMenuItem1;
    CCMenuItemImage *selectMenuItem2;
    
    CCMenuItemImage *selectMenuItem3;
    CCMenuItemImage *selectMenuItem4;
    
    CCMenuItemImage *selectMenuItem5;
    CCMenuItemImage *selectMenuItem6;
    
    CCMenuItemImage *selectMenuItem7;
    CCMenuItemImage *selectMenuItem8;
    
    CCSprite *tabItemSprite1;
    CCSprite *tabItemSprite2;
    CCSprite *tabItemSprite3;
    CCSprite *tabItemSprite4;
    CCSprite *tabItemSprite5;
    CCSprite *tabItemSprite6;
    CCSprite *tabItemSprite7;
    CCSprite *tabItemSprite8;
    CCSprite *tabItemSprite9;
    CCSprite *tabItemSprite10;
    CCSprite *tabItemSprite11;
    CCSprite *tabItemSprite12;
    
    CCMenu *backMenu;
    CCMenu *tabMenu; 
    CCMenu *upgradeMenu1;
    
    CCMenu *selectMenu1;
    CCMenu *selectMenu2;
    CCMenu *selectMenu3;
    CCMenu *selectMenu4;
    
    CCLabelTTF *moneyLabel;
    
    CCLabelTTF *upgradeLabel1;
    CCLabelTTF *upgradeLabel2;
    CCLabelTTF *upgradeLabel3;
    CCLabelTTF *upgradeLabel4;
    CCLabelTTF *upgradeLabel5;
    CCLabelTTF *upgradeLabel6;
    CCLabelTTF *upgradeLabel7;
    CCLabelTTF *upgradeLabel8;
//    CCLabelTTF *upgradeLabel9;
//    CCLabelTTF *upgradeLabel10;
//    CCLabelTTF *upgradeLabel11;
//    CCLabelTTF *upgradeLabel12;
    
    int tabState;
    int buttonState;
    int slotState;
    
    int upgradeButtonState;
    
    //팝업
    CCMenu* reset_menu;
    CCSprite* popSpr;
    CCLabelTTF* label;
    
    CCMenu* reset_menu2;
    CCSprite* popSpr2;
    CCLabelTTF* label2;
    
}

-(void)back;

-(void)tab1Clicked:(id)sender;
-(void)tab2Clicked:(id)sender;
-(void)tab3Clicked:(id)sender;

-(void)selectButton1:(id)sender;
-(void)selectButton2:(id)sender;
-(void)selectButton3:(id)sender;
-(void)selectButton4:(id)sender;

-(void)upgradeItem;
-(void)setSlotItem:(id)sender;
-(void)buySlotItem:(id)sender;
-(void)deleteSlotItem:(id)sender;

+ (CCScene *)scene;

@end
