//
//  IntroLayer.m
//  DefendDokdo
//
//  Created by 전 수열 on 11. 11. 1..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import "IntroLayer.h"
#import "MainLayer.h"


@implementation IntroLayer

+ (CCScene *)scene
{
	CCScene *scene = [CCScene node];
	IntroLayer *layer = [IntroLayer node];
	[scene addChild:layer];
	return scene;
}

- (id)init
{
	if( self = [super init] )
	{
        //전체메뉴        
        //다음으로 이동
        intromenu[0] = [CCMenuItemImage itemFromNormalImage:@"intro1.jpg" selectedImage:@"intro1.jpg" target:self selector:@selector(moveNext:)];
        
        //다음으로 이동
        intromenu[1] = [CCMenuItemImage itemFromNormalImage:@"intro2.jpg" selectedImage:@"intro2.jpg" target:self selector:@selector(moveNext2:)];
        intromenu[1].visible = NO;
        
        //메뉴로 이동
        intromenu[2] = [CCMenuItemImage itemFromNormalImage:@"intro3.jpg" selectedImage:@"intro3.jpg" target:self selector:@selector(moveNext3:)];
        intromenu[2].visible = NO;
        
        
        for (int i = 0; i < 3; i++) {
            intromenu[i].anchorPoint = CGPointZero;
        }
        
        [intromenu[0] setPosition:ccp(0, 0)];
        [intromenu[1] setPosition:ccp(0, 0)];
        [intromenu[2] setPosition:ccp(0, 0)];
        
        
        intro_menu = [CCMenu menuWithItems:intromenu[0], intromenu[1], intromenu[2], nil];
        
        intro_menu.anchorPoint = CGPointZero;
        [intro_menu setPosition:ccp(0, 0)];
		
        [self addChild: intro_menu z:1];

	}
	
	return self;
}

-(void)moveNext:(id)sender
{
    intromenu[1].visible = YES;
    intromenu[0].visible = NO;
    NSLog(@"1");
}

-(void)moveNext2:(id)sender
{
    intromenu[2].visible = YES;
    intromenu[1].visible = NO;
    intromenu[0].visible = NO;
    NSLog(@"2");
}

-(void)moveNext3:(id)sender
{
    NSLog(@"3");
    [[CCDirector sharedDirector] pushScene:[CCTransitionSlideInT transitionWithDuration:0.3 scene:[MainLayer scene]]]; 
}

@end
