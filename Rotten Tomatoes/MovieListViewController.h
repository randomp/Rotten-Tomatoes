//
//  MovieListViewController.h
//  Rotten Tomatoes
//
//  Created by Peiqi Zheng on 9/13/14.
//  Copyright (c) 2014 Peiqi Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    movieList,
    dvdList
}listType;

@interface MovieListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchDisplayDelegate> {
    listType viewType;
}

- (id) initWithType:(listType)type;

@end
