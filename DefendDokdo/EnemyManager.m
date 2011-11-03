//
//  EnemyManager.m
//  DefendDokdo
//
//  Created by 전 수열 on 11. 11. 2..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import "EnemyManager.h"
#import "Enemy.h"
#import "GameScene.h"
#import "Const.h"

@interface EnemyManager(Private)
//- (void)createEnemy:(NSInteger)type level:(NSInteger)level;
@end


@implementation EnemyManager

- (id)initWithGameScene:(GameScene *)gameScene
{
	if( self == [self init] )
	{
		_gameScene = gameScene;
	}
	
	return self;
}

- (void)update
{
	for( Enemy *enemy in _gameScene.enemies )
	{
		[enemy applyForce:0 :-GRAVITY];
		[enemy applyForce:0 :0];
		[enemy update];
	}
}

- (void)createEnemy:(NSInteger)type level:(NSInteger)level
{
	Enemy *enemy = [[Enemy alloc] initWithType:type level:level];
//	enemy.x = arc4random() % 2 ? 0 : 480;
	enemy.x = 0;
	enemy.y = 320;
	enemy.speed = 5;
	[_gameScene.enemies addObject:enemy];
	[_gameScene.gameLayer addChild:enemy.enemySpr];
	[enemy applyForce:10 :0];
}

@end
