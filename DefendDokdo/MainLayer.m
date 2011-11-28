//
//  MainLayer.m
//  DefendDokdo
//
//  Created by 전 수열 on 11. 11. 1..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import "SimpleAudioEngine.h"
#import "MainLayer.h"

#import "IntroLayer.h"
#import "GameScene.h"
#import "SettingsLayer.h"

#import "InfoLayer.h"

//테스트
#import "ResultLayer.h"
#import "UpgradeLayer.h"
#import "UserData.h"

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
        
        sunSprite = [[CCSprite alloc] initWithFile:@"sun_ui.png"];
        sunSprite.anchorPoint =CGPointZero;
        [sunSprite setPosition:ccp(50, 250)];
        [self addChild:sunSprite z:0];
        
        dokdoSprite = [[CCSprite alloc] initWithFile:@"dokdo.png"];
        dokdoSprite.anchorPoint =CGPointZero;
        [dokdoSprite setPosition:ccp(0, 0)];
        [self addChild:dokdoSprite z:0];
        
        
        seaSprite = [[CCSprite alloc] initWithFile:@"sea2.png"];
        seaSprite.anchorPoint =CGPointZero;
        [seaSprite setPosition:ccp(0, 0)];
        [self addChild:seaSprite z:0];
        
        cloudSprite = [[CCSprite alloc] initWithFile:@"cloud.png"];
        cloudSprite.anchorPoint =CGPointZero;
        [cloudSprite setPosition:ccp(0, 0)];
        [self addChild:cloudSprite z:-1];
        
        menuBgSprite = [[CCSprite alloc] initWithFile:@"Title_bg2.png"];
        menuBgSprite.anchorPoint = CGPointZero;
		[menuBgSprite setPosition:ccp(0, 0)];
        [self addChild:menuBgSprite z:-2];
        
        //전체메뉴        
        //인트로 이동
        mainmenu[0] = [CCMenuItemImage itemFromNormalImage:@"dokdoIntro.png" selectedImage:@"dokdoIntro.png" target:self selector:@selector(moveIntro:)];
        
        //게임 이동
        mainmenu[1] = [CCMenuItemImage itemFromNormalImage:@"gameStart.png" selectedImage:@"gameStart.png" target:self selector:@selector(moveGame:)];
        
        //환경설정 이동
        mainmenu[2] = [CCMenuItemImage itemFromNormalImage:@"setting.png" selectedImage:@"setting.png" target:self selector:@selector(moveSetting:)];
        
        
        for (int i = 0; i < 3; i++) {
            mainmenu[i].anchorPoint = CGPointZero;
        }
        
        [mainmenu[0] setPosition:ccp(50, 100)];
        [mainmenu[1] setPosition:ccp(220, 200)];
        [mainmenu[2] setPosition:ccp(350, 115)];
        
        
        CCMenu *menu = [CCMenu menuWithItems:mainmenu[0], mainmenu[1], mainmenu[2], nil];
        
        menu.anchorPoint = CGPointZero;
        [menu setPosition:ccp(0, 0)];
		
        [self addChild: menu z:1];
        
        //왼쪽 하단 메뉴 아이템 
        menu_facebook = [CCMenuItemImage itemFromNormalImage:@"Main_facebook_on_btn.png" selectedImage:@"Main_facebook_on_btn.png" target:self 
                                                    selector:@selector(moveFacebook:)];
        menu_facebook.anchorPoint = CGPointZero;
        
        menu_ranking = [CCMenuItemImage itemFromNormalImage:@"Main_GameCenter_on_btn.png" selectedImage:@"Main_GameCenter_on_btn.png" target:self 
                                                   selector:@selector(moveRank:)];
        menu_ranking.anchorPoint = CGPointZero;
        
        menu_info = [CCMenuItemImage itemFromNormalImage:@"Main_info_on_btn.png" selectedImage:@"Main_info_on_btn.png" target:self 
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
    if ([UserData userData].backSound)
        [[SimpleAudioEngine sharedEngine] playEffect:@"click.mp3"];    
	
   [[CCDirector sharedDirector] replaceScene:[CCTransitionCrossFade transitionWithDuration:0.5 scene:[ResultLayer scene]]];
}

-(void)moveIntro:(id)sender
{
    if ([UserData userData].backSound)
        [[SimpleAudioEngine sharedEngine] playEffect:@"click.mp3"];    
	
    [[CCDirector sharedDirector] replaceScene:[CCTransitionCrossFade transitionWithDuration:0.5 scene:[IntroLayer scene]]]; 
}

-(void)moveSetting:(id)sender{

    if ([UserData userData].backSound)
        [[SimpleAudioEngine sharedEngine] playEffect:@"click.mp3"];    

    
    [[CCDirector sharedDirector] replaceScene:[CCTransitionCrossFade transitionWithDuration:0.5 scene:[SettingsLayer scene]]];
}



-(void)moveFacebook:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.facebook.com/DefendDokdo"]];
}

-(void)moveRank:(id)sender
{
    if ([UserData userData].backSound)
        [[SimpleAudioEngine sharedEngine] playEffect:@"click.mp3"];        
}

-(void)moveInfo:(id)sender
{
	if ([UserData userData].backSound)
        [[SimpleAudioEngine sharedEngine] playEffect:@"click.mp3"];    

    [[CCDirector sharedDirector] replaceScene:[CCTransitionCrossFade transitionWithDuration:0.5 scene:[InfoLayer scene]]]; 
}

@end
