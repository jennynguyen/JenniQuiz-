//
//  TopicCell.h
//  JenniQuiz
//
//  Created by Jennifer Nguyen on 24/10/2014.
//  Copyright (c) 2014 Jennifer Nguyen. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface TopicCell : UICollectionViewCell

@property (nonatomic, weak) IBOutlet UILabel* topicTitle;

@property (nonatomic, weak) IBOutlet UIImageView* topicImageView;

@property (nonatomic, weak) IBOutlet UIView* overlayView;

@property (nonatomic, weak) IBOutlet UIImageView* tickImageView;


@end
