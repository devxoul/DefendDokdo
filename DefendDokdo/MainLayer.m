//
//  MainLayer.m
//  DefendDokdo
//
//  Created by 전 수열 on 11. 11. 1..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import "MainLayer.h"


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
	if( self == [super init] )
	{
		
	}
	
	return self;
}

@end
