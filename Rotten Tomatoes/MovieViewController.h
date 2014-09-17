//
//  MovieViewController.h
//  Rotten Tomatoes
//
//  Created by Peiqi Zheng on 9/15/14.
//  Copyright (c) 2014 Peiqi Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"

@interface MovieViewController : UIViewController

@property (strong, nonatomic) UIImage *preloadImage;

- (id)initWithMovie:(Movie *) movie;

@end
