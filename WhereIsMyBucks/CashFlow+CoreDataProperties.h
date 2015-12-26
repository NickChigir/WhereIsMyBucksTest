//
//  CashFlow+CoreDataProperties.h
//  WhereIsMyBucks
//
//  Created by Nick Chigir on 12/9/15.
//  Copyright © 2015 Nick Chigir. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "CashFlow.h"

NS_ASSUME_NONNULL_BEGIN

@interface CashFlow (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *accountId;
@property (nullable, nonatomic, retain) NSDecimalNumber *amount;
@property (nullable, nonatomic, retain) NSNumber *cathegoryId;
@property (nullable, nonatomic, retain) NSNumber *id;
@property (nullable, nonatomic, retain) NSNumber *tranId;
@property (nullable, nonatomic, retain) Cathegory *linkToCathegory;
@property (nullable, nonatomic, retain) Transaction *linkToTransaction;

@end

NS_ASSUME_NONNULL_END
