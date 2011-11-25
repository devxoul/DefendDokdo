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
        
        //배경
        CCSprite *background = [CCSprite spriteWithFile:@"tutorial_bg.png"];
        [background setAnchorPoint:CGPointZero];
        [background setPosition:CGPointMake(0, 0)];
        [self addChild:background];
        
        //전체메뉴        
        intromenu[0] = [CCMenuItemImage itemFromNormalImage:@"Korean_btn.png" selectedImage:@"Korean_btn.png" target:self selector:@selector(korean:)];
        
        intromenu[1] = [CCMenuItemImage itemFromNormalImage:@"English_btn.png" selectedImage:@"English_btn.png" target:self selector:@selector(english:)];

        
        intromenu[2] = [CCMenuItemImage itemFromNormalImage:@"japanese_btn.png" selectedImage:@"japanese_btn.png" target:self selector:@selector(japanese:)];

        intromenu[3] = [CCMenuItemImage itemFromNormalImage:@"Chinese_btn.png" selectedImage:@"Chinese_btn.png" target:self selector:@selector(chinese:)];

        
        [intromenu[0] setPosition:ccp(263, 285)];
        [intromenu[1] setPosition:ccp(324, 285)];
        [intromenu[2] setPosition:ccp(385, 285)];
        [intromenu[3] setPosition:ccp(446, 285)];
        
        intro_menu = [CCMenu menuWithItems:intromenu[0], intromenu[1], intromenu[2], intromenu[3], nil];
        
        intro_menu.anchorPoint = CGPointZero;
        [intro_menu setPosition:ccp(0, 0)];
		
        [self addChild: intro_menu z:1];
        
        
        //text
        self.isTouchEnabled  = YES;
        
        description = [[UITextView alloc] initWithFrame:CGRectMake(247,64,219,235)];
        description.backgroundColor = [UIColor clearColor];
        introInfo = [[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"intro_description" ofType:@"plist"]] retain];
        description.text = [introInfo objectForKey:@"korean"];  //enemyDescription is a string from plist in my code
        [description setEditable:NO]; 
        description.font = [UIFont fontWithName:@"Helvetica" size:14.0f];
        description.textColor = [UIColor blackColor];
        description.showsHorizontalScrollIndicator = NO;
        
        description.alwaysBounceVertical = YES;
//        description.alwaysBounceHorizontal = YES; 
//        description.transform = CGAffineTransformMakeRotation(CC_DEGREES_TO_RADIANS( 90.0f ));
        
        [[[CCDirector sharedDirector]openGLView]addSubview:description]; 
        [description release];
        
        //뒤로가기 
        menu_back = [CCMenuItemImage itemFromNormalImage:@"back_on_btn.png" selectedImage:@"back_off_btn.png" target:self selector:@selector(back)];
        menu_back.anchorPoint = CGPointZero;
        
        backMenu = [CCMenu menuWithItems:menu_back, nil];
        backMenu.anchorPoint = CGPointZero;
        [backMenu setPosition:ccp(7, 250)];
        
        [self addChild:backMenu z:2];

	}
	
	return self;
}

-(void)korean:(id)sender{
    
    description.text = [introInfo objectForKey:@"korean"]; 
    
}

-(void)english:(id)sender{
    
    description.text = [introInfo objectForKey:@"english"]; 
    
}

-(void)japanese:(id)sender{
    
    description.text = [introInfo objectForKey:@"japanese"]; 
    
}

-(void)chinese:(id)sender{
    
    description.text = [introInfo objectForKey:@"chinese"]; 
    
}

- (void)back{
    
    [[CCDirector sharedDirector] replaceScene:[CCTransitionCrossFade transitionWithDuration:0.7 scene:[MainLayer scene]]];
    [description removeFromSuperview];
    
}

@end
