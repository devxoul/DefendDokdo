//
//  ControlManager.m
//  DefendDokdo
//
//  Created by 전 수열 on 11. 11. 2..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import "ControlManager.h"
#import "Enemy.h"

@interface pointObject:NSObject{
	CGPoint p;
	NSDate *time;
}
@property CGPoint p;
@property (nonatomic,copy) NSDate *time;
+ (pointObject *)pointWithCGPoint:(CGPoint)point andTime:(NSDate *)date;
@end

@implementation pointObject
@synthesize p, time;
+ (pointObject *)pointWithCGPoint:(CGPoint)point andTime:(NSDate *)date
{
	pointObject *ret = nil;
	if ((ret = [[pointObject alloc] init]))
	{
		ret.p = point;
		ret.time = date;
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
		object.x = targetPoint.x;
		object.y = targetPoint.y;
		
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
		CGPoint curPoint = [[CCDirector sharedDirector] convertToGL:[touch locationInView: [touch view]]];
		CGPoint originalPoint = [[originalPositionArray objectAtIndex:i] p];
		NSInteger interval = [[[originalPositionArray objectAtIndex:i] time] timeIntervalSinceNow];
		
		[object applyForce:(curPoint.x - originalPoint.x)/abs(interval) :(curPoint.y - originalPoint.y)/abs(interval)];
		
		[touchArray removeObjectAtIndex:i];
		[managedObjectsArray removeObjectAtIndex:i];
		[originalPositionArray removeObjectAtIndex:i];
		return object;
	}
	return nil;
}

@end
