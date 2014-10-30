//
//  TopicTableCell.h
//  JenniQuiz
//
//  Created by Jennifer Nguyen on 24/10/2014.
//  Copyright (c) 2014 Jennifer Nguyen. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface TopicTableCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel* topicTitle;

@property (nonatomic, weak) IBOutlet UIImageView* selectionImageView;

@end
