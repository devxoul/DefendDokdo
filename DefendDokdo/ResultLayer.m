//
//  ResultLayer.m
//  DefendDokdo
//
//  Created by 전 수열 on 11. 11. 1..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import "ResultLayer.h"

#import "GameScene.h"
#import "UpgradeLayer.h"
#import "MainLayer.h"
#import "UserData.h"
#import "SkillData.h"
#import "Const.h"

@implementation ResultLayer

- (id)init
{
	if( self = [super init] )
	{
        
        //배경
        CCSprite *background = [CCSprite spriteWithFile:@"result_dialog2.png"];
        [background setAnchorPoint:CGPointZero];
        [background setPosition:CGPointMake(0, 0)];
        [self addChild:background];
        
        //얼러트창
//        CCSprite *bigAlert = [CCSprite spriteWithFile:@"big_alert.png"];
//        [bigAlert setAnchorPoint:CGPointZero];
//        [bigAlert setPosition:CGPointMake(30, 35)];
//        [self addChild:bigAlert];
//        
        //태극기 이미지
        CCSprite *flagImage = [CCSprite spriteWithFile:(NSString*)[[[SkillData skillData] getSkillInfo:UPGRADE_TYPE_FLAG :[[UserData userData] flagLevel]] objectForKey:@"spritename"]];
        [flagImage setAnchorPoint:CGPointZero];
        [flagImage setPosition:CGPointMake(77, 80)];
        [self addChild:flagImage z:4];
        
        //start
        result_start = [CCMenuItemImage itemFromNormalImage:@"start_on_btn.png" selectedImage:@"start_off_btn.png" target:self selector:@selector(moveGame:)];
        [result_start setAnchorPoint:CGPointZero];
        [result_start setPosition:ccp(220, 127)];
        
        //upgrade
        result_upgrade = [CCMenuItemImage itemFromNormalImage:@"upgrade_on_btn.png" selectedImage:@"upgrade_off_btn.png" target:self selector:@selector(moveUpgrade:)];
        [result_upgrade setAnchorPoint:CGPointZero];
        [result_upgrade setPosition:ccp(220, 18)];
        
        CCMenu *result_menu = [CCMenu menuWithItems:result_start, result_upgrade, nil];
        result_menu.anchorPoint = CGPointZero;
        [result_menu setPosition:ccp(0, 0)];
        [self addChild: result_menu z:5];
        
        //게임머니
         moneyLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d",[[UserData userData] point]] dimensions:CGSizeMake(0,0) alignment:UITextAlignmentRight fontName:@"NanumScript.ttf" fontSize:70];
        
        [self addChild:moneyLabel];
        
        [moneyLabel setColor:ccc3(0, 0, 0)];
        [moneyLabel setAnchorPoint:CGPointZero];
        [moneyLabel setPosition:CGPointMake(380, 240)];
        
//        //뒤로 가기 
//        CCMenu *backButton = [CCMenu menuWithItems:
//                              [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithFile:@"back_blue.png"] selectedSprite:[CCSprite spriteWithFile:@"back_blue.png"] block:^(id sender) {
//            [[CCDirector sharedDirector] pushScene:[CCTransitionSlideInL transitionWithDuration:0.3 scene:[ResultLayer scene]]];
//        }], nil];
//        
//        [backButton setAnchorPoint:CGPointZero];
//        [backButton setPosition:CGPointMake(30, 295)];
//        
//        [self addChild:backButton];
        
        //뒤로가기 
        menu_back = [CCMenuItemImage itemFromNormalImage:@"back_on_btn.png" selectedImage:@"back_off_btn.png" target:self selector:@selector(back:)];
        menu_back.anchorPoint = CGPointZero;
        
        backMenu = [CCMenu menuWithItems:menu_back, nil];
        backMenu.anchorPoint = CGPointZero;
        [backMenu setPosition:ccp(7, 250)];
        
        [self addChild:backMenu];
		
	}
	
	return self;
}

+ (CCScene *)scene
{
	CCScene *scene = [CCScene node];
	ResultLayer *layer = [ResultLayer node];
	[scene addChild:layer];
	return scene;
}

-(void)moveGame:(id)sender
{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionCrossFade transitionWithDuration:0.7 scene:[GameScene scene]]];
}

-(void)moveUpgrade:(id)sender
{
//    [[CCDirector sharedDirector] pushScene:[CCTransitionSlideInT transitionWithDuration:0.3 scene:
    [[CCDirector sharedDirector] replaceScene:[CCTransitionCrossFade transitionWithDuration:0.7 scene:[UpgradeLayer scene]]];
}

- (void)back:(id)sender {
    
    [[CCDirector sharedDirector] replaceScene:[CCTransitionCrossFade transitionWithDuration:0.7 scene:[MainLayer scene]]];
}

@end
