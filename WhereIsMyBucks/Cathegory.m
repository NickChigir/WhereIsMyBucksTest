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

@end
