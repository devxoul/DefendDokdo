//
//  Stone.h
//  DefendDokdo
//
//  Created by 상훈 한 on 11. 11. 6..
//  Copyright (c) 2011년 Joyfl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class GameScene;

@interface Stone : NSObject
{
    CCSprite* stoneSprite;
    
    CGFloat x, y;
    CGFloat speed;
    CGFloat downPoint;
    
    NSInteger damage;
    NSInteger level;
    NSInteger stoneState;
    NSInteger mp;
    
    NSInteger direction;
    NSInteger effectPower;
    
    BOOL isEffect;
    
    GameScene* gameScene;

}

@property (readonly)  NSInteger mp;
@property (readwrite) NSInteger stoneState;

@property (nonatomic, retain) CCSprite* stoneSprite; 

-(void) draw;
-(id) initWithInfo:(CGPoint)location :(CGFloat)_speed :(GameScene*)_gameScene;

@end
