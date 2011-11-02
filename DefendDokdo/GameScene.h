//
//  GameScene.h
//  DefendDokdo
//
//  Created by 전 수열 on 11. 11. 1..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "EnemyManager.h"
#import "ControlManager.h"
#import "SkillManager.h"

@interface GameScene : CCScene {
	EnemyManager *enemyManager;
	ControlManager *controlManager;
	SkillManager *skillManager;
	
	NSMutableArray *enemies;
}

@property (nonatomic, retain) NSMutableArray *enemies;

@end
