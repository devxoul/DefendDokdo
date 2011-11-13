//
//  Stone.m
//  DefendDokdo
//
//  Created by 상훈 한 on 11. 11. 6..
//  Copyright (c) 2011년 Joyfl. All rights reserved.
//

#import "Stone.h"
#import "Const.h"

@implementation Stone

@synthesize x, y, speed, damage, level, stoneSprite,downPoint,stoneState;


-(id) init:(NSString*)fileName :(CGPoint)location :(float)_speed{
    if( self = [self init] )
    {
        x = location.x;
        y = location.y;
        speed = _speed;
        stoneSprite = [CCSprite spriteWithFile:fileName];
        if(110 < x && x < 225){
            downPoint = 31.f/23.f * x - 98.3;
            direction = DIRECTION_STATE_LEFT;
        }
        else if(225 <= x && x <= 240){
            x=225;
            downPoint = 31.f/23.f * x - 98.3;
            direction = DIRECTION_STATE_LEFT;
        }
        else if(260 < x && x < 360){
            downPoint = -31.f/20.f * x  + 608;
            direction = DIRECTION_STATE_RIGHT;
        }
        else if(240 < x && x <= 260){
            x = 260;
            downPoint = -31.f/20.f * x  + 608;
            direction = DIRECTION_STATE_RIGHT;
        }
        stoneState = STONE_STATE_DOWN;
        [stoneSprite setAnchorPoint:ccp(0.5, 0.5)];
        
        //독도 안쪽을 선택했다면 스킬은 쓸 수 없다
        if (y<downPoint) {
            return nil;
        }
        
    }
    return self;
}

-(void) draw{
    @synchronized(self){
        if(stoneState!=STONE_STATE_STOP){
            //적 충돌 체크!
        }
        switch (stoneState) {
            case STONE_STATE_DOWN:
                if(downPoint <= y){
                    y=y-1;
                    if(y<40){
                        stoneState = STONE_STATE_STOP;
                    }
                }
                else{
                    //돌이 부딪히는 애니메이션 구현
                    stoneState = STONE_STATE_ROLLING;
                    speed = speed/15;
                }
                [stoneSprite setPosition:ccp(x,y)];
                speed+=GRAVITY*10;
                [self performSelector:@selector(draw) withObject:nil afterDelay:1.0/speed];
                break;
            case STONE_STATE_ROLLING:{
                if(y<40){
                    //돌이 물에 떨어지는 애니메이션 구현
                    stoneState = STONE_STATE_STOP;
                    [self performSelector:@selector(draw) withObject:nil afterDelay:1.0];
                    break;
                }
                switch(direction){
                        //굴러가는 애니메이션 추가
                    case DIRECTION_STATE_LEFT:
                        x = x-1;
                        y = y - 31.f/23.f;
                        [stoneSprite setPosition:ccp(x,y)];
                        speed+=GRAVITY*10;
                        [self performSelector:@selector(draw) withObject:nil afterDelay:1.0/speed];
                        break;
                    case DIRECTION_STATE_RIGHT:
                        x = x+1;
                        y = y - 31.f/20.f;
                        [stoneSprite setPosition:ccp(x,y)];
                        speed+=GRAVITY*10;
                        [self performSelector:@selector(draw) withObject:nil afterDelay:1.0/speed];
                        break;
                }
            }
                break;
            case STONE_STATE_STOP:
                [stoneSprite setVisible:NO];
                [stoneSprite removeFromParentAndCleanup:YES];
                [self release];
                break;
                
        }
        
    }
    
}

@end