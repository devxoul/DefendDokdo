//
//  IAPStore.m
//  DefendDokdo
//
//  Created by omniavinco on 11. 11. 24..
//  Copyright (c) 2011년 Joyfl. All rights reserved.
//

#import "IAPStore.h"
#import "StoreKit/StoreKit.h"

@implementation IAPStore

@synthesize delegate;

- (id)init
{
	if ([super init]) {
		queue = [SKPaymentQueue defaultQueue];
		[queue addTransactionObserver:self];
	}
	return self;
}

- (bool)buyProduct:(NSString *)product
{
	if ([SKPaymentQueue canMakePayments])
	{

		
		SKMutablePayment *payment = [[SKMutablePayment alloc] init];
		payment.productIdentifier = product;
		payment.quantity = 1;
		
		[queue addPayment:payment];
		
	}
	return NO;
}

- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions
{
	for (SKPaymentTransaction *transaction in transactions) {
    switch (transaction.transactionState) {
			case SKPaymentTransactionStatePurchased:
					// Successed
				[delegate successedPurchaseProduct:transaction.payment.productIdentifier];
				break;
			case SKPaymentTransactionStateFailed:
					// Failed
				[delegate failedPurchaseProduct:transaction.payment.productIdentifier];
				break;
				
			default:
				break;
		}
	}
}
@end
