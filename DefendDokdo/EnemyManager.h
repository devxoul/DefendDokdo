//
//  EnemyManager.h
//  DefendDokdo
//
//  Created by 전 수열 on 11. 11. 2..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class GameScene;

@interface EnemyManager : NSObject {
	GameScene *gameScene;
	NSArray *enemyInfoList;
	NSArray *stageInfoList;
	NSInteger lastSunPermillage;
}

- (id)initWithGameScene:(GameScene *)gameScene;
- (void)update;
//- (void)createEnemy:(NSInteger)type level:(NSInteger)level;
@end
