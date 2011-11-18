//
//  SkillLayer.h
//  DefendDokdo
//
//  Created by 상훈 한 on 11. 11. 5..
//  Copyright (c) 2011년 Joyfl. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GameScene.h"


@interface SkillLayer : CCLayer {
    GameScene* _gameScene;
}

- (id)initWithScene:(GameScene* )gameScene;


@end