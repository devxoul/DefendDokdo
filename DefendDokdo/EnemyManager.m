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
- (void)createEnemy:(NSInteger)type level:(NSInteger)level;
@end


@implementation EnemyManager

- (id)initWithGameScene:(GameScene *)scene
{
	if( self = [self init] )
	{
		gameScene = scene;
		enemyInfoList = [[[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"EnemyInfoList" ofType:@"plist"]] retain] objectForKey:@"EnemyInfoList"];
		stageInfoList = [[[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"StageInfoList" ofType:@"plist"]] retain] objectForKey:@"StageInfoList"];
	}
	
	return self;
}

- (void)update
{
	if( lastSunPermillage != gameScene.sunPermillage )
	{
		for( NSInteger i = 0; i < 12; i++ )
		{
			NSInteger frequency = [[[stageInfoList objectAtIndex:[gameScene currentStage]] objectAtIndex:i] integerValue];
			
			// 퍼밀리지가 1 다음 3이 될 경우도 있어서 중간 과정을 모두 체크해줌
			for( NSInteger j = lastSunPermillage + 1; j <= gameScene.sunPermillage; j++ )
			{
				if( frequency && j % frequency == 0 )
				{
					NSLog( @"가라 %d번 %d레벨 Enemy!!", i / 3, i % 3 );
					[self createEnemy:i / 3 level:i % 3];
					break;
				}
			}
		}
		
		lastSunPermillage = gameScene.sunPermillage;
	}
	
	NSMutableIndexSet *willBeRemovedEnemyIndices = [[[NSMutableIndexSet alloc] init] autorelease];
	
	for( NSInteger i = 0; i < gameScene.enemies.count; i++ )
	{
		Enemy *enemy = [gameScene.enemies objectAtIndex:i];
		[enemy update];
		
		if( enemy.state == ENEMY_STATE_REMOVE )
			[willBeRemovedEnemyIndices addIndex:i];
	}
	
	[gameScene.enemies removeObjectsAtIndexes:willBeRemovedEnemyIndices];
}

- (void)createEnemy:(NSInteger)type level:(NSInteger)level
{
	NSDictionary *enemyInfo = [[enemyInfoList objectAtIndex:type] objectAtIndex:level];
	[gameScene.enemies addObject:[[Enemy alloc] initWithGameScene:gameScene type:type level:level hp:[[enemyInfo objectForKey:@"hp"] integerValue] power:[[enemyInfo objectForKey:@"power"] integerValue] speed:[[enemyInfo objectForKey:@"speed"] floatValue]]];
}

@end
