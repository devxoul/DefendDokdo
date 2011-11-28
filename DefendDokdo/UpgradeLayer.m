//
//  UpgradeLayer.m
//  DefendDokdo
//
//  Created by 전 수열 on 11. 11. 1..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import "SimpleAudioEngine.h"

#import "UpgradeLayer.h"

#import "MainLayer.h"
#import "UserData.h"
#import "SkillData.h"
#import "Const.h"
#import "ResultLayer.h"

@implementation UpgradeLayer

+ (CCScene *)scene
{
	CCScene *scene = [CCScene node];
	UpgradeLayer *layer = [UpgradeLayer node];
    layer.isTouchEnabled = YES;
	[scene addChild:layer];
	return scene;
}

- (id)init
{
	if( self = [super init] )
	{
        tabState = 0;
        buttonState = 0;
		upgradeButtonState = 0;
        
        //배경
        //        upgradeBgSprite = [[CCSprite alloc] initWithFile:@"dokdo_bg.jpg"];
        //        upgradeBgSprite.anchorPoint = CGPointZero;
        //		[upgradeBgSprite setPosition:ccp(0, 0)];
        //        [self addChild:upgradeBgSprite z:-1];
        
        //탭배경 
        tab1BgSprite = [[CCSprite alloc] initWithFile:@"tab_dialog_bg.png"];
        tab1BgSprite.anchorPoint = CGPointZero;
        //        [tab1BgSprite setPosition:ccp(70, 15)];
        [tab1BgSprite setPosition:ccp(0, 0)];
        [self addChild:tab1BgSprite z:0];
        
        tab2BgSprite = [[CCSprite alloc] initWithFile:@"skill_tab_bg.png"];
        tab2BgSprite.anchorPoint = CGPointZero;
        tab2BgSprite.position = tab1BgSprite.position;
        [self addChild:tab2BgSprite z:-1];
        tab2BgSprite.visible = NO;
        
        tab3BgSprite = [[CCSprite alloc] initWithFile:@"cash_tab_bg.png"];
        tab3BgSprite.anchorPoint = CGPointZero;
        tab3BgSprite.position = tab1BgSprite.position;
        [self addChild:tab3BgSprite z:-2];
        tab3BgSprite.visible = NO;
		
        //왼쪽 탭버튼
        tab1 = [CCMenuItemImage itemFromNormalImage:@"upgrade_on_tab_btn.png" selectedImage:@"upgrade_off_tab_btn.png" target:self selector:@selector(tab1Clicked:)];
        tab1.anchorPoint = CGPointZero;
        [tab1 setPosition:ccp(46, 167)];
        
        tab2 = [CCMenuItemImage itemFromNormalImage:@"skill_on_tab_btn.png" selectedImage:@"skill_off_tab_btn.png" target:self selector:@selector(tab2Clicked:)];
        tab2.anchorPoint = CGPointZero;
        [tab2 setPosition:ccp(46, 95)];
        
        tab3 = [CCMenuItemImage itemFromNormalImage:@"cash_on_tab_btn.png" selectedImage:@"cash_off_tab_btn.png" target:self selector:@selector(tab3Clicked:)];
        tab3.anchorPoint = CGPointZero;
        [tab3 setPosition:ccp(46, 23)];
        
        tabMenu = [CCMenu menuWithItems:tab1, tab2, tab3, nil];
        tabMenu.anchorPoint = CGPointZero;
        tabMenu.position = ccp(0, 0);
        [self addChild:tabMenu z:1];
        
        //안에 버튼 1 (메뉴+아이템사진)
        upgradeMenuItem1 = [CCMenuItemImage itemFromNormalImage:@"upgrade_on_btn2.png" selectedImage:@"upgrade_off_btn2.png" target:self selector:@selector(selectButton1:)];
        [upgradeMenuItem1 setAnchorPoint:CGPointZero];
        [upgradeMenuItem1 setPosition:ccp(91, 132)];
        
        tabItemSprite1 = [[CCSprite alloc] initWithFile:@"flag_btn.png"];
        tabItemSprite1.anchorPoint = CGPointZero;
		[tabItemSprite1 setPosition:ccp(110, 143)];
        [self addChild:tabItemSprite1 z:6];
        
        tabItemSprite5 = [[CCSprite alloc] initWithFile:@"stone_btn.png"];
        tabItemSprite5.anchorPoint = CGPointZero;
		[tabItemSprite5 setPosition:ccp(110, 143)];
        [self addChild:tabItemSprite5 z:5];
        
        tabItemSprite9 = [[CCSprite alloc] initWithFile:@"money_btn.png"];
        tabItemSprite9.anchorPoint = CGPointZero;
		[tabItemSprite9 setPosition:ccp(110, 143)];
        [self addChild:tabItemSprite9 z:4];
        
        //안에 버튼 2 (메뉴+아이템사진)
        upgradeMenuItem2 = [CCMenuItemImage itemFromNormalImage:@"upgrade_on_btn2.png" selectedImage:@"upgrade_off_btn2.png" target:self selector:@selector(selectButton2:)];
        [upgradeMenuItem2 setAnchorPoint:CGPointZero];
        [upgradeMenuItem2 setPosition:ccp(260, 132)];
        
        tabItemSprite2 = [[CCSprite alloc] initWithFile:@"atk_btn.png"];
        tabItemSprite2.anchorPoint = CGPointZero;
		[tabItemSprite2 setPosition:ccp(279, 143)];
        [self addChild:tabItemSprite2 z:6];
        
        tabItemSprite6 = [[CCSprite alloc] initWithFile:@"arrow_btn.png"];
        tabItemSprite6.anchorPoint = CGPointZero;
		[tabItemSprite6 setPosition:ccp(279, 143)];
        [self addChild:tabItemSprite6 z:5];
        
        tabItemSprite10 = [[CCSprite alloc] initWithFile:@"money_btn.png"];
        tabItemSprite10.anchorPoint = CGPointZero;
		[tabItemSprite10 setPosition:ccp(279, 143)];
        [self addChild:tabItemSprite10 z:4];
        
        //안에 버튼 3 (메뉴+아이템사진)
        upgradeMenuItem3 = [CCMenuItemImage itemFromNormalImage:@"upgrade_on_btn2.png" selectedImage:@"upgrade_off_btn2.png" target:self selector:@selector(selectButton3:)];
        [upgradeMenuItem3 setAnchorPoint:CGPointZero];
        [upgradeMenuItem3 setPosition:ccp(91, 36)];
        
        tabItemSprite3 = [[CCSprite alloc] initWithFile:@"maxmp_btn.png"];
        tabItemSprite3.anchorPoint = CGPointZero;
		[tabItemSprite3 setPosition:ccp(110, 45)];
        [self addChild:tabItemSprite3 z:6];
        
        tabItemSprite7 = [[CCSprite alloc] initWithFile:@"heal_btn.png"];
        tabItemSprite7.anchorPoint = CGPointZero;
		[tabItemSprite7 setPosition:ccp(110, 45)];
        [self addChild:tabItemSprite7 z:5];
        
        tabItemSprite11 = [[CCSprite alloc] initWithFile:@"money_btn.png"];
        tabItemSprite11.anchorPoint = CGPointZero;
		[tabItemSprite11 setPosition:ccp(110, 45)];
        [self addChild:tabItemSprite11 z:4];
        
        //안에 버튼 4 (메뉴+아이템사진)
        upgradeMenuItem4 = [CCMenuItemImage itemFromNormalImage:@"upgrade_on_btn2.png" selectedImage:@"upgrade_off_btn2.png" target:self selector:@selector(selectButton4:)];
        [upgradeMenuItem4 setAnchorPoint:CGPointZero];
        [upgradeMenuItem4 setPosition:ccp(260, 36)];
        
        tabItemSprite4 = [[CCSprite alloc] initWithFile:@"mp_btn.png"];
        tabItemSprite4.anchorPoint = CGPointZero;
		[tabItemSprite4 setPosition:ccp(279, 45)];
        [self addChild:tabItemSprite4 z:6];
        
        tabItemSprite8 = [[CCSprite alloc] initWithFile:@"esqueke_btn.png"];
        tabItemSprite8.anchorPoint = CGPointZero;
		[tabItemSprite8 setPosition:ccp(279, 45)];
        [self addChild:tabItemSprite8 z:5];
        
        tabItemSprite12 = [[CCSprite alloc] initWithFile:@"money_btn.png"];
        tabItemSprite12.anchorPoint = CGPointZero;
		[tabItemSprite12 setPosition:ccp(279, 45)];
        [self addChild:tabItemSprite12 z:4];
        
        upgradeMenu1 = [CCMenu menuWithItems:upgradeMenuItem1, upgradeMenuItem2, upgradeMenuItem3, upgradeMenuItem4, nil];
        upgradeMenu1.anchorPoint = CGPointZero;
        [upgradeMenu1 setPosition:ccp(0, 0)];
        [self addChild: upgradeMenu1 z:2];
        
        //버튼라벨
        upgradeLabel1 = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Lv %d",[[UserData userData] flagLevel]] dimensions:CGSizeMake(0,0) alignment:UITextAlignmentCenter fontName:@"NanumScript.ttf" fontSize:30]; 
        //        [[CCLabelTTF labelWithString:[NSString stringWithFormat:@"태극기"] fontName:@"NanumScript.ttf" fontSize:30] retain];
        
        [self addChild:upgradeLabel1 z:5];
        
        [upgradeLabel1 setColor:ccc3(0, 0, 0)];
        [upgradeLabel1 setAnchorPoint:CGPointZero];
        [upgradeLabel1 setPosition:CGPointMake(190, 170)];
        
        upgradeLabel2 = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d G", [[SkillData skillData] getSkillPrice:UPGRADE_TYPE_FLAG :[[UserData userData] flagLevel]]] dimensions:CGSizeMake(0,0) alignment:UITextAlignmentCenter fontName:@"NanumScript.ttf" fontSize:20]; 
        
        [self addChild:upgradeLabel2 z:8];
        
        [upgradeLabel2 setColor:ccc3(0, 0, 0)];
        [upgradeLabel2 setAnchorPoint:CGPointZero];
        [upgradeLabel2 setPosition:CGPointMake(190, 150)];
        
        upgradeLabel3 = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Lv %d",[[UserData userData] userAtkLevel]] dimensions:CGSizeMake(0,0) alignment:UITextAlignmentCenter fontName:@"NanumScript.ttf" fontSize:30];
        
        [self addChild:upgradeLabel3 z:8];
        
        [upgradeLabel3 setColor:ccc3(0, 0, 0)];
        [upgradeLabel3 setAnchorPoint:CGPointZero];
        [upgradeLabel3 setPosition:CGPointMake(359, 170)];
        
        upgradeLabel4 = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d G", [[SkillData skillData] getSkillPrice:UPGRADE_TYPE_ATTACK :[[UserData userData] userAtkLevel]]] dimensions:CGSizeMake(0,0) alignment:UITextAlignmentCenter fontName:@"NanumScript.ttf" fontSize:20];
        
        [self addChild:upgradeLabel4 z:8];
        
        [upgradeLabel4 setColor:ccc3(0, 0, 0)];
        [upgradeLabel4 setAnchorPoint:CGPointZero];
        [upgradeLabel4 setPosition:CGPointMake(359, 150)];
        
        upgradeLabel5 = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Lv %d",[[UserData userData] userMaxMpLevel]] dimensions:CGSizeMake(0,0) alignment:UITextAlignmentCenter fontName:@"NanumScript.ttf" fontSize:30]; 
        
        [self addChild:upgradeLabel5 z:8];
        
        [upgradeLabel5 setColor:ccc3(0, 0, 0)];
        [upgradeLabel5 setAnchorPoint:CGPointZero];
        [upgradeLabel5 setPosition:CGPointMake(190, 75)];
        
        upgradeLabel6 = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d G", [[SkillData skillData] getSkillPrice:UPGRADE_TYPE_MAXMP :[[UserData userData] userMaxMpLevel]]] dimensions:CGSizeMake(0,0) alignment:UITextAlignmentCenter fontName:@"NanumScript.ttf" fontSize:20];
        
        [self addChild:upgradeLabel6 z:8];
        
        [upgradeLabel6 setColor:ccc3(0, 0, 0)];
        [upgradeLabel6 setAnchorPoint:CGPointZero];
        [upgradeLabel6 setPosition:CGPointMake(190, 55)];
        
        upgradeLabel7 = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Lv %d",[[UserData userData] userMPspeedLevel]] dimensions:CGSizeMake(0,0) alignment:UITextAlignmentCenter fontName:@"NanumScript.ttf" fontSize:30]; 
        
        [self addChild:upgradeLabel7 z:8];
        
        [upgradeLabel7 setColor:ccc3(0, 0, 0)];
        [upgradeLabel7 setAnchorPoint:CGPointZero];
        [upgradeLabel7 setPosition:CGPointMake(359, 75)];
        
        upgradeLabel8 = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d G", [[SkillData skillData] getSkillPrice:UPGRADE_TYPE_REGENMP :[[UserData userData] userMPspeedLevel]]] dimensions:CGSizeMake(0,0) alignment:UITextAlignmentCenter fontName:@"NanumScript.ttf" fontSize:20];
        
        [self addChild:upgradeLabel8 z:8];
        
        [upgradeLabel8 setColor:ccc3(0, 0, 0)];
        [upgradeLabel8 setAnchorPoint:CGPointZero];
        [upgradeLabel8 setPosition:CGPointMake(359, 55)];
        
        
        //아이템슬롯 
        itemSlotBgSprite = [[CCSprite alloc] initWithFile:@"skill_slot_img.png"];
        itemSlotBgSprite.anchorPoint = CGPointZero;
        [itemSlotBgSprite setPosition:ccp(95,255)];
        [self addChild:itemSlotBgSprite z:2];
        
        slot1 = [[CCSprite alloc] initWithFile:@"slot_empty.gif"];
        slot1.anchorPoint = CGPointZero;
        [slot1 setPosition:ccp(104, 265)];
        [self addChild:slot1 z:1];
        
        slot2 = [[CCSprite alloc] initWithFile:@"slot_empty.gif"];
        slot2.anchorPoint = CGPointZero;
        [slot2 setPosition:ccp(171, 265)];
        [self addChild:slot2 z:1];
        
        slot3 = [[CCSprite alloc] initWithFile:@"slot_empty.gif"];
        slot3.anchorPoint = CGPointZero;
        [slot3 setPosition:ccp(238, 265)];
        [self addChild:slot3 z:1];
        
        lock1 = [[CCSprite alloc] initWithFile:@"lock_img.png"];
        lock1.anchorPoint = CGPointZero;
        [lock1 setPosition:ccp(118.5, 265.5)];
        [self addChild:lock1 z:10];
        
        lock2 = [[CCSprite alloc] initWithFile:@"lock_img.png"];
        lock2.anchorPoint = CGPointZero;
        [lock2 setPosition:ccp(185.5, 265.5)];
        [self addChild:lock2 z:10];
        if([[[[UserData userData] skillSlot] objectForKey:@"2"] boolValue])
            [lock2 setVisible:NO];
        
        
        lock3 = [[CCSprite alloc] initWithFile:@"lock_img.png"];
        lock3.anchorPoint = CGPointZero;
        [lock3 setPosition:ccp(252.5, 265.5)];
        [self addChild:lock3 z:10];
        if([[[[UserData userData] skillSlot] objectForKey:@"3"] boolValue])
            [lock3 setVisible:NO];
        
        slot_stone1 = [[CCSprite alloc] initWithFile:@"stone_img.png"];
        slot_stone1.anchorPoint = CGPointZero;
        [slot_stone1 setPosition:ccp(117, 267.5)];
        [self addChild:slot_stone1 z:6];
        
        slot_arrow1 = [[CCSprite alloc] initWithFile:@"arrow_img.png"];
        slot_arrow1.anchorPoint = CGPointZero;
        [slot_arrow1 setPosition:ccp(118.5, 266)];
        [self addChild:slot_arrow1 z:7];
        
        slot_hill1 = [[CCSprite alloc] initWithFile:@"hill_img.png"];
        slot_hill1.anchorPoint = CGPointZero;
        [slot_hill1 setPosition:ccp(116, 272)];
        [self addChild:slot_hill1 z:8];
        
        slot_earthquake1 = [[CCSprite alloc] initWithFile:@"earthquake_img.png"];
        slot_earthquake1.anchorPoint = CGPointZero;
        [slot_earthquake1 setPosition:ccp(115, 269)];
        [self addChild:slot_earthquake1 z:9];
        
        slot_stone2 = [[CCSprite alloc] initWithFile:@"stone_img.png"];
        slot_stone2.anchorPoint = CGPointZero;
        [slot_stone2 setPosition:ccp(184, 267.5)];
        [self addChild:slot_stone2 z:6];
        
        slot_arrow2 = [[CCSprite alloc] initWithFile:@"arrow_img.png"];
        slot_arrow2.anchorPoint = CGPointZero;
        [slot_arrow2 setPosition:ccp(185.5, 266)];
        [self addChild:slot_arrow2 z:7];
        
        slot_hill2 = [[CCSprite alloc] initWithFile:@"hill_img.png"];
        slot_hill2.anchorPoint = CGPointZero;
        [slot_hill2 setPosition:ccp(183, 272)];
        [self addChild:slot_hill2 z:8];
        
        slot_earthquake2 = [[CCSprite alloc] initWithFile:@"earthquake_img.png"];
        slot_earthquake2.anchorPoint = CGPointZero;
        [slot_earthquake2 setPosition:ccp(182, 269)];
        [self addChild:slot_earthquake2 z:9];
        
        slot_stone3 = [[CCSprite alloc] initWithFile:@"stone_img.png"];
        slot_stone3.anchorPoint = CGPointZero;
        [slot_stone3 setPosition:ccp(251, 267.5)];
        [self addChild:slot_stone3 z:6];
        
        slot_arrow3 = [[CCSprite alloc] initWithFile:@"arrow_img.png"];
        slot_arrow3.anchorPoint = CGPointZero;
        [slot_arrow3 setPosition:ccp(252.5, 266)];
        [self addChild:slot_arrow3 z:7];
        
        slot_hill3 = [[CCSprite alloc] initWithFile:@"hill_img.png"];
        slot_hill3.anchorPoint = CGPointZero;
        [slot_hill3 setPosition:ccp(250, 272)];
        [self addChild:slot_hill3 z:8];
        
        slot_earthquake3 = [[CCSprite alloc] initWithFile:@"earthquake_img.png"];
        slot_earthquake3.anchorPoint = CGPointZero;
        [slot_earthquake3 setPosition:ccp(246.5, 269)];
        [self addChild:slot_earthquake3 z:9];
        
        lock1.visible = NO;
        
        slot_stone1.visible = NO;
        slot_stone2.visible = NO;
        slot_stone3.visible = NO;
        
        slot_arrow1.visible = NO;
        slot_arrow2.visible = NO;
        slot_arrow3.visible = NO;
        
        slot_hill1.visible = NO;
        slot_hill2.visible = NO;
        slot_hill3.visible = NO;
        
        slot_earthquake1.visible = NO;
        slot_earthquake2.visible = NO;
        slot_earthquake3.visible = NO;
        
        switch ([[[[UserData userData] userSkillSlot] objectForKey:@"1"] integerValue]) {
            case SKILL_STATE_STONE:
                [slot_stone1 setVisible:YES];
                break;                
            case SKILL_STATE_ARROW:
                [slot_arrow1 setVisible:YES];
                break;                
            case SKILL_STATE_HEALING:
                [slot_hill1 setVisible:YES];
                break;                
            case SKILL_STATE_EARTHQUAKE:
                [slot_earthquake1 setVisible:YES];
                break;                
        }
        
        switch ([[[[UserData userData] userSkillSlot] objectForKey:@"2"] integerValue]) {
            case SKILL_STATE_STONE:
                [slot_stone2 setVisible:YES];
                break;                
            case SKILL_STATE_ARROW:
                [slot_arrow2 setVisible:YES];
                break;                
            case SKILL_STATE_HEALING:
                [slot_hill2 setVisible:YES];
                break;                
            case SKILL_STATE_EARTHQUAKE:
                [slot_earthquake2 setVisible:YES];
                break;                
        }
        
        switch ([[[[UserData userData] userSkillSlot] objectForKey:@"3"] integerValue]) {
            case SKILL_STATE_STONE:
                [slot_stone3 setVisible:YES];
                break;                
            case SKILL_STATE_ARROW:
                [slot_arrow3 setVisible:YES];
                break;                
            case SKILL_STATE_HEALING:
                [slot_hill3 setVisible:YES];
                break;                
            case SKILL_STATE_EARTHQUAKE:
                [slot_earthquake3 setVisible:YES];
                break;                
        }
        
        
        //게임머니
        //        moneyLabel = [[CCLabelTTF labelWithString:[NSString stringWithFormat:@"1000"] fontName:@"NanumScript.ttf" fontSize:70] retain];
        //        
        //        [self addChild:moneyLabel z:-1];
        //        
        //        [moneyLabel setColor:ccc3(0, 0, 0)];
        //        [moneyLabel setAnchorPoint:CGPointZero];
        //        [moneyLabel setPosition:CGPointMake(370, 240)];
        
        //게임머니
		moneyLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d",[[UserData userData] point]] dimensions:CGSizeMake(200, 60) alignment:UITextAlignmentRight fontName:@"NanumScript.ttf" fontSize:40];
        
        [self addChild:moneyLabel];
        
        [moneyLabel setColor:ccc3(0, 0, 0)];
        [moneyLabel setAnchorPoint:ccp(0,0.5)];
        [moneyLabel setPosition:CGPointMake(210, 260)];
		
        
        //뒤로가기 
        menu_back = [CCMenuItemImage itemFromNormalImage:@"back_on_btn.png" selectedImage:@"back_off_btn.png" target:self selector:@selector(back)];
        menu_back.anchorPoint = CGPointZero;
        
        backMenu = [CCMenu menuWithItems:menu_back, nil];
        backMenu.anchorPoint = CGPointZero;
        [backMenu setPosition:ccp(7, 250)];
        
        [self addChild:backMenu z:2];
        
        //누르면 뜰 메뉴
        selectMenuItem1 = [CCMenuItemImage itemFromNormalImage:@"upgrade_btn.png" selectedImage:@"upgrade_btn.png" target:self selector:@selector(upgradeItem)];
        [selectMenuItem1 setAnchorPoint:CGPointZero];
        [selectMenuItem1 setPosition:ccp(91, 132)];
        
        selectMenuItem2 = [CCMenuItemImage itemFromNormalImage:@"slot_btn.png" selectedImage:@"slot_btn.png" target:self selector:@selector(setSlotItem:)];
        [selectMenuItem2 setAnchorPoint:CGPointZero];
        [selectMenuItem2 setPosition:ccp(173, 132)];
        
        selectMenu1 = [CCMenu menuWithItems:selectMenuItem1, selectMenuItem2, nil];
        selectMenu1.anchorPoint = CGPointZero;
        [selectMenu1 setPosition:ccp(0, 0)];
        [self addChild: selectMenu1 z:10];
        
        selectMenuItem3 = [CCMenuItemImage itemFromNormalImage:@"upgrade_btn.png" selectedImage:@"upgrade_btn.png" target:self selector:@selector(upgradeItem)];
        [selectMenuItem3 setAnchorPoint:CGPointZero];
        [selectMenuItem3 setPosition:ccp(260, 132)];
        
        selectMenuItem4 = [CCMenuItemImage itemFromNormalImage:@"slot_btn.png" selectedImage:@"slot_btn.png" target:self selector:@selector(setSlotItem:)];
        [selectMenuItem4 setAnchorPoint:CGPointZero];
        [selectMenuItem4 setPosition:ccp(342, 132)];
        
        selectMenu2 = [CCMenu menuWithItems:selectMenuItem3, selectMenuItem4, nil];
        selectMenu2.anchorPoint = CGPointZero;
        [selectMenu2 setPosition:ccp(0, 0)];
        [self addChild: selectMenu2 z:10];
        
        selectMenuItem5 = [CCMenuItemImage itemFromNormalImage:@"upgrade_btn.png" selectedImage:@"upgrade_btn.png" target:self selector:@selector(upgradeItem)];
        [selectMenuItem5 setAnchorPoint:CGPointZero];
        [selectMenuItem5 setPosition:ccp(91, 36)];
        
        selectMenuItem6 = [CCMenuItemImage itemFromNormalImage:@"slot_btn.png" selectedImage:@"slot_btn.png" target:self selector:@selector(setSlotItem:)];
        [selectMenuItem6 setAnchorPoint:CGPointZero];
        [selectMenuItem6 setPosition:ccp(173, 36)];
        
        selectMenu3 = [CCMenu menuWithItems:selectMenuItem5, selectMenuItem6, nil];
        selectMenu3.anchorPoint = CGPointZero;
        [selectMenu3 setPosition:ccp(0, 0)];
        [self addChild: selectMenu3 z:10];
        
        selectMenuItem7 = [CCMenuItemImage itemFromNormalImage:@"upgrade_btn.png" selectedImage:@"upgrade_btn.png" target:self selector:@selector(upgradeItem)];
        [selectMenuItem7 setAnchorPoint:CGPointZero];
        [selectMenuItem7 setPosition:ccp(260, 36)];
        
        selectMenuItem8 = [CCMenuItemImage itemFromNormalImage:@"slot_btn.png" selectedImage:@"slot_btn.png" target:self selector:@selector(setSlotItem:)];
        [selectMenuItem8 setAnchorPoint:CGPointZero];
        [selectMenuItem8 setPosition:ccp(342, 36)];
        
        selectMenu4 = [CCMenu menuWithItems:selectMenuItem7, selectMenuItem8, nil];
        selectMenu4.anchorPoint = CGPointZero;
        [selectMenu4 setPosition:ccp(0, 0)];
        [self addChild: selectMenu4 z:10];
        
        selectMenu1.visible = NO;
        selectMenu2.visible = NO;
        selectMenu3.visible = NO;
        selectMenu4.visible = NO;
		
	}
	
	return self;
}

-(void)tab1Clicked:(id)sender{
	
	if( upgradeButtonState == 1 )
		return;
	
    if ([UserData userData].backSound)
        [[SimpleAudioEngine sharedEngine] playEffect:@"click.mp3"];
    
    tab1BgSprite.visible = YES;
    tab2BgSprite.visible = NO;
    tab3BgSprite.visible = NO;
    
    tabItemSprite1.visible = YES;
    tabItemSprite2.visible = YES;
    tabItemSprite3.visible = YES;
    tabItemSprite4.visible = YES;
    
    tabItemSprite5.visible = NO;
    tabItemSprite6.visible = NO;
    tabItemSprite7.visible = NO;
    tabItemSprite8.visible = NO;
    
    tabItemSprite9.visible = NO;
    tabItemSprite10.visible = NO;
    tabItemSprite11.visible = NO;
    tabItemSprite12.visible = NO;
    
    [upgradeLabel1 setString:[NSString stringWithFormat:@"Lv %d",[[UserData userData] flagLevel]]];
    [upgradeLabel2 setString:[NSString stringWithFormat:@"%d G", [[SkillData skillData] getSkillPrice:UPGRADE_TYPE_FLAG :[[UserData userData] flagLevel]]]];
    [upgradeLabel3 setString:[NSString stringWithFormat:@"Lv %d",[[UserData userData] userAtkLevel]]];
    [upgradeLabel4 setString:[NSString stringWithFormat:@"%d G", [[SkillData skillData] getSkillPrice:UPGRADE_TYPE_ATTACK :[[UserData userData] userAtkLevel]]]];
    [upgradeLabel5 setString:[NSString stringWithFormat:@"Lv %d",[[UserData userData] userMaxMpLevel]]];
    [upgradeLabel6 setString:[NSString stringWithFormat:@"%d G", [[SkillData skillData] getSkillPrice:UPGRADE_TYPE_MAXMP :[[UserData userData] userMaxMpLevel]]]];
    [upgradeLabel7 setString:[NSString stringWithFormat:@"Lv %d",[[UserData userData] userMPspeedLevel]]];
    [upgradeLabel8 setString:[NSString stringWithFormat:@"%d G", [[SkillData skillData] getSkillPrice:UPGRADE_TYPE_REGENMP :[[UserData userData] userMPspeedLevel]]]];
    
    //    [selectMenu1 cleanup];
    //    [selectMenu2 cleanup];
    //    [selectMenu3 cleanup];
    //    [selectMenu4 cleanup];
    //    
    //    [selectMenuItem1 cleanup];
    //    [selectMenuItem2 cleanup];
    //    [selectMenuItem3 cleanup];
    //    [selectMenuItem4 cleanup];
    //    [selectMenuItem5 cleanup];
    //    [selectMenuItem6 cleanup];
    //    [selectMenuItem7 cleanup];
    //    [selectMenuItem8 cleanup];
    
    selectMenu1.visible = NO;
    selectMenu2.visible = NO;
    selectMenu3.visible = NO;
    selectMenu4.visible = NO;
    
    tabState = 0;
}

-(void)tab2Clicked:(id)sender{
	
	if( upgradeButtonState == 1 )
		return;
	
    if ([UserData userData].backSound)
        [[SimpleAudioEngine sharedEngine] playEffect:@"click.mp3"];
    
    tab1BgSprite.visible = NO;
    tab2BgSprite.visible = YES;
    tab3BgSprite.visible = NO;
    
    tabItemSprite1.visible = NO;
    tabItemSprite2.visible = NO;
    tabItemSprite3.visible = NO;
    tabItemSprite4.visible = NO;
    
    tabItemSprite5.visible = YES;
    tabItemSprite6.visible = YES;
    tabItemSprite7.visible = YES;
    tabItemSprite8.visible = YES;
    
    tabItemSprite9.visible = NO;
    tabItemSprite10.visible = NO;
    tabItemSprite11.visible = NO;
    tabItemSprite12.visible = NO;
    
    
    [upgradeLabel1 setString:[NSString stringWithFormat:@"Lv %d",[[UserData userData] stoneLevel]]];
    [upgradeLabel2 setString:[NSString stringWithFormat:@"%d G", [[SkillData skillData] getSkillPrice:SKILL_STATE_STONE :[[UserData userData] stoneLevel]]]];
    [upgradeLabel3 setString:[NSString stringWithFormat:@"Lv %d",[[UserData userData] arrowLevel]]];
    [upgradeLabel4 setString:[NSString stringWithFormat:@"%d G", [[SkillData skillData] getSkillPrice:SKILL_STATE_ARROW :[[UserData userData] arrowLevel]]]];
    [upgradeLabel5 setString:[NSString stringWithFormat:@"Lv %d",[[UserData userData] hillLevel]]];
    [upgradeLabel6 setString:[NSString stringWithFormat:@"%d G", [[SkillData skillData] getSkillPrice:SKILL_STATE_HEALING :[[UserData userData] hillLevel]]]];
    [upgradeLabel7 setString:[NSString stringWithFormat:@"Lv %d",[[UserData userData] earthquakeLevel]]];
    [upgradeLabel8 setString:[NSString stringWithFormat:@"%d G", [[SkillData skillData] getSkillPrice:SKILL_STATE_EARTHQUAKE :[[UserData userData] earthquakeLevel]]]];
    
    selectMenu1.visible = NO;
    selectMenu2.visible = NO;
    selectMenu3.visible = NO;
    selectMenu4.visible = NO;
    
    tabState = 1;
    
}

-(void)tab3Clicked:(id)sender{
	
	if( upgradeButtonState == 1 )
		return;
    
    if ([UserData userData].backSound)
        [[SimpleAudioEngine sharedEngine] playEffect:@"click.mp3"];    
	
    tab1BgSprite.visible = NO;
    tab2BgSprite.visible = NO;
    tab3BgSprite.visible = YES;
    
    tabItemSprite1.visible = NO;
    tabItemSprite2.visible = NO;
    tabItemSprite3.visible = NO;
    tabItemSprite4.visible = NO;
    
    tabItemSprite5.visible = NO;
    tabItemSprite6.visible = NO;
    tabItemSprite7.visible = NO;
    tabItemSprite8.visible = NO;
    
    tabItemSprite9.visible = YES;
    tabItemSprite10.visible = YES;
    tabItemSprite11.visible = YES;
    tabItemSprite12.visible = YES;
    
    [upgradeLabel1 setString:@"1000G"];
    [upgradeLabel2 setString:@"0.99$"];
    [upgradeLabel3 setString:@"2500G"];
    [upgradeLabel4 setString:@"1.99$"];
    [upgradeLabel5 setString:@"4000G"];
    [upgradeLabel6 setString:@"2.99$"];
    [upgradeLabel7 setString:@"6500G"];
    [upgradeLabel8 setString:@"4.99$"];
    
    selectMenu1.visible = NO;
    selectMenu2.visible = NO;
    selectMenu3.visible = NO;
    selectMenu4.visible = NO;
    
    tabState = 2;
    
}

-(void)selectButton1:(id)sender{
	
	if( upgradeButtonState == 1 )
		return;
    
    if ([UserData userData].backSound)
        [[SimpleAudioEngine sharedEngine] playEffect:@"click.mp3"];    
	
    buttonState = 1;
    
    switch (tabState) {
        case 0:
            [self upgradeItem];
            break;
            
        case 1:
            selectMenu1.visible = YES;
            selectMenu2.visible = NO;
            selectMenu3.visible = NO;
            selectMenu4.visible = NO;
            
            break;
            
        case 2:
            [self upgradeItem];
            break;
            
        default:
            break;
    }
    
}

-(void)selectButton2:(id)sender{
	
	if( upgradeButtonState == 1 )
		return;
    
    if ([UserData userData].backSound)
        [[SimpleAudioEngine sharedEngine] playEffect:@"click.mp3"];    
    
    buttonState = 2;
    
    switch (tabState) {
        case 0:
            [self upgradeItem];
            break;
            
        case 1:
            selectMenu1.visible = NO;
            selectMenu2.visible = YES;
            selectMenu3.visible = NO;
            selectMenu4.visible = NO;
            
            break;
            
        case 2:
            [self upgradeItem];
            break;
            
        default:
            break;
    }
    
}

-(void)selectButton3:(id)sender{
	
	if( upgradeButtonState == 1 )
		return;
    
    if ([UserData userData].backSound)
        [[SimpleAudioEngine sharedEngine] playEffect:@"click.mp3"];    
	
    buttonState = 3;
    
    switch (tabState) {
        case 0:
            [self upgradeItem];
            break;
            
        case 1:
            selectMenu1.visible = NO;
            selectMenu2.visible = NO;
            selectMenu3.visible = YES;
            selectMenu4.visible = NO;
            
            break;
            
        case 2:
            [self upgradeItem];
            break;
            
        default:
            break;
    }
    
}

-(void)selectButton4:(id)sender{
	
	if( upgradeButtonState == 1 )
		return;
    
    if ([UserData userData].backSound)
        [[SimpleAudioEngine sharedEngine] playEffect:@"click.mp3"];    
    
    buttonState = 4;
    
    switch (tabState) {
        case 0:
            [self upgradeItem];
            break;
            
        case 1:
            selectMenu1.visible = NO;
            selectMenu2.visible = NO;
            selectMenu3.visible = NO;
            selectMenu4.visible = YES;
            
            break;
            
        case 2:
            [self upgradeItem];
            break;
            
        default:
            break;
    }
    
}


-(void)upgradeItem{
    
    if(upgradeButtonState == 1)
        return;
    
	popSpr = [[CCSprite alloc] initWithFile:@"small_popup.png"];
	[popSpr setAnchorPoint:ccp(0.5, 0.5)];
	[popSpr setPosition:ccp(240, 160)];
	[self addChild:popSpr z:13];
	
	label = [CCLabelTTF labelWithString:@"really?" fontName:@"NanumScript.ttf" fontSize:55];
	label.color = ccWHITE;
	label.anchorPoint = ccp(0.5, 0.5);
	label.position = ccp(245, 190);
	[self addChild:label z:14];
	
	CCMenuItemImage* yes;    
	CCMenuItemImage* no;
	
	upgradeButtonState = 1;
	
	
	yes = [CCMenuItemImage itemFromNormalImage:@"yes_off_btn.png" selectedImage:@"yes_on_btn.png" block:^(id sender) {
		//            BOOL result;
		//            result = [[UserData userData] removeToFile];
		//            
		
		
		switch (tabState) {
			case 0:
				
				switch (buttonState) {
					case 1:
						if ([UserData userData].flagLevel < 8){
                            if([[UserData userData] point] < [[SkillData skillData] getSkillPrice:UPGRADE_TYPE_FLAG :[[UserData userData] flagLevel]]){
                                break;
                            }
                            [UserData userData].flagLevel++; 
                            [UserData userData].point -=[ [SkillData skillData] getSkillPrice:UPGRADE_TYPE_FLAG :[[UserData userData] flagLevel]];
                            [[UserData userData] saveToFile];
                            
                            [upgradeLabel1 setString:[NSString stringWithFormat:@"Lv %d",[[UserData userData] flagLevel]]];
                            [upgradeLabel2 setString:[NSString stringWithFormat:@"%d G", [[SkillData skillData] getSkillPrice:UPGRADE_TYPE_FLAG :[[UserData userData] flagLevel]]]];
						}
						break;
						
					case 2:
						if ([UserData userData].userAtkLevel < 20){
                            if([[UserData userData] point] < [[SkillData skillData] getSkillPrice:UPGRADE_TYPE_ATTACK :[[UserData userData] userAtkLevel]]){
                                break;
                            }
                            [UserData userData].userAtkLevel++; 
                            [UserData userData].point -=[ [SkillData skillData] getSkillPrice:UPGRADE_TYPE_ATTACK :[[UserData userData] userAtkLevel]];
                            [[UserData userData] saveToFile];
                            
                            [upgradeLabel3 setString:[NSString stringWithFormat:@"Lv %d",[[UserData userData] userAtkLevel]]];
                            [upgradeLabel4 setString:[NSString stringWithFormat:@"%d G", [[SkillData skillData] getSkillPrice:UPGRADE_TYPE_ATTACK :[[UserData userData] userAtkLevel]]]];
						}
						break;
						
					case 3:
						if ([UserData userData].userMaxMpLevel < 20){
                            if([[UserData userData] point] < [[SkillData skillData] getSkillPrice:UPGRADE_TYPE_MAXMP :[[UserData userData] userMaxMpLevel]]){
                                break;
                            }
                            [UserData userData].userMaxMpLevel++; 
                            [UserData userData].point -=[ [SkillData skillData] getSkillPrice:UPGRADE_TYPE_MAXMP :[[UserData userData] userMaxMpLevel]];
                            [[UserData userData] saveToFile];
                            
                            [upgradeLabel5 setString:[NSString stringWithFormat:@"Lv %d",[[UserData userData] userMaxMpLevel]]];
                            [upgradeLabel6 setString:[NSString stringWithFormat:@"%d G", [[SkillData skillData] getSkillPrice:UPGRADE_TYPE_MAXMP :[[UserData userData] userMaxMpLevel]]]];
						}
						break;
						
					case 4:
						if ([UserData userData].userMPspeedLevel < 20){
                            if([[UserData userData] point] < [[SkillData skillData] getSkillPrice:UPGRADE_TYPE_REGENMP :[[UserData userData] userMPspeedLevel]]){
                                break;
                            }
                            [UserData userData].userMPspeedLevel++; 
                            [UserData userData].point -=[ [SkillData skillData] getSkillPrice:UPGRADE_TYPE_REGENMP :[[UserData userData] userMPspeedLevel]];
                            [[UserData userData] saveToFile];
                            
                            [upgradeLabel7 setString:[NSString stringWithFormat:@"Lv %d",[[UserData userData] userMPspeedLevel]]];
                            [upgradeLabel8 setString:[NSString stringWithFormat:@"%d G", [[SkillData skillData] getSkillPrice:UPGRADE_TYPE_REGENMP :[[UserData userData] userMPspeedLevel]]]];
						}
						break;
						
					default:
						break;
				}
				
				break;
				
			case 1:
				
				switch (buttonState) {
					case 1:
						if ([UserData userData].stoneLevel < 20){
                            if([[UserData userData] point] < [[SkillData skillData] getSkillPrice:SKILL_STATE_STONE :[[UserData userData] stoneLevel]]){
                                break;
                            }
							[UserData userData].stoneLevel++; 
                            [UserData userData].point -=[ [SkillData skillData] getSkillPrice:SKILL_STATE_STONE :[[UserData userData] stoneLevel]];
                            [[UserData userData] saveToFile];
							
							[upgradeLabel1 setString:[NSString stringWithFormat:@"Lv %d",[[UserData userData] stoneLevel]]];
							[upgradeLabel2 setString:[NSString stringWithFormat:@"%d G", [[SkillData skillData] getSkillPrice:SKILL_STATE_STONE :[[UserData userData] stoneLevel]]]];
						}
						
						selectMenu1.visible = NO;
						
						break;
						
					case 2:
						if ([UserData userData].arrowLevel < 20){
                            if([[UserData userData] point] < [[SkillData skillData] getSkillPrice:SKILL_STATE_ARROW :[[UserData userData] arrowLevel]]){
                                break;
                            }
                            [UserData userData].arrowLevel++; 
                            [UserData userData].point -=[ [SkillData skillData] getSkillPrice:SKILL_STATE_ARROW :[[UserData userData] arrowLevel]];
                            [[UserData userData] saveToFile];
							
							[upgradeLabel3 setString:[NSString stringWithFormat:@"Lv %d",[[UserData userData] arrowLevel]]];
							[upgradeLabel4 setString:[NSString stringWithFormat:@"%d G", [[SkillData skillData] getSkillPrice:SKILL_STATE_ARROW :[[UserData userData] arrowLevel]]]];
						}
						
						selectMenu2.visible = NO;
						
						break;
						
					case 3:
						if ([UserData userData].hillLevel < 20){
                            if([[UserData userData] point] < [[SkillData skillData] getSkillPrice:SKILL_STATE_HEALING :[[UserData userData] hillLevel]]){
                                break;
                            }
                            
                            [UserData userData].hillLevel++;                            
                            [UserData userData].point -=[ [SkillData skillData] getSkillPrice:SKILL_STATE_HEALING :[[UserData userData] hillLevel]];
							[[UserData userData] saveToFile];
							
							[upgradeLabel5 setString:[NSString stringWithFormat:@"Lv %d",[[UserData userData] hillLevel]]];
							[upgradeLabel6 setString:[NSString stringWithFormat:@"%d G", [[SkillData skillData] getSkillPrice:SKILL_STATE_HEALING :[[UserData userData] hillLevel]]]];
						}
						
						selectMenu3.visible = NO;
						
						break;
						
					case 4:
						if ([UserData userData].earthquakeLevel < 20){
                            if([[UserData userData] point] < [[SkillData skillData] getSkillPrice:SKILL_STATE_EARTHQUAKE :[[UserData userData] earthquakeLevel]]){
                                break;
                            }
                            [UserData userData].earthquakeLevel++; 
                            [UserData userData].point -=[ [SkillData skillData] getSkillPrice:SKILL_STATE_EARTHQUAKE :[[UserData userData] earthquakeLevel]];
                            [[UserData userData] saveToFile];
							
							[upgradeLabel7 setString:[NSString stringWithFormat:@"Lv %d",[[UserData userData] earthquakeLevel]]];
							[upgradeLabel8 setString:[NSString stringWithFormat:@"%d G", [[SkillData skillData] getSkillPrice:SKILL_STATE_EARTHQUAKE :[[UserData userData] earthquakeLevel]]]];
						}
						
						selectMenu4.visible = NO;
						
						break;
						
					default:
						break;
				}
				
				break;
				
			case 2:
				
				switch (buttonState) {
					case 1:
						if ([UserData userData].flagLevel < 9) {
							[UserData userData].flagLevel++; 
							[[UserData userData] saveToFile];
						}
						break;
						
					case 2:
						if ([UserData userData].userAtkLevel < 21){
							[UserData userData].userAtkLevel++; 
							[[UserData userData] saveToFile];
						}
						break;
						
					case 3:
						if ([UserData userData].userMaxMpLevel < 21){
							[UserData userData].userMaxMpLevel++; 
							[[UserData userData] saveToFile];
						}
						break;
						
					case 4:
						if ([UserData userData].userMPspeedLevel < 21){
							[UserData userData].userMPspeedLevel++; 
							[[UserData userData] saveToFile];
						}
						break;
						
					default:
						break;
				}
				
				break;
				
			default:
				break;
		}
		
		reset_menu.visible = NO;
		popSpr.visible = NO;
		label.visible = NO;
		
		upgradeButtonState = 0;
		[moneyLabel setString:[NSString stringWithFormat:@"%d", [[UserData userData] point]]];
		
	}];
	
	[yes setAnchorPoint:CGPointZero];
	yes.position = ccp(160, 115);
	
	no = [CCMenuItemImage itemFromNormalImage:@"no_off_btn.png" selectedImage:@"no_on_btn.png" block:^(id sender) {
		
		upgradeButtonState = 0;
		
		reset_menu.visible = NO;
		popSpr.visible = NO;
		label.visible = NO;
		
	}];
	
	[no setAnchorPoint:CGPointZero];
	no.position = ccp(290, 115);
	
	reset_menu = [CCMenu menuWithItems:yes, no, nil];    
	[reset_menu setAnchorPoint:CGPointZero];
	[reset_menu setPosition:CGPointZero];
	[self addChild:reset_menu z:14];
    
}

/*-(void)upgradeItem{
 
 if( upgradeButtonState == 1 )
 return;
 
 popSpr = [[CCSprite alloc] initWithFile:@"small_popup.png"];
 [popSpr setAnchorPoint:ccp(0.5, 0.5)];
 [popSpr setPosition:ccp(240, 160)];
 [self addChild:popSpr z:13];
 
 label = [CCLabelTTF labelWithString:@"really?" fontName:@"NanumScript.ttf" fontSize:55];
 label.color = ccWHITE;
 label.anchorPoint = ccp(0.5, 0.5);
 label.position = ccp(245, 190);
 [self addChild:label z:14];
 
 CCMenuItemImage* yes;    
 CCMenuItemImage* no;
 
 upgradeButtonState = 1;
 
 
 yes = [CCMenuItemImage itemFromNormalImage:@"yes_off_btn.png" selectedImage:@"yes_on_btn.png" block:^(id sender) {
 //            BOOL result;
 //            result = [[UserData userData] removeToFile];
 
 switch (tabState) {
 case 0:
 
 switch (buttonState) {
 case 1:
 if ([UserData userData].backSound)
 [[SimpleAudioEngine sharedEngine] playEffect:@"click.mp3"];    
 
 if([UserData userData].flagLevel < 8){
 [UserData userData].flagLevel++; 
 [[UserData userData] saveToFile];
 
 [upgradeLabel1 setString:[NSString stringWithFormat:@"Lv %d",[[UserData userData] flagLevel]]];
 [upgradeLabel2 setString:[NSString stringWithFormat:@"%d G", [[SkillData skillData] getSkillPrice:UPGRADE_TYPE_FLAG :[[UserData userData] flagLevel]]]];
 }
 break;
 
 case 2:
 if ([UserData userData].backSound)
 [[SimpleAudioEngine sharedEngine] playEffect:@"click.mp3"];    
 
 if([UserData userData].userAtkLevel < 20){
 [UserData userData].userAtkLevel++; 
 [[UserData userData] saveToFile];
 
 [upgradeLabel3 setString:[NSString stringWithFormat:@"Lv %d",[[UserData userData] userAtkLevel]]];
 [upgradeLabel4 setString:[NSString stringWithFormat:@"%d G", [[SkillData skillData] getSkillPrice:UPGRADE_TYPE_ATTACK :[[UserData userData] userAtkLevel]]]];
 }
 break;
 
 case 3:
 if ([UserData userData].backSound)
 [[SimpleAudioEngine sharedEngine] playEffect:@"click.mp3"];    
 
 if([UserData userData].userMaxMpLevel < 20){
 [UserData userData].userMaxMpLevel++; 
 [[UserData userData] saveToFile];
 
 [upgradeLabel5 setString:[NSString stringWithFormat:@"Lv %d",[[UserData userData] userMaxMpLevel]]];
 [upgradeLabel6 setString:[NSString stringWithFormat:@"%d G", [[SkillData skillData] getSkillPrice:UPGRADE_TYPE_MAXMP :[[UserData userData] userMaxMpLevel]]]];
 }
 break;
 
 case 4:
 if ([UserData userData].backSound)
 [[SimpleAudioEngine sharedEngine] playEffect:@"click.mp3"];    
 
 if([UserData userData].userMPspeedLevel < 20){
 [UserData userData].userMPspeedLevel++; 
 [[UserData userData] saveToFile];
 
 [upgradeLabel7 setString:[NSString stringWithFormat:@"Lv %d",[[UserData userData] userMPspeedLevel]]];
 [upgradeLabel8 setString:[NSString stringWithFormat:@"%d G", [[SkillData skillData] getSkillPrice:UPGRADE_TYPE_REGENMP :[[UserData userData] userMPspeedLevel]]]];
 }
 break;
 
 default:
 break;
 }
 
 break;
 
 case 1:
 
 switch (buttonState) {
 case 1:
 if ([UserData userData].backSound)
 [[SimpleAudioEngine sharedEngine] playEffect:@"click.mp3"];    
 
 if ([UserData userData].stoneLevel < 20){
 [UserData userData].stoneLevel++; 
 [[UserData userData] saveToFile];
 
 [upgradeLabel1 setString:[NSString stringWithFormat:@"Lv %d",[[UserData userData] stoneLevel]]];
 [upgradeLabel2 setString:[NSString stringWithFormat:@"%d G", [[SkillData skillData] getSkillPrice:SKILL_STATE_STONE :[[UserData userData] stoneLevel]]]];
 }
 
 selectMenu1.visible = NO;
 
 break;
 
 case 2:
 if ([UserData userData].backSound)
 [[SimpleAudioEngine sharedEngine] playEffect:@"click.mp3"];    
 
 if ([UserData userData].arrowLevel < 20){
 [UserData userData].arrowLevel++; 
 [[UserData userData] saveToFile];
 
 [upgradeLabel3 setString:[NSString stringWithFormat:@"Lv %d",[[UserData userData] arrowLevel]]];
 [upgradeLabel4 setString:[NSString stringWithFormat:@"%d G", [[SkillData skillData] getSkillPrice:SKILL_STATE_ARROW :[[UserData userData] arrowLevel]]]];
 }
 
 selectMenu2.visible = NO;
 
 break;
 
 case 3:
 if ([UserData userData].backSound)
 [[SimpleAudioEngine sharedEngine] playEffect:@"click.mp3"];    
 
 if ([UserData userData].hillLevel < 20){
 [UserData userData].hillLevel++; 
 [[UserData userData] saveToFile];
 
 [upgradeLabel5 setString:[NSString stringWithFormat:@"Lv %d",[[UserData userData] hillLevel]]];
 [upgradeLabel6 setString:[NSString stringWithFormat:@"%d G", [[SkillData skillData] getSkillPrice:SKILL_STATE_HEALING :[[UserData userData] hillLevel]]]];
 }
 
 selectMenu3.visible = NO;
 
 break;
 
 case 4:
 if ([UserData userData].backSound)
 [[SimpleAudioEngine sharedEngine] playEffect:@"click.mp3"];    
 
 if ([UserData userData].earthquakeLevel < 20){
 [UserData userData].earthquakeLevel++; 
 [[UserData userData] saveToFile];
 
 [upgradeLabel7 setString:[NSString stringWithFormat:@"Lv %d",[[UserData userData] earthquakeLevel]]];
 [upgradeLabel8 setString:[NSString stringWithFormat:@"%d G", [[SkillData skillData] getSkillPrice:SKILL_STATE_EARTHQUAKE :[[UserData userData] earthquakeLevel]]]];
 }
 
 selectMenu4.visible = NO;
 
 break;
 
 default:
 break;
 }
 
 break;
 
 case 2:
 
 switch (buttonState) {
 case 1:
 if ([UserData userData].backSound)
 [[SimpleAudioEngine sharedEngine] playEffect:@"click.mp3"];    
 
 if ([UserData userData].flagLevel < 9) {
 [UserData userData].flagLevel++; 
 [[UserData userData] saveToFile];
 }
 break;
 
 case 2:
 if ([UserData userData].backSound)
 [[SimpleAudioEngine sharedEngine] playEffect:@"click.mp3"];    
 
 if ([UserData userData].userAtkLevel < 21){
 [UserData userData].userAtkLevel++; 
 [[UserData userData] saveToFile];
 }
 break;
 
 case 3:
 if ([UserData userData].backSound)
 [[SimpleAudioEngine sharedEngine] playEffect:@"click.mp3"];    
 
 if ([UserData userData].userMaxMpLevel < 21){
 [UserData userData].userMaxMpLevel++; 
 [[UserData userData] saveToFile];
 }
 break;
 
 case 4:
 if ([UserData userData].backSound)
 [[SimpleAudioEngine sharedEngine] playEffect:@"click.mp3"];    
 
 if ([UserData userData].userMPspeedLevel < 21){
 [UserData userData].userMPspeedLevel++; 
 [[UserData userData] saveToFile];
 }
 break;
 
 default:
 break;
 }
 
 break;
 
 default:
 break;
 }
 
 
 
 }*/

-(void)setSlotItem:(id)sender{
    
    NSLog(@"setSlotItem");
    
    if(upgradeButtonState == 1)
        return;
    
    //사용가능 슬롯 개수
    
    switch (tabState) {
        case 1:
            switch (buttonState) {
                case 1:
                    
                    if([[[[UserData userData] skillSlot] objectForKey:@"1"] boolValue])
                    {
                        if( [[[[UserData userData] userSkillSlot] objectForKey:@"1"] integerValue] == -1){
                            if([UserData userData].stoneLevel==0)
                                break;
                            [[[UserData userData] userSkillSlot] setObject:[NSNumber numberWithInteger:SKILL_STATE_STONE] forKey:@"1"];
                            //                                돌스킬만 YES로
                            slot_stone1.visible = YES;
                            slot_arrow1.visible = NO;
                            slot_hill1.visible = NO;
                            slot_earthquake1.visible = NO;
                            [[UserData userData] saveToFile];
                            
                        }
                        else if([[[[UserData userData] skillSlot] objectForKey:@"2"] boolValue]){
                            if( [[[[UserData userData] userSkillSlot] objectForKey:@"2"] integerValue] == -1){
                                if([UserData userData].stoneLevel==0)
                                    break;
                                [[[UserData userData] userSkillSlot] setObject:[NSNumber numberWithInteger:SKILL_STATE_STONE] forKey:@"2"];
                                slot_stone2.visible = YES;
                                slot_arrow2.visible = NO;
                                slot_hill2.visible = NO;
                                slot_earthquake2.visible = NO;
                                [[UserData userData] saveToFile];
                                
                            }
                            else if([[[[UserData userData] skillSlot] objectForKey:@"3"] boolValue]){
                                if( [[[[UserData userData] userSkillSlot] objectForKey:@"3"] integerValue] == -1){
                                    if([UserData userData].stoneLevel==0)
                                        break;
                                    [[[UserData userData] userSkillSlot] setObject:[NSNumber numberWithInteger:SKILL_STATE_STONE] forKey:@"3"];
                                    slot_stone3.visible = YES;
                                    slot_arrow3.visible = NO;
                                    slot_hill3.visible = NO;
                                    slot_earthquake3.visible = NO;
                                    [[UserData userData] saveToFile];
                                }
                            }
                            
                        }
                        
                    }
                    
                    break;
                    
                case 2:
                    
                    if([[[[UserData userData] skillSlot] objectForKey:@"1"] boolValue])
                    {
                        if( [[[[UserData userData] userSkillSlot] objectForKey:@"1"] integerValue] == -1){
                            if([UserData userData].arrowLevel==0)
                                break;
                            [[[UserData userData] userSkillSlot] setObject:[NSNumber numberWithInteger:SKILL_STATE_ARROW] forKey:@"1"];
                            //                                화살스킬만 YES로 
                            slot_arrow1.visible = YES;
                            [[UserData userData] saveToFile];
                        }
                        else if([[[[UserData userData] skillSlot] objectForKey:@"2"] boolValue]){
                            if( [[[[UserData userData] userSkillSlot] objectForKey:@"2"] integerValue] == -1){
                                if([UserData userData].arrowLevel==0)
                                    break;
                                [[[UserData userData] userSkillSlot] setObject:[NSNumber numberWithInteger:SKILL_STATE_ARROW] forKey:@"2"];
                                [[UserData userData] saveToFile];
                                slot_arrow2.visible = YES;
                            }
                            else if([[[[UserData userData] skillSlot] objectForKey:@"3"] boolValue]){
                                if( [[[[UserData userData] userSkillSlot] objectForKey:@"3"] integerValue] == -1){
                                    if([UserData userData].arrowLevel==0)
                                        break;
                                    [[[UserData userData] userSkillSlot] setObject:[NSNumber numberWithInteger:SKILL_STATE_ARROW] forKey:@"3"];
                                    [[UserData userData] saveToFile];
                                    slot_arrow3.visible = YES;
                                }
                            }
                            
                        }
                        
                    }
                    
                    break;
                    
                case 3:
                    
                    if([[[[UserData userData] skillSlot] objectForKey:@"1"] boolValue])
                    {
                        if( [[[[UserData userData] userSkillSlot] objectForKey:@"1"] integerValue] == -1){
                            if([UserData userData].hillLevel==0)
                                break;
                            [[[UserData userData] userSkillSlot] setObject:[NSNumber numberWithInteger:SKILL_STATE_HEALING] forKey:@"1"];
                            //                                힐링스킬만 YES로 
                            [[UserData userData] saveToFile];
                            slot_hill1.visible = YES;
                        }
                        else if([[[[UserData userData] skillSlot] objectForKey:@"2"] boolValue]){
                            if( [[[[UserData userData] userSkillSlot] objectForKey:@"2"] integerValue] == -1){
                                if([UserData userData].hillLevel==0)
                                    break;
                                [[[UserData userData] userSkillSlot] setObject:[NSNumber numberWithInteger:SKILL_STATE_HEALING] forKey:@"2"];
                                [[UserData userData] saveToFile];
                                slot_hill2.visible = YES;
                            }
                            else if([[[[UserData userData] skillSlot] objectForKey:@"3"] boolValue]){
                                if( [[[[UserData userData] userSkillSlot] objectForKey:@"3"] integerValue] == -1){
                                    if([UserData userData].hillLevel==0)
                                        break;
                                    [[[UserData userData] userSkillSlot] setObject:[NSNumber numberWithInteger:SKILL_STATE_HEALING] forKey:@"3"];
                                    [[UserData userData] saveToFile];
                                    slot_hill3.visible = YES;
                                }
                            }
                            
                        }
                        
                    }
                    
                    break;
                    
                case 4:
                    
                    if([[[[UserData userData] skillSlot] objectForKey:@"1"] boolValue])
                    {
                        if( [[[[UserData userData] userSkillSlot] objectForKey:@"1"] integerValue] == -1){
                            if([UserData userData].earthquakeLevel==0)
                                break;//                                지진스킬만 YES로 
                            [[[UserData userData] userSkillSlot] setObject:[NSNumber numberWithInteger:SKILL_STATE_EARTHQUAKE] forKey:@"1"];
                            [[UserData userData] saveToFile];
                            slot_earthquake1.visible = YES;
                        }
                        else if([[[[UserData userData] skillSlot] objectForKey:@"2"] boolValue]){
                            if( [[[[UserData userData] userSkillSlot] objectForKey:@"2"] integerValue] == -1){
                                if([UserData userData].earthquakeLevel==0)
                                    break;//                                지진스킬만 YES로 
                                [[[UserData userData] userSkillSlot] setObject:[NSNumber numberWithInteger:SKILL_STATE_EARTHQUAKE] forKey:@"2"];
                                [[UserData userData] saveToFile];
                                slot_earthquake2.visible = YES;
                            }
                            else if([[[[UserData userData] skillSlot] objectForKey:@"3"] boolValue]){
                                if( [[[[UserData userData] userSkillSlot] objectForKey:@"3"] integerValue] == -1){
                                    if([UserData userData].earthquakeLevel==0)
                                        break;//                                지진스킬만 YES로 
                                    [[[UserData userData] userSkillSlot] setObject:[NSNumber numberWithInteger:SKILL_STATE_EARTHQUAKE] forKey:@"3"];
                                    [[UserData userData] saveToFile];
                                    slot_earthquake3.visible = YES;
                                }
                            }
                            
                        }
                        
                    }
                    
                    break;
                    
                default:
                    break;
            }
            break;
            
        default:
            break;
    }
    
    
}

-(void)buySlotItem:(id)sender{
    /*   
     if ([[UserData userData] point] < 10) {
     
     return;
     }
     
     */ 
    if([[[[UserData userData] skillSlot] objectForKey:@"2"] boolValue] == NO)
    {
        [[[UserData userData] skillSlot] setObject:[NSNumber numberWithBool:YES] forKey:@"2"];
        //2번쨰 자물쇠 스프라이트 제거
        lock2.visible = NO;
    }
    else if([[[[UserData userData] skillSlot] objectForKey:@"3"] boolValue] == NO){
        [[[UserData userData] skillSlot] setObject:[NSNumber numberWithBool:YES] forKey:@"3"];
        //3번째 자물쇠 스프라이트 제거
        lock3.visible = NO;
    }
    
}

- (void)back{
    
    [[CCDirector sharedDirector] replaceScene:[CCTransitionCrossFade transitionWithDuration:0.7 scene:[ResultLayer scene]]];
    
}

- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
    NSLog(@"ccTouchesEnded");
    
    for (UITouch *touch in touches) {
        if (touch) {
            CGPoint location = [[CCDirector sharedDirector] convertToGL:[touch locationInView:[touch view]]];
            
            if (CGRectContainsPoint(slot1.boundingBox, location)) {
                
                if([[[[UserData userData] skillSlot] objectForKey:@"1"] boolValue])
                {
                    if( [[[[UserData userData] userSkillSlot] objectForKey:@"1"] integerValue] != -1)
                        [[[UserData userData] userSkillSlot] setObject:[NSNumber numberWithInteger:-1] forKey:@"1"];
                    //                    사진 4개 visible no로!
                    slot_stone1.visible = NO;
                    slot_arrow1.visible = NO;
                    slot_hill1.visible = NO;
                    slot_earthquake1.visible = NO;
                    
                    
                }
                else {
                    [self buySlotItem:self];
                }
                
            }
            else if(CGRectContainsPoint(slot2.boundingBox, location)){
                
                if([[[[UserData userData] skillSlot] objectForKey:@"2"] boolValue])
                {
                    if([[[[UserData userData] userSkillSlot] objectForKey:@"2"] integerValue] != -1)
                        [[[UserData userData] userSkillSlot] setObject:[NSNumber numberWithInteger:-1] forKey:@"2"];
                    //                    사진 4개 NO
                    
                    slot_stone2.visible = NO;        
                    slot_arrow2.visible = NO;
                    slot_hill2.visible = NO;
                    slot_earthquake2.visible = NO;
                    
                }
                else{
                    [self buySlotItem:self];
                }
            }
            else if(CGRectContainsPoint(slot3.boundingBox, location)){
                
                if([[[[UserData userData] skillSlot] objectForKey:@"3"] boolValue])
                {
                    if([[[[UserData userData] userSkillSlot] objectForKey:@"3"] integerValue] != -1)
                        [[[UserData userData] userSkillSlot] setObject:[NSNumber numberWithInteger:-1] forKey:@"3"];
                    //                    사진 4개 NO
                    slot_stone3.visible = NO;
                    slot_arrow3.visible = NO;
                    slot_hill3.visible = NO;
                    slot_earthquake3.visible = NO;
                    
                }
                else{
                    [self buySlotItem:self];
                }
            }
        }
    }
    
}

@end
