//
//  SkillData.m
//  DefendDokdo
//
//  Created by 상훈 한 on 11. 11. 14..
//  Copyright (c) 2011년 Joyfl. All rights reserved.
//

#import "SkillData.h"
#import "Const.h"

@implementation SkillData

+ (SkillData *)skillData
{
    static SkillData *ret;
    
    if (!ret)
    {
        ret = [[SkillData alloc] init];
        
    }
    
    return ret;
}

- (id)init
{
    if (self = [super init])
    {
        skillInfo = [[[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"SkillInfoList" ofType:@"plist"]] objectForKey:@"SkillInfoList"] retain];
        upgradeInfo = [[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"UpgradeInfoList" ofType:@"plist"]] retain];
        
        return self;
    }
    
    return nil;
}

-(NSInteger)getUpgradeInfo:(NSInteger)skillType :(NSInteger)skillLevel{
    switch (skillType) {
        case UPGRADE_TYPE_FLAG:
            return [[[[upgradeInfo objectForKey:@"flaghp"] objectForKey:[NSString stringWithFormat:@"%d", skillLevel]] objectForKey:@"hp"] integerValue];
            break;
        case UPGRADE_TYPE_ATTACK:
            return [[[[upgradeInfo objectForKey:@"userattack"] objectForKey:[NSString stringWithFormat:@"%d", skillLevel]] objectForKey:@"damage"] integerValue];
            break;
        case UPGRADE_TYPE_MAXMP:
            return [[[[upgradeInfo objectForKey:@"maxmp"] objectForKey:[NSString stringWithFormat:@"%d", skillLevel]] objectForKey:@"mp"] integerValue];
            break;
        case UPGRADE_TYPE_REGENMP:
            return [[[[upgradeInfo objectForKey:@"regenmp"] objectForKey:[NSString stringWithFormat:@"%d", skillLevel]] objectForKey:@"regen"] integerValue];
            break;
    }
    
    
    return 0;
    
}

-(NSDictionary *)getSkillInfo:(NSInteger)skillType :(NSInteger)skillLevel{
    
    
    switch (skillType) {
        case SKILL_STATE_STONE:            
            return [[skillInfo objectForKey:@"StoneInfoList"] objectForKey:[NSString stringWithFormat:@"%d", skillLevel]];
            break;
        case SKILL_STATE_ARROW:            
            return [[skillInfo objectForKey:@"ArrowInfoList"] objectForKey:[NSString stringWithFormat:@"%d", skillLevel]];
            break;
        case SKILL_STATE_HEALING:            
            return [[skillInfo objectForKey:@"HealInfoList"] objectForKey:[NSString stringWithFormat:@"%d", skillLevel]];
            break;
        case SKILL_STATE_EARTHQUAKE:            
            return [[skillInfo objectForKey:@"EarthInfoList"] objectForKey:[NSString stringWithFormat:@"%d", skillLevel]];
            break;
        case UPGRADE_TYPE_FLAG:
            return [[upgradeInfo objectForKey:@"flaghp"] objectForKey:[NSString stringWithFormat:@"%d", skillLevel]];
            break;
        case UPGRADE_TYPE_ATTACK:
            return [[upgradeInfo objectForKey:@"userattack"] objectForKey:[NSString stringWithFormat:@"%d", skillLevel]];
            break;
        case UPGRADE_TYPE_MAXMP:
            return [[upgradeInfo objectForKey:@"maxmp"] objectForKey:[NSString stringWithFormat:@"%d", skillLevel]];
            break;
        case UPGRADE_TYPE_REGENMP:
            return [[upgradeInfo objectForKey:@"regenmp"] objectForKey:[NSString stringWithFormat:@"%d", skillLevel]];
            break;
    }
    
    return nil;
}

-(NSInteger)getSkillPrice:(NSInteger)skillType :(NSInteger)skillLevel{
    
    
    switch (skillType) {
        case SKILL_STATE_STONE:            
            return [[[[skillInfo objectForKey:@"StoneInfoList"] objectForKey:[NSString stringWithFormat:@"%d", skillLevel]] objectForKey:@"price"] integerValue];
            break;
        case SKILL_STATE_ARROW:            
            return [[[[skillInfo objectForKey:@"ArrowInfoList"] objectForKey:[NSString stringWithFormat:@"%d", skillLevel]] objectForKey:@"price"] integerValue];
            break;
        case SKILL_STATE_HEALING:            
            return [[[[skillInfo objectForKey:@"HealInfoList"] objectForKey:[NSString stringWithFormat:@"%d", skillLevel]] objectForKey:@"price"] integerValue];
            break;
        case SKILL_STATE_EARTHQUAKE:            
            return [[[[skillInfo objectForKey:@"EarthInfoList"] objectForKey:[NSString stringWithFormat:@"%d", skillLevel]] objectForKey:@"price"] integerValue];
            break;  
        case UPGRADE_TYPE_FLAG:
            return [[[[upgradeInfo objectForKey:@"flaghp"] objectForKey:[NSString stringWithFormat:@"%d", skillLevel]] objectForKey:@"price"] integerValue];
            break;
        case UPGRADE_TYPE_ATTACK:
            return [[[[upgradeInfo objectForKey:@"userattack"] objectForKey:[NSString stringWithFormat:@"%d", skillLevel]] objectForKey:@"price"] integerValue];
            break;
        case UPGRADE_TYPE_MAXMP:
            return [[[[upgradeInfo objectForKey:@"maxmp"] objectForKey:[NSString stringWithFormat:@"%d", skillLevel]] objectForKey:@"price"] integerValue];
            break;
        case UPGRADE_TYPE_REGENMP:
            return [[[[upgradeInfo objectForKey:@"regenmp"] objectForKey:[NSString stringWithFormat:@"%d", skillLevel]] objectForKey:@"price"] integerValue];
            break;
            
    }
    
    return 0;
}


@end
