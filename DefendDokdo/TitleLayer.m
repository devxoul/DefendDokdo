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
        
        titleBgSprite = [[CCSprite alloc] initWithFile:@"Title_bg.png"];
        titleBgSprite.anchorPoint = CGPointZero;
		[titleBgSprite setPosition:ccp(0, 0)];
        
        [self addChild:titleBgSprite z:0];
        
//        titleLogo = [[CCSprite alloc] initWithFile:@"dokdo_logo.jpeg"];
//        titleLogo.anchorPoint = CGPointZero;
//        titleLogo.position = ccp(102, 100);
//        
//        [self addChild:titleLogo z:1];
        
        touchTheScreenSprite = [[CCSprite alloc] initWithFile:@"Touch_the_Screen.png"];
        touchTheScreenSprite.anchorPoint = CGPointZero;
        [touchTheScreenSprite setPosition:ccp(97, 30)];
        
        [self addChild:touchTheScreenSprite z:2];
		
        twinkle1 = [[CCSprite alloc] initWithFile:@"twinkle.png"];
        twinkle1.anchorPoint = CGPointZero;
        [twinkle1 setPosition:ccp(20, 150)];
        
        [self addChild:twinkle1 z:3];
        
        twinkle2 = [[CCSprite alloc] initWithFile:@"twinkle.png"];
        twinkle2.anchorPoint = CGPointZero;
        [twinkle2 setPosition:ccp(200, 260)];
        
        [self addChild:twinkle2 z:3];
        
        twinkle3 = [[CCSprite alloc] initWithFile:@"twinkle.png"];
        twinkle3.anchorPoint = CGPointZero;
        [twinkle3 setPosition:ccp(420, 200)];
        
        [self addChild:twinkle3 z:3];
        
        twinkle4 = [[CCSprite alloc] initWithFile:@"twinkle.png"];
        twinkle4.anchorPoint = CGPointZero;
        [twinkle4 setPosition:ccp(400, 70)];
        
        [self addChild:twinkle4 z:3];
        
        twinkle5 = [[CCSprite alloc] initWithFile:@"twinkle.png"];
        twinkle5.anchorPoint = CGPointZero;
        [twinkle5 setPosition:ccp(120, 70)];
        
        [self addChild:twinkle5 z:3];
        
        CCFiniteTimeAction *inAction = [CCFadeIn actionWithDuration:0.3f];
        CCFiniteTimeAction *outAction = [CCFadeOut actionWithDuration:0.3f];
        
        [twinkle1 runAction:[CCRepeatForever actionWithAction:[CCSequence actions:inAction,outAction, nil]]];
        [twinkle2 runAction:[CCRepeatForever actionWithAction:[CCSequence actions:inAction,outAction, nil]]];
        [twinkle3 runAction:[CCRepeatForever actionWithAction:[CCSequence actions:inAction,outAction, nil]]];
        [twinkle4 runAction:[CCRepeatForever actionWithAction:[CCSequence actions:inAction,outAction, nil]]];
        [twinkle5 runAction:[CCRepeatForever actionWithAction:[CCSequence actions:inAction,outAction, nil]]];
        [touchTheScreenSprite runAction:[CCRepeatForever actionWithAction:[CCSequence actions:inAction,outAction, nil]]];
        
	}
	return self;
}

- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
//    touchTheScreenSprite.visible = NO;
    
    [[CCDirector sharedDirector] pushScene:[CCTransitionPageTurn transitionWithDuration:0.5 scene:[MainLayer scene]]];
    
//    [titleLogo runAction:[CCSequence actions:[CCMoveTo actionWithDuration:1 position:ccp(titleLogo.position.x , 350)], 
//                          [CCCallBlockN actionWithBlock:^(CCNode *node) {
//            titleLogo.visible = NO;
//            [[CCDirector sharedDirector] pushScene:[CCTransitionPageTurn transitionWithDuration:0.5 scene:[MainLayer scene]]];
//    }],nil]];
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
    [titleBgSprite release];
//    [titleLogo release];
    
	// don't forget to call "super dealloc"
	[super dealloc];
}
@end
