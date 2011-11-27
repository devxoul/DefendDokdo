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
#import "SimpleAudioEngine.h"

@implementation GameUILayer

@synthesize skills, slot1Count, slot2Count, slot3Count,slotState, slot1MaxCount, slot2MaxCount, slot3MaxCount;

-(void)update{
	moneyLabel.string = [[[NSString stringWithFormat:@"%d", _gameScene.money] retain] autorelease];
	
    //HP, MP Gage Bar 그리기
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
        [slot1MpLabel setColor:ccRED];
        
    }else{
        [slot1MpLabel setColor:ccBLACK];
    }
        
    if(mpStat < slot2Mp || slot2Mp == 0){
        [slot2MpLabel setColor:ccRED];    
    }
    else{
        [slot2MpLabel setColor:ccBLACK];
    }
    if(mpStat < slot3Mp || slot3Mp == 0){
        [slot3MpLabel setColor:ccRED];
    }
    else{
        [slot3MpLabel setColor:ccBLACK];
    }
}


- (id)init
{
	if( self = [super init] )
	{
		self.isTouchEnabled = YES;
        
    }
	
	CCSprite *moneySpr = [[CCSprite alloc] initWithFile:@"money_icon.png"];
	moneySpr.position = ccp( 20, 300 );
	[self addChild:moneySpr];
	
	moneyLabel = [[CCLabelTTF labelWithString:@"0" fontName:@"NanumScript" fontSize:30] retain];
	moneyLabel.color = ccc3( 0, 0, 0 );
	moneyLabel.position = ccp( 50, 301 );
	[self addChild:moneyLabel];
    
    //스킬 넣는 부분 - 수정 필요함
    skills = [[NSMutableArray alloc] init];
    if([[[[UserData userData] skillSlot] objectForKey:@"1"] boolValue]){
        [skills addObject:[[Slot alloc] initWithSkillInfo:[[[[UserData userData] userSkillSlot] objectForKey:@"1"] integerValue] :self :ccp(295,25)]];
        slot1Mp = [[[[SkillData skillData] getSkillInfo:[[[[UserData userData] userSkillSlot] objectForKey:@"1"] integerValue] :[[UserData userData] getSkillLevel:[[[[UserData userData] userSkillSlot] objectForKey:@"1"] integerValue]]] objectForKey:@"mp"] integerValue];
        slot1MpLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d", slot1Mp] dimensions:CGSizeZero alignment:UITextAlignmentRight fontName:@"NanumScript" fontSize:15];
        [slot1MpLabel setAnchorPoint:ccp(0.5, 0.5)];
        [slot1MpLabel setPosition:ccp(315,11)];
        [slot1MpLabel setColor:ccRED];
        [self addChild:slot1MpLabel];
        
    }else{
        [skills addObject:[[Slot alloc] initWithSkillInfo:SKILL_STATE_LOCK :self :ccp(295,25)]];
        slot1Mp = 0;
        slot1MpLabel = [CCLabelTTF labelWithString:@"none" dimensions:CGSizeZero alignment:UITextAlignmentRight fontName:@"NanumScript" fontSize:15];
        [slot1MpLabel setAnchorPoint:ccp(0.5, 0.5)];
        [slot1MpLabel setPosition:ccp(315,11)];
        [slot1MpLabel setColor:ccRED];
        [self addChild:slot1MpLabel];

    }
    
    slot1Shadow = [[CCSprite alloc] initWithFile:@"skill_shadow.png"];
    [slot1Shadow setPosition:ccp(294.5, 51)];
    [slot1Shadow setAnchorPoint:ccp(0.5, 1.0)];
    [slot1Shadow setOpacity:150];
    slot1Count = 0;
    [self addChild:slot1Shadow];
    
/*    
    slot1MpShadow = [[CCSprite alloc] initWithFile:@"skill_shadow.png"];
    [slot1MpShadow setPosition:ccp(295, 51)];
    [slot1MpShadow setAnchorPoint:ccp(0.5, 1.0)];
    [slot1MpShadow setOpacity:150];
    [self addChild:slot1MpShadow];
    [slot1MpShadow setVisible:NO];
*/
    //삭제할 내용 - 
    //스킬 쿨타임 정하기
    switch ([[[[UserData userData] userSkillSlot] objectForKey:@"1"] integerValue]) {
        case SKILL_STATE_STONE:
            slot1MaxCount = 100 - [[UserData userData] getSkillLevel:SKILL_STATE_STONE] * 2;
            break;
        case SKILL_STATE_ARROW:
            slot1MaxCount = 50 - [[UserData userData] getSkillLevel:SKILL_STATE_ARROW] * 2;
            break;
        case SKILL_STATE_EARTHQUAKE:
            slot1MaxCount = 150 - [[UserData userData] getSkillLevel:SKILL_STATE_EARTHQUAKE] * 3;
            break;
        case SKILL_STATE_HEALING:
            slot1MaxCount = 100 - [[UserData userData] getSkillLevel:SKILL_STATE_HEALING] * 2;
            break;
        default:
            slot1MaxCount = 0;
            break;
    }    
    
    if([[[[UserData userData] skillSlot] objectForKey:@"2"] boolValue]){
        [skills addObject:[[Slot alloc] initWithSkillInfo:[[[[UserData userData] userSkillSlot] objectForKey:@"2"] integerValue] :self :ccp(368,25)]];
        
        slot2Mp = [[[[SkillData skillData] getSkillInfo:[[[[UserData userData] userSkillSlot] objectForKey:@"2"] integerValue] :[[UserData userData] getSkillLevel:[[[[UserData userData] userSkillSlot] objectForKey:@"2"] integerValue]]] objectForKey:@"mp"] integerValue];
        
        slot2MpLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d", slot2Mp] dimensions:CGSizeZero alignment:UITextAlignmentRight fontName:@"NanumScript" fontSize:15];
        [slot2MpLabel setAnchorPoint:ccp(0.5, 0.5)];
        [slot2MpLabel setPosition:ccp(388,11)];
        [slot2MpLabel setColor:ccRED];
        [self addChild:slot2MpLabel];
        
    }else{
        [skills addObject:[[Slot alloc] initWithSkillInfo:SKILL_STATE_LOCK :self :ccp(368,25)]];
        slot2Mp = 0;

        slot2MpLabel = [CCLabelTTF labelWithString:@"none" dimensions:CGSizeZero alignment:UITextAlignmentRight fontName:@"NanumScript" fontSize:15];
        [slot2MpLabel setAnchorPoint:ccp(0.5, 0.5)];
        [slot2MpLabel setPosition:ccp(388,11)];
        [slot2MpLabel setColor:ccRED];
        [self addChild:slot2MpLabel];

    }
    slot2Shadow = [[CCSprite alloc] initWithFile:@"skill_shadow.png"];
    [slot2Shadow setPosition:ccp(367.5, 51)];
    [slot2Shadow setAnchorPoint:ccp(0.5, 1.0)];
    [slot2Shadow setOpacity:150];
    slot2Count = 0;
    [self addChild:slot2Shadow];
    /*
    slot2MpShadow = [[CCSprite alloc] initWithFile:@"skill_shadow.png"];
    [slot2MpShadow setPosition:ccp(368, 51)];
    [slot2MpShadow setAnchorPoint:ccp(0.5, 1.0)];
    [slot2MpShadow setOpacity:150];
    [self addChild:slot2MpShadow];
    [slot2MpShadow setVisible:NO];
    */
    //스킬 쿨타임 정하기
    switch ([[[[UserData userData] userSkillSlot] objectForKey:@"2"] integerValue]) {
        case SKILL_STATE_STONE:
            slot2MaxCount = 100 - [[UserData userData] getSkillLevel:SKILL_STATE_STONE] * 2;
            break;
        case SKILL_STATE_ARROW:
            slot2MaxCount = 50 - [[UserData userData] getSkillLevel:SKILL_STATE_ARROW] * 2;
            break;
        case SKILL_STATE_EARTHQUAKE:
            slot2MaxCount = 150 - [[UserData userData] getSkillLevel:SKILL_STATE_EARTHQUAKE] * 3;
            break;
        case SKILL_STATE_HEALING:
            slot2MaxCount = 100 - [[UserData userData] getSkillLevel:SKILL_STATE_HEALING] * 2;
            break;
        default:
            slot2MaxCount = 0;
            break;
    }
    
    if([[[[UserData userData] skillSlot] objectForKey:@"3"] boolValue]){
        [skills addObject:[[Slot alloc] initWithSkillInfo:[[[[UserData userData] userSkillSlot] objectForKey:@"3"] integerValue] :self :ccp(441,25)]];
        
        slot3Mp = [[[[SkillData skillData] getSkillInfo:[[[[UserData userData] userSkillSlot] objectForKey:@"3"] integerValue] :[[UserData userData] getSkillLevel:[[[[UserData userData] userSkillSlot] objectForKey:@"3"] integerValue]]] objectForKey:@"mp"] integerValue];
        
        slot3MpLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d", slot3Mp] dimensions:CGSizeZero alignment:UITextAlignmentRight fontName:@"NanumScript" fontSize:15];
        [slot3MpLabel setAnchorPoint:ccp(0.5, 0.5)];
        [slot3MpLabel setPosition:ccp(460,11)];
        [slot3MpLabel setColor:ccRED];
        [self addChild:slot3MpLabel];

    }else{
        [skills addObject:[[Slot alloc] initWithSkillInfo:SKILL_STATE_LOCK :self :ccp(441,25)]];
        slot3Mp = 0;
        
        slot3MpLabel = [CCLabelTTF labelWithString:@"none" dimensions:CGSizeZero alignment:UITextAlignmentRight fontName:@"NanumScript" fontSize:15];
        [slot3MpLabel setAnchorPoint:ccp(0.5, 0.5)];
        [slot3MpLabel setPosition:ccp(460,11)];
        [slot3MpLabel setColor:ccRED];
        [self addChild:slot3MpLabel];
    }
    slot3Shadow = [[CCSprite alloc] initWithFile:@"skill_shadow.png"];
    [slot3Shadow setPosition:ccp(441, 51)];
    [slot3Shadow setAnchorPoint:ccp(0.5, 1.0)];
    [slot3Shadow setOpacity:150];
    slot3Count = 0;
    [self addChild:slot3Shadow];
    /*
    slot3MpShadow = [[CCSprite alloc] initWithFile:@"skill_shadow.png"];
    [slot3MpShadow setPosition:ccp(441, 51)];
    [slot3MpShadow setAnchorPoint:ccp(0.5, 1.0)];
    [slot3MpShadow setOpacity:150];
    [self addChild:slot3MpShadow];
    [slot3MpShadow setVisible:NO];
    */
    //삭제할 내용 - 
    switch ([[[[UserData userData] userSkillSlot] objectForKey:@"3"] integerValue]) {
        case SKILL_STATE_STONE:
            slot3MaxCount = 100 - [[UserData userData] getSkillLevel:SKILL_STATE_STONE] * 2;
            break;
        case SKILL_STATE_ARROW:
            slot3MaxCount = 50 - [[UserData userData] getSkillLevel:SKILL_STATE_ARROW] * 2;
            break;
        case SKILL_STATE_EARTHQUAKE:
            slot3MaxCount = 150 - [[UserData userData] getSkillLevel:SKILL_STATE_EARTHQUAKE] * 3;
            break;
        case SKILL_STATE_HEALING:
            slot3MaxCount = 100 - [[UserData userData] getSkillLevel:SKILL_STATE_HEALING] * 2;
            break;
        default:
            slot3MaxCount = 0;
            break;
    }    
    
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
	menu.position = ccp( 450, 290 );
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
	[[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
	[[CCDirector sharedDirector] pushScene:[GameScene node]];	
}

- (void)onMainMenuBtnClick:(id)sender
{
	[[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
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
                            if([[UserData userData] backSound]){
                                [[SimpleAudioEngine sharedEngine] playEffect:@"cancel.wav"];
                            }
                            return;
                        }
                        [[[skills objectAtIndex:0] slotSprite] setVisible:NO];
                        slotState = 1;
                        _gameScene.skillManager.skillState = SKILL_STATE_STONE;
                        break;
                    case SKILL_STATE_ARROW:
                        if(_gameScene.player.mp < [[[[SkillData skillData] getSkillInfo:SKILL_STATE_ARROW :[[UserData userData] arrowLevel]] objectForKey:@"mp"] integerValue]){     
                            if([[UserData userData] backSound]){
                                [[SimpleAudioEngine sharedEngine] playEffect:@"cancel.wav"];
                            }
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
                            if([[UserData userData] backSound]){
                                [[SimpleAudioEngine sharedEngine] playEffect:@"cancel.wav"];
                            }
                            return;
                        }
                        [[[skills objectAtIndex:1] slotSprite] setVisible:NO];
                        slotState = 2;
                        _gameScene.skillManager.skillState = SKILL_STATE_STONE;
                        break;
                    case SKILL_STATE_ARROW:
                        if(_gameScene.player.mp < [[[[SkillData skillData] getSkillInfo:SKILL_STATE_ARROW :[[UserData userData] arrowLevel]] objectForKey:@"mp"] integerValue]){    
                            if([[UserData userData] backSound]){
                                [[SimpleAudioEngine sharedEngine] playEffect:@"cancel.wav"];
                            }
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
                            if([[UserData userData] backSound]){
                                [[SimpleAudioEngine sharedEngine] playEffect:@"cancel.wav"];
                            }
                            return;
                        }
                        [[[skills objectAtIndex:2] slotSprite] setVisible:NO];
                        slotState = 3;
                        _gameScene.skillManager.skillState = SKILL_STATE_STONE;
                        break;
                    case SKILL_STATE_ARROW:
                        if(_gameScene.player.mp < [[[[SkillData skillData] getSkillInfo:SKILL_STATE_ARROW :[[UserData userData] arrowLevel]] objectForKey:@"mp"] integerValue]){                        
                            if([[UserData userData] backSound]){
                                [[SimpleAudioEngine sharedEngine] playEffect:@"cancel.wav"];
                            }
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
            else{
                if([[UserData userData] backSound]){
                    [[SimpleAudioEngine sharedEngine] playEffect:@"cancel.wav"];
                }
            }
        }           
    }
    
}

- (void)ccTouchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    
}

@end
