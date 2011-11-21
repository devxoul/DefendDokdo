//
//  SkillData.h
//  DefendDokdo
//
//  Created by 상훈 한 on 11. 11. 14..
//  Copyright (c) 2011년 Joyfl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SkillData : NSObject{
    
    NSDictionary* skillInfo;
    NSDictionary* upgradeInfo;
}


+ (SkillData *)skillData;
- (NSDictionary *)getSkillInfo:(NSInteger)skillType :(NSInteger)skillLevel;
- (NSInteger)getSkillPrice:(NSInteger)skillType :(NSInteger)skillLevel;
- (NSInteger)getUpgradeInfo:(NSInteger)skillType :(NSInteger)skillLevel;
@end
