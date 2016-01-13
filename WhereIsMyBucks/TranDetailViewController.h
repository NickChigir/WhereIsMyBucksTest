//
//  TranDetailViewController.h
//  WhereIsMyBucks
//
//  Created by Nick Chigir on 1/5/16.
//  Copyright © 2016 Nick Chigir. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Transaction.h"
#import "CashFlow.h"
#import "HBTransactionController.h"

@interface TranDetailViewController : HBTransactionController
@property (weak, nonatomic) IBOutlet UILabel *balanceLabel;
@property (weak, nonatomic) IBOutlet UITextField *amountField;

@property (weak, nonatomic) IBOutlet UIPickerView *cathegoryPicker;

//@property (nonatomic) Transaction *tran;

@end
