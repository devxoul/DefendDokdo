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

@implementation GameUILayer

@synthesize skills;

-(void)update{
    //HP, MP Gage Bar 그리기
    //MP에 관해서는 증가량 설정~
//    [mpBar setTextureRect:CGRectMake(0,0, 174 ,12)];
    //    [hpBar setTextureRect:CGRectMake(0,0, 194 ,12)];

    [hp setString:[NSString stringWithFormat:@"%d/%d",(NSInteger)_gameScene.flag.hp, (NSInteger)_gameScene.flag.maxHp]];
    CGFloat hpCount = 194.0/ _gameScene.flag.maxHp;
    [hpBar setTextureRect:CGRectMake(0, 0, hpCount * (CGFloat)_gameScene.flag.hp, 12)];
    
    [mp setString:[NSString stringWithFormat:@"%d/%d",(NSInteger)_gameScene.flag.hp, (NSInteger)_gameScene.flag.maxHp]];
    CGFloat mpCount = 174.0/_gameScene.flag.maxHp;
    [mpBar setTextureRect:CGRectMake(0, 0, mpCount * (CGFloat)_gameScene.flag.hp, 12)];

}


- (id)init
{
	if( self = [super init] )
	{
		self.isTouchEnabled = YES;

    }

    
    //스킬 넣는 부분 - 수정 필요함
    skills = [[NSMutableArray alloc] init];
    [skills addObject:[[Slot alloc] initWithSkillInfo:SKILL_STATE_STONE :self :ccp(295,25)]];
    [skills addObject:[[Slot alloc] initWithSkillInfo:SKILL_STATE_ARROW :self :ccp(368,25)]];
    [skills addObject:[[Slot alloc] initWithSkillInfo:SKILL_STATE_EARTHQUAKE :self :ccp(441,25)]];

    
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

    hp = [CCLabelTTF labelWithString:@"0/0" dimensions:CGSizeMake(192, 13) alignment:UITextAlignmentRight fontName:@"ArialMT" fontSize:13];
    [hp setAnchorPoint:ccp(0.5, 0.5)];
    [hp setPosition:ccp(GAMEUILAYER_DEFAULT_X + 145.f, GAMEUILAYER_DEFAULT_Y + 27.5f)];
    [hp setColor:ccBLACK];
    [self addChild:hp];
    
    mp = [CCLabelTTF labelWithString:@"0/0" dimensions:CGSizeMake(172, 13) alignment:UITextAlignmentRight fontName:@"ArialMT" fontSize:13];
    [mp setAnchorPoint:ccp(0.5, 0.5)];
    [mp setPosition:ccp(GAMEUILAYER_DEFAULT_X + 155.f, GAMEUILAYER_DEFAULT_Y + 10.5f)];
    [mp setColor:ccBLACK];
    [self addChild:mp];
    
	return self;
}
- (id)initWithScene:(GameScene* )gameScene{
    _gameScene = gameScene;
    
    return [self init];
}


- (void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{

}

- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch *touch in touches) {
        if (touch) {
            CGPoint location = [[CCDirector sharedDirector] convertToGL:[touch locationInView:[touch view]]];
            for(Slot* slot in skills){
                [[slot slotSprite] setVisible:YES];
                if (CGRectContainsPoint([slot slotSprite].boundingBox, location)){
                    switch ([slot skillType]) {
                        case SKILL_STATE_STONE:
                            [[slot slotSprite] setVisible:NO];
                            _gameScene.skillManager.skillState = SKILL_STATE_STONE;
                            break;
                        case SKILL_STATE_ARROW:
                            [[slot slotSprite] setVisible:NO];
                            _gameScene.skillManager.skillState = SKILL_STATE_ARROW;
                            break;
                        case SKILL_STATE_HEALING:
                            [[slot slotSprite] setVisible:NO];
                            _gameScene.skillManager.skillState = SKILL_STATE_HEALING;
                            break;
                        case SKILL_STATE_EARTHQUAKE:
                            [[slot slotSprite] setVisible:NO];
                            _gameScene.skillManager.skillState = SKILL_STATE_EARTHQUAKE;
                            break;
                        case SKILL_STATE_LOCK:
                            //doNothing
                            break;
                    }
                }
            }
        }           
    }
 
}

- (void)ccTouchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
 

}

@end
