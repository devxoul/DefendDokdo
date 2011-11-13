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
//	CCSprite *bg = [[CCSprite alloc] initWithFile:@".png"];
//	[self.gameLayer addChild:bg z:Z_BACKGROUND];
	
	sun = [[CCSprite alloc] initWithFile:@"sun.png"];
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
	
	if( arc4random() % 50 < 1 ) [enemyManager createEnemy:0 level:0]; // temp
	
	[enemyManager update];
    [gameUILayer update];
}

@end
