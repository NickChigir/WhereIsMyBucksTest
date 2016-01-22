//
//  Cathegory.m
//  WhereIsMyBucks
//
//  Created by Nick Chigir on 11/27/15.
//  Copyright © 2015 Nick Chigir. All rights reserved.
//

#import "Cathegory.h"

@implementation Cathegory

// Insert code here to add functionality to your managed object subclass
+(NSInteger) getItemsCountForContext:(NSManagedObjectContext *) context{
   
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName: @"Cathegory"
                                              inManagedObjectContext:context];
    [request setEntity:entity];
    
    
    [request setResultType:NSDictionaryResultType];
    
    NSExpression *keyPathExpression = [NSExpression expressionForKeyPath:@"cathegoryName"];
    
    // Create an expression to represent the function you want to apply
    NSExpression *expression = [NSExpression expressionForFunction:@"count:"
                                                         arguments:@[keyPathExpression]];
    NSExpressionDescription *expressionDescription = [[NSExpressionDescription alloc] init];
    [expressionDescription setName:@"itemsCount"];
    [expressionDescription setExpression:expression];
    [expressionDescription setExpressionResultType:NSInteger32AttributeType];
    [request setPropertiesToFetch:@[expressionDescription]];
    
    
    //request.predicate = [NSPredicate predicateWithFormat:@"id == 2"];
    
    
    //request.sortDescriptors = [NSArray array];
    
    NSError *error = nil;
    NSArray *array = [context executeFetchRequest:request error:&error];
    NSLog(@"result %@", array.description);
    
    
    
    
    
    if(array != nil) {
        
        NSNumber *n = [[array objectAtIndex:0] valueForKey: @"itemsCount"];
        
        return n.intValue;
    }
    else{
        return 0;
    }
    
}


+(NSArray<NSDictionary *> *) totalsByCategoryForContext:(NSManagedObjectContext *) context{
    NSArray<NSDictionary *> *result;
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName: @"Cathegory"
                                              inManagedObjectContext:context];
    [request setEntity:entity];
    
    
    [request setResultType:NSDictionaryResultType];
    
    NSExpression *keyPathGrouping = [NSExpression expressionForKeyPath:@"cathegoryName"];
    NSExpression *keyPathSum = [NSExpression expressionForKeyPath:@"toCashFlow.amount"];
    
    // Create an expression to represent the function you want to apply
    NSExpression *expression = [NSExpression expressionForFunction:@"sum:"
                                                         arguments:@[keyPathSum]];
    
    
    NSExpressionDescription *expressionDescGroupBy = [[NSExpressionDescription alloc] init];
    [expressionDescGroupBy setName:@"categoryName"];
    [expressionDescGroupBy setExpression:keyPathGrouping];
    [expressionDescGroupBy setExpressionResultType:NSStringAttributeType];
    
    NSExpressionDescription *expressionDescription = [[NSExpressionDescription alloc] init];
    [expressionDescription setName:@"TotalAmount"];
    [expressionDescription setExpression:expression];
    [expressionDescription setExpressionResultType:NSInteger32AttributeType];
    [request setPropertiesToFetch:@[expressionDescGroupBy, expressionDescription]];
    
    
    //request.predicate = [NSPredicate predicateWithFormat:@"id == 2"];
    
    
    //request.sortDescriptors = [NSArray array];
    
    NSError *error = nil;
    result= [context executeFetchRequest:request error:&error];
    NSLog(@"result %@", result.description);
    return result;
}

+(void) createDefaultCategoriesForContext:(NSManagedObjectContext *) context{
   // NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
  
    NSArray *defaultCategories = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"default category list"];
    NSLog(@"default list: %@",defaultCategories );
    for (NSDictionary *defaultProperty in defaultCategories) {
        NSLog(@"category: %@",defaultProperty);
        Cathegory *cathegory = [NSEntityDescription insertNewObjectForEntityForName:@"Cathegory" inManagedObjectContext:context];
        cathegory.cathegoryName = [defaultProperty valueForKey:@"name"];
        cathegory.cathegoryDescription =  [defaultProperty valueForKey:@"description"];
        cathegory.imageName =[defaultProperty valueForKey:@"image"];
    }
    NSError *error = nil;
    if (![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        //abort();
    }

}

@end
