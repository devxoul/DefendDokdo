//
//  Arrow.h
//  DefendDokdo
//
//  Created by 상훈 한 on 11. 11. 9..
//  Copyright (c) 2011년 Joyfl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"


@class GameScene;

@interface Arrow : NSObject
{
    NSMutableArray* arrowArray;
    NSMutableArray* unusedArrowArray;
    CGPoint touchPoint;
    CGPoint startPoint;
    
    NSInteger damage;
    NSInteger number;
    NSInteger mp;
    
    GameScene* gameScene;
    
    NSInteger secondGrade;
    NSInteger firstGrade;
    NSInteger constGrade;
    
    NSInteger arrowState;
    
}

@property (nonatomic, retain) NSMutableArray* arrowArray; 
@property (nonatomic, retain) NSMutableArray* unusedArrowArray; 

@property (readonly) NSInteger mp;

-(id) initWithInfo:(GameScene*)_gameScene;
-(BOOL) addArrow:(CGPoint)_touchPoint;

@end