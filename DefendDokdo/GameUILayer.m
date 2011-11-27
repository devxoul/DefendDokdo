//
//  GameUILayer.m
//  DefendDokdo
//
//  Created by 전 수열 on 11. 11. 1..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import "GameUILayer.h"
#import "Slot.h"
#import "Flag.h"
#import "GameScene.h"
#import "Player.h"
#import "UserData.h"
#import "SkillData.h"
//#import "MainLayer.h"
#import "ResultLayer.h"

@implementation GameUILayer

@synthesize skills, slot1Count, slot2Count, slot3Count,slotState;

-(void)update{
    //HP, MP Gage Bar 그리기
    //MP에 관해서는 증가량 설정~
    //    [mpBar setTextureRect:CGRectMake(0,0, 174 ,12)];
    //    [hpBar setTextureRect:CGRectMake(0,0, 194 ,12)];
    NSInteger mpStat = _gameScene.player.mp;
    
    
    [hp setString:[NSString stringWithFormat:@"%d/%d",(NSInteger)_gameScene.flag.hp, (NSInteger)_gameScene.flag.maxHp]];
    CGFloat hpCount = 194.0/ _gameScene.flag.maxHp;
    [hpBar setTextureRect:CGRectMake(0, 0, hpCount * (CGFloat)_gameScene.flag.hp, 12)];
    
    [mp setString:[NSString stringWithFormat:@"%d/%d",(NSInteger)_gameScene.player.mp, (NSInteger)_gameScene.player.maxMp]];
    CGFloat mpCount = 174.0/(CGFloat)_gameScene.player.maxMp;
    [mpBar setTextureRect:CGRectMake(0, 0, mpCount * (CGFloat)_gameScene.player.mp, 12)];
    
    CGFloat slotCount = 53.0/(CGFloat)slot1MaxCount;
    [slot1Shadow setTextureRect:CGRectMake(0, 0, 71, slotCount * slot1Count)];
    
    slotCount =  53.0/(CGFloat)slot2MaxCount;
    [slot2Shadow setTextureRect:CGRectMake(0, 0, 71, slotCount * slot2Count)];
    
    slotCount =  53.0/(CGFloat)slot3MaxCount;
    [slot3Shadow setTextureRect:CGRectMake(0, 0, 71, slotCount * slot3Count)];
    
    if(slot1Count > 0){
        slot1Count--;
    }
    if(slot2Count > 0){
        slot2Count--;
    }
    if(slot3Count > 0){
        slot3Count--;
    }
    
    if(mpStat < slot1Mp || slot1Mp == 0){
        [slot1MpShadow setVisible:YES];
    }else{
        [slot1MpShadow setVisible:NO];
    }
        
    if(mpStat < slot2Mp || slot2Mp == 0){
        [slot2MpShadow setVisible:YES];
    }
    else{
        [slot2MpShadow setVisible:NO];

    }
    if(mpStat < slot3Mp || slot3Mp == 0){
        [slot3MpShadow setVisible:YES];
    }
    else{
        [slot3MpShadow setVisible:NO];
    }
}


- (id)init
{
	if( self = [super init] )
	{
		self.isTouchEnabled = YES;
        
    }
    
    //스킬 넣는 부분 - 수정 필요함
    skills = [[NSMutableArray alloc] init];
    if([[[[UserData userData] skillSlot] objectForKey:@"1"] boolValue]){
        [skills addObject:[[Slot alloc] initWithSkillInfo:[[[[UserData userData] userSkillSlot] objectForKey:@"1"] integerValue] :self :ccp(295,25)]];
        slot1Mp = [[[[SkillData skillData] getSkillInfo:[[[[UserData userData] userSkillSlot] objectForKey:@"1"] integerValue] :[[UserData userData] getSkillLevel:[[[[UserData userData] userSkillSlot] objectForKey:@"1"] integerValue]]] objectForKey:@"mp"] integerValue];
    }else{
        [skills addObject:[[Slot alloc] initWithSkillInfo:SKILL_STATE_LOCK :self :ccp(295,25)]];
        slot1Mp = 0;
    }
    
    slot1Shadow = [[CCSprite alloc] initWithFile:@"skill_shadow.png"];
    [slot1Shadow setPosition:ccp(295, 51)];
    [slot1Shadow setAnchorPoint:ccp(0.5, 1.0)];
    [slot1Shadow setOpacity:150];
    slot1Count = 0;
    [self addChild:slot1Shadow];

    
    slot1MpShadow = [[CCSprite alloc] initWithFile:@"skill_shadow.png"];
    [slot1MpShadow setPosition:ccp(295, 51)];
    [slot1MpShadow setAnchorPoint:ccp(0.5, 1.0)];
    [slot1MpShadow setOpacity:150];
    [self addChild:slot1MpShadow];
    [slot1MpShadow setVisible:NO];

    //삭제할 내용 - 
    slot1MaxCount = 100;
    
    
    if([[[[UserData userData] skillSlot] objectForKey:@"2"] boolValue]){
        [skills addObject:[[Slot alloc] initWithSkillInfo:[[[[UserData userData] userSkillSlot] objectForKey:@"2"] integerValue] :self :ccp(368,25)]];
        
        slot2Mp = [[[[SkillData skillData] getSkillInfo:[[[[UserData userData] userSkillSlot] objectForKey:@"2"] integerValue] :[[UserData userData] getSkillLevel:[[[[UserData userData] userSkillSlot] objectForKey:@"2"] integerValue]]] objectForKey:@"mp"] integerValue];
    }else{
        [skills addObject:[[Slot alloc] initWithSkillInfo:SKILL_STATE_LOCK :self :ccp(368,25)]];
        slot2Mp = 0;
    }
    slot2Shadow = [[CCSprite alloc] initWithFile:@"skill_shadow.png"];
    [slot2Shadow setPosition:ccp(368, 51)];
    [slot2Shadow setAnchorPoint:ccp(0.5, 1.0)];
    [slot2Shadow setOpacity:150];
    slot2Count = 0;
    [self addChild:slot2Shadow];
    
    slot2MpShadow = [[CCSprite alloc] initWithFile:@"skill_shadow.png"];
    [slot2MpShadow setPosition:ccp(368, 51)];
    [slot2MpShadow setAnchorPoint:ccp(0.5, 1.0)];
    [slot2MpShadow setOpacity:150];
    [self addChild:slot2MpShadow];
    [slot2MpShadow setVisible:NO];
    
    //삭제할 내용 - 
    slot2MaxCount = 100;
    
    if([[[[UserData userData] skillSlot] objectForKey:@"3"] boolValue]){
        [skills addObject:[[Slot alloc] initWithSkillInfo:[[[[UserData userData] userSkillSlot] objectForKey:@"3"] integerValue] :self :ccp(441,25)]];
        
        slot3Mp = [[[[SkillData skillData] getSkillInfo:[[[[UserData userData] userSkillSlot] objectForKey:@"3"] integerValue] :[[UserData userData] getSkillLevel:[[[[UserData userData] userSkillSlot] objectForKey:@"3"] integerValue]]] objectForKey:@"mp"] integerValue];
    }else{
        [skills addObject:[[Slot alloc] initWithSkillInfo:SKILL_STATE_LOCK :self :ccp(441,25)]];
        slot3Mp = 0;
    }
    slot3Shadow = [[CCSprite alloc] initWithFile:@"skill_shadow.png"];
    [slot3Shadow setPosition:ccp(441, 51)];
    [slot3Shadow setAnchorPoint:ccp(0.5, 1.0)];
    [slot3Shadow setOpacity:150];
    slot3Count = 0;
    [self addChild:slot3Shadow];
    
    slot3MpShadow = [[CCSprite alloc] initWithFile:@"skill_shadow.png"];
    [slot3MpShadow setPosition:ccp(441, 51)];
    [slot3MpShadow setAnchorPoint:ccp(0.5, 1.0)];
    [slot3MpShadow setOpacity:150];
    [self addChild:slot3MpShadow];
    [slot3MpShadow setVisible:NO];
    
    //삭제할 내용 - 
    slot3MaxCount = 100;
    
    hplabel = [[CCSprite alloc] initWithFile:@"hplabel.png"];
    [hplabel setPosition:ccp(GAMEUILAYER_DEFAULT_X + 0.f, GAMEUILAYER_DEFAULT_Y + 27.f)];
    hplabel.anchorPoint = ccp(0.0f, 0.5f);
    [self addChild:hplabel];
    
    mplabel = [[CCSprite alloc] initWithFile:@"mplabel.png"];
    [mplabel setPosition:ccp(GAMEUILAYER_DEFAULT_X + 25.f, GAMEUILAYER_DEFAULT_Y + 9.f)];
    mplabel.anchorPoint = ccp(0.0f, 0.5f);
    [self addChild:mplabel];
    
    
    hpBarBg = [[CCSprite alloc] initWithFile:@"hpgaugebg.png"];
    [hpBarBg setPosition:ccp(GAMEUILAYER_DEFAULT_X + 45.f, GAMEUILAYER_DEFAULT_Y + 27.f)];
    hpBarBg.anchorPoint = ccp(0.0f, 0.5f);
    [self addChild:hpBarBg];
    
    //총길이 194
    hpBar = [CCSprite spriteWithTexture:[[CCTextureCache sharedTextureCache] addImage:@"hpgauge.png"] rect:CGRectMake(0,0,0,12)];
    [hpBar setPosition:ccp(GAMEUILAYER_DEFAULT_X + 48.f, GAMEUILAYER_DEFAULT_Y + 27.f)];
    hpBar.anchorPoint = ccp(0.0f, 0.5f);
    [self addChild:hpBar];
    
    //총길이 174
    mpBarBg = [[CCSprite alloc] initWithFile:@"mpgaugebg.png"];
    [mpBarBg setPosition:ccp(GAMEUILAYER_DEFAULT_X + 65.f, GAMEUILAYER_DEFAULT_Y + 10.5f)];
    mpBarBg.anchorPoint = ccp(0.0f, 0.5f);
    [self addChild:mpBarBg];
    
    mpBar = [CCSprite spriteWithTexture:[[CCTextureCache sharedTextureCache] addImage:@"mpgauge.png"] rect:CGRectMake(0,0,0,12)];
    [mpBar setPosition:ccp(GAMEUILAYER_DEFAULT_X + 68.f, GAMEUILAYER_DEFAULT_Y + 10.5f)];
    mpBar.anchorPoint = ccp(0.0f, 0.5f);
    [self addChild:mpBar];    
    
    hp = [CCLabelTTF labelWithString:@"0/0" dimensions:CGSizeMake(192, 13) alignment:UITextAlignmentRight fontName:@"NanumScript" fontSize:13];
    [hp setAnchorPoint:ccp(0.5, 0.5)];
    [hp setPosition:ccp(GAMEUILAYER_DEFAULT_X + 145.f, GAMEUILAYER_DEFAULT_Y + 27.5f)];
    [hp setColor:ccBLACK];
    [self addChild:hp];
    
    mp = [CCLabelTTF labelWithString:@"0/0" dimensions:CGSizeMake(172, 13) alignment:UITextAlignmentRight fontName:@"NanumScript" fontSize:13];
    [mp setAnchorPoint:ccp(0.5, 0.5)];
    [mp setPosition:ccp(GAMEUILAYER_DEFAULT_X + 155.f, GAMEUILAYER_DEFAULT_Y + 10.5f)];
    [mp setColor:ccBLACK];
    [self addChild:mp];
    
    pauseBtn = [[CCMenuItemImage itemFromNormalImage:@"pause_stop_off_btn.png" selectedImage:@"pause_stop_on_btn.png" target:self selector:@selector(onPauseBtnTouch:)] retain];
	CCMenu *menu = [[CCMenu menuWithItems:pauseBtn, nil] retain];
	menu.position = ccp( 450, 300 );
	[self addChild:menu];
	
	pauseBg = [[CCSprite alloc] initWithFile:@"black.png"];
	pauseBg.anchorPoint = ccp( 0, 0 );
	[self addChild:pauseBg];
	pauseBg.visible = NO;
	
	CCMenuItemFont *resume = [CCMenuItemFont itemFromString:@"Resume" target:self selector:@selector(onResumeBtnClick:)];
	[resume setFontName:@"NanumScript.ttf"];
	CCMenuItemFont *mainmenu = [CCMenuItemFont itemFromString:@"Main Menu" target:self selector:@selector(onMainMenuBtnClick:)];
	[mainmenu setFontName:@"NanumScript.ttf"];
	CCMenuItemFont *tryagain = [CCMenuItemFont itemFromString:@"Try Again" target:self selector:@selector(onTryAgainBtnClick:)];
	[tryagain setFontName:@"NanumScript.ttf"];
	
	pauseMenu = [CCMenu menuWithItems:resume, tryagain, mainmenu, nil];
	[self addChild:pauseMenu];
	pauseMenu.position = ccp( 240, 150 );
	pauseMenu.visible = NO;
	[pauseMenu alignItemsVertically];
    
    slotState = 0;
	
	return self;
}
- (id)initWithScene:(GameScene* )gameScene{
    _gameScene = gameScene;
    
    return [self init];
}

- (void)onPauseBtnTouch:(id)sender
{
	_gameScene.nGameState = GAMESTATE_PAUSE;
	pauseBg.visible = YES;
	pauseMenu.visible = YES;
}

- (void)onResumeBtnClick:(id)sender
{
	pauseBg.visible = NO;
	pauseMenu.visible = NO;
	_gameScene.nGameState = GAMESTATE_START;
}

-(void)onTryAgainBtnClick:(id)sender
{
	[[CCDirector sharedDirector] pushScene:[GameScene node]];	
}

- (void)onMainMenuBtnClick:(id)sender
{
	[[CCDirector sharedDirector] pushScene:[ResultLayer	scene]];
}

- (void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	if( _gameScene.nGameState == GAMESTATE_PAUSE )
		return;
	
    for (UITouch *touch in touches) {
        if (touch) {
            CGPoint location = [[CCDirector sharedDirector] convertToGL:[touch locationInView:[touch view]]];
            
            
            for(Slot* slot in skills){
                [[slot slotSprite] setVisible:YES];
            }
            
            if(CGRectContainsPoint([[skills objectAtIndex:0] slotSprite].boundingBox, location) && slot1Count == 0){
                switch( [[skills objectAtIndex:0] skillType]){
                    case SKILL_STATE_STONE:
                        if(_gameScene.player.mp < [[[[SkillData skillData] getSkillInfo:SKILL_STATE_STONE :[[UserData userData] stoneLevel]] objectForKey:@"mp"] integerValue]){
                            return;
                        }
                        [[[skills objectAtIndex:0] slotSprite] setVisible:NO];
                        slotState = 1;
                        _gameScene.skillManager.skillState = SKILL_STATE_STONE;
                        break;
                    case SKILL_STATE_ARROW:
                        if(_gameScene.player.mp < [[[[SkillData skillData] getSkillInfo:SKILL_STATE_ARROW :[[UserData userData] arrowLevel]] objectForKey:@"mp"] integerValue]){
                            return;
                        }
                        [[[skills objectAtIndex:0] slotSprite] setVisible:NO];
                        slotState = 1;
                        _gameScene.skillManager.skillState = SKILL_STATE_ARROW;
                        break;
                    case SKILL_STATE_HEALING:
                        slotState = 1;
                        _gameScene.skillManager.skillState = SKILL_STATE_HEALING;
                        break;
                    case SKILL_STATE_EARTHQUAKE:
                        slotState = 1;
                        _gameScene.skillManager.skillState = SKILL_STATE_EARTHQUAKE;
                        break;
                    case SKILL_STATE_LOCK:
                        break;
                        
                }
            }
            else if(CGRectContainsPoint([[skills objectAtIndex:1] slotSprite].boundingBox, location) && slot2Count == 0){
                switch( [[skills objectAtIndex:1] skillType]){
                    case SKILL_STATE_STONE:
                        if(_gameScene.player.mp < [[[[SkillData skillData] getSkillInfo:SKILL_STATE_STONE :[[UserData userData] stoneLevel]] objectForKey:@"mp"] integerValue]){
                            return;
                        }
                        [[[skills objectAtIndex:1] slotSprite] setVisible:NO];
                        slotState = 2;
                        _gameScene.skillManager.skillState = SKILL_STATE_STONE;
                        break;
                    case SKILL_STATE_ARROW:
                        if(_gameScene.player.mp < [[[[SkillData skillData] getSkillInfo:SKILL_STATE_ARROW :[[UserData userData] arrowLevel]] objectForKey:@"mp"] integerValue]){
                            return;
                        }
                        [[[skills objectAtIndex:1] slotSprite] setVisible:NO];
                        slotState = 2;
                        _gameScene.skillManager.skillState = SKILL_STATE_ARROW;
                        break;
                    case SKILL_STATE_HEALING:
                        slotState = 2;
                        _gameScene.skillManager.skillState = SKILL_STATE_HEALING;
                        break;
                    case SKILL_STATE_EARTHQUAKE:
                        slotState = 2;
                        _gameScene.skillManager.skillState = SKILL_STATE_EARTHQUAKE;
                        break;
                    case SKILL_STATE_LOCK:
                        break;
                        
                }
            }
            else if(CGRectContainsPoint([[skills objectAtIndex:2] slotSprite].boundingBox, location) && slot3Count == 0){
                switch( [[skills objectAtIndex:2] skillType]){
                    case SKILL_STATE_STONE:
                        if(_gameScene.player.mp < [[[[SkillData skillData] getSkillInfo:SKILL_STATE_STONE :[[UserData userData] stoneLevel]] objectForKey:@"mp"] integerValue]){
                            return;
                        }
                        [[[skills objectAtIndex:2] slotSprite] setVisible:NO];
                        slotState = 3;
                        _gameScene.skillManager.skillState = SKILL_STATE_STONE;
                        break;
                    case SKILL_STATE_ARROW:
                        if(_gameScene.player.mp < [[[[SkillData skillData] getSkillInfo:SKILL_STATE_ARROW :[[UserData userData] arrowLevel]] objectForKey:@"mp"] integerValue]){
                            return;
                        }
                        [[[skills objectAtIndex:2] slotSprite] setVisible:NO];
                        slotState = 3;
                        _gameScene.skillManager.skillState = SKILL_STATE_ARROW;
                        break;
                    case SKILL_STATE_HEALING:
                        slotState = 3;
                        _gameScene.skillManager.skillState = SKILL_STATE_HEALING;
                        break;
                    case SKILL_STATE_EARTHQUAKE:
                        slotState = 3;
                        _gameScene.skillManager.skillState = SKILL_STATE_EARTHQUAKE;
                        break;
                    case SKILL_STATE_LOCK:
                        break;
                        
                }
            }
        }           
    }
    
}

- (void)ccTouchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    
}

@end
