//
//  ReviewViewController.m
//  JenniQuiz
//
//  Created by Jennifer Nguyen on 24/10/2014.
//  Copyright (c) 2014 Jennifer Nguyen. All rights reserved.
//


#import "ResultsViewController.h"
#import "ReviewViewController.h"
#import "Utils.h"
#import "Config.h"


@interface ResultsViewController ()

@property (nonatomic, weak) IBOutlet ADVRoundProgressChart* resultsChart;

@property (nonatomic, weak) IBOutlet UIButton* reviewButton;

@property (nonatomic, weak) IBOutlet UILabel* infoLabel;

@property (nonatomic, weak) IBOutlet UILabel* passOrFailLabel;

@end

@implementation ResultsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGFloat fractionCorrect = [Utils calculateCorrectScore:self.questions];
    NSInteger correctCount = [Utils calculateNumberOfCorrectAnswers:self.questions];
    
    self.resultsChart.chartBorderWidth = 4.0f;
    self.resultsChart.chartBorderColor = [UIColor whiteColor];
    self.resultsChart.fontName = [Config sharedInstance].mainFont;
    self.resultsChart.progress = fractionCorrect;
    self.resultsChart.backgroundColor = [UIColor clearColor];
    
    self.resultsChart.detailText =[NSString stringWithFormat:@"%lu of %lu answers", (long)correctCount, (unsigned long)self.questions.count];
    
    self.title = @"Results";
    
    UIImage* buttonBackground = [[UIImage imageNamed:@"button"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
    buttonBackground = [buttonBackground imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
    [self.reviewButton setBackgroundImage:buttonBackground forState:UIControlStateNormal];
    self.reviewButton.titleLabel.font = [UIFont fontWithName:[Config sharedInstance].boldFont size:16.0f];
    [self.reviewButton setTitle:@"REVIEW TEST" forState:UIControlStateNormal];
    

    self.infoLabel.text = @"Here are your results";
    self.infoLabel.font = [UIFont fontWithName:[Config sharedInstance].mainFont size:16.0f];
    self.infoLabel.textColor = [UIColor whiteColor];
    
    self.view.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:[Config sharedInstance].mainBackground]];
    self.view.tintColor = [UIColor whiteColor];
    
    self.navigationItem.hidesBackButton = YES;
    
    UIBarButtonItem* doneItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneTapped:)];
    self.navigationItem.rightBarButtonItem = doneItem;
    
}


-(IBAction)reviewButtonTapped:(id)sender{
    [self performSegueWithIdentifier:@"review" sender:self];
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"review"]){
        
        ReviewViewController* controller = segue.destinationViewController;
        
        controller.questions = self.questions;
    }
    
}

-(IBAction)doneTapped:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
