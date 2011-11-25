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
//		settingBgSprite = [[CCSprite alloc] initWithFile:@"Settings_bg.png"];
//		settingBgSprite.anchorPoint = CGPointZero;
//		[settingBgSprite setPosition:ccp(0, 0)];
//		[self addChild:settingBgSprite z:0];
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
		
		CCSprite* black = [[CCSprite alloc] initWithFile:@"black.png"];
		black.anchorPoint = CGPointZero;
		black.position = CGPointZero;
		[self addChild:black z:0];
		
				
		//전체메뉴 
		
		set_yes_sound = [[CCSprite alloc] initWithFile:@"Sound_on_btn.png"];
		set_no_sound = [[CCSprite alloc] initWithFile:@"Sound_off_btn.png"];

		set_yes_sound.anchorPoint = CGPointZero;
		set_no_sound.anchorPoint = CGPointZero;
		
		set_yes_vibration = [[CCSprite alloc] initWithFile:@"Vibration_on_btn.png"];
		set_no_vibration = [[CCSprite alloc] initWithFile:@"Vibration_off_btn.png"];
		
		set_yes_vibration.anchorPoint = CGPointZero;
		set_no_vibration.anchorPoint = CGPointZero;

		
		if ([[UserData userData] backSound] == YES) {
			[set_yes_sound setVisible:NO];
			[set_no_sound setVisible:YES];
		}
		else
		{
			[set_no_sound setVisible:NO];
			[set_yes_sound setVisible:YES];
		}
		
		
		if ([[UserData userData] vibration] == YES) {
			[set_yes_vibration setVisible:NO];
			[set_no_vibration setVisible:YES];
		}
		else
		{
			[set_yes_vibration setVisible:YES];
			[set_no_vibration setVisible:NO];
		}
				
		set_reset = [CCMenuItemImage itemFromNormalImage:@"Reset_on_btn.png" selectedImage:@"Reset_off_btn.png" target:self selector:@selector(setReset:)];
		set_reset.anchorPoint = CGPointZero;
		
		menu = [CCMenu menuWithItems:set_reset, nil];
		menu.anchorPoint = CGPointZero;
		[menu setPosition:ccp(0, 0)];
		
		[set_yes_sound setPosition:ccp(44, 115)];
		[set_no_sound setPosition:ccp(44, 115)];
		[set_yes_vibration setPosition:ccp(200, 115)];
		[set_no_vibration setPosition:ccp(200, 115)];
		
		[set_reset setPosition:ccp(350, 115)];
		
		[self addChild:set_yes_sound z:2];
		[self addChild:set_yes_vibration z:2];
		[self addChild:set_no_sound z:2];
		[self addChild:set_no_vibration z:2];
		
		[self addChild: menu z:2];
		
		//뒤로가기 
		menu_back = [CCMenuItemImage itemFromNormalImage:@"back_off_btn.png" selectedImage:@"back_on_btn.png" target:self selector:@selector(back:)];
		menu_back.anchorPoint = CGPointZero;
		
		backMenu = [CCMenu menuWithItems:menu_back, nil];
		backMenu.anchorPoint = CGPointZero;
		
		[backMenu setPosition:ccp(5, 250)];
		[self addChild:backMenu];        
		
		resetState = SETTING_RESET;		
	}
	
	return self;
}


-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	UITouch* touch = [touches anyObject];
	CGPoint cocoa = [touch locationInView:[touch view]];
	CGPoint touchPoint = [[CCDirector sharedDirector] convertToGL:cocoa];
	
	if ((set_yes_sound.boundingBox.origin.x < touchPoint.x) && ((set_yes_sound.boundingBox.size.width + set_yes_sound.boundingBox.origin.x) > touchPoint.x) ) {
		if ((set_yes_sound.boundingBox.origin.y < touchPoint.y) && ((set_yes_sound.boundingBox.size.height + set_yes_sound.boundingBox.origin.y) > touchPoint.y)) {
			[self setSound];
		}
	}		
	
	if ((set_yes_vibration.boundingBox.origin.x < touchPoint.x) && ((set_yes_vibration.boundingBox.size.width + set_yes_vibration.boundingBox.origin.x) > touchPoint.x) ) {
		if ((set_yes_vibration.boundingBox.origin.y < touchPoint.y) && ((set_yes_vibration.boundingBox.size.height + set_yes_vibration.boundingBox.origin.y) > touchPoint.y)) {
			[self setVibration];
		}
	}		

}


-(void)setSound
{
	if (resetState == SETTING_RESET) 
	{
		if ([UserData userData].backSound == YES)
		{
			[UserData userData].backSound = NO;
			
			[set_yes_sound setVisible:NO];
			[set_no_sound setVisible:YES];			
			
			[[UserData userData] setToFile];
			[[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
		}
		else if([UserData userData].backSound == NO)
		{
			[UserData userData].backSound = YES;
			
			[set_no_sound setVisible:NO];
			[set_yes_sound setVisible:YES];
			
			[[UserData userData] setToFile];
//			[[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"GameBGM.mp3"];
		}
		
		if ([UserData userData].backSound)
			[[SimpleAudioEngine sharedEngine] playEffect:@"click.mp3"];    
	}
}

-(void)setVibration
{    
	if (resetState == SETTING_RESET)
	{		
		if ([UserData userData].vibration == YES)
		{
			[UserData userData].vibration = NO;
			
			[set_yes_vibration setVisible:NO];
			[set_no_vibration setVisible:YES];
			
			[[UserData userData] setToFile];
		}
		else if([UserData userData].vibration == NO)
		{
			[UserData userData].vibration = YES;

			[set_yes_vibration setVisible:YES];
			[set_no_vibration setVisible:NO];

			[[UserData userData] setToFile];              
		}
		
		if ([UserData userData].backSound)
			[[SimpleAudioEngine sharedEngine] playEffect:@"click.mp3"];    
		
	}
}

-(void)setReset:(id)sender
{
	resetState = SETTING_RESET_POPUP;
	
	popSpr = [[CCSprite alloc] initWithFile:@"small_popup.png"];
	[popSpr setAnchorPoint:ccp(0.5, 0.5)];
	[popSpr setPosition:ccp(240, 160)];
	[self addChild:popSpr z:3];
	
	label = [CCLabelTTF labelWithString:@"really?" fontName:@"NanumScript.ttf" fontSize:55];
	label.color = ccWHITE;
	label.anchorPoint = ccp(0.5, 0.5);
	label.position = ccp(245, 190);
	[self addChild:label z:4];
	
	CCMenuItemImage* yes;    
	CCMenuItemImage* no;
	
	yes = [CCMenuItemImage itemFromNormalImage:@"yes_off_btn.png" selectedImage:@"yes_on_btn.png" block:^(id sender) {
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
	yes.position = ccp(160, 115);
	
	no = [CCMenuItemImage itemFromNormalImage:@"no_off_btn.png" selectedImage:@"no_on_btn.png" block:^(id sender) {
		resetState = SETTING_RESET;
		reset_menu.visible = NO;
		popSpr.visible = NO;
		label.visible = NO;
		
		if ([UserData userData].backSound)
			[[SimpleAudioEngine sharedEngine] playEffect:@"click.mp3"];    
	}];
	
	[no setAnchorPoint:CGPointZero];
	no.position = ccp(290, 115);
	
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
