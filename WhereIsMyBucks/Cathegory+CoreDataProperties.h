//
//  Cathegory+CoreDataProperties.h
//  WhereIsMyBucks
//
//  Created by Nick Chigir on 11/27/15.
//  Copyright © 2015 Nick Chigir. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Cathegory.h"

NS_ASSUME_NONNULL_BEGIN

@interface Cathegory (CoreDataProperties)

@property (nonatomic) int32_t id;
@property (nullable, nonatomic, retain) NSString *cathegoryName;
@property (nullable, nonatomic, retain) NSString *cathegoryDescription;

@end

NS_ASSUME_NONNULL_END
