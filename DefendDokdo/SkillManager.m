//
//  SkillManager.m
//  DefendDokdo
//
//  Created by 전 수열 on 11. 11. 2..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import "SkillManager.h"
#import "GameScene.h"
#import "SkillLayer.h"
#import "AudioToolbox/AudioServices.h"
#import "Stone.h"
#import "Arrow.h"
#import "Enemy.h"
#import "SkillData.h"
#import "ArrowObject.h"
#import "UserData.h"

@implementation SkillManager

@synthesize skillState, arrow,stoneArray;

enum{
    skill_stone_tag=1
};

- (id)initWithGameScene:(GameScene *)gameScene
{
	if( self == [super init] )
	{
		_gameScene = gameScene;
        skillState = SKILL_STATE_NORMAL;
        arrow = [[Arrow alloc] initWithInfo:_gameScene];
        stoneArray = [[NSMutableArray alloc] init];
        
        
	}
	
	return self;
}

- (void)update
{

    switch (skillState) {            
        case SKILL_STATE_EARTHQUAKE:
            skillState = SKILL_STATE_NORMAL;
            [self createEarthQuake];
            break;
        case SKILL_STATE_HEALING:
            skillState = SKILL_STATE_NORMAL;

            break;
    }
      
    NSMutableIndexSet *removedStone = [[NSMutableIndexSet alloc] init];
    for(Stone *current in stoneArray){
        if(current.stoneState == STONE_STATE_STOP){
            [removedStone addIndex:[stoneArray indexOfObject:current]];
            [[current stoneSprite] removeFromParentAndCleanup:YES];
            
        }
        else
            [current draw];
    }
    [stoneArray removeObjectsAtIndexes:removedStone];
    
    //화살 날릴 때는 꼭 싱크 보장.
    @synchronized(self){
        NSMutableIndexSet *removedArrow = [[NSMutableIndexSet alloc] init];
        
        for(ArrowObject *current in arrow.arrowArray){
            if(current.arrowState == ARROW_STATE_UNUSED){
                [removedArrow addIndex:[arrow.arrowArray indexOfObject:current]];
                [arrow.unusedArrowArray addObject:current];
            }
            else
                [current draw];
        }
        [arrow.arrowArray removeObjectsAtIndexes:removedArrow];
    }
    
}

-(void)createStone:(CGPoint)location{
    Stone* stone = [[Stone alloc] initWithInfo:location :0.1 :_gameScene];

    if(stone!=nil){
        skillState = SKILL_STATE_NORMAL;
        
        //마나소비
        [_gameScene.skillLayer addChild:[stone stoneSprite] z:1 tag:skill_stone_tag];
        [stoneArray addObject:stone];
    }
}

-(void)createArrow:(CGPoint)location{
    
    skillState = SKILL_STATE_NORMAL;
    [arrow addArrow:location];
    //마나 소비
}

-(void) createEarthQuake{
    //마나 소비
    CCShaky3D *shake = [CCShaky3D actionWithRange:5 shakeZ:NO grid:ccg(1,1) duration:0.5];
    [_gameScene.gameLayer runAction:shake];
    //적들 체크 ~
    //애니메이션 효과 주기 - 일정 시간 동안
    
    //구현!
    NSInteger damage = [[[[SkillData skillData] getSkillInfo:SKILL_STATE_EARTHQUAKE :[[UserData userData] earthquakeLevel]] objectForKey:@"damage"] integerValue];
    NSInteger power = [[[[SkillData skillData] getSkillInfo:SKILL_STATE_EARTHQUAKE :[[UserData userData] earthquakeLevel]] objectForKey:@"effectPower"] integerValue];
    
    for(Enemy* current in _gameScene.enemies){
        if([current x] <= FLAG_X)
            [current beDamaged:damage forceX:-power forceY:power];
        else
            [current beDamaged:damage forceX:power forceY:power];            
    }
    
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}

@end
