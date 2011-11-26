//
//  InfoLayer.m
//  DefendDokdo
//
//  Created by Youjin Lim on 11. 11. 7..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import "InfoLayer.h"
#import "MainLayer.h"
#import "UserData.h"
#import "SimpleAudioEngine.h"

@implementation InfoLayer

NSString* infoArr[15] = 
{
	@"Information",
	@" ",
	@"ters213@gmail.com",
	@" ",
	@"Credit",
	@" ",
	@"imeugenius",
	@"MC.Im",
	@"Cute Sanghun",
	@"Nice Gyuseon",
	@"Youngest Xoul"
};


+ (CCScene *)scene
{
	CCScene *scene = [CCScene node];
	InfoLayer *layer = [InfoLayer node];
	[scene addChild:layer];
	return scene;
}

- (id)init
{
	if( self = [super init] )
	{
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
		
        CCMenuItemImage* back = [CCMenuItemImage itemFromNormalImage:@"back_off_btn.png" selectedImage:@"back_on_btn.png" 
                                                              target:self selector:@selector(moveBack:)];
        
        back.anchorPoint = CGPointZero;
        
        CCMenu* menu = [CCMenu menuWithItems:back, nil];
        [menu setAnchorPoint:CGPointZero];
        [menu setPosition:ccp(5, 260)];
        
        [self addChild:menu];
		
		CCLabelTTF* infolab[10];
		
		for (int i = 0; i < 15; i++)
		{
			infolab[i] = [CCLabelTTF labelWithString:infoArr[i] fontName:@"NanumScript.ttf" fontSize:30];
			infolab[i].anchorPoint = ccp(0.5, 0.5);
			infolab[i].position = ccp(240, 280 - (i * 25));
			infolab[i].color = ccWHITE;
			
			[self addChild:infolab[i]];
		}		
		
	}
	
	return self;
}

-(void)moveBack:(id)sender
{
    if ([UserData userData].backSound)
        [[SimpleAudioEngine sharedEngine] playEffect:@"click.mp3"];    
    
    [[CCDirector sharedDirector] replaceScene:[CCTransitionCrossFade transitionWithDuration:0.5 scene:[MainLayer scene]]];        
}

@end