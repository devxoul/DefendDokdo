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



@class GameLayer, GameUILayer, Flag, SkillLayer, ResultLayer, Player;

@interface GameScene : CCScene {
	GameLayer *gameLayer;
	SkillLayer *skillLayer;
	GameUILayer *gameUILayer;
	
	EnemyManager *enemyManager;
	ControlManager *controlManager;
	SkillManager *skillManager;
	
	CCSprite *backgroundSky;
	
	CCSprite *sea1[2];
	CCSprite *sea2[2];
	CCSprite *sea3[2];
	
	CCSprite *cloud[4];
	CCSprite *sun;
	
	Flag *flag;
	Player *player;	
	
	NSMutableArray *enemies;
	
	NSInteger nCount;
	NSInteger nWaveCount;
	
	NSInteger currentStage;
	
	CCLabelTTF *label;
	
@public
	NSInteger nGameState;
}

@property (nonatomic, retain) GameLayer *gameLayer;
@property (nonatomic, retain) GameUILayer *gameUILayer;
@property (nonatomic, retain) SkillLayer *skillLayer;

@property (readonly) ControlManager *controlManager;

@property (nonatomic, retain) Flag *flag;
@property (nonatomic, retain) NSMutableArray *enemies;

@property (nonatomic, retain) Player *player;

@property (nonatomic, retain) SkillManager *skillManager;
@property (readwrite) NSInteger nGameState;

@property (readonly) NSInteger currentStage;
@property (readonly) NSInteger sunPermillage;

-(void)waveEffect:(NSInteger)_count;

@end
