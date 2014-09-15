//
//  MovieCell.h
//  Rotten Tomatoes
//
//  Created by Peiqi Zheng on 9/14/14.
//  Copyright (c) 2014 Peiqi Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"

@interface MovieCell : UITableViewCell

@property (nonatomic, strong) Movie *movie;

+ (NSString *)cellIdentifier;

@end
