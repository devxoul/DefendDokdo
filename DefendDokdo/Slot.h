//
//  Slot.h
//  DefendDokdo
//
//  Created by 상훈 한 on 11. 11. 7..
//  Copyright (c) 2011년 Joyfl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class GameUILayer;

@interface Slot : NSObject
{
    CCSprite* slotSprite;
    NSInteger skillType;
}


@property (nonatomic, retain) CCSprite* slotSprite;
@property (readwrite) NSInteger skillType;

-(id) initWithInfo:(NSInteger)_skillType :(GameUILayer*)_layer :(CGPoint)location;

@end
