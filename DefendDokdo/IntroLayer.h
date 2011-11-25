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
    
    CCMenuItemImage * intromenu[4];
    CCMenu *intro_menu;   
    
    CCMenuItemImage *menu_back;
    CCMenu *backMenu;
    
    UITextView *description;
    
    NSDictionary* introInfo;
    
}

+ (CCScene *)scene;

-(void)korean:(id)sender;
-(void)english:(id)sender;
-(void)japanese:(id)sender;
-(void)chinese:(id)sender;

- (void)back;

@end
