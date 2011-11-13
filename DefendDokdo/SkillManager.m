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

@implementation SkillManager

@synthesize skillState, stone;
@synthesize arrow;

enum{
     skill_stone_tag=1
};

- (id)initWithGameScene:(GameScene *)gameScene
{
	if( self == [self init] )
	{
		_gameScene = gameScene;
        skillState = SKILL_STATE_NORMAL;
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
    stone = [[Stone alloc] init:@"stone_0.png" :location :100.0];
    if(stone!=nil){
        skillState = SKILL_STATE_NORMAL;
        [_gameScene.skillLayer addChild:[stone stoneSprite] z:1 tag:skill_stone_tag];
        [stone draw];
    }
}

-(void)createArrow:(CGPoint)location{
    arrow = [[Arrow alloc] init:@"arrow.png" :location :10 :_gameScene];
    NSLog(@"arrow Create");
    if(arrow!=nil){
        skillState = SKILL_STATE_NORMAL;
        [arrow draw];
    }
}

-(void) createEarthQuake{
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}

@end
