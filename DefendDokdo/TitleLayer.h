//
//  HelloWorldLayer.h
//  DefendDokdo
//
//  Created by 전 수열 on 11. 11. 1..
//  Copyright Joyfl 2011년. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"

// HelloWorldLayer
@interface TitleLayer : CCLayer
{
    
    CCSprite *titleBgSprite;        
    
//    CCSprite *titleLogo;  
    
    CCSprite *touchTheScreenSprite;     
    
    CCSprite *twinkle1;
    CCSprite *twinkle2;
    CCSprite *twinkle3;
    CCSprite *twinkle4;
    CCSprite *twinkle5;
    
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end
