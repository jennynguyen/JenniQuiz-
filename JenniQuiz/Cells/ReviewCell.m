//
//  ResultCell.m
//  JenniQuiz
//
//  Created by Jennifer Nguyen on 24/10/2014.
//  Copyright (c) 2014 Jennifer Nguyen. All rights reserved.
//


#import "ReviewCell.h"
#import "Config.h"

@interface ReviewCell ()

@property (nonatomic, strong) UIImage* correctImage;

@property (nonatomic, strong) UIImage* wrongImage;

@end

@implementation ReviewCell

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
    
    CGFloat labelSize = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ? 20.0f : 16.0f;
    CGFloat countSize = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ? 32.0f : 26.0f;
    
    self.countLabel.textColor = [UIColor whiteColor];
    self.countLabel.font = [UIFont fontWithName:[Config sharedInstance].boldFont size:countSize];
    
    self.questionLabel.textColor = [UIColor whiteColor];
    self.questionLabel.font = [UIFont fontWithName:[Config sharedInstance].mainFont size:labelSize];
    
    self.correctImage = [[UIImage imageNamed:@"tick"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.wrongImage = [[UIImage imageNamed:@"cross"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)showCorrectImage:(BOOL)correct{
    if (correct) {
        self.resultImageView.image = self.correctImage;
    }else{
        self.resultImageView.image = self.wrongImage;
    }
}

@end
