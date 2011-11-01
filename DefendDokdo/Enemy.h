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
}

@property (nonatomic) NSInteger *type;
@property (nonatomic) NSInteger *level;
@property (nonatomic) NSInteger *power;
@property (nonatomic) NSInteger *maxHp;
@property (nonatomic) NSInteger *hp;
@property (nonatomic) NSInteger *speed;

@property (nonatomic, retain) CCSprite *enemySpr;

@end
