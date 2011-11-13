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

@interface GameScene(Private)
- (void)initLayers;
- (void)initStage;
- (void)initManagers;
@end


@implementation GameScene

@synthesize gameLayer, gameUILayer, skillLayer;
@synthesize flag, enemies;
@synthesize skillManager;

enum{
	BACKGROUND_1,
	BACKGROUND_2,
	BACKGROUND_3,
	BACKGROUND_4
};

- (id)init
{
	if( self == [super init] )
	{
		[self initLayers];
		[self initStage];
		[self initManagers];
	}
	
	return self;
}

- (void)initLayers
{
	gameLayer = [[GameLayer alloc] init];
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
	[flag init:self];
	
	enemies = [[NSMutableArray alloc] init];
}

- (void)initManagers
{
	enemyManager = [[EnemyManager alloc] initWithGameScene:self];
	skillManager = [[SkillManager alloc] initWithGameScene:self];
}

- (void)draw
{
	[super draw];
	
	if (nCount % 50 == 0) {

		[arryBg[nBgState] setVisible:NO];
		nBgState++;
		
		if (nBgState == 4) {
			//gameover
			nBgState = 0;
			nCount = 0;
			[arryBg[nBgState] setVisible:YES];
		}
		else {
			[arryBg[nBgState] setVisible:YES];
		}		
	}
	
	NSInteger sunX = sun.position.x + 1;
	NSInteger sunY = ((-1/200)*sunX*sunX) - ((14/5)*sunX) - 104;
	[sun setPosition:ccp(sunX, sunY)];
	
	if( arc4random() % 50 < 1 ) [enemyManager createEnemy:0 level:0]; // temp
	
	[enemyManager update];
    [gameUILayer update];
	
	nCount++;
}

@end
