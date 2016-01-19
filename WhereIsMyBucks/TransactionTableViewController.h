//
//  TransactionTableViewController.h
//  WhereIsMyBucks
//
//  Created by Nick Chigir on 1/19/16.
//  Copyright © 2016 Nick Chigir. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Transaction.h"

@interface TransactionTableViewController : UITableViewController<UITextFieldDelegate>
@property (nonatomic) Transaction *transaction;

@end
