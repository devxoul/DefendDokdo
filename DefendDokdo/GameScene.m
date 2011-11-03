//
//  GameScene.m
//  DefendDokdo
//
//  Created by 전 수열 on 11. 11. 1..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import "GameScene.h"
#import "GameLayer.h"
#import "GameUILayer.h"

@implementation GameScene

@synthesize gameLayer, gameUILayer;
@synthesize enemies;

- (id)init
{
	if( self == [super init] )
	{
		enemies = [[NSMutableArray alloc] init];
		
		gameLayer = [[GameLayer alloc] init];
		[self addChild:gameLayer];
		gameUILayer = [[GameUILayer alloc] init];
//		[self addChild:gameUILayer];
		
		enemyManager = [[EnemyManager alloc] initWithGameScene:self];
	}
	
	return self;
}

- (void)draw
{
	[super draw];
	
	if( arc4random() % 10 < 1 )
		[enemyManager createEnemy:0 level:0];
	
	[enemyManager update];
}

@end
