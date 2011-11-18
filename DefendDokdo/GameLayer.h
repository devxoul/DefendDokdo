//
//  GameLayer.h
//  DefendDokdo
//
//  Created by 전 수열 on 11. 11. 1..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class ControlManager;
@class GameScene;

@interface GameLayer : CCLayer {
    
	GameScene *scene;
	ControlManager *controlManager;
}

- (id)initWithScene:(GameScene *)scene_;

@end
