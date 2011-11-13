//
//  GameLayer.m
//  DefendDokdo
//
//  Created by 전 수열 on 11. 11. 1..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import "GameLayer.h"


@implementation GameLayer

- (id)init
{
	if( self == [super init] )
	{   
        [self setContentSize:CGSizeMake(480.f, 290.f)];
        [self setAnchorPoint:ccp(0.0, 1.0)];
		self.isTouchEnabled = YES;
	}

	return self;
}

@end
