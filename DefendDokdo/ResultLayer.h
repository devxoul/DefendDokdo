//
//  ResultLayer.h
//  DefendDokdo
//
//  Created by 전 수열 on 11. 11. 1..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface ResultLayer : CCLayer {
 
    CCLabelTTF *moneyLabel;
    CCMenuItemImage *result_start;
    CCMenuItemImage *result_upgrade;
    CCMenuItemImage *menu_back;
    
    CCMenu *backMenu;
}

+ (CCScene *)scene;

-(void)moveGame:(id)sender;
-(void)moveUpgrade:(id)sender;

- (void)back:(id)sender;

@end
