//
//  DetailsViewController.m
//  Instagram
//
//  Created by Sergio Santoyo on 7/9/20.
//  Copyright © 2020 ssantoyo. All rights reserved.
//

#import "DetailsViewController.h"
#import "TimelineViewController.h"
#import "LoginViewController.h"
#import "SceneDelegate.h"
#import <Parse/Parse.h>
#import "PostCell.h"
#import "Post.h"
#import "AppDelegate.h"
#import "DateTools.h"
#import "NSDate+TimeAgo.h"
#import "PFImageView.h"



@interface DetailsViewController ()
@property (weak, nonatomic) IBOutlet PFImageView  *postImageView;
@property (weak, nonatomic) IBOutlet UITextView *captionLabel;
@property (weak, nonatomic) IBOutlet UILabel *timestampLabel;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.postImageView.file = self.post.image;
    [self.postImageView loadInBackground];
    
    self.captionLabel.text = self.post.caption;
    
    NSDate *createdAt = [self.post createdAt];     NSString *ago = [createdAt timeAgo];     NSString *createdAtString = ago;     self.timestampLabel.text = createdAtString;

 
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
