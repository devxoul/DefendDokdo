//
//  SkillData.h
//  DefendDokdo
//
//  Created by 상훈 한 on 11. 11. 14..
//  Copyright (c) 2011년 Joyfl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SkillData : NSObject{
    
    NSInteger stoneLv;
    NSInteger arrowLv;
    NSInteger earthLv;
    NSInteger healLv;
    
    NSDictionary* skillInfo;
    NSDictionary* skillLvInfo;
    

}


@property (readwrite) NSInteger stoneLv;
@property (readwrite) NSInteger arrowLv;
@property (readwrite) NSInteger earthLv;
@property (readwrite) NSInteger healLv;


@property (retain, readonly) NSDictionary* skillInfo;
@property (retain, readwrite) NSDictionary* skillLvInfo;


+ (SkillData *)skillData;
- (BOOL) saveToFile;
-(NSDictionary *)getSkillInfo:(NSInteger)skillType;
-(BOOL) buySkill:(NSInteger)skillType;

@end
