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
#import "GameLayer.h"
#import "GameUILayer.h"
#import "Slot.h"
#import "Flag.h"

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
        [self initHealingAnimation];
	}
	
	return self;
}

-(void)initHealingAnimation{
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"healing_effect.plist"];
	
	healSpr = [CCSprite spriteWithSpriteFrameName:@"healing_effect_1.png"];
	healSpr.anchorPoint = ccp( 0.5f, 0 );
	
	CCSpriteBatchNode* healBatchNode = [[CCSpriteBatchNode batchNodeWithFile:@"healing_effect.png"] retain];
	[healBatchNode addChild:healSpr];
	
	NSMutableArray *aniFrames = [[NSMutableArray alloc] init];
	for( NSInteger i = 1; i < 6; i++ )
	{
		CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"healing_effect_%d.png",i]];
		[aniFrames addObject:frame];
	}
	
	CCAnimation* animation = [CCAnimation animationWithFrames:aniFrames delay:0.08f];
	healingAnimation = [[CCAnimate alloc] initWithAnimation:animation restoreOriginalFrame:NO];
    
    
    [_gameScene.skillLayer addChild:healBatchNode];    
    [healSpr setPosition:_gameScene.flag.flagSpr.position];
    
    
    [healSpr setVisible:NO];
}

- (void)doHeal{
    [healSpr stopAllActions];
    [healSpr setPosition:_gameScene.flag.flagSpr.position];
    [healSpr setVisible:YES];
    CCCallFunc *back = [CCCallFunc actionWithTarget:self selector:@selector(endHeal)];
    [healSpr runAction:[CCSequence actions:healingAnimation,back, nil]];     
}

-(void)endHeal{
    for(Slot* slot in [_gameScene.gameUILayer skills]){
        [[slot slotSprite] setVisible:YES];
    }
    [healSpr setVisible:NO];
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
            [self doHeal];
            break;
    }
    
    @synchronized(self){
        
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
    }
    
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
    
    @synchronized(self){
        if(stone!=nil){
            skillState = SKILL_STATE_NORMAL;
            if([self useMp:(CGFloat)stone.mp]){
                [_gameScene.skillLayer addChild:[stone stoneSprite] z:1 tag:skill_stone_tag];
                [stoneArray addObject:stone];
            }
        }
    }
}

-(void)createArrow:(CGPoint)location{
    
    skillState = SKILL_STATE_NORMAL;
    if([self useMp:arrow.mp]){
        [arrow addArrow:location];
    }
    //마나 소비
}

-(void)shakyPlus:(id)sender{
    {
        earthQuakeCount--;
        CGFloat var = sin(arc4random());
        if(arc4random() % 2 == 0)
            [_gameScene.gameLayer setPosition:ccp(EARTHQUAKE_MAX_POWER+var,EARTHQUAKE_MAX_POWER+var)];
        else
            [_gameScene.gameLayer setPosition:ccp(EARTHQUAKE_MAX_POWER+var,EARTHQUAKE_MAX_POWER-var)];
        if(earthQuakeCount == 0)
            [self runAction:[CCSequence actions:[CCDelayTime actionWithDuration:0.01],[CCCallFunc actionWithTarget:self selector:@selector(endQuake:)],nil]];
        else
            [self runAction:[CCSequence actions:[CCDelayTime actionWithDuration:0.01],[CCCallFunc actionWithTarget:self selector:@selector(shakyMinus:)],nil]];
    }
    
}
-(void)shakyMinus:(id)sender{
    @synchronized(self){
        
        earthQuakeCount--;    
        CGFloat var = sin(arc4random());
        
        if(arc4random() % 2 == 0)
            [_gameScene.gameLayer setPosition:ccp(-EARTHQUAKE_MAX_POWER-var, -EARTHQUAKE_MAX_POWER-var)];
        else
            [_gameScene.gameLayer setPosition:ccp(-EARTHQUAKE_MAX_POWER-var, -EARTHQUAKE_MAX_POWER+var)];
        
        if(earthQuakeCount == 0)
            [self runAction:[CCSequence actions:[CCDelayTime actionWithDuration:0.01],[CCCallFunc actionWithTarget:self selector:@selector(endQuake:)],nil]];
        
        else
            [self runAction:[CCSequence actions:[CCDelayTime actionWithDuration:0.01],[CCCallFunc actionWithTarget:self selector:@selector(shakyPlus:)],nil]];
    }    
}

-(void)endQuake:(id)sender{
    for(Slot* slot in [_gameScene.gameUILayer skills]){
        [[slot slotSprite] setVisible:YES];
    }
    [_gameScene.gameLayer setPosition:ccp(0,0)];
}

-(void) createEarthQuake{
    //구현!
    if([self useMp: [[[[SkillData skillData] getSkillInfo:SKILL_STATE_EARTHQUAKE :[[UserData userData] earthquakeLevel]] objectForKey:@"mp"] integerValue]]){
        
        [self stopAllActions];
        
        NSInteger damage = [[[[SkillData skillData] getSkillInfo:SKILL_STATE_EARTHQUAKE :[[UserData userData] earthquakeLevel]] objectForKey:@"damage"] integerValue];
        NSInteger power = [[[[SkillData skillData] getSkillInfo:SKILL_STATE_EARTHQUAKE :[[UserData userData] earthquakeLevel]] objectForKey:@"effectPower"] integerValue];
        
        earthQuakeCount = power*3;
        
        
        [self runAction:[CCSequence actions:[CCDelayTime actionWithDuration:0.01],[CCCallFunc actionWithTarget:self selector:@selector(shakyPlus:)],nil]];
        
        @synchronized(self){
            
            for(Enemy* current in _gameScene.enemies){
                if([current x] <= FLAG_X)
                    [current beDamaged:damage forceX:-power forceY:power];
                else
                    [current beDamaged:damage forceX:power forceY:power];            
            }
        }    
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    }
}

-(BOOL) useMp:(CGFloat)mp{
    return YES;
}

@end
