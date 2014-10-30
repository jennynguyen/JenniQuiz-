//
//  AnswerReviewCell.h
//  JenniQuiz
//
//  Created by Jennifer Nguyen on 24/10/2014.
//  Copyright (c) 2014 Jennifer Nguyen. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface AnswerReviewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel* answerLabel;

@property (nonatomic, weak) IBOutlet UIImageView* tickImageView;

@property (nonatomic, weak) IBOutlet UIImageView* barImageView;

-(void)showImageForCorrectAnswer:(BOOL)correct AndChosenAnswer:(BOOL)chosen;

@end
