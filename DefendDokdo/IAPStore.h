//
//  IAPStore.h
//  DefendDokdo
//
//  Created by omniavinco on 11. 11. 24..
//  Copyright (c) 2011년 Joyfl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StoreKit/StoreKit.h"

@protocol IAPStoreDelegate <NSObject>

- (void)successedPurchaseProduct:(NSString *)product;
- (void)failedPurchaseProduct:(NSString *)product;

@end

@interface IAPStore : NSObject<SKPaymentTransactionObserver>
{
	SKPaymentQueue *queue;
	NSObject<IAPStoreDelegate> *delegate;
}

@property (retain) NSObject<IAPStoreDelegate> *delegate;
- (bool)buyProduct:(NSString *)product;

@end
