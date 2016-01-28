//
//  AppDelegate.h
//  WhereIsMyBucks
//
//  Created by Nick Chigir on 11/24/15.
//  Copyright © 2015 Nick Chigir. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate,UITabBarControllerDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;


@property (nonatomic, strong) IBOutlet UITabBarController *tabBarController;

// Convenience Methods / Accessors
@property (nonatomic, readonly) UISplitViewController *splitViewController;
@property (nonatomic, readonly) UIViewController *currentMasterViewController;
@property (nonatomic, readonly) UINavigationController *masterNavigationController;
@property (nonatomic, readonly) UINavigationController *detailNavigationController;


- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end

