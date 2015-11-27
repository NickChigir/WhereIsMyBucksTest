//
//  Transaction+CoreDataProperties.h
//  WhereIsMyBucks
//
//  Created by Nick Chigir on 11/27/15.
//  Copyright © 2015 Nick Chigir. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Transaction.h"

NS_ASSUME_NONNULL_BEGIN

@interface Transaction (CoreDataProperties)

@property (nonatomic) int32_t id;
@property (nonatomic) NSTimeInterval tranDate;
@property (nullable, nonatomic, retain) NSDecimalNumber *tranAmount;

@end

NS_ASSUME_NONNULL_END
