//
//  Enemy.h
//  DefendDokdo
//
//  Created by 전 수열 on 11. 11. 1..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class GameLayer;

@interface Enemy : NSObject {
	GameLayer *gameLayer;
	
	NSInteger type;
	NSInteger level;
    NSInteger power;
	NSInteger maxHp;
	NSInteger hp;
	float speed;
	
	CCSprite *enemySpr;
	
	CCSpriteBatchNode *boatBatchNode;
	CCSprite *boatEnemySpr;
	CCAnimate *boatAnimation;
	
	CCSpriteBatchNode *swimBatchNode;
	CCSprite *swimEnemySpr;
	CCAnimate *swimAnimation;
	
	CCSpriteBatchNode *walkBatchNode;
	CCSprite *walkEnemySpr;
	CCAnimate *walkAnimation;
	
	CCSpriteBatchNode *attackBatchNode;
	CCSprite *attackEnemySpr;
	CCAnimate *attackAnimation;
	
	CCSpriteBatchNode *catchBatchNode;
	CCSprite *catchEnemySpr;
	CCAnimate *catchAnimation;
	
	CCSpriteBatchNode *fallBatchNode;
	CCSprite *fallEnemySpr;
	CCAnimate *fallAnimation;
	
	CCSpriteBatchNode *hitBatchNode;
	CCSprite *hitEnemySpr;
	CCAnimate *hitAnimation;
	
	CCSpriteBatchNode *dieBatchNode;
	CCSprite *dieEnemySpr;
	CCAnimate *dieAnimation;
	
	float _x;
	float _y;
	float dx;
	float dy;
	
	NSInteger state;
}

@property (nonatomic) NSInteger type;
@property (nonatomic) NSInteger level;
@property (nonatomic) NSInteger power;
@property (nonatomic) NSInteger maxHp;
@property (nonatomic) NSInteger hp;
@property (nonatomic) float speed;

@property (nonatomic) float x;
@property (nonatomic) float y;
@property (nonatomic) float dx;
@property (nonatomic) float dy;
@property (nonatomic, readonly, getter = getBoundingBox) CGRect boundingBox;


- (id)initWithGameLayer:(GameLayer *)layer type:(NSInteger)type level:(NSInteger)level;
- (void)update;
- (void)applyForce:(float)x:(float)y;

- (void)beDamaged:(NSInteger)damage;
- (void)beDamaged:(NSInteger)damage forceX:(NSInteger)forceX forceY:(NSInteger)forceY;

@end
