//
//  ResultLayer.m
//  DefendDokdo
//
//  Created by 전 수열 on 11. 11. 1..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import "ResultLayer.h"


@implementation ResultLayer

+ (CCScene *)scene
{
	CCScene *scene = [CCScene node];
	ResultLayer *layer = [ResultLayer node];
	[scene addChild:layer];
	return scene;
}

- (id)init
{
	if( self = [super init] )
	{
		
	}
	
	return self;
}

@end
