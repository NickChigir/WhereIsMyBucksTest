//
//  CatergoryPickerDataSource.h
//  WhereIsMyBucks
//
//  Created by Nick Chigir on 1/5/16.
//  Copyright © 2016 Nick Chigir. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Cathegory.h"

@interface CategoryPickerDataSource : NSObject<UIPickerViewDataSource,UIPickerViewDelegate>
-(instancetype)initWithContext: (NSManagedObjectContext *) context;
-(Cathegory *) getCathegoryAtIndex: (NSInteger) index;

@end
