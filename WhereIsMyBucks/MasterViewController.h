//
//  MasterViewController.h
//  WhereIsMyBucks
//
//  Created by Nick Chigir on 11/24/15.
//  Copyright © 2015 Nick Chigir. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>



@class DetailViewController;

@interface MasterViewController : UITableViewController <NSFetchedResultsControllerDelegate,UISplitViewControllerDelegate>

@property (strong, nonatomic) DetailViewController *detailViewController;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;


@end

