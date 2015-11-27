//
//  Balance+CoreDataProperties.h
//  WhereIsMyBucks
//
//  Created by Nick Chigir on 11/27/15.
//  Copyright © 2015 Nick Chigir. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Balance.h"

NS_ASSUME_NONNULL_BEGIN

@interface Balance (CoreDataProperties)

@property (nonatomic) int32_t id;
@property (nonatomic) int32_t accountId;
@property (nullable, nonatomic, retain) NSDecimalNumber *currenctAmount;
@property (nonatomic) NSTimeInterval positionDate;

@end

NS_ASSUME_NONNULL_END
