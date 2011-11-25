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
#import "Player.h"


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
	
	healSpr = [[CCSprite spriteWithSpriteFrameName:@"healing_effect_1.png"] retain];
    [healSpr setPosition:ccp(240, FLAG_Y)];
	healSpr.anchorPoint = ccp( 0.5f, 0.0 );
	
	healBatchNode = [[CCSpriteBatchNode batchNodeWithFile:@"healing_effect.png"] retain];
	[healBatchNode addChild:healSpr];
	
	NSMutableArray *aniFrames = [[NSMutableArray alloc] init];
	for( int i = 1; i < 6; i++ )
	{
		CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"healing_effect_%d.png",i]];
		[aniFrames addObject:frame];
	}
	
	CCAnimation* animation = [CCAnimation animationWithFrames:aniFrames delay:0.08f];
	healingAnimation = [[CCAnimate alloc] initWithAnimation:animation restoreOriginalFrame:NO];
    
    [self addChild:healBatchNode z:1];    
    [healSpr setVisible:NO];
//	[flagSpr runAction:[CCRepeatForever actionWithAction:flagAnimation]];


}



- (void)doHeal{
    
    if(![self useMp:[[[[SkillData skillData] getSkillInfo:SKILL_STATE_HEALING :[UserData userData].hillLevel] objectForKey:@"mp"] integerValue]]){
        return;
    }
    [healSpr setVisible:YES];
    switch (_gameScene.gameUILayer.slotState){
        case 1:
            _gameScene.gameUILayer.slot1Count = 100;
            break;
        case 2:
            _gameScene.gameUILayer.slot2Count = 100;
            break;
        case 3:
            _gameScene.gameUILayer.slot3Count = 100;
            break;
    }
    
    [healSpr stopAllActions];
    healSlot = _gameScene.gameUILayer.slotState-1;
    [[[_gameScene.gameUILayer.skills objectAtIndex:healSlot] slotSprite] setVisible:NO];

//  [healSpr setPosition:_gameScene.flag.flagSpr.position];
    
    CCCallFunc *back = [CCCallFunc actionWithTarget:self selector:@selector(endHeal)];
    [healSpr runAction:[CCSequence actions:healingAnimation,back, nil]];  
    
    _gameScene.flag.hp+=[[[[SkillData skillData] getSkillInfo:SKILL_STATE_HEALING :[UserData userData].hillLevel] objectForKey:@"hp"] integerValue];

    if(_gameScene.flag.hp>_gameScene.flag.maxHp)
        _gameScene.flag.hp = _gameScene.flag.maxHp;
}

-(void)endHeal{
    [healSpr setVisible:NO];
    [[(Slot*)[[_gameScene.gameUILayer skills] objectAtIndex:healSlot] slotSprite] setVisible:YES];
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
            switch (_gameScene.gameUILayer.slotState){
                case 1:
                    _gameScene.gameUILayer.slot1Count = 100;
                    break;
                case 2:
                    _gameScene.gameUILayer.slot2Count = 100;
                    break;
                case 3:
                    _gameScene.gameUILayer.slot3Count = 100;
                    break;
            }
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
        
        switch (_gameScene.gameUILayer.slotState){
            case 1:
                _gameScene.gameUILayer.slot1Count = 100;
                break;
            case 2:
                _gameScene.gameUILayer.slot2Count = 100;
                break;
            case 3:
                _gameScene.gameUILayer.slot3Count = 100;
                break;
        }
        
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
    
    [[(Slot*)[[_gameScene.gameUILayer skills] objectAtIndex:(earthQuakeSlot-1)] slotSprite] setVisible:YES];
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
        earthQuakeSlot = _gameScene.gameUILayer.slotState;
        switch (earthQuakeSlot){
            case 1:
                [[[[_gameScene.gameUILayer skills] objectAtIndex:0] slotSprite] setVisible:NO];
                _gameScene.gameUILayer.slot1Count = 100;
                break;
            case 2:
                [[[[_gameScene.gameUILayer skills] objectAtIndex:1] slotSprite] setVisible:NO];
                _gameScene.gameUILayer.slot2Count = 100;
                break;
            case 3:
                [[[[_gameScene.gameUILayer skills] objectAtIndex:2] slotSprite] setVisible:NO];
                _gameScene.gameUILayer.slot3Count = 100;
                break;
        }
            for(Enemy* current in _gameScene.enemies){
                if([current x] <= FLAG_X)
                    [current beDamaged:damage forceX:-power forceY:power];
                else
                    [current beDamaged:damage forceX:power forceY:power];            
            }
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    }
}

-(BOOL) useMp:(CGFloat)mp{
    if(_gameScene.player.mp < (NSInteger)mp)
        return NO;
    else{
        _gameScene.player.mp -= (NSInteger)mp;
        return YES;
    }
}

@end
