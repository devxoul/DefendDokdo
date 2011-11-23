//
//  ControlManager.m
//  DefendDokdo
//
//  Created by 전 수열 on 11. 11. 2..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import "ControlManager.h"
#import "Enemy.h"
#import "Const.h"

#warning change CONSTANT
#define ACC_CONSTANT 1000

@interface pointObject:NSObject{
	CGPoint p;
	CGPoint acc;
	NSDate *time;
}
@property CGPoint p;
@property CGPoint acc;
@property (nonatomic,copy) NSDate *time;
+ (pointObject *)pointWithCGPoint:(CGPoint)point andTime:(NSDate *)date;
@end

@implementation pointObject
@synthesize p, time, acc;
+ (pointObject *)pointWithCGPoint:(CGPoint)point andTime:(NSDate *)date
{
	pointObject *ret = nil;
	if ((ret = [[pointObject alloc] init]))
	{
		ret.p = point;
		ret.time = date;
		ret.acc = CGPointMake(0.0f, 0.0f);
	}
	return [ret autorelease];
}
@end

@implementation ControlManager

- (id)init
{
	if( self = [super init] )
	{
		touchArray = [[NSMutableArray alloc] initWithCapacity:6];
		managedObjectsArray = [[NSMutableArray alloc] initWithCapacity:6];
		originalPositionArray = [[NSMutableArray alloc] initWithCapacity:6];
	}
	
	return self;
}

-(void)dealloc
{
	[touchArray dealloc];
	touchArray = nil;
	[managedObjectsArray dealloc];
	managedObjectsArray = nil;
	[originalPositionArray dealloc];
	originalPositionArray = nil;
	
	[super dealloc];
}

- (bool)manageObject:(NSObject *)object WithTouch:(UITouch *)touch
{
	if ([touchArray indexOfObject:touch] == NSNotFound)
	{
		[touchArray addObject:touch];
		[managedObjectsArray addObject:object];
		CGPoint targetPoint = [[CCDirector sharedDirector] convertToGL:[touch locationInView: [touch view]]];
		[originalPositionArray addObject:[pointObject pointWithCGPoint:targetPoint andTime:[NSDate date]]];
		return true;
	}
	return false;
}

- (bool)moveManagedObjectOfTouch:(UITouch *)touch
{
	if ([touchArray indexOfObject:touch] != NSNotFound)
	{
		NSUInteger i = [touchArray indexOfObject:touch];
		Enemy *object = [managedObjectsArray objectAtIndex:i];
		CGPoint targetPoint = [[CCDirector sharedDirector] convertToGL:[touch locationInView: [touch view]]];
		
		// 땅 또는 바다에 들어갔을 때 맞고 드래그 그만
		/*if( targetPoint.x < DOKDO_LEFT_X || DOKDO_RIGHT_X < targetPoint.x )
		{
			if( targetPoint.y < SEA_Y )
				if( ![self stopManagingObjectOfTouch:touch] )
					return false;
		}
		else if( targetPoint.y <= [Enemy getGroundY:targetPoint.x] )
		{
			if( ![self stopManagingObjectOfTouch:touch] )
				return false;
		}*/
		
		object.x = targetPoint.x - 20;
		object.y = targetPoint.y - 20;
		
		NSTimeInterval interval = [[[originalPositionArray objectAtIndex:i] time] timeIntervalSinceNow];
		CGPoint originalPoint = [[originalPositionArray objectAtIndex:i] p];
		
		[[originalPositionArray objectAtIndex:i] setAcc:CGPointMake((targetPoint.x - originalPoint.y)/ABS(interval)/ACC_CONSTANT, (targetPoint.y - originalPoint.y)/ABS(interval)/ACC_CONSTANT)];
		
		[[originalPositionArray objectAtIndex:i] setP:targetPoint];
		[[originalPositionArray objectAtIndex:i] setTime:[NSDate date]];
		return true;
	}
	return false;
}

- (Enemy *)stopManagingObjectOfTouch:(UITouch *)touch
{
	if ([touchArray indexOfObject:touch] != NSNotFound)
	{
		NSUInteger i = [touchArray indexOfObject:touch];
		Enemy *object = [managedObjectsArray objectAtIndex:i];
		CGPoint acc = [[originalPositionArray objectAtIndex:i] acc];
		
		[object applyForce:acc.x :acc.y];
		NSLog(@"force : (%f, %f)", acc.x, acc.y);
		
		[touchArray removeObjectAtIndex:i];
		[managedObjectsArray removeObjectAtIndex:i];
		[originalPositionArray removeObjectAtIndex:i];
		return object;
	}
	return nil;
}

@end
