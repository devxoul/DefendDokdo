//
//  ArrowObject.m
//  DefendDokdo
//
//  Created by 상훈 한 on 11. 11. 9..
//  Copyright (c) 2011년 Joyfl. All rights reserved.
//

#import "ArrowObject.h"
#import "Const.h"
#import "GameScene.h"
#import "SkillLayer.h"

@implementation ArrowObject

@synthesize x, y;
@synthesize direction;
@synthesize arrowSprite;
@synthesize arrowState;
@synthesize touchPoint;
@synthesize location;
@synthesize arrowSpeed;

-(id) init:(NSString*)_fileName :(CGPoint)_touchPoint :(NSInteger)_demage :(GameScene*)_gameScene{    

    if( self == [super init] )
    {
        
        touchPoint = _touchPoint;
        arrowSprite = [CCSprite spriteWithFile:_fileName];
        
        if(0 <= touchPoint.x && touchPoint.x <= 240){
            x = 0;
            y = 240;
            direction = DIRECTION_STATE_LEFT;
            grade = (240.0 - (float) touchPoint.y)/(0.0-(float)touchPoint.x);
            arrowSprite.rotation = -atan(grade) * 180 / M_PI;

        }
        else if(240 < touchPoint.x && touchPoint.x <= 480){
            x = 480;
            y = 240;
            direction = DIRECTION_STATE_RIGHT;
            grade = (240.0 - (float) touchPoint.y)/(480.0-(float)touchPoint.x) ;
            arrowSprite.rotation = -atan(grade) * 180 / M_PI + 180;

        }
        
        //그레이드 계산 후 로테이트 해야함
//        arrowSprite.rotation = 90;
        arrowSpeed = 100;       
        arrowState = ARROW_STATE_MOVING;
        [arrowSprite setAnchorPoint:ccp(1.0, 0.5)];
        [arrowSprite setPosition:ccp(x,y)];
        [_gameScene.skillLayer addChild:arrowSprite z:1];
        
    }
    return self;
}

-(void) draw{
    switch (direction) {
        case DIRECTION_STATE_LEFT:
            x++;
            y = y + grade;
            break;
        case DIRECTION_STATE_RIGHT:
            x--;
            y = y - grade;
            break;
    }

    arrowSpeed += 5;
    [arrowSprite setPosition:ccp(x,y)];

    switch (arrowState) {
        case ARROW_STATE_MOVING:
            //충돌 체크, 데미지 체크 - 
            [self performSelector:@selector(draw) withObject:nil afterDelay:1.0/arrowSpeed];
            if(arrowSprite.position.y <=40){
                arrowState = ARROW_STATE_STOP;
            }
            break;
        case ARROW_STATE_STOP:
            //맞는 애니메이션, 쾅
            arrowState = ARROW_STATE_DEAD;
            [self performSelector:@selector(draw) withObject:nil afterDelay:1.0/arrowSpeed];
            break;
        case ARROW_STATE_DEAD:
            [arrowSprite removeFromParentAndCleanup:YES];
            [self release];
            //화살 사라지는 애니메이션, 끝나면 자가 Release
            break;
    }
    
}

-(void) runDisappearAnimation{
//애니메이션 추가
}

-(void) runCrashAnimation{
//애니메이션 추가
}
@end
