//
//  Const.h
//  DefendDokdo
//
//  Created by 전 수열 on 11. 11. 3..
//  Copyright (c) 2011년 Joyfl. All rights reserved.
//

#ifndef DefendDokdo_Const_h
#define DefendDokdo_Const_h

#define GRAVITY				0.6
#define AIR_RESISTANCE		0.01
#define WATER_RESISTANCE	0.5
#define BUOYANCY			0.2

#define SEA_Y				30
#define PLANE_Y				250
#define DOKDO_LEFT_X		110
#define DOKDO_RIGHT_X		360
#define FLAG_LEFT_X			225
#define FLAG_RIGHT_X		260
#define FLAG_X				240
#define TOP_Y				205

#define ENEMY_TYPE_NORMAL		0
#define ENEMY_TYPE_SAMURAI		1
#define ENEMY_TYPE_NINJA		2
#define ENEMY_TYPE_KAMIKAZE		3

#define ENEMY_STATE_BOAT		0
#define ENEMY_STATE_FLIGHT		1
#define ENEMY_STATE_SWIM		2
#define ENEMY_STATE_WALK		3
#define ENEMY_STATE_ATTACK		4
#define ENEMY_STATE_CATCH		5
#define ENEMY_STATE_FALL		6
#define ENEMY_STATE_HIT			7
#define ENEMY_STATE_DIE			8
#define ENEMY_STATE_EXPLOSION	9

#define Z_BACKGROUND		0
#define Z_SUN				1
#define Z_PLANE				2
#define Z_DOKDO				3
#define Z_SEA				4
#define Z_FLAG				5
#define Z_ENEMY				6
#define Z_Label				7

//성은 추가, 게임 State
#define GAMESTATE_START		0
#define GAMESTATE_CLEAR		1
#define GAMESTATE_OVER		2
#define GAMESTATE_ENDING	3

//상훈 추가, 스킬 부분

#define SKILL_STATE_NORMAL      0
#define SKILL_STATE_STONE       1
#define SKILL_STATE_ARROW       2
#define SKILL_STATE_HEALING     3
#define SKILL_STATE_EARTHQUAKE  4
#define SKILL_STATE_LOCK        5
#define UPGRADE_TYPE_FLAG       6
#define UPGRADE_TYPE_MAXMP      7
#define UPGRADE_TYPE_REGENMP    8
#define UPGRADE_TYPE_ATTACK     9

#define STONE_STATE_DOWN    0
#define STONE_STATE_ROLLING 1
#define STONE_STATE_STOP    2
#define STONE_STATE_DEAD    3

#define ARROW_STATE_MOVING  0
#define ARROW_STATE_STOP    1
#define ARROW_STATE_DEAD    2
#define ARROW_STATE_DEADING 3
#define ARROW_STATE_UNUSED  4

#define DIRECTION_STATE_LEFT    0
#define DIRECTION_STATE_RIGHT   1



#endif
