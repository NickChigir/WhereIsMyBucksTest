//
//  ChartsViewController.m
//  WhereIsMyBucks
//
//  Created by Nick Chigir on 1/29/16.
//  Copyright © 2016 Nick Chigir. All rights reserved.
//

#import "ChartsViewController.h"
#import "Cathegory.h"
#import "AppDelegate.h"

@interface ChartsViewController ()

@property (weak, nonatomic) IBOutlet GKBarGraph *graphView;
@property (nonatomic) NSArray<NSDictionary *> *categoryData;
@property (nonatomic) NSNumber *grandTotal;


@end

@implementation ChartsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    // Do any additional setup after loading the view.
    [self populateData];
    self.graphView.dataSource = self;
    self.graphView.marginBar=10;
    self.graphView.barWidth =30;
    [self.graphView draw];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Model Data source
- (void) populateData{
    NSManagedObjectContext *context =[(AppDelegate *)[[UIApplication sharedApplication]delegate]  managedObjectContext];
    self.categoryData = [Cathegory totalsByCategoryForContext:context];
    
}
-(NSNumber *) grandTotal {
    if (_grandTotal == nil) {
        _grandTotal = [NSNumber numberWithDouble:0.0];
        
        for (NSDictionary *item in self.categoryData) {
            NSNumber *currentTotal = [item valueForKey:TOTAL_AMOUNT];
          _grandTotal = [NSNumber  numberWithDouble:_grandTotal.doubleValue + currentTotal.doubleValue];
           
        }
    }
        return _grandTotal;
    
}

#pragma mark - GKBarGraphDataSource

- (NSInteger)numberOfBars {
    return [self.categoryData count];
}

- (NSNumber *)valueForBarAtIndex:(NSInteger)index {
    NSNumber *value=[[self.categoryData objectAtIndex:index] valueForKey:TOTAL_AMOUNT];
    return  [NSNumber numberWithDouble:  value.doubleValue/self.grandTotal.doubleValue*100];
}

- (UIColor *)colorForBarAtIndex:(NSInteger)index {
    id colors = @[[UIColor gk_turquoiseColor],
                  [UIColor gk_peterRiverColor],
                  [UIColor gk_alizarinColor],
                  [UIColor gk_amethystColor],
                  [UIColor gk_emerlandColor],
                  [UIColor gk_sunflowerColor]
                  ];
    return [colors objectAtIndex:(index%6)];
}

//- (UIColor *)colorForBarBackgroundAtIndex:(NSInteger)index {
//    return [UIColor redColor];
//}

- (CFTimeInterval)animationDurationForBarAtIndex:(NSInteger)index {
    CGFloat percentage = [[self valueForBarAtIndex:index] doubleValue];
    percentage = (percentage / 100);
    return (self.graphView.animationDuration * percentage);
}

- (NSString *)titleForBarAtIndex:(NSInteger)index {
     return [[self.categoryData objectAtIndex:index] valueForKey:CATEGORY_NAME];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
