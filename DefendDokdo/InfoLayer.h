//
//  InfoLayer.h
//  DefendDokdo
//
//  Created by Youjin Lim on 11. 11. 7..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface InfoLayer : CCLayer {
	
    CCSprite *menuBgSprite;
    CCSprite *seaSprite;
    CCSprite *cloudSprite;
    CCSprite *dokdoSprite;
    CCSprite *sunSprite;	    
}

+ (CCScene *)scene;
-(void)moveBack:(id)sender;

@end
