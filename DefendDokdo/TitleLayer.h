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
    
    CCSprite *titleBgSprite;        // 연한 백
    
    CCSprite *titleLogo;            // 마트 러쉬 로고
    
    CCSprite *touchTheScreenSprite;     // 터치더 스크린 없어져요

}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end
