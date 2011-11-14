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


@implementation ResultLayer

- (id)init
{
	if( self = [super init] )
	{
        
        //배경
        CCSprite *background = [CCSprite spriteWithFile:@"dokdo_bg.jpg"];
        [background setAnchorPoint:CGPointZero];
        [background setPosition:CGPointMake(0, 0)];
        [self addChild:background];
        
        //얼러트창
        CCSprite *bigAlert = [CCSprite spriteWithFile:@"big_alert.png"];
        [bigAlert setAnchorPoint:CGPointZero];
        [bigAlert setPosition:CGPointMake(30, 35)];
        [self addChild:bigAlert];
        
        //태극기 이미지
        CCSprite *flagImage = [CCSprite spriteWithFile:@"flag.jpg"];
        [flagImage setAnchorPoint:CGPointZero];
        [flagImage setPosition:CGPointMake(50, 55)];
        [self addChild:flagImage z:4];
        
        //start
        result_start = [CCMenuItemImage itemFromNormalImage:@"result_start.jpg" selectedImage:@"result_start.jpg" target:self selector:@selector(moveGame:)];
        [result_start setAnchorPoint:CGPointZero];
        [result_start setPosition:ccp(310, 145)];
        
        //upgrade
        result_upgrade = [CCMenuItemImage itemFromNormalImage:@"result_upgrade.jpg" selectedImage:@"result_upgrade.jpg" target:self selector:@selector(moveUpgrade:)];
        [result_upgrade setAnchorPoint:CGPointZero];
        [result_upgrade setPosition:ccp(310, 55)];
        
        CCMenu *result_menu = [CCMenu menuWithItems:result_start, result_upgrade, nil];
        result_menu.anchorPoint = CGPointZero;
        [result_menu setPosition:ccp(0, 0)];
        [self addChild: result_menu z:5];
        
        //게임머니
         moneyLabel = [[CCLabelTTF labelWithString:[NSString stringWithFormat:@"1000"] fontName:@"NanumScript.ttf" fontSize:70] retain];
        
        [self addChild:moneyLabel];
        
        [moneyLabel setColor:ccc3(0, 0, 0)];
        [moneyLabel setAnchorPoint:CGPointZero];
        [moneyLabel setPosition:CGPointMake(380, 250)];
        
        //뒤로 가기 
        CCMenu *backButton = [CCMenu menuWithItems:
                              [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithFile:@"back_blue.png"] selectedSprite:[CCSprite spriteWithFile:@"back_blue.png"] block:^(id sender) {
            [[CCDirector sharedDirector] pushScene:[CCTransitionSlideInL transitionWithDuration:0.3 scene:[ResultLayer scene]]];
        }], nil];
        
        [backButton setAnchorPoint:CGPointZero];
        [backButton setPosition:CGPointMake(30, 295)];
        
        [self addChild:backButton];
		
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
    [[CCDirector sharedDirector] pushScene:[CCTransitionSlideInT transitionWithDuration:0.3 scene:[GameScene scene]]];
}

-(void)moveUpgrade:(id)sender
{
    [[CCDirector sharedDirector] pushScene:[CCTransitionSlideInT transitionWithDuration:0.3 scene:[UpgradeLayer scene]]];
}

@end
