//
//  Arrow.m
//  DefendDokdo
//
//  Created by 상훈 한 on 11. 11. 9..
//  Copyright (c) 2011년 Joyfl. All rights reserved.
//

#import "Arrow.h"
#import "GameScene.h"
#import "ArrowObject.h"
#import "SkillLayer.h"
#import "SkillData.h"
#import "UserData.h"

@implementation Arrow

@synthesize arrowArray; 
@synthesize unusedArrowArray;

@synthesize mp;


-(id) initWithInfo:(GameScene*)_gameScene
{
    
    if( self = [super init] )
    {
        
        NSDictionary *skillInfo = [[SkillData skillData] getSkillInfo:SKILL_STATE_ARROW :[[UserData userData] arrowLevel]];
        
        gameScene = _gameScene;
        
        number = [[skillInfo objectForKey:@"number"] integerValue];
        damage = [[skillInfo objectForKey:@"damage"] integerValue];
        mp = [[skillInfo objectForKey:@"mp"] integerValue];
        
        unusedArrowArray = [[NSMutableArray alloc] init];
        arrowArray = [[NSMutableArray alloc] init];
      //  for(int i=0; i<30 ; i++){
      //      [unusedArrowArray addObject:[[ArrowObject alloc] init:@"arrow.png" :damage :gameScene]];
      //  }
    }
    
    return self;
    
}

-(BOOL) addArrow:(CGPoint)_touchPoint{
    if(_touchPoint.y <=40 || _touchPoint.x == 240)
        return NO;
    NSInteger count = number*15;
    for(int i=0; i<number; i++){
        if([unusedArrowArray count]==0){
            [unusedArrowArray addObject:[[ArrowObject alloc] init:@"arrow.png" :damage :gameScene]];        
        }
        ArrowObject* current = [unusedArrowArray lastObject];
        [current setReady:_touchPoint :count];
        count-=15;
        [arrowArray addObject:current];
        [unusedArrowArray removeLastObject];            
    }
    
    return YES;
}

@end
