//
//  MainLayer.m
//  DefendDokdo
//
//  Created by 전 수열 on 11. 11. 1..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import "MainLayer.h"

#import "IntroLayer.h""
#import "GameScene.h"
#import "SettingsLayer.h"

#import "InfoLayer.h"

//테스트
#import "ResultLayer.h"

@implementation MainLayer

//+ (CCScene *)scene
//{
//	CCScene *scene = [CCScene node];
//	MainLayer *layer = [MainLayer node];
//	[scene addChild:layer];
//	return scene;
//}

//- (id)init
//{
//	if( self == [super init] )
//	{
//		
//	}
//	
//	return self;
//}

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
        self.isTouchEnabled = YES;
        
        //메뉴배경
        menuBgSprite = [[CCSprite alloc] initWithFile:@"dokdo_bg.jpg"];
        menuBgSprite.anchorPoint = CGPointZero;
		[menuBgSprite setPosition:ccp(0, 0)];
        [self addChild:menuBgSprite z:0];
        
        //전체메뉴        
        //인트로 이동
        mainmenu[0] = [CCMenuItemImage itemFromNormalImage:@"intro_btn.gif" selectedImage:@"intro_btn.gif" target:self selector:@selector(moveIntro:)];
        
        //게임 이동
        mainmenu[1] = [CCMenuItemImage itemFromNormalImage:@"game_btn.gif" selectedImage:@"game_btn.gif" target:self selector:@selector(moveGame:)];
        
        //환경설정 이동
        mainmenu[2] = [CCMenuItemImage itemFromNormalImage:@"setting_btn.gif" selectedImage:@"setting_btn.gif" target:self selector:@selector(moveSetting:)];
        
        
        for (int i = 0; i < 3; i++) {
            mainmenu[i].anchorPoint = CGPointZero;
        }
        
        [mainmenu[0] setPosition:ccp(300, 150)];
        [mainmenu[1] setPosition:ccp(300, 100)];
        [mainmenu[2] setPosition:ccp(300, 50)];
        
        
        CCMenu *menu = [CCMenu menuWithItems:mainmenu[0], mainmenu[1], mainmenu[2], nil];
        
        menu.anchorPoint = CGPointZero;
        [menu setPosition:ccp(0, 0)];
		
        [self addChild: menu z:1];
        
        //왼쪽 하단 메뉴 아이템 
        menu_facebook = [CCMenuItemImage itemFromNormalImage:@"facebook_blue.png" selectedImage:@"facebook_blue.png" target:self 
                                                    selector:@selector(moveFacebook:)];
        menu_facebook.anchorPoint = CGPointZero;
        
        menu_ranking = [CCMenuItemImage itemFromNormalImage:@"gamecenter.png" selectedImage:@"gamecenter.png" target:self 
                                                   selector:@selector(moveRank:)];
        menu_ranking.anchorPoint = CGPointZero;
        
        menu_info = [CCMenuItemImage itemFromNormalImage:@"info_blue.png" selectedImage:@"info_blue.jpg" target:self 
                                                selector:@selector(moveInfo:)];
        menu_info.anchorPoint = CGPointZero;
        
        [menu_facebook setPosition:ccp(90, 10)];
        [menu_ranking setPosition:ccp(35, 10)];
        [menu_info setPosition:ccp(145, 10)];
        
        menu_more = [CCMenu menuWithItems:menu_facebook, menu_ranking, menu_info, nil];
        menu_more.anchorPoint = CGPointZero;
        [menu_more setPosition:ccp(0, 0)];
        
        [self addChild:menu_more];
        //menu_more.visible = NO;
        
    }
    
    return self;
}

+(CCScene*)scene
{
    CCScene *scene = [CCScene node];
    MainLayer *layer = [MainLayer node];
    [scene addChild:layer];
    
    return scene;    
}

-(void)moveGame:(id)sender
{
    [[CCDirector sharedDirector] pushScene:[CCTransitionSlideInT transitionWithDuration:0.3 scene://[GameScene scene]]];
        [ResultLayer scene]]];
}

-(void)moveIntro:(id)sender
{
    [[CCDirector sharedDirector] pushScene:[CCTransitionSlideInT transitionWithDuration:0.3 scene:[IntroLayer scene]]]; 
}

-(void)moveSetting:(id)sender{
    
    [[CCDirector sharedDirector] pushScene:[CCTransitionSlideInR transitionWithDuration:0.3 scene:[SettingsLayer scene]]];
}



-(void)moveFacebook:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.facebook.com/eugenius89"]];
}

-(void)moveRank:(id)sender
{
    
}

-(void)moveInfo:(id)sender
{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionSlideInT transitionWithDuration:0.3 scene:[InfoLayer scene]]]; 
    
}

@end
