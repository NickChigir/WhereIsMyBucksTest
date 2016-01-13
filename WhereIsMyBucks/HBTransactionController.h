//
//  HBTransactionController.h
//  WhereIsMyBucks
//
//  Created by Nick Chigir on 1/12/16.
//  Copyright © 2016 Nick Chigir. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Transaction.h"
#import "ScrollViewController.h"
#define AMOUNT_UPDATED_NOTIFICATION @"HBAmountUpdated"
#define DETAIL_ADDED_NOTIFICATION @"HBDetailAdded"
#define DETAIL_REMOVED_NOTIFICATION @"HBDetailRemoved"

@interface HBTransactionController : UIViewController
@property (weak) Transaction *transaction;
@property (weak) ScrollViewController *scrollDelegate;

@end
