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
#define ACC_CONSTANT 2000
#define INTERVAL_LOWER_BOUND 0.07
#define INTERVAL_UPPER_BOUND 0.11

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
		object.x = targetPoint.x;// - 20;
		object.y = targetPoint.y - 20;
		
//		if( DOKDO_LEFT_X <= object.x && object.x <= DOKDO_RIGHT_X )
//		{
			if( object.y < [Enemy getGroundY:object.x] - 10 )
			{
				[self stopManagingObjectOfTouch:touch];
				return false;
			}
//		}
		
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
		NSTimeInterval interval = ABS([[[originalPositionArray objectAtIndex:i] time] timeIntervalSinceNow]);
		CGPoint acc;
		if (interval > INTERVAL_UPPER_BOUND) {
			acc = CGPointMake(0.0f, 0.0f);
		}
		if (interval > INTERVAL_LOWER_BOUND) {
			CGPoint targetPoint = [[CCDirector sharedDirector] convertToGL:[touch locationInView: [touch view]]];
			CGPoint originalPoint = [[originalPositionArray objectAtIndex:i] p];
			acc = CGPointMake((targetPoint.x - originalPoint.y)/ABS(interval)/ACC_CONSTANT, (targetPoint.y - originalPoint.y)/ABS(interval)/ACC_CONSTANT);
		}
		else
			acc = [[originalPositionArray objectAtIndex:i] acc];
		
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
