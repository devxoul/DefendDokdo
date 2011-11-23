//
//  Slot.m
//  DefendDokdo
//
//  Created by 상훈 한 on 11. 11. 7..
//  Copyright (c) 2011년 Joyfl. All rights reserved.
//

#import "Slot.h"
#import "Const.h"
#import "GameUILayer.h"

@implementation Slot

@synthesize slotSprite;
@synthesize skillType;
@synthesize selectedSprite;

-(id) initWithSkillInfo:(NSInteger)_skillType :(GameUILayer*)_layer :(CGPoint)location{
    if(self==[super init]){
        skillType = _skillType;
        switch (skillType) {
            case SKILL_STATE_STONE: 
                slotSprite = [CCSprite spriteWithFile:@"skill_stone_on_btn.png"];
                selectedSprite = [CCSprite spriteWithFile:@"skill_stone_off_btn.png"];
                break;
            case SKILL_STATE_ARROW: 
                slotSprite = [CCSprite spriteWithFile:@"skill_arrow_on_btn.png"];
                selectedSprite = [CCSprite spriteWithFile:@"skill_arrow_off_btn.png"];
                break;
            case SKILL_STATE_HEALING: 
                slotSprite = [CCSprite spriteWithFile:@"skill_hp_on_btn.png"];
                selectedSprite = [CCSprite spriteWithFile:@"skill_hp_off_btn.png"];
                break;
            case SKILL_STATE_EARTHQUAKE: 
                slotSprite = [CCSprite spriteWithFile:@"skill_earthquake_on_btn.png"];
                selectedSprite = [CCSprite spriteWithFile:@"skill_earthquake_off_btn.png"];
                break;
            case SKILL_STATE_LOCK: 
                //스킬 잠김
                break;
            default:
                slotSprite = [CCSprite spriteWithFile:@"skill_empty_on_btn.png"];
                selectedSprite = [CCSprite spriteWithFile:@"skill_stone_off_btn.png"];
                break;
        }
        
        [selectedSprite setAnchorPoint:ccp(0.5f, 0.5f)];
        [selectedSprite setPosition:location];
        [_layer addChild:selectedSprite];
        [slotSprite setAnchorPoint:ccp(0.5f, 0.5f)];
        [slotSprite setPosition:location];
        [_layer addChild:slotSprite];
              
        return self;
    }
    
    return nil;
}

@end
