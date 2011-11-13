//
//  ArrowObject.h
//  DefendDokdo
//
//  Created by 상훈 한 on 11. 11. 9..
//  Copyright (c) 2011년 Joyfl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class GameScene;

@interface ArrowObject : NSObject{

    NSInteger direction;
    CCSprite* arrowSprite;
    
    NSInteger arrowState;
    CGPoint touchPoint;
    CGPoint location;

    CGFloat x;
    CGFloat y;
    CGFloat grade;
    CGFloat arrowSpeed;

}


@property (readwrite) NSInteger direction;
@property (nonatomic, retain) CCSprite* arrowSprite;

@property (readwrite) NSInteger arrowState;


@property (readwrite) CGPoint touchPoint;
@property (readwrite) CGPoint location;

@property (readwrite) CGFloat x;
@property (readwrite) CGFloat y;
@property (readwrite) CGFloat arrowSpeed;

-(id) init:(NSString*)_fileName :(CGPoint)_touchPoint :(NSInteger)_demage :(GameScene*)_gameScene;    
-(void) runDisappearAnimation;
-(void) runCrashAnimation;
-(void) draw;

@end
