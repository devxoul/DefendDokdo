	//
	//  GameScene.m
	//  DefendDokdo
	//
	//  Created by 전 수열 on 11. 11. 1..
	//  Copyright 2011년 Joyfl. All rights reserved.
	//

#import "GameScene.h"
#import "Const.h"

#import "GameLayer.h"
#import "SkillLayer.h"
#import "GameUILayer.h"
#import "ResultLayer.h"

#import "Flag.h"
#import "Player.h"

#import "UserData.h"


@interface GameScene(Private)
- (void)initLayers;
- (void)initStage;
- (void)initManagers;
@end


@implementation GameScene

@synthesize gameLayer, gameUILayer, skillLayer;
@synthesize controlManager;
@synthesize flag, enemies, player;
@synthesize skillManager;
@synthesize nGameState;
@synthesize currentStage, sunPermillage;


NSInteger arryWaveEffect1[18] = 
{
	0,
	0.5,
	1,
	0,
	1.5,
	2,
	2.5,
	0,
	0,
	0,
	0,
	-2.5,
	-2,
	-1.5,
	0,
	-1,
	-0.5,
	0
};

NSInteger arryWaveEffect2[26] = 
{
	0,
	0.5,
	0.5,
	1,
	1,
	0,
	1,
	1,
	1.5,
	1.5,
	2,
	0,
	0,
	0,
	0,
	-2,
	-1.5,
	-1.5,
	-1,
	-1,
	0,
	-1,
	-1,
	-0.5,
	-0.5,
	0
};

NSInteger arryWaveEffect3[22] = 
{
	0,
	0.5,
	0.5,
	1,
	1,
	0,
	1.5,
	2,
	2.5,
	0,
	0,
	0,
	0,
	-2.5,
	-2,
	-1.5,
	0,
	-1,
	-1,
	-0.5,
	-0.5,
	0
};

- (id)init
{
	if( self = [super init] )
	{
		[self initManagers];
		[self initLayers];
		[self initStage];
		
		currentStage = [[UserData userData] stageLevel];
		NSLog( @"currentStage : %d", currentStage );
	}
	
	return self;
}

- (void)initLayers
{
	gameLayer = [[GameLayer alloc] initWithScene:self];
	[self addChild:gameLayer];
	
	skillLayer = [[SkillLayer alloc] initWithScene:self];
	[self addChild:skillLayer];
    
    [self addChild:skillManager];
	
	gameUILayer = [[GameUILayer alloc] initWithScene:self];
	[self addChild:gameUILayer];
	
}

- (void)initStage
{	
	backgroundSky = [[CCSprite alloc] initWithFile:@"sky.png"];
	[backgroundSky setAnchorPoint:CGPointZero];
	[backgroundSky setPosition:CGPointZero];
	[self.gameLayer addChild:backgroundSky z:Z_BACKGROUND];
	
	nGameState = GAMESTATE_START;
	nCount = 0;
	nWaveCount = 0;
	
	sun = [[CCSprite alloc] initWithFile:@"sun.png"];
	[sun setPosition:ccp(-40.0f, 100.0f)];
	[sun setAnchorPoint:ccp(0.0f, 0.0f)];
	[self.gameLayer addChild:sun z:Z_SUN];
	
	CCSprite *dokdo = [[CCSprite alloc] initWithFile:@"dokdo.png"];
	[dokdo setAnchorPoint:ccp(0.5f, 0.5f)];
	[dokdo setPosition:ccp(240, 140)];
	[self.gameLayer addChild:dokdo z:Z_DOKDO];
	
	for (NSInteger i = 0; i < 2; i++) {
		sea1[i] = [[CCSprite alloc] initWithFile:@"pado01.png"];
		sea1[i].anchorPoint = CGPointZero;
		[self.gameLayer addChild:sea1[i] z:Z_SEA];
	}
	
	sea1[0].position = ccp(0.0f, -10.0f);
	sea1[1].position = ccp(sea1[0].position.x - 479.0f, -10.0f);

	for (NSInteger i = 0; i < 2; i++) {
		sea2[i] = [[CCSprite alloc] initWithFile:@"pado02.png"];
		sea2[i].anchorPoint = CGPointZero;
		[self.gameLayer addChild:sea2[i] z:(Z_DOKDO-1)];
	}
	
	sea2[0].position = ccp(-40.0f, 5.0f);
	sea2[1].position = ccp(440.0f, 5.0f);
	
	for (NSInteger i = 0; i < 2; i++) {
		sea3[i] = [[CCSprite alloc] initWithFile:@"pado03.png"];
		sea3[i].anchorPoint = CGPointZero;
		[self.gameLayer addChild:sea3[i] z:(Z_DOKDO-2)];
	}
	
	sea3[0].position = ccp(-100.0f, 13.0f);
	sea3[1].position = ccp(380.0f, 13.0f);
	
	for (NSInteger i = 0; i < 4; i++) {
		cloud[i] = [[CCSprite alloc] initWithFile:[NSString stringWithFormat:@"cloud0%d.png", (i+1)]];
		[cloud[i] setAnchorPoint:ccp(0.0f, 0.0f)];
		[self.gameLayer addChild:cloud[i] z:Z_CLOUDE];
	}
	
	[cloud[1] setPosition:ccp(180, 270)];
	[cloud[2] setPosition:ccp(400, 150)];
	[cloud[3] setPosition:ccp(535, 120)];
	
	[cloud[0] setVisible:NO];
	
	flag = [Flag alloc];
	[flag init:self.gameLayer];
	
	player = [Player alloc];
	[player init:self.gameLayer];
	
	enemies = [[NSMutableArray alloc] init];
	
	label = [[CCLabelTTF alloc] initWithString:@"" fontName:@"NanumScript.ttf" fontSize:100];
	label.color = ccBLACK;	
	label.visible = NO;
	
	[self addChild:label z:Z_LABEL];
}

- (void)initManagers
{
	enemyManager = [[EnemyManager alloc] initWithGameScene:self];
	skillManager = [[SkillManager alloc] initWithGameScene:self];
	controlManager = [[ControlManager alloc] init];
}

- (void)draw
{
	[super draw];
	
	if (nGameState == GAMESTATE_START)
	{
		[enemyManager update];
		[gameUILayer update];
		[skillManager update];
		[player update];
		// 배경변화
		[backgroundSky setPosition:ccp(backgroundSky.position.x - 0.3, backgroundSky.position.y)];
		
		// 해이동

		//		
		//		CGFloat sunX = sun.position.x + 0.1; // 2분 42초 
		//		CGFloat sunX = sun.position.x + 0.15; // 1분 23초
		//		CGFloat sunX = sun.position.x + 0.12; // 1분 46초
		//		CGFloat sunX = sun.position.x + 0.11; // 2분 24초
		//		CGFloat sunX = sun.position.x + 0.115; // 1분 34초
		//		CGFloat sunX = sun.position.x + 0.112; // 2분 18초
		CGFloat sunX = sun.position.x + 0.113; // 1분 56초
		CGFloat sunY = ((-1.0/280.0) * (sunX*sunX)) + (((12.0/7.0)*sunX) + (520.0/7.0));
		
		[sun setPosition:ccp(sunX, sunY)];
		
		if (sunX >= 480) {
			nGameState = GAMESTATE_CLEAR;
		}
		
		// 바다 이펙트
		if (nCount % 3 == 0) {
			[self waveEffect:nWaveCount];
		}
		
		[cloud[1] setPosition:ccp(cloud[1].position.x - 0.7, cloud[1].position.y)];
		[cloud[2] setPosition:ccp(cloud[2].position.x - 0.3, cloud[2].position.y)];
		[cloud[3] setPosition:ccp(cloud[3].position.x - 0.1, cloud[3].position.y)];

		NSInteger i;
		for (i = 1; i < 4; i++) {
			if ((cloud[i].position.x + cloud[i].contentSize.width) < 0) {
				if (i == 1) 
					[cloud[i] setPosition:ccp(480.0f, cloud[i].position.y)];
				else if (i == 2) 
					[cloud[i] setPosition:ccp(520.0f, cloud[i].position.y)];
				else if (i == 3) 
					[cloud[i] setPosition:ccp(535.0f, cloud[i].position.y)];
			}
		}
		nCount++;
		
		if( flag.hp <= 0 )
			nGameState = GAMESTATE_OVER;
	}
	else if (nGameState == GAMESTATE_CLEAR)
	{
		[label setString:@"Clear!"];
		label.visible = YES;
		[label runAction:[CCEaseBackInOut actionWithAction:[CCMoveTo actionWithDuration:0.5 position:ccp( 240, 160 )]]];
		[self schedule:@selector(onLabelEnd:) interval:2.0];
		if ([UserData isGameCenterAvailable])
			[UserData sendScore:0 Of:@"level"];
		
		[[UserData userData] setStageLevel:currentStage + 1];

		nGameState = GAMESTATE_ENDING;		
		
	}
	else if (nGameState == GAMESTATE_OVER)
	{
		label.visible = YES;
		label.string = @"Game Over!";
		[label runAction:[CCEaseBackInOut actionWithAction:[CCMoveTo actionWithDuration:0.5 position:ccp( 240, 160 )]]];
		[self schedule:@selector(onLabelEnd:) interval:2.0];
		
		nGameState = GAMESTATE_ENDING;
	}
	else if( nGameState == GAMESTATE_PAUSE )
	{
		
	}
}

-(void)waveEffect:(NSInteger)_count
{
	[sea1[0] setPosition:ccp(sea1[0].position.x + 1, sea1[0].position.y + arryWaveEffect1[_count%18])];
	[sea1[1] setPosition:ccp(sea1[1].position.x + 1, sea1[1].position.y + arryWaveEffect1[_count%18])];
	
	if (sea1[0].position.x >= 480) {
		[sea1[0] setPosition:ccp(sea1[1].position.x - 479.0f, sea1[0].position.y)];
	}
	
	if (sea1[1].position.x >= 480) {
		[sea1[1] setPosition:ccp(sea1[0].position.x - 479.0f, sea1[1].position.y)];
	}
	
	[sea2[0] setPosition:ccp(sea2[0].position.x + 1, sea2[0].position.y + arryWaveEffect2[_count%26])];
	[sea2[1] setPosition:ccp(sea2[1].position.x + 1, sea2[1].position.y + arryWaveEffect2[_count%26])];
	
	if (sea2[0].position.x >= 480) {
		[sea2[0] setPosition:ccp(sea2[1].position.x - 479.0f, sea2[0].position.y)];
	}
	
	if (sea2[1].position.x >= 480) {
		[sea2[1] setPosition:ccp(sea2[0].position.x - 479.0f, sea2[1].position.y)];
	}
	
	[sea3[0] setPosition:ccp(sea3[0].position.x + 1, sea3[0].position.y + arryWaveEffect3[_count%22])];
	[sea3[1] setPosition:ccp(sea3[1].position.x + 1, sea3[1].position.y + arryWaveEffect3[_count%22])];
	
	if (sea3[0].position.x >= 480) {
		[sea3[0] setPosition:ccp(sea3[1].position.x - 479.0f, sea3[0].position.y)];
	}
	
	if (sea3[1].position.x >= 480) {
		[sea3[1] setPosition:ccp(sea3[0].position.x - 479.0f, sea3[1].position.y)];
	}	
	
	nWaveCount++;
}

- (NSInteger)sunPermillage
{
	return (NSInteger)((sun.position.x + 40.113) * 1000 / 520);
}

- (void)onLabelEnd:(id)sender
{
//	[[CCDirector sharedDirector] pushScene:[CCTransitionSlideInL transitionWithDuration:0.3 scene:[[[ResultLayer node] scene] autorelease]]];
}



@end
