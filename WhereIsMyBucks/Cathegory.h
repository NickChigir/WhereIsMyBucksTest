//
//  Cathegory.h
//  WhereIsMyBucks
//
//  Created by Nick Chigir on 11/27/15.
//  Copyright © 2015 Nick Chigir. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface Cathegory : NSManagedObject

// Insert code here to declare functionality of your managed object subclass
+(NSInteger) getItemsCountForContext:(NSManagedObjectContext *) context;

    


@end

NS_ASSUME_NONNULL_END

#import "Cathegory+CoreDataProperties.h"
