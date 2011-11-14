//
//  InfoLayer.m
//  DefendDokdo
//
//  Created by Youjin Lim on 11. 11. 7..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import "InfoLayer.h"


@implementation InfoLayer

+ (CCScene *)scene
{
	CCScene *scene = [CCScene node];
	InfoLayer *layer = [InfoLayer node];
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