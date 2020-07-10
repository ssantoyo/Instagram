//
//  TimelineViewController.m
//  Instagram
//
//  Created by Sergio Santoyo on 7/7/20.
//  Copyright © 2020 ssantoyo. All rights reserved.
//

#import "TimelineViewController.h"
#import "LoginViewController.h"
#import "SceneDelegate.h"
#import <Parse/Parse.h>
#import "PostCell.h"
#import "Post.h"
#import "AppDelegate.h"
#import "DateTools.h"
#import "NSDate+TimeAgo.h"
#import "DetailsViewController.h"


@interface TimelineViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *posts;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UIRefreshControl *refreshControl;


@end

@implementation TimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 300;
    
    [self getTimeline];
    //will refresh the table view
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(getTimeline) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
    
}
    


-(void)getTimeline{
    // construct query
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    //reorders post from recently added post to the top
    [query orderByDescending: @"createdAt"];
    query.limit = 20;
    NSLog(@"Post is being refreshed");

    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts != nil) {
            self.posts = (NSMutableArray *)posts;
            //refreshes tableView data
            [self.tableView reloadData];
            // do something with the array of object returned by the call
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
        [self.refreshControl endRefreshing];
    }];
}



- (IBAction)onTapLogout:(id)sender {
    SceneDelegate *sceneDelegate = (SceneDelegate *) self.view.window.windowScene.delegate;
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    sceneDelegate.window.rootViewController = loginViewController;
    
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        // PFUser.current() will now be nil
    }];
}









#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    if ([[segue identifier] isEqualToString:@"DetailsSegue"]){
           PostCell *tappedCell = sender;
           NSIndexPath *indexPath = [self.tableView indexPathForCell:tappedCell];
           Post *post = self.posts[indexPath.row];
            DetailsViewController *detailsViewController = [segue destinationViewController];
           detailsViewController.post = post;
    }
       
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
     PostCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PostCell" forIndexPath:indexPath];
     
     Post *post = self.posts[indexPath.row];
     cell.post = post;
    
    cell.postImageView.file = post.image;
    [cell.postImageView loadInBackground];
    
    cell.captionLabel.text = post.caption;
    
     return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.posts.count;
}


@end
