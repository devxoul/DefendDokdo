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
    
    CGPoint touchPoint;
    CGPoint startPoint;
    
    NSInteger damage;
    NSInteger number;
    
    NSInteger direction;
    NSString* fileName;
    GameScene* gameScene;
    
    NSInteger secondGrade;
    NSInteger firstGrade;
    NSInteger constGrade;
    
    NSInteger arrowState;
         
}

@property (readwrite) CGPoint touchPoint;
@property (readwrite) CGPoint startPoint;

@property (nonatomic, retain) NSMutableArray* arrowArray; 
@property (nonatomic, retain) NSString* fileName;

-(void) draw;
-(id) initWithInfo:(CGPoint)_touchPoint :(GameScene*)_gameScene;

@end