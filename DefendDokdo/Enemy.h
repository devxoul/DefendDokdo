//
//  Enemy.h
//  DefendDokdo
//
//  Created by 전 수열 on 11. 11. 1..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class GameScene;

@interface Enemy : NSObject {
	GameScene *gameScene;
	
	NSInteger type;
	NSInteger level;
	
	NSInteger maxHp;
	NSInteger hp;
    NSInteger power;
	CGFloat speed;
	
	CCSprite *enemySpr;
	
	CCSprite *boatSpr;
	CCSpriteBatchNode *boatBatchNode;
	CCSprite *boatEnemySpr;
	CCAnimate *boatAnimation;
	
	CCSpriteBatchNode *flightBatchNode;
	CCSprite *flightEnemySpr;
	CCAnimate *flightAnimation;
	
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
	
	CCSpriteBatchNode *explosionBatchNode;
	CCSprite *explosionEnemySpr;
	CCAnimate *explosionAnimation;
	
	CCSpriteBatchNode *waterEffectBatchNode;
	CCSprite *waterEffectSpr;
	CCAnimate *waterEffectAnimation;
	BOOL isWaterEffectRunning;
	
	CGFloat _x;
	CGFloat _y;
	CGFloat dx;
	CGFloat dy;
	
	NSInteger state;
	
	CGFloat gapX;
	CGFloat gapY;
	
	BOOL firstDirection; // 초기 방향
	BOOL isFlightExists; // 비행기가 아직도 떠있는지
	BOOL fallWithNoDamage; // YES일 경우 떨어져도 데미지를 입지 않음. (비행기에서 떨어질 때, 돌 맞고 떨어질 때)
}

@property (nonatomic) NSInteger type;
@property (nonatomic) NSInteger level;

@property (nonatomic) NSInteger maxHp;
@property (nonatomic) NSInteger hp;
@property (nonatomic) NSInteger power;
@property (nonatomic) CGFloat speed;

@property (readonly) NSInteger state;

@property (nonatomic) CGFloat x;
@property (nonatomic) CGFloat y;
@property (nonatomic) CGFloat dx;
@property (nonatomic) CGFloat dy;
@property (nonatomic, readonly, getter = getBoundingBox) CGRect boundingBox;

+ (CGFloat)getGroundY:(CGFloat)x;

- (id)initWithGameScene:(GameScene *)scene type:(NSInteger)_type level:(NSInteger)_level hp:(NSInteger)_hp power:(NSInteger)_power speed:(CGFloat)_speed;
- (void)update;
- (void)applyForce:(CGFloat)x:(CGFloat)y;

- (void)beDamaged:(NSInteger)damage;
- (void)beDamaged:(NSInteger)damage forceX:(NSInteger)forceX forceY:(NSInteger)forceY;
- (void)beCaught;

@end
