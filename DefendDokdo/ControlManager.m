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

#define ACC_CONSTANT 2000
#define MIN_INTERVAL 0.005
#define MAX_ACC 10

@interface pointObject:NSObject{
	CGPoint p; // 최근
	CGPoint acc; // 가속도
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
		
		pointObject *obj = [originalPositionArray objectAtIndex:i];
		CGPoint lastPoint = [obj p];
		
		NSTimeInterval interval = ABS( [[[originalPositionArray objectAtIndex:i] time] timeIntervalSinceNow] );
		
#ifdef DEBUGGING
		NSLog( @"interval : %f", interval );
#endif
		
		if( interval < MIN_INTERVAL ) interval = MIN_INTERVAL;
		
		CGPoint acc = [obj acc];
		CGFloat accX = acc.x + ( targetPoint.x - lastPoint.x ) / interval / ACC_CONSTANT;
		CGFloat accY = acc.y + ( targetPoint.y - lastPoint.y ) / interval / ACC_CONSTANT;
		[obj setAcc:CGPointMake(accX, accY)];
		
		[obj setP:targetPoint];
		[obj setTime:[NSDate date]];
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
		
//		if( acc.x > MAX_ACC ) acc.x = MAX_ACC;
//		else if( acc.x < -MAX_ACC ) acc.x = -MAX_ACC;
//		
//		if( acc.y > MAX_ACC ) acc.y = MAX_ACC;
//		else if( acc.y < -MAX_ACC ) acc.y = -MAX_ACC;
		
		[object applyForce:acc.x :acc.y];
		
#ifdef DEBUGGING
		NSLog(@"force : (%f, %f)", acc.x, acc.y);
#endif
		
		[touchArray removeObjectAtIndex:i];
		[managedObjectsArray removeObjectAtIndex:i];
		[originalPositionArray removeObjectAtIndex:i];
		return object;
	}
	return nil;
}

@end