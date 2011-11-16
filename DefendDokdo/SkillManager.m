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

@implementation SkillManager

@synthesize skillState, arrow;

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
//            [self doHeal];
            break;
    }
}

-(void)createStone:(CGPoint)location{
    Stone* stone = [[Stone alloc] initWithInfo:location :100.0 :_gameScene];

    if(stone!=nil){
        skillState = SKILL_STATE_NORMAL;
        [_gameScene.skillLayer addChild:[stone stoneSprite] z:1 tag:skill_stone_tag];
        [stone draw];
    }
}

-(void)createArrow:(CGPoint)location{
//<<<<<<< HEAD
//    Arrow* arrow = [[[Arrow alloc] initWithInfo :location :_gameScene] retain];
//    NSLog(@"arrow Create");
//    if(arrow!=nil){
//        skillState = SKILL_STATE_NORMAL;
//=======
    skillState = SKILL_STATE_NORMAL;
    
    if([arrow arrowShot:location]){
        [arrow draw];
    }
}

-(void) createEarthQuake{
    //적들 체크 ~
    skillState = SKILL_STATE_NORMAL;
    //애니메이션 효과 주기 - 일정 시간 동안
    
    //구현!
    NSInteger damage = [[[[SkillData skillData] getSkillInfo:SKILL_STATE_EARTHQUAKE] objectForKey:@"damage"] integerValue];
    NSInteger power = [[[[SkillData skillData] getSkillInfo:SKILL_STATE_EARTHQUAKE] objectForKey:@"effectPower"] integerValue];
    
    for(Enemy* current in _gameScene.enemies){
        if([current x] <= FLAG_X)
            [current beDamaged:damage forceX:-power/2.0 forceY:power/10.0];
        else
            [current beDamaged:damage forceX:power/2.0 forceY:power/10.0];            
    }

    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}

@end
