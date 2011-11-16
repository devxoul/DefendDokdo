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
#import "Enemy.h"
#import "Arrow.h"

@implementation ArrowObject

@synthesize x, y;
@synthesize direction;
@synthesize arrowSprite;
@synthesize arrowState;
@synthesize touchPoint;
@synthesize location;
@synthesize arrowSpeed;


//-(id) init:(NSString*)_fileName :(CGPoint)_touchPoint :(NSInteger)_damage :(GameScene*)_gameScene{    
-(id) init:(NSString*)_fileName:(NSInteger)_damage :(GameScene*)_gameScene
{
    
    if( self == [super init] )
    {
        arrowSprite = [CCSprite spriteWithFile:_fileName];
        gameScene = _gameScene;
        damage = _damage;

        if(0 <= touchPoint.x && touchPoint.x <= 240){
            x = 0;
            y = 320;
            direction = DIRECTION_STATE_LEFT;
            grade = (320.0 - (float) touchPoint.y)/(0.0-(float)touchPoint.x);
            incremental = 2.0 * (-grade) / (touchPoint.x);
        }
        else if(240 < touchPoint.x && touchPoint.x <= 480){
            x = 480;
            y = 320;
            direction = DIRECTION_STATE_RIGHT;
            grade = (320.0 - (float) touchPoint.y)/(480.0-(float)touchPoint.x) ;
            incremental = 2.0 * grade / (480 - touchPoint.x);
        }
        
        
        //그레이드 계산 후 로테이트 해야함
        rawIncremental = incremental;
//        arrowSpeed = 50;
//        arrowState = ARROW_STATE_MOVING;
//
//        [arrowSprite setAnchorPoint:ccp(1.0, 0.5)];
//        [arrowSprite setPosition:ccp(x,y)];
//        
//		[_gameScene.skillLayer addChild:arrowSprite z:1];
//=======
        
        [arrowSprite setAnchorPoint:ccp(1.0, 0.5)];
        [arrowSprite setPosition:ccp(0,0)];
        [arrowSprite setVisible:NO];
		[_gameScene.skillLayer addChild:arrowSprite z:1];
        arrowState = ARROW_STATE_STOP;
//>>>>>>> CrowDroid
        
    }
    return self;
}

-(void) selfRelease:(id)sender{
    [arrowSprite setVisible:NO];
    [arrowSprite setPosition:ccp(0,0)];
    [gameScene.skillManager.arrow.unusedArrowArray addObject:self];
}

-(void)setReady:(CGPoint)_touchPoint{
    arrowSprite.opacity = 255;
    arrowSprite.rotation = 0;
    touchPoint=_touchPoint;
    if(0 <= touchPoint.x && touchPoint.x <= 240){
        x = 0;
        y = 320;
        direction = DIRECTION_STATE_LEFT;
        grade = (320.0 - (float) touchPoint.y)/(0.0-(float)touchPoint.x);
        incremental = 2.0 * (-grade) / (touchPoint.x);
    }
    else if(240 < touchPoint.x && touchPoint.x <= 480){
        x = 480;
        y = 320;
        direction = DIRECTION_STATE_RIGHT;
        grade = (320.0 - (float) touchPoint.y)/(480.0-(float)touchPoint.x) ;
        incremental = 2.0 * grade / (480 - touchPoint.x);
    }
    
    rawIncremental = incremental;
    arrowSpeed = 50;
    
    [arrowSprite setPosition:ccp(x,y)];
    
}

-(void)drawAtDelay:(CGFloat)delay{
    arrowState = ARROW_STATE_MOVING;
    [self performSelector:@selector(draw) withObject:nil afterDelay:delay];
}

-(void) draw{
    [arrowSprite setVisible:YES];
    arrowSpeed += 2;
    switch (arrowState) {
        case ARROW_STATE_MOVING:
            
            //충돌 체크, 데미지 체크 - 
            for(Enemy* current in gameScene.enemies){
                if(CGRectContainsPoint([current getBoundingBox],arrowSprite.position)){
                    [current beDamaged:damage];
                    arrowState = ARROW_STATE_STOP;
                    break;
                }
            }
            
            switch (direction) {
                case DIRECTION_STATE_LEFT:
                    x++;
                    y = y - incremental;
                    incremental +=rawIncremental;
                    arrowSprite.rotation = atan(incremental) * 180 / M_PI;

                    if(y < ((31.f/23.f * x - 98.3)-10.0) && x < 240)
                        arrowState = ARROW_STATE_STOP;
                    break;
                    
                case DIRECTION_STATE_RIGHT:
                    x--;
                    y = y - incremental;
                    incremental +=rawIncremental;
                    arrowSprite.rotation = atan(-incremental) * 180 / M_PI + 180;
                    if(y < ((-31.f/20.f * x  + 608)-10.0) && x > 240)
                        arrowState = ARROW_STATE_STOP;
                    break;
            }
            
            if(arrowSprite.position.y <=40){
                arrowState = ARROW_STATE_STOP;
            }
            
            [self performSelector:@selector(draw) withObject:nil afterDelay:1.0/arrowSpeed];
            break;
        case ARROW_STATE_STOP:
            //맞는 애니메이션, 쾅
            arrowState = ARROW_STATE_DEAD;
            [self performSelector:@selector(draw) withObject:nil afterDelay:1.0/arrowSpeed];
            break;
        case ARROW_STATE_DEAD:
            arrowDeadEndCallBack = [[CCCallFunc actionWithTarget:self selector:@selector(selfRelease:)] retain];
            action = [CCFadeOut actionWithDuration:0.3f];    
            [arrowSprite runAction:[CCSequence actions:action, arrowDeadEndCallBack,nil]];
            //화살 사라지는 애니메이션, 끝나면 자가 Release
            break;
    }
    if(arrowState == ARROW_STATE_MOVING)
        [arrowSprite setPosition:ccp(x,y)];
    
}

-(void) runDisappearAnimation{
    //애니메이션 추가
}

-(void) runCrashAnimation{
    //애니메이션 추가
}
@end
