//
//  Stone.m
//  DefendDokdo
//
//  Created by 상훈 한 on 11. 11. 6..
//  Copyright (c) 2011년 Joyfl. All rights reserved.
//

#import "Stone.h"
#import "Const.h"
#import "SkillData.h"
#import "GameScene.h"
#import "Enemy.h"
#import "UserData.h"

@implementation Stone

@synthesize stoneState, mp, stoneSprite;



-(id) initWithInfo :(CGPoint)location :(CGFloat)_speed :(GameScene*)_gameScene{    
    
    if( self = [self init] )
    {
        NSDictionary *skillInfo = [[SkillData skillData] getSkillInfo:SKILL_STATE_STONE :[[UserData userData] stoneLevel]];
        
        gameScene = _gameScene;
        x = location.x;
        y = location.y;
        speed = _speed;
        stoneSprite = [CCSprite spriteWithFile:[skillInfo objectForKey:@"spriteName"]];
        damage = [[skillInfo objectForKey:@"damage"] integerValue];
        isEffect = [[skillInfo objectForKey:@"effect"] boolValue];
        mp = [[skillInfo objectForKey:@"mp"] integerValue];
        
        
        (isEffect==YES) ? (effectPower = [[skillInfo objectForKey:@"effectPower"] integerValue]) : (effectPower =0);
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
    if(stoneState==STONE_STATE_DOWN || stoneState == STONE_STATE_ROLLING){
        //적 충돌 체크!
        for(Enemy* current in gameScene.enemies){
            
            
            if(CGRectIntersectsRect([current getBoundingBox], stoneSprite.boundingBox)){
                switch (direction) {
//                    case DIRECTION_STATE_LEFT:
//                        if(effectPower==0){
                            [current beDamaged:damage];
//                        }
//                        else{//enemy State에 따라서 !
//                            [current beDamaged:damage forceX:-(CGFloat)effectPower forceY:-(CGFloat)effectPower];
//                        }
                        break;
                    case DIRECTION_STATE_RIGHT:
                        [current beDamaged:damage forceX:(CGFloat)effectPower forceY:-(CGFloat)effectPower];
                        break;
                }
            }
        }
    }
    switch (stoneState) {
        case STONE_STATE_DOWN:
            if(downPoint <= y){
                y=y-speed;
                switch(direction){
                    case DIRECTION_STATE_LEFT:
                        stoneSprite.rotation -= 3;
                        break;
                    case DIRECTION_STATE_RIGHT:
                        stoneSprite.rotation += 3;
                        break;
                }

                if(y<SEA_Y){
                    stoneState = STONE_STATE_STOP;
                }
            }
            else{
                //돌이 부딪히는 애니메이션 구현// 돌이 바닥에 부딪힐 때 이펙트
                stoneState = STONE_STATE_ROLLING;
                speed = speed/15;
            }
            [stoneSprite setPosition:ccp(x,y)];
            speed+=GRAVITY/3.0;
            break;
        case STONE_STATE_ROLLING:{
            if(y<SEA_Y){
                //돌이 물에 떨어지는 이펙트
                stoneState = STONE_STATE_STOP;
                break;
            }
            switch(direction){
                    //굴러가는 애니메이션 추가 - 는 할필요 없나?이대로 로테이트? 이펙트는 추가?
                case DIRECTION_STATE_LEFT:
                    stoneSprite.rotation -= 10*speed;
                    x = x-speed;
                    y = y - speed*31.f/23.f;
                    [stoneSprite setPosition:ccp(x,y)];
                    speed+=GRAVITY/3.0;
                    break;
                case DIRECTION_STATE_RIGHT:
                    stoneSprite.rotation += 10*speed;
                    x = x+speed;
                    y = y - speed*31.f/20.f;
                    [stoneSprite setPosition:ccp(x,y)];
                    speed+=GRAVITY/3.0;
                    break;
            }
        }
            break;
        case STONE_STATE_STOP:
            break;
            
    }

}

@end
