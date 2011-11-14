//
//  IntroLayer.h
//  DefendDokdo
//
//  Created by 전 수열 on 11. 11. 1..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface IntroLayer : CCLayer {
    
    CCMenuItemImage * intromenu[3];
    CCMenu *intro_menu;    
}

+ (CCScene *)scene;

-(void)moveNext:(id)sender;
-(void)moveNext2:(id)sender;
-(void)moveNext3:(id)sender;

@end
