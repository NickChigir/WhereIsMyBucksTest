//
//  Cathegory+CoreDataProperties.h
//  WhereIsMyBucks
//
//  Created by Nick Chigir on 1/18/16.
//  Copyright © 2016 Nick Chigir. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Cathegory.h"
#import "CashFlow.h"
NS_ASSUME_NONNULL_BEGIN

@interface Cathegory (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *imageName;
@property (nullable, nonatomic, retain) NSString *cathegoryDescription;
@property (nullable, nonatomic, retain) NSString *cathegoryName;
@property (nullable, nonatomic, retain) NSNumber *id;
@property (nullable, nonatomic, retain) NSSet<CashFlow *> *toCashFlow;

@end

@interface Cathegory (CoreDataGeneratedAccessors)

- (void)addToCashFlowObject:(CashFlow *)value;
- (void)removeToCashFlowObject:(CashFlow *)value;
- (void)addToCashFlow:(NSSet<CashFlow *> *)values;
- (void)removeToCashFlow:(NSSet<CashFlow *> *)values;

@end

NS_ASSUME_NONNULL_END
