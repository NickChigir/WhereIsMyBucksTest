//
//  CatergoryPickerDataSource.m
//  WhereIsMyBucks
//
//  Created by Nick Chigir on 1/5/16.
//  Copyright © 2016 Nick Chigir. All rights reserved.
//

#import "CategoryPickerDataSource.h"

@interface CategoryPickerDataSource()

@property (nonatomic) NSArray<Cathegory *> *fetchResult;
@property (weak,nonatomic) NSManagedObjectContext *managedObjectContext;

@end


@implementation CategoryPickerDataSource

-(instancetype)initWithContext: (NSManagedObjectContext *) context{
    self = [super init];
    self.managedObjectContext = context;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Cathegory" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:50];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"cathegoryName" ascending:YES];
    
    [fetchRequest setSortDescriptors:@[sortDescriptor]];
     NSError *error = nil;
    self.fetchResult = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (error != nil) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error while fetching cathegory %@, %@", error, [error userInfo]);
        abort();
    }
    
    
    return self;
}

-(Cathegory *) getCathegoryAtIndex: (NSInteger) index{
    return self.fetchResult[index];
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.fetchResult.count;
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component __TVOS_PROHIBITED{
    Cathegory *category =self.fetchResult[row];
    return category.cathegoryName;
}

@end
