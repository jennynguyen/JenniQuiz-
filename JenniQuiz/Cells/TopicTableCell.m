//
//  TopicTableCell.m
//  JenniQuiz
//
//  Created by Jennifer Nguyen on 24/10/2014.
//  Copyright (c) 2014 Jennifer Nguyen. All rights reserved.
//


#import "TopicTableCell.h"
#import "Config.h"

@implementation TopicTableCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)awakeFromNib{
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.topicTitle.font = [UIFont fontWithName:[Config sharedInstance].boldFont size:14.0f];
    self.topicTitle.textColor = [UIColor whiteColor];
    self.topicTitle.numberOfLines = 0;
    
    self.selectionImageView.alpha = 0.0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    self.selectionImageView.alpha = selected ? 1.0 : 0.0;
}

@end
