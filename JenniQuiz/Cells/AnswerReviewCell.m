//
//  AnswerReviewCell.m
//  JenniQuiz
//
//  Created by Jennifer Nguyen on 24/10/2014.
//  Copyright (c) 2014 Jennifer Nguyen. All rights reserved.
//


#import "AnswerReviewCell.h"
#import "Config.h"

@interface AnswerReviewCell ()

@end

@implementation AnswerReviewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)awakeFromNib{
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    
    self.answerLabel.textColor = [UIColor whiteColor];
    self.answerLabel.font = [UIFont fontWithName:[Config sharedInstance].mainFont size:19.0f];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.barImageView.image = [[UIImage imageNamed:@"item-selected-empty"] resizableImageWithCapInsets:UIEdgeInsetsMake(20, 0, 20, 20)];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)showImageForCorrectAnswer:(BOOL)correct AndChosenAnswer:(BOOL)chosen{
    
    self.barImageView.alpha = chosen ? 1.0 : 0.0;
    self.tickImageView.alpha = correct ? 1.0 : 0.0;

}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.contentView setNeedsLayout];
    [self.contentView layoutIfNeeded];
    
    self.answerLabel.preferredMaxLayoutWidth = CGRectGetWidth(self.answerLabel.frame);
}

@end
