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

@synthesize stoneLv;
@synthesize arrowLv;
@synthesize earthLv;
@synthesize healLv;
@synthesize skillInfo;
@synthesize skillLvInfo;


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
        skillLvInfo = [NSDictionary dictionaryWithContentsOfFile:[(NSString *)[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"SkillData.plist"]];
        
        stoneLv = [[skillLvInfo objectForKey:@"stoneLv"] integerValue];
        arrowLv = [[skillLvInfo objectForKey:@"arrowLv"] integerValue];
        earthLv = [[skillLvInfo objectForKey:@"healLv"] integerValue];
        healLv  = [[skillLvInfo objectForKey:@"earthLv"] integerValue];
        
        skillInfo = [[[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"SkillInfoList" ofType:@"plist"]] objectForKey:@"SkillInfoList"] retain];

        
        
        return self;
    }
    
    return nil;
}

- (BOOL) saveToFile{
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    [dict setObject:[NSNumber numberWithInteger:stoneLv] forKey:@"stoneLv"];
    [dict setObject:[NSNumber numberWithInteger:arrowLv] forKey:@"arrowLv"];
    [dict setObject:[NSNumber numberWithInteger:healLv] forKey:@"healLv"];
    [dict setObject:[NSNumber numberWithInteger:earthLv] forKey:@"earthLv"];
    
    return [dict writeToFile:[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"SkillData.plist"] atomically:YES];
}


-(BOOL) buySkill:(NSInteger)skillType{

    switch (skillType) {
        case SKILL_STATE_STONE:            
            stoneLv++;
            break;
        case SKILL_STATE_ARROW:            
            arrowLv++;
            break;
        case SKILL_STATE_HEALING:            
            healLv++;
            break;
        case SKILL_STATE_EARTHQUAKE:            
            earthLv++;
            break;
        }
    
    return [self saveToFile];
    
}

-(NSDictionary *)getSkillInfo:(NSInteger)skillType{

    
    switch (skillType) {
        case SKILL_STATE_STONE:            
            return [[skillInfo objectForKey:@"StoneInfoList"] objectForKey:[NSString stringWithFormat:@"%d", stoneLv]];
            break;
        case SKILL_STATE_ARROW:            
            return [[skillInfo objectForKey:@"ArrowInfoList"] objectForKey:[NSString stringWithFormat:@"%d", arrowLv]];
            break;
        case SKILL_STATE_HEALING:            
            return [[skillInfo objectForKey:@"HealInfoList"] objectForKey:[NSString stringWithFormat:@"%d", healLv]];
            break;
        case SKILL_STATE_EARTHQUAKE:            
            return [[skillInfo objectForKey:@"EarthInfoList"] objectForKey:[NSString stringWithFormat:@"%d", earthLv]];
            break;
    }
    
    return nil;
}


@end
