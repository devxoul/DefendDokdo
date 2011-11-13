//
//  Flag.m
//  DefendDokdo
//
//  Created by 전 수열 on 11. 11. 1..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import "Flag.h"
#import "Const.h"

@implementation Flag

@synthesize level, maxHp, hp;
@synthesize flagSpr;

- (id)init:(CCScene*)scene
{
	flagSpr = [[CCSprite alloc]initWithFile:@".png"];
	[flagSpr setPosition:ccp(240, 320)];
	[flagSpr setAnchorPoint:ccp(0.5f, 0.0f)];
	
	[scene addChild:flagSpr z:Z_FLAG];
}

@end
