//
//  KeysGenerator.m
//  WhereIsMyBucks
//
//  Created by Nick Chigir on 11/27/15.
//  Copyright © 2015 Nick Chigir. All rights reserved.
//

#import "KeysGenerator.h"
#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@implementation KeysGenerator


+(int32_t) getMaxIdFromBase: (NSString *) table {
    NSManagedObjectContext *managedObjectContext = [(AppDelegate *)[[UIApplication sharedApplication]delegate]  managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName: table
                                              inManagedObjectContext:managedObjectContext];
    [request setEntity:entity];
    
    
    [request setResultType:NSDictionaryResultType];
    
    NSExpression *keyPathExpression = [NSExpression expressionForKeyPath:@"id"];
    
    // Create an expression to represent the function you want to apply
    NSExpression *expression = [NSExpression expressionForFunction:@"max:"
                                                         arguments:@[keyPathExpression]];
    NSExpressionDescription *expressionDescription = [[NSExpressionDescription alloc] init];
    [expressionDescription setName:@"maxId"];
    [expressionDescription setExpression:expression];
    [expressionDescription setExpressionResultType:NSInteger32AttributeType];
    [request setPropertiesToFetch:@[expressionDescription]];
    
    
    //request.predicate = [NSPredicate predicateWithFormat:@"id == 2"];
    
    
    //request.sortDescriptors = [NSArray array];
    
    NSError *error = nil;
    NSArray *array = [managedObjectContext executeFetchRequest:request error:&error];
    NSLog(@"result %@", array.description);
    

    
    
    
    if(error != nil) {
        
        NSNumber *n = [[array objectAtIndex:0] valueForKey: @"maxId"];
        
        return n.intValue;
    }
    else{
        return -1;
    }
}



+(int32_t) getNewTranId{
    
    
    static int32_t maxTranId =-1;
    if (maxTranId ==-1) {
        maxTranId = [KeysGenerator getMaxIdFromBase:@"Transaction"];
    }
    else {
        maxTranId++;
    }
    NSLog(@"new tran id : %i", maxTranId);
    return maxTranId;
}




@end
