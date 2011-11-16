//
//  ControlManager.h
//  DefendDokdo
//
//  Created by 전 수열 on 11. 11. 2..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class Enemy;

@interface ControlManager : NSObject {
	NSMutableArray *touchArray;
	NSMutableArray *managedObjectsArray;
	NSMutableArray *originalPositionArray;
}

- (bool)manageObject:(NSObject *)object WithTouch:(UITouch *)touch;
- (bool)moveManagedObjectOfTouch:(UITouch *)touch;
- (Enemy *)stopManagingObjectOfTouch:(UITouch *)touch;

@end
