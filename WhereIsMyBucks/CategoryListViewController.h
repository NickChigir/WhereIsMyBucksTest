//
//  CategoryListViewController.h
//  WhereIsMyBucks
//
//  Created by Nick Chigir on 1/17/16.
//  Copyright © 2016 Nick Chigir. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Cathegory.h"
#import "Transaction.h"

@interface CategoryListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
//@property (weak,nonatomic) Cathegory *selectedCategory;
@property (weak,nonatomic) Transaction *transaction;
@property (nonatomic) NSInteger detailIndex;
@property (weak,nonatomic) UIButton *categoryButton;
@end
