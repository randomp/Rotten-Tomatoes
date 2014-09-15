//
//  MovieListViewController.m
//  Rotten Tomatoes
//
//  Created by Peiqi Zheng on 9/13/14.
//  Copyright (c) 2014 Peiqi Zheng. All rights reserved.
//

#import "MovieListViewController.h"
#import "MovieCell.h"
#import "TSMessage.h"
#import "MMProgressHUD.h"

@interface MovieListViewController () {
    NSString *rtApiUrl;
    NSString *screenTile;
    UIRefreshControl *uiRefreshControl;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSArray *movies;
@property (strong, nonatomic) NSMutableArray *searchResult;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end

@implementation MovieListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIColor *tiffanyGreen = [UIColor colorWithRed:124.0f/255.0f green:238.0f/255.0f blue:206.0f/255.0f alpha:0.5f];
    self.navigationController.navigationBar.barTintColor = tiffanyGreen;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView setRowHeight:125.0f];
    [self.tableView registerNib:[UINib nibWithNibName:@"MovieCell" bundle:nil] forCellReuseIdentifier:[MovieCell cellIdentifier]];
    
    uiRefreshControl = [[UIRefreshControl alloc] init];
    uiRefreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"Pull to Refresh"];
    [uiRefreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:uiRefreshControl];
    
    self.searchBar.delegate = self;
    self.tableView.tableHeaderView = self.searchBar;
    
    [self getMoives];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id)initWithType:(listType)type {
    viewType = type;
    switch (viewType) {
        case movieList:
            rtApiUrl = @"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?apikey=dagqdghwaq3e3mxyrp7kmmj5&limit=20&country=us";
            screenTile = @"Movies";
            break;
        case dvdList:
            rtApiUrl = @"http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/top_rentals.json?apikey=dagqdghwaq3e3mxyrp7kmmj5&limit=20&country=us";
            screenTile = @"DVD";
        default:
            break;
    }
    self = [super init];
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = screenTile;
        self.view.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return self.searchResult.count;
    } else {
        return self.movies.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MovieCell *cell = (MovieCell *)[tableView dequeueReusableCellWithIdentifier:[MovieCell cellIdentifier]];
    if (!cell) {
        cell = [[MovieCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[MovieCell cellIdentifier]];
    }
    Movie *movie;
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        if (self.searchResult.count > indexPath.row) {
            movie = self.searchResult[indexPath.row];
        }
    } else {
        movie = self.movies[indexPath.row];
    }
    cell.movie = movie;
    return cell;
}

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"title contains[c] %@", searchText];
    self.searchResult = [NSMutableArray arrayWithArray: [self.movies filteredArrayUsingPredicate:resultPredicate]];
    NSLog(@"size: %d",(int)self.searchResult.count);
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    [self filterContentForSearchText:searchString scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                                         objectAtIndex:[self.searchDisplayController.searchBar
                                                                        selectedScopeButtonIndex]]];
    return YES;
}

- (void)getMoives {
    [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleFade];
    [MMProgressHUD showWithTitle:@"Loading"];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:rtApiUrl] cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:5];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        [MMProgressHUD dismiss];
        if (connectionError!=nil) {
            [TSMessage showNotificationInViewController:self title:@"Network Error!" subtitle:@"Please check your network and try again." type:TSMessageNotificationTypeError duration:3 canBeDismissedByUser:YES];
        } else {
            id object = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            self.movies = [Movie getMovies:object];
        }
        [self.tableView reloadData];
        self.searchResult = [NSMutableArray arrayWithCapacity:[self.movies count]];
    }];
}

- (void)refresh:(id)sender {
    [self getMoives];
    [(UIRefreshControl *)sender endRefreshing];
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
