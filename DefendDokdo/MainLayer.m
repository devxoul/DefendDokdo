//
//  MainLayer.m
//  DefendDokdo
//
//  Created by 전 수열 on 11. 11. 1..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import "MainLayer.h"

#import "UserData.h"

@implementation MainLayer

+ (CCScene *)scene
{
	CCScene *scene = [CCScene node];
	MainLayer *layer = [MainLayer node];
	[scene addChild:layer];
	return scene;
}

- (id)init
{
	if( self = [super init] )
	{
		
		if ([UserData isGameCenterAvailable]) // 게임센터 접속
		{
			[UserData connectGameCenter];
		}
	}
	
	return self;
}

@end
