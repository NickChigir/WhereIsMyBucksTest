//
//  ImageCollectionViewController.h
//  WhereIsMyBucks
//
//  Created by Nick Chigir on 1/20/16.
//  Copyright © 2016 Nick Chigir. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Cathegory.h"

@interface ImageCollectionViewController : UICollectionViewController

@property (weak, nonatomic) UIButton *selectedImage;
@property (weak,nonatomic) Cathegory *selectedCategory;

@end
