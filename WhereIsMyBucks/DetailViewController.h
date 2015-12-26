//
//  DetailViewController.h
//  WhereIsMyBucks
//
//  Created by Nick Chigir on 11/24/15.
//  Copyright © 2015 Nick Chigir. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Transaction.h"
@interface DetailViewController : UIViewController

@property (strong, nonatomic) Transaction *detailItem;

@property (weak, nonatomic) IBOutlet UINavigationItem *detailNavigation;

@end

