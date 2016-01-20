//
//  DetailViewController.m
//  WhereIsMyBucks
//
//  Created by Nick Chigir on 11/24/15.
//  Copyright © 2015 Nick Chigir. All rights reserved.
//

#import "DetailViewController.h"
#import "Cathegory.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
            
        // Update the view.
        [self configureView];
    }
}

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {
        
        NSDateFormatter *dateFormat = [NSDateFormatter new];
        [dateFormat setDateFormat:@"MMM dd yyyy"];
        
        NSString *tranDate = [dateFormat stringFromDate:[[NSDate alloc] initWithTimeIntervalSince1970:self.detailItem.tranDate]];
        
       

        self.detailNavigation.title =[NSString stringWithFormat:@"Transaction at: %@", tranDate];
        self.titleLabel.text = self.detailItem.tranAmount.description;
           }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
    self.tableView.dataSource =self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.detailItem.toCashFlow.count;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    CashFlow *content = self.detailItem.toCashFlow[indexPath.row];
    cell.textLabel.text = content.linkToCathegory.cathegoryName;
    cell.detailTextLabel.text = [NSString  stringWithFormat:@"%@", content.amount.description];
    cell.imageView.image = [UIImage imageNamed:content.linkToCathegory.imageName];
    return cell;
    
}


@end
