//
//  Stone.h
//  DefendDokdo
//
//  Created by 상훈 한 on 11. 11. 6..
//  Copyright (c) 2011년 Joyfl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Stone : NSObject
{
    CCSprite* stoneSprite;
    
    float x, y;
    float speed;
    float downPoint;
    
    int damage;
    int level;
    int stoneState;
    
    int direction;
    
}

@property (readwrite) float x;
@property (readwrite) float y;
@property (readwrite) float speed;
@property (readwrite) float downPoint;

@property (readwrite) int damage;
@property (readwrite) int level;
@property (readwrite) int stoneState;

@property (nonatomic, retain) CCSprite* stoneSprite; 

-(void) draw;
-(id) init:(NSString*)fileName :(CGPoint)location :(float)_speed;

@end
