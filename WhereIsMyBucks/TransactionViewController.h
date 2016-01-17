//
//  TransactionViewController.h
//  WhereIsMyBucks
//
//  Created by Nick Chigir on 1/16/16.
//  Copyright © 2016 Nick Chigir. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Transaction.h"

@interface TransactionViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property (nonatomic) Transaction *transaction;
//@property (nonatomic) BOOL isNew;
@end
