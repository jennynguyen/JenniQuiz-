//
//  AnswerCell.m
//  JenniQuiz
//
//  Created by Jennifer Nguyen on 24/10/2014.
//  Copyright (c) 2014 Jennifer Nguyen. All rights reserved.
//


#import "AnswerCell.h"
#import "Config.h"

@implementation AnswerCell

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
    
    CGFloat textFontSize = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ? 19.0f : 15.0f;
    CGFloat indexFontSize = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ? 25.0f : 18.0f;
    
    self.answerLabel.textColor = [UIColor whiteColor];
    self.answerLabel.font = [UIFont fontWithName:[Config sharedInstance].mainFont size:textFontSize];
    
    self.indexLabel.textColor = [UIColor whiteColor];
    self.indexLabel.font = [UIFont fontWithName:[Config sharedInstance].boldFont size:indexFontSize];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.barImageView.image = [[UIImage imageNamed:@"item-selected-empty"] resizableImageWithCapInsets:UIEdgeInsetsMake(20, 0, 20, 20)];
    
    self.answerImageView.clipsToBounds = YES;
    self.answerImageView.contentMode = UIViewContentModeScaleAspectFill;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    self.contentView.alpha = 1.0;
    if(!self.isForReview){
        self.barImageView.alpha = selected ? 1.0 : 0.0;
        self.tickImageView.alpha = selected ? 1.0 : 0.0;
    }
}

-(void)showImageForCorrectAnswer:(BOOL)correct AndChosenAnswer:(BOOL)chosen{
    
    self.barImageView.alpha = chosen ? 1.0 : 0.0;
    self.tickImageView.alpha = correct ? 1.0 : 0.0;
    
}

-(void)showCorrectAnswerWithAnimation{
    [UIView animateWithDuration:1.0 animations:^{
        self.barImageView.alpha = 1.0;
    }];
}

-(void)showWrongAnswerWithAnimation{
    [UIView animateWithDuration:1.0 animations:^{
        self.contentView.alpha = 0.1;
    }];
}

@end
