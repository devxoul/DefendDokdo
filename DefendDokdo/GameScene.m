//
//  GameScene.m
//  DefendDokdo
//
//  Created by 전 수열 on 11. 11. 1..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import "GameScene.h"
#import "GameLayer.h"
#import "SkillLayer.h"
#import "GameUILayer.h"
#import "Const.h"
#import "Flag.h"
#import "ResultLayer.h"

@interface GameScene(Private)
- (void)initLayers;
- (void)initStage;
- (void)initManagers;
@end


@implementation GameScene

@synthesize gameLayer, gameUILayer, skillLayer;
@synthesize controlManager;
@synthesize flag, enemies;
@synthesize skillManager;
@synthesize nGameState;


enum{
	BACKGROUND_1,
	BACKGROUND_2,
	BACKGROUND_3,
	BACKGROUND_4
};


- (id)init
{
	if( self = [super init] )
	{
		[self initLayers];
		[self initManagers];
		[self initStage];
	}
	
	return self;
}

- (void)initLayers
{
	gameLayer = [[GameLayer alloc] initWithScene:self];
	[self addChild:gameLayer];
    
    skillLayer = [[SkillLayer alloc] initWithScene:self];
    [self addChild:skillLayer];
	
	gameUILayer = [[GameUILayer alloc] initWithScene:self];
	[self addChild:gameUILayer];
}

- (void)initStage
{
	for (int i = 0; i < 4; i++) {
		arryBg[i] = [[CCSprite alloc] initWithFile:[NSString stringWithFormat:@"game_bg_%d.png", i]];
		[arryBg[i] setAnchorPoint:CGPointZero];
		[arryBg[i] setPosition:CGPointZero];
		[arryBg[i] setVisible:NO];
		[self.gameLayer addChild:arryBg[i] z:Z_BACKGROUND];
	}
	
	[arryBg[BACKGROUND_1] setVisible:YES];
	nBgState = BACKGROUND_1;
	
	nGameState = GAMESTATE_START;
	nCount = 0;
	
	sun = [[CCSprite alloc] initWithFile:@"sun.png"];
	[sun setPosition:ccp(-40.0f, 100.0f)];
	[sun setAnchorPoint:ccp(0.5f, 0.0f)];
	[self.gameLayer addChild:sun z:Z_SUN];
	
	CCSprite *dokdo = [[CCSprite alloc] initWithFile:@"dokdo.png"];
	dokdo.position = ccp( 222, 116 );
	[self.gameLayer addChild:dokdo z:Z_DOKDO];
	
	CCSprite *sea = [[CCSprite alloc] initWithFile:@"sea.png"];
	sea.anchorPoint = CGPointZero;
	[self.gameLayer addChild:sea z:Z_SEA];
	
	flag = [Flag alloc];
	[flag init:self.gameLayer];
	
	enemies = [[NSMutableArray alloc] init];
	
	label = [CCLabelTTF alloc];
	label.string = @" ";
	label.position = ccp( 240, 480 );
	label.color = ccBLACK;
	label.visible = NO;
	
	[self addChild:label z:Z_Label];
}

- (void)initManagers
{
	enemyManager = [[EnemyManager alloc] initWithGameScene:self];
	skillManager = [[SkillManager alloc] initWithGameScene:self];
	controlManager = [[ControlManager alloc] init];
}

- (void)draw
{
	[super draw];
	
	if (nGameState == GAMESTATE_START)
	{		
		if( arc4random() % 50 < 1 ) [enemyManager createEnemy:0 level:0]; // temp
		
		[enemyManager update];
		[gameUILayer update];
		[skillManager update];
		
		//		if (nCount % 250 == 0) {
		//			
		//			[arryBg[nBgState] setVisible:NO];
		//			nBgState++;
		//			
		//			if (nBgState == 4) {
		//				//gameover
		//				nBgState = 0;
		//				nCount = 0;
		//				[arryBg[nBgState] setVisible:YES];
		//			}
		//			else {
		//				[arryBg[nBgState] setVisible:YES];
		//			}		
		//		}
		//		
		//		CGFloat sunX = sun.position.x + 0.1; // 2분 42초 
		//		CGFloat sunX = sun.position.x + 0.15; // 1분 23초
		//		CGFloat sunX = sun.position.x + 0.12; // 1분 46초
		//		CGFloat sunX = sun.position.x + 0.11; // 2분 24초
		//		CGFloat sunX = sun.position.x + 0.115; // 1분 34초
		//		CGFloat sunX = sun.position.x + 0.112; // 2분 18초
		CGFloat sunX = sun.position.x + 0.113; // 1분 56초
		
		
		CGFloat sunY = ((-1.0/280.0) * (sunX*sunX)) + (((12.0/7.0)*sunX) + (520.0/7.0));
		
		if (sunX > 240) {
			int i = 0;
			i++;
		}
		
		[sun setPosition:ccp(sunX, sunY)];
		
		if (sunX > 480) {
			nGameState = GAMESTATE_CLEAR;
		}
		
		//		nCount++;
		
	}
	else if (nGameState == GAMESTATE_CLEAR)
	{
		label.visible = YES;
		label.string = @"Clear!";
		[label runAction:[CCEaseBackInOut actionWithAction:[CCMoveTo actionWithDuration:0.5 position:ccp( 240, 160 )]]];
		[self schedule:@selector(onLabelEnd:) interval:2.0];
		
		nGameState = GAMESTATE_ENDING;
		//		if ([UserData userData].backSound) 
		//            [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"clear.mp3"];
		
	}
	else if (nGameState == GAMESTATE_OVER)
	{
		label.visible = YES;
		label.string = @"Game Over!";
		[label runAction:[CCEaseBackInOut actionWithAction:[CCMoveTo actionWithDuration:0.5 position:ccp( 240, 160 )]]];
		[self schedule:@selector(onLabelEnd:) interval:2.0];		
		
		nGameState = GAMESTATE_ENDING;
	}	
}

- (void)onLabelEnd:(id)sender
{
	[[CCDirector sharedDirector] pushScene:[CCTransitionSlideInL transitionWithDuration:0.3 scene:[[[ResultLayer node] scene] autorelease]]];
}

@end
