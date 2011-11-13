//
//  Arrow.m
//  DefendDokdo
//
//  Created by 상훈 한 on 11. 11. 9..
//  Copyright (c) 2011년 Joyfl. All rights reserved.
//

#import "Arrow.h"
#import "GameScene.h"
#import "ArrowObject.h"
#import "SkillLayer.h"

@implementation Arrow

@synthesize touchPoint;
@synthesize startPoint;

@synthesize damage;
@synthesize level;
@synthesize quantity;
@synthesize arrowArray; 

@synthesize fileName;

-(void) draw{

  //  NSMutableIndexSet* removedArrowArray = [[NSMutableIndexSet alloc] init];
    
    if(count == 0)
        return;
    else
        count--;
    
        //적 충돌 체크  - 및 상태 변환
        ArrowObject *current = [[[ArrowObject alloc] init:fileName :touchPoint:10 :gameScene] retain];
        [current draw]; 
//<<<<<<< HEAD
    /*   
        switch ([current arrowState]) {
            case ARROW_STATE_MOVING:
                //기울기 계산
                NSLog(@"arrowMove");
                [current performSelector:@selector(draw) withObject:nil afterDelay:1.0/[current arrowSpeed]];
                if([[current arrowSprite] position].y <=40){
                    [current setArrowState:ARROW_STATE_STOP];
                }
                break;
            case ARROW_STATE_STOP:
                //맞는 애니메이션
                [current performSelector:@selector(draw) withObject:nil afterDelay:1.0/[current arrowSpeed]];
                break;
            case ARROW_STATE_DEAD:
                [[current arrowSprite] removeFromParentAndCleanup:YES];
                [current release];
                [removedArrowArray addIndex:[arrowArray indexOfObject:current]];
                //화살 사라지는 애니메이션, 자가 Release
                break;
        }
    */
    
  //  [arrowArray removeObjectsAtIndexes:removedArrowArray];
 //   removedArrowArray = nil;
  //  [removedArrowArray release];

//    [self performSelector:@selector(draw) withObject:nil afterDelay:0.2];
//=======

    [self performSelector:@selector(draw) withObject:nil afterDelay:0.4];
//>>>>>>> CrowDroid
}

-(id) init:(NSString*)_fileName :(CGPoint)_touchPoint :(NSInteger)_level :(GameScene*)_gameScene{    

    if( self = [super init] )
    {
        
        fileName = _fileName;
        gameScene = _gameScene;
        touchPoint = _touchPoint;
        level = _level;
        
        if(touchPoint.y <=40 || touchPoint.x == 240)
            return nil;
        
        if(0 <= touchPoint.x && touchPoint.x <= 240){
            direction = DIRECTION_STATE_LEFT;
        }
        else if(240 < touchPoint.x && touchPoint.x <= 480){
            direction = DIRECTION_STATE_RIGHT;
        }

        arrowArray = [[NSMutableArray alloc] init];
        
        /*for(int index=0;index < level*3; index++){
            [arrowArray addObject:[[ArrowObject alloc] init:fileName :touchPoint:10 :gameScene]];
            NSLog(@"create Arrow Object");
        }
         */
        count = level *3;
        
    }
    
    return self;
}

@end
