//
//  GameUILayer.m
//  DefendDokdo
//
//  Created by 전 수열 on 11. 11. 1..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import "GameUILayer.h"
#import "Slot.h"

@implementation GameUILayer


-(void)update{
    //HP, MP Gage Bar 그리기
    //MP에 관해서는 증가량 설정~
    [mpBar setTextureRect:CGRectMake(0,0, 100+arc4random()%7 ,8)];
    [hpBar setTextureRect:CGRectMake(0,0, 100+arc4random()%7 ,8)];
    
}


- (id)init
{
	if( self == [super init] )
	{
		self.isTouchEnabled = YES;

    }

    
    //스킬 넣는 부분 - 수정 필요함
    skills = [[NSMutableArray alloc] init];
    [skills addObject:[[Slot alloc] initWithInfo:SKILL_STATE_STONE :self :ccp(380,25)]];
    [skills addObject:[[Slot alloc] initWithInfo:SKILL_STATE_ARROW :self :ccp(340,25)]];

    
    hpBarBg = [[CCSprite alloc] initWithFile:@"gaugebg.png"];
    [hpBarBg setPosition:ccp(40.f ,37.5)];
    hpBarBg.anchorPoint = ccp(0.0f, 0.5f);
    [self addChild:hpBarBg];
    
    hpBar = [CCSprite spriteWithTexture:[[CCTextureCache sharedTextureCache] addImage:@"gauge.png"] rect:CGRectMake(0,0,0,8)];
    [hpBar setPosition:ccp(40.f,37.5)];
    hpBar.anchorPoint = ccp(0.0f, 0.5f);
    
    [self addChild:hpBar];
    
    mpBarBg = [[CCSprite alloc] initWithFile:@"gaugebg.png"];
    [mpBarBg setPosition:ccp(40.f,12.5)];
    mpBarBg.anchorPoint = ccp(0.0f, 0.5f);
    [self addChild:mpBarBg];
    
    mpBar = [CCSprite spriteWithTexture:[[CCTextureCache sharedTextureCache] addImage:@"gauge.png"] rect:CGRectMake(0,0,0,8)];
    [mpBar setPosition:ccp(40.f,12.5)];
    mpBar.anchorPoint = ccp(0.0f, 0.5f);
    [self addChild:mpBar];    
    
    CCLabelTTF* hpLabel = [[CCLabelTTF alloc] initWithString:@"HP" fontName:@"Arial" fontSize:17];
    [hpLabel setPosition:ccp(10, 37.5f)];
    hpLabel.anchorPoint = ccp(0.0f, 0.5f);
    [hpLabel setColor:ccRED];
    [self addChild:hpLabel];

    CCLabelTTF* mpLabel = [[CCLabelTTF alloc] initWithString:@"MP" fontName:@"Arial" fontSize:17];
    [mpLabel setPosition:ccp(10,12.5)];
    mpLabel.anchorPoint = ccp(0.0f, 0.5f);
    [mpLabel setColor:ccBLUE];
    [self addChild:mpLabel];

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
                if (CGRectContainsPoint([slot slotSprite].boundingBox, location)){
                    NSLog(@"Slot Selected");
                    switch ([slot skillType]) {
                        case SKILL_STATE_STONE:
                            NSLog(@"Stone Skill Selected");
                            _gameScene.skillManager.skillState = SKILL_STATE_STONE;
                            break;
                        case SKILL_STATE_ARROW:
                            NSLog(@"Arrow Skill Selected");
                            _gameScene.skillManager.skillState = SKILL_STATE_ARROW;
                            break;
                        case SKILL_STATE_HEALING:
                            _gameScene.skillManager.skillState = SKILL_STATE_HEALING;
                            [_gameScene.skillManager update];
                            break;
                        case SKILL_STATE_EARTHQUAKE:
                            _gameScene.skillManager.skillState = SKILL_STATE_EARTHQUAKE;
                            [_gameScene.skillManager update];
                            break;
                        case SKILL_STATE_LOCK:
                            //doNothing
                            break;
                    }
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
