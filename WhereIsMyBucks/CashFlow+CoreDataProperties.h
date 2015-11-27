//
//  CashFlow+CoreDataProperties.h
//  WhereIsMyBucks
//
//  Created by Nick Chigir on 11/27/15.
//  Copyright © 2015 Nick Chigir. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "CashFlow.h"

NS_ASSUME_NONNULL_BEGIN

@interface CashFlow (CoreDataProperties)

@property (nonatomic) int32_t id;
@property (nonatomic) int32_t tranId;
@property (nonatomic) int32_t accountId;
@property (nonatomic) int32_t cathegoryId;
@property (nullable, nonatomic, retain) NSDecimalNumber *amount;
@property (nullable, nonatomic, retain) Transaction *linkToTransaction;
@property (nullable, nonatomic, retain) Cathegory *linkToCathegory;

@end

NS_ASSUME_NONNULL_END
