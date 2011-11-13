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

-(id) initWithInfo:(NSInteger)_skillType :(GameUILayer*)_layer :(CGPoint)location{
    if(self==[super init]){
        skillType = _skillType;
        switch (skillType) {
            case SKILL_STATE_STONE: 
                slotSprite = [CCSprite spriteWithFile:@"stone_0.png"];
                break;
            case SKILL_STATE_ARROW: 
                slotSprite = [CCSprite spriteWithFile:@"arrow.png"];
                break;
            case SKILL_STATE_HEALING: 
                break;
            case SKILL_STATE_EARTHQUAKE: 
                break;
            case SKILL_STATE_LOCK: 
                //스킬 잠김
                break;
        }
        
        [slotSprite setAnchorPoint:ccp(0.5f, 0.5f)];
        [slotSprite setPosition:location];
        [_layer addChild:slotSprite];
        
        return self;
    }
    
    return nil;
}

@end
