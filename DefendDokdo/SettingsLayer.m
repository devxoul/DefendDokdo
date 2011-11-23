//
//  SettingsLayer.m
//  DefendDokdo
//
//  Created by 전 수열 on 11. 11. 1..
//  Copyright 2011년 Joyfl. All rights reserved.
//
#import "SimpleAudioEngine.h"

#import "SettingsLayer.h"
#import "UserData.h"
#import "MainLayer.h"


#define SETTING_RESET               0
#define SETTING_RESET_POPUP         1

@implementation SettingsLayer

+ (CCScene *)scene
{
	CCScene *scene = [CCScene node];
	SettingsLayer *layer = [SettingsLayer node];
	[scene addChild:layer];
	return scene;
}

- (id)init
{
	if( self = [super init] )
	{
		// Initialization code here.
		self.isTouchEnabled = YES;
		
		CCLayer *layer = [CCLayer node];
		layer.anchorPoint = CGPointZero;
		[layer setPosition: ccp(0,0)];
		[self addChild: layer z:-1];
		
		//배경
		settingBgSprite = [[CCSprite alloc] initWithFile:@"mainbg.png"];
		settingBgSprite.anchorPoint = CGPointZero;
		[settingBgSprite setPosition:ccp(0, 0)];
		[self addChild:settingBgSprite z:0];
		
		for (int i = 0; i < 2; i++)
		{
			setOff[i] = [[CCSprite alloc] initWithFile:@"off.png"];
			setOff[i].anchorPoint = CGPointZero;
			setOff[i].visible = NO;
			
			[self addChild:setOff[i] z:3];
		}
		
		//전체메뉴 
		CCMenuItemImage *set_sound = [CCMenuItemImage itemFromNormalImage:@"sound.png" selectedImage:@"sound.png" target:self selector:@selector(setSound:)];
		set_sound.anchorPoint = CGPointZero;
		
		CCMenuItemImage *set_vibration = [CCMenuItemImage itemFromNormalImage:@"vibration.png" selectedImage:@"vibration.png" target:self selector:@selector(setVibration:)];
		set_vibration.anchorPoint = CGPointZero;
		
		CCMenuItemImage *set_reset = [CCMenuItemImage itemFromNormalImage:@"reset.png" selectedImage:@"reset_pressed.png" target:self selector:@selector(setReset:)];
		set_reset.anchorPoint = CGPointZero;
		
		CCMenu *menu = [CCMenu menuWithItems:set_sound, set_vibration, set_reset, nil];
		menu.anchorPoint = CGPointZero;
		[menu setPosition:ccp(0, 0)];
		
		[set_sound setPosition:ccp(24, 115)];
		[set_vibration setPosition:ccp(180, 115)];
		[set_reset setPosition:ccp(330, 115)];
		
		[self addChild: menu z:2];
		
		setOff[0].position = ccp(set_sound.position.x, set_sound.position.y);
		setOff[1].position = ccp(set_vibration.position.x, set_vibration.position.y);
		
		if ([UserData userData].backSound == NO) 
			setOff[0].visible = YES;
		
		if ([UserData userData].vibration == NO)
			setOff[1].visible = YES;
		
		//뒤로가기 
		menu_back = [CCMenuItemImage itemFromNormalImage:@"back_pink.png" selectedImage:@"back_blue.png" target:self selector:@selector(back:)];
		menu_back.anchorPoint = CGPointZero;
		
		backMenu = [CCMenu menuWithItems:menu_back, nil];
		backMenu.anchorPoint = CGPointZero;
		
		[backMenu setPosition:ccp(5, 270)];
		[self addChild:backMenu];        
		
		resetState = SETTING_RESET;		
	}
	
	return self;
}


-(void)setSound:(id)sender
{
	if (resetState == SETTING_RESET) 
	{
		if ([UserData userData].backSound == YES)
		{
			[UserData userData].backSound = NO;
			setOff[0].visible = YES;
			
			[[UserData userData] setToFile];
			[[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
		}
		else if([UserData userData].backSound == NO)
		{
			[UserData userData].backSound = YES;
			setOff[0].visible = NO;
			
			[[UserData userData] setToFile];
			[[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"GameBGM.mp3"];
		}
		
		if ([UserData userData].backSound)
			[[SimpleAudioEngine sharedEngine] playEffect:@"click.mp3"];    
	}
}

-(void)setVibration:(id)sender
{    
	if (resetState == SETTING_RESET)
	{
		if ([UserData userData].vibration == YES)
		{
			[UserData userData].vibration = NO;
			setOff[1].visible = YES;
			
			[[UserData userData] setToFile];
		}
		else if([UserData userData].vibration == NO)
		{
			[UserData userData].vibration = YES;
			setOff[1].visible = NO;
			
			[[UserData userData] setToFile];              
		}
		
		if ([UserData userData].backSound)
			[[SimpleAudioEngine sharedEngine] playEffect:@"click.mp3"];    
		
	}
}

-(void)setReset:(id)sender
{
	resetState = SETTING_RESET_POPUP;
	
	popSpr = [[CCSprite alloc] initWithFile:@"small_alert.png"];
	[popSpr setAnchorPoint:ccp(0.5, 0.5)];
	[popSpr setPosition:ccp(240, 160)];
	[self addChild:popSpr z:3];
	
	label = [CCLabelTTF labelWithString:@"really?" fontName:@"BurstMyBubble.ttf" fontSize:55];
	label.color = ccBLACK;
	label.anchorPoint = ccp(0.5, 0.5);
	label.position = ccp(245, 190);
	[self addChild:label z:4];
	
	CCMenuItemImage* yes;    
	CCMenuItemImage* no;
	
	yes = [CCMenuItemImage itemFromNormalImage:@"btn_yes.png" selectedImage:@"btn_yes.png" block:^(id sender) {
		BOOL result;
		result = [[UserData userData] removeToFile];
		
		resetState = SETTING_RESET;
		reset_menu.visible = NO;
		popSpr.visible = NO;
		label.visible = NO;
		
		if ([UserData userData].backSound)
			[[SimpleAudioEngine sharedEngine] playEffect:@"click.mp3"];    
		
	}];
	
	[yes setAnchorPoint:CGPointZero];
	yes.position = ccp(120, 100);
	
	no = [CCMenuItemImage itemFromNormalImage:@"btn_no.png" selectedImage:@"btn_no.png" block:^(id sender) {
		resetState = SETTING_RESET;
		reset_menu.visible = NO;
		popSpr.visible = NO;
		label.visible = NO;
		
		if ([UserData userData].backSound)
			[[SimpleAudioEngine sharedEngine] playEffect:@"click.mp3"];    
	}];
	
	[no setAnchorPoint:CGPointZero];
	no.position = ccp(260, 100);
	
	reset_menu = [CCMenu menuWithItems:yes, no, nil];    
	[reset_menu setAnchorPoint:CGPointZero];
	[reset_menu setPosition:CGPointZero];
	[self addChild:reset_menu z:4];
	
} 

- (void)back:(id)sender {
	
	[[CCDirector sharedDirector] pushScene:[CCTransitionSlideInL transitionWithDuration:0.3 scene:[MainLayer scene]]];
	
	if ([UserData userData].backSound)
		[[SimpleAudioEngine sharedEngine] playEffect:@"click.mp3"];    
}

-(void)dealloc
{
	[super dealloc];
}	

@end
