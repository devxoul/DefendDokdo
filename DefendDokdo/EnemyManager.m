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

- (id)initWithGameScene:(GameScene *)scene
{
	if( self = [self init] )
	{
		gameScene = scene;
		enemyInfoList = [[[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"EnemyInfoList" ofType:@"plist"]] retain] objectForKey:@"EnemyInfoList"];
	}
	
	return self;
}

- (void)update
{
	for( Enemy *enemy in gameScene.enemies )
	{
		//if( arc4random() % 50 < 1 ) [enemy applyForce:(float)((NSInteger)(arc4random() % 20) - 10) :(float)(arc4random() % 10 + 5)]; // temp
		
		[enemy update];
	}
}

- (void)createEnemy:(NSInteger)type level:(NSInteger)level
{
	NSDictionary *enemyInfo = [[enemyInfoList objectAtIndex:type] objectAtIndex:level];
	Enemy *enemy = [[[Enemy alloc] initWithGameScene:gameScene type:type level:level hp:[[enemyInfo objectForKey:@"hp"] integerValue] power:[[enemyInfo objectForKey:@"power"] integerValue] speed:[[enemyInfo objectForKey:@"speed"] floatValue]] autorelease];
	[gameScene.enemies addObject:enemy];
}

@end
