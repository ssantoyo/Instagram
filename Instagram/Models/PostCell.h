//
//  PostCell.h
//  Instagram
//
//  Created by Sergio Santoyo on 7/9/20.
//  Copyright © 2020 ssantoyo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"
#import "PFImageView.h"


NS_ASSUME_NONNULL_BEGIN

@interface PostCell : UITableViewCell

@property (weak, nonatomic) Post *post;
@property (weak, nonatomic) IBOutlet UILabel *captionLabel;
@property (weak, nonatomic) IBOutlet PFImageView *postImageView;



@end

NS_ASSUME_NONNULL_END
