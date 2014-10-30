//
//  AnswerCell.h
//  JenniQuiz
//
//  Created by Jennifer Nguyen on 24/10/2014.
//  Copyright (c) 2014 Jennifer Nguyen. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface AnswerCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel* answerLabel;

@property (nonatomic, weak) IBOutlet UILabel* indexLabel;

@property (nonatomic, weak) IBOutlet UIImageView* answerImageView;

@property (nonatomic, weak) IBOutlet UIImageView* tickImageView;

@property (nonatomic, weak) IBOutlet UIImageView* barImageView;

@property (nonatomic, assign) BOOL isForReview;

-(void)showImageForCorrectAnswer:(BOOL)correct AndChosenAnswer:(BOOL)chosen;

-(void)showCorrectAnswerWithAnimation;

-(void)showWrongAnswerWithAnimation;

@end
