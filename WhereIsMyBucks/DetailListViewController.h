//
//  DetailListViewController.h
//  WhereIsMyBucks
//
//  Created by Nick Chigir on 1/5/16.
//  Copyright © 2016 Nick Chigir. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CashFlow.h"    
#import "HBTransactionController.h"

@interface DetailListViewController : HBTransactionController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *editButton;
@property (nullable, nonatomic, weak) NSOrderedSet<CashFlow *> *cashFlowList;
@end
