//
//  Account+CoreDataProperties.h
//  WhereIsMyBucks
//
//  Created by Nick Chigir on 11/27/15.
//  Copyright © 2015 Nick Chigir. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Account.h"

NS_ASSUME_NONNULL_BEGIN

@interface Account (CoreDataProperties)

@property (nonatomic) int32_t id;
@property (nullable, nonatomic, retain) NSString *accountName;
@property (nullable, nonatomic, retain) NSString *accountDescription;
@property (nonatomic) int16_t accountType;

@end

NS_ASSUME_NONNULL_END
