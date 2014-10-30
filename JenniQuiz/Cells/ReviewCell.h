//
//  ResultCell.h
//  JenniQuiz
//
//  Created by Jennifer Nguyen on 24/10/2014.
//  Copyright (c) 2014 Jennifer Nguyen. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface ReviewCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel* countLabel;

@property (nonatomic, strong) IBOutlet UILabel* questionLabel;

@property (nonatomic, strong) IBOutlet UIImageView* resultImageView;

@property (nonatomic, strong) IBOutlet UIImageView* bottomBorderImageView;

-(void)showCorrectImage:(BOOL)correct;

@end
