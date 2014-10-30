//
//  QuestionContainerController.m
//  JenniQuiz
//
//  Created by Jennifer Nguyen on 24/10/2014.
//  Copyright (c) 2014 Jennifer Nguyen. All rights reserved.
//


#import "QuestionContainerController.h"
#import "QuestionDisplayEngine.h"
#import "Datasource.h"
#import "Config.h"


@interface QuestionContainerController ()

@property (nonatomic, strong) QuestionDisplayEngine* displayEngine;

@property (nonatomic, strong) UILabel* statusLabel;

@property (nonatomic, strong) UIProgressView* statusProgress;

@property (nonatomic, strong) UILabel* timerLabel;

@property (nonatomic, assign) NSInteger currentQuestionIndex;

@property (nonatomic, strong) NSTimer* timer;

@property (nonatomic, assign) CGFloat currentTimeInterval;

@property (nonatomic, assign) NSTimeInterval totalTimeInterval;

@end

@implementation QuestionContainerController

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
    
    self.navigationItem.hidesBackButton = YES;
    
    self.displayEngine = [[QuestionDisplayEngine alloc] init];
    [self.displayEngine attachDelegate:self];
    
    NSArray* nibs = [[NSBundle mainBundle] loadNibNamed:@"StatusView" owner:nil options:nil];
    UIView* statusView = nibs[0];
    
    self.statusLabel = (UILabel*)[statusView viewWithTag:1];
    self.statusProgress = (UIProgressView*)[statusView viewWithTag:2];
    self.navigationItem.titleView = statusView;
    
    self.statusLabel.textColor = [UIColor whiteColor];
    self.statusLabel.font = [UIFont fontWithName:[Config sharedInstance].mainFont size:14.0f];
    self.statusProgress.tintColor = [UIColor whiteColor];
    
    self.currentQuestionIndex = -1;
    
    self.view.backgroundColor = [UIColor blackColor];

    self.timerLabel = (UILabel*)[statusView viewWithTag:3];
    self.timerLabel.textColor = [UIColor whiteColor];
    self.timerLabel.font = [UIFont fontWithName:[Config sharedInstance].mainFont size:14.0f];
    self.timerLabel.alpha = 0.0;
    
    BOOL isTimedQuiz = [Config sharedInstance].isTimedQuiz;
    
    self.totalTimeInterval = isTimedQuiz ? floor([Config sharedInstance].timeNeededInMinutes * 60) : 0;
    
    if(self.totalTimeInterval > 0){
        self.timerLabel.alpha = 1.0;
        self.currentTimeInterval = 0;
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateTime:) userInfo:nil repeats:YES];
        [self updateTimerText];
    }
    
    UIBarButtonItem* doneItem = [[UIBarButtonItem alloc] initWithTitle:@"Stop" style:UIBarButtonItemStylePlain target:self action:@selector(doneTapped:)];
    self.navigationItem.rightBarButtonItem = doneItem;
    
    
    [self showNextQuestion];
}

-(void)showNextQuestion{
    
    self.currentQuestionIndex++;
    [self setStatusInfoWithCount:self.currentQuestionIndex];
    BOOL canShowNextQuestion = [self.displayEngine showNextQuestion:self.questions inMainView:self.view];
    if(!canShowNextQuestion){
        
        [self.timer invalidate];
        [self saveResultsAndShowThem];
    }
}

-(void)questionHasBeenAnswered:(Question *)question withController:(QuestionViewController *)controller{
    
    [self showNextQuestion];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"results"]){
        ResultsViewController* controller = segue.destinationViewController;
        controller.questions = self.questions;
    }
}

-(IBAction)doneTapped:(id)sender{
    [self.timer invalidate];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)setStatusInfoWithCount:(NSInteger)count{
    
    self.statusLabel.text = [NSString stringWithFormat:@"Question %ld of %ld", (long)count+1, (unsigned long)self.questions.count];
    
    [self.statusProgress setProgress:count/(CGFloat)self.questions.count animated:YES];
    
}

-(void)updateTime:(id)sender{
    self.currentTimeInterval++;
    [self updateTimerText];
    
    if(self.currentTimeInterval == self.totalTimeInterval){
        [self timeUp];
    }
}

-(void)updateTimerText{
    
    NSInteger secondsLeft = self.totalTimeInterval - self.currentTimeInterval;
    NSInteger minutes = floor(secondsLeft/60);
    NSInteger seconds = round(secondsLeft - minutes * 60);
    
    self.timerLabel.text = [NSString stringWithFormat:@"%ld:%ld", (long)minutes, (long)seconds];
    
}

-(void)timeUp{
    [self.timer invalidate];
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Time Up!"  message:@"Your Time is Up" delegate:self cancelButtonTitle:@"See Your Results" otherButtonTitles:nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    
    [self saveResultsAndShowThem];
}

-(void)saveResultsAndShowThem{

    [Datasource saveAggregates:self.questions forDate:[NSDate date]];
    [self performSegueWithIdentifier:@"results" sender:self];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
