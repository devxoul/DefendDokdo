//
//  Enemy.h
//  DefendDokdo
//
//  Created by 전 수열 on 11. 11. 1..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Enemy : NSObject {
	NSInteger *type;
	NSInteger *level;
    NSInteger *power;
	NSInteger *maxHp;
	NSInteger *hp;
	NSInteger *speed;
	
	CCSprite *enemySpr;
	
	float _x;
	float _y;
	float dx;
	float dy;
}

@property (nonatomic) NSInteger *type;
@property (nonatomic) NSInteger *level;
@property (nonatomic) NSInteger *power;
@property (nonatomic) NSInteger *maxHp;
@property (nonatomic) NSInteger *hp;
@property (nonatomic) NSInteger *speed;

@property (nonatomic, retain) CCSprite *enemySpr;

@property (nonatomic) float x;
@property (nonatomic) float y;
@property (nonatomic) float dx;
@property (nonatomic) float dy;

- (id)initWithType:(NSInteger)type level:(NSInteger)level;
- (void)applyForce:(float)force direction:(float)direction;
- (void)applyForce:(float)x:(float)y;
- (void)update;

@end
