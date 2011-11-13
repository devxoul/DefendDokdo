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
    
    NSInteger level;
    NSInteger damage;
    NSInteger quantity;
    
    NSInteger direction;
    NSString* fileName;
    GameScene* gameScene;
    
    NSInteger secondGrade;
    NSInteger firstGrade;
    NSInteger constGrade;
    
    NSInteger arrowState;
    
    NSInteger count;
     
}

@property (readwrite) CGPoint touchPoint;
@property (readwrite) CGPoint startPoint;

@property (readwrite) NSInteger damage;
@property (readwrite) NSInteger level;
@property (readwrite) NSInteger quantity;

@property (nonatomic, retain) NSMutableArray* arrowArray; 
@property (nonatomic, retain) NSString* fileName;

-(void) draw;
-(id) init:(NSString*)_fileName :(CGPoint)_touchPoint :(NSInteger)_level :(GameScene*)_gameScene;

@end