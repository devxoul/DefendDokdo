//
//  SkillLayer.m
//  DefendDokdo
//
//  Created by 상훈 한 on 11. 11. 5..
//  Copyright (c) 2011년 Joyfl. All rights reserved.
//

#import "SkillLayer.h"
#import "GameUILayer.h"
#import "Slot.h"

@implementation SkillLayer


- (id)init
{
	if( self = [super init] )
	{   
        [self setContentSize:CGSizeMake(480.f, 290.f)];
        [self setAnchorPoint:ccp(0.0, 1.0)];
		self.isTouchEnabled = YES;
	}
	
	return self;
}

- (id)initWithScene:(GameScene* )gameScene{
    _gameScene = gameScene;
    
    return [self init];
}



- (void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{    
    for (UITouch *touch in touches) {
        if (touch) {
            CGPoint location = [[CCDirector sharedDirector] convertToGL:[touch locationInView:[touch view]]];
            if(!CGRectContainsPoint(CGRectMake(0.0, 0.0, 480.0, 55.0), location)){
                switch (_gameScene.skillManager.skillState) {
                    case SKILL_STATE_STONE:
                        [[(Slot*)[_gameScene.gameUILayer.skills objectAtIndex:_gameScene.gameUILayer.slotState-1] slotSprite] setVisible:YES];
                        [_gameScene.skillManager createStone:location];
                        break;
                    case SKILL_STATE_ARROW:
                        [[(Slot*)[_gameScene.gameUILayer.skills objectAtIndex:_gameScene.gameUILayer.slotState-1] slotSprite] setVisible:YES];
                        [_gameScene.skillManager createArrow:location];
                        break;
                        
                }
            }
        }           
    }
    
    
}   

- (void)ccTouchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    
}



@end
