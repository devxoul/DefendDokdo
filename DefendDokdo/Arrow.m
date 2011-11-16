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

@implementation Arrow

@synthesize touchPoint;
@synthesize startPoint;

@synthesize arrowArray; 
@synthesize unusedArrowArray;

@synthesize fileName;

-(void) draw
{
    
}


-(id) initWithInfo:(GameScene*)_gameScene
{
    
    if( self = [super init] )
    {
        
        NSDictionary *skillInfo = [[SkillData skillData] getSkillInfo:SKILL_STATE_ARROW];
        
        fileName = @"arrow.png";
        gameScene = _gameScene;

        number = [[skillInfo objectForKey:@"number"] integerValue];
        damage = [[skillInfo objectForKey:@"damage"] integerValue];
        count=number;
        
        unusedArrowArray = [[NSMutableArray alloc] init];
        arrowArray = [[NSMutableArray alloc] init];
        for(int i=0; i<30 ; i++){
            [unusedArrowArray addObject:[[ArrowObject alloc] init:fileName :damage :gameScene]];
        }
    }
    
    return self;

}

-(BOOL) arrowShot:(CGPoint)_touchPoint{
    if(_touchPoint.y <=40 || _touchPoint.x == 240)
        return NO;
    CGFloat delay=0.0f;
    @synchronized(self){
        for(int i=0; i<number; i++){
            if([unusedArrowArray count]==0){
                [unusedArrowArray addObject:[[ArrowObject alloc] init:fileName :damage :gameScene]];        
            }
            ArrowObject* current = [unusedArrowArray lastObject];
            [current setReady:_touchPoint];
            [unusedArrowArray removeLastObject];
            [current drawAtDelay:delay];
            delay+=0.4f;
            
        }
    }
    return YES;
}

@end
