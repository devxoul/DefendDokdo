//
//  HelloWorldLayer.m
//  DefendDokdo
//
//  Created by 전 수열 on 11. 11. 1..
//  Copyright Joyfl 2011년. All rights reserved.
//


// Import the interfaces
#import "TitleLayer.h"
#import "MainLayer.h"
#import "UserData.h"
#import "SimpleAudioEngine.h"

// HelloWorldLayer implementation
@implementation TitleLayer

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	TitleLayer *layer = [TitleLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) {
        
        
		self.isTouchEnabled = YES;
        
        titleBgSprite = [[CCSprite alloc] initWithFile:@"dokdo_bg.jpg"];
        titleBgSprite.anchorPoint = CGPointZero;
		[titleBgSprite setPosition:ccp(0, 0)];
        
        [self addChild:titleBgSprite z:0];
        
        titleLogo = [[CCSprite alloc] initWithFile:@"dokdo_logo.jpeg"];
        titleLogo.anchorPoint = CGPointZero;
        titleLogo.position = ccp(102, 100);
        
        [self addChild:titleLogo z:1];
        
        touchTheScreenSprite = [[CCSprite alloc] initWithFile:@"touchthescreen.jpg"];
        touchTheScreenSprite.anchorPoint = CGPointZero;
        [touchTheScreenSprite setPosition:ccp(0, 0)];
        
        [self addChild:touchTheScreenSprite z:2];		
	}
	return self;
}

- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    touchTheScreenSprite.visible = NO;
    
    [titleLogo runAction:[CCSequence actions:[CCMoveTo actionWithDuration:1 position:ccp(titleLogo.position.x , 350)], 
                          [CCCallBlockN actionWithBlock:^(CCNode *node) {
            titleLogo.visible = NO;
            [[CCDirector sharedDirector] pushScene:[CCTransitionPageTurn transitionWithDuration:0.5 scene:[MainLayer scene]]];
    }],nil]];
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
    [titleBgSprite release];
    [titleLogo release];
    
	// don't forget to call "super dealloc"
	[super dealloc];
}
@end
