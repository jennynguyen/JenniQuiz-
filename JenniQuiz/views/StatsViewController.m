//
//  StatsViewController.m
//  JenniQuiz
//
//  Created by Jennifer Nguyen on 24/10/2014.
//  Copyright (c) 2014 Jennifer Nguyen. All rights reserved.
//


#import "StatsViewController.h"
#import "ADVRoundProgressChart.h"
#import "PNScrollLineChart.h"
#import "PNScrollBarChart.h"
#import "QuestionInfoController.h"
#import "TopicCollectionController.h"
#import "QuestionContainerController.h"
#import "Datasource.h"
#import "Utils.h"
#import "Config.h"

@interface StatsViewController () <TopicCollectionControllerDelegate, QuestionInfoControllerDelegate, UIAlertViewDelegate>

@property (nonatomic, weak) IBOutlet ADVRoundProgressChart* scoresProgress;

@property (nonatomic, strong) PNScrollBarChart* scoresBarChart;

@property (nonatomic, weak) IBOutlet UILabel* testsTakenCount;

@property (nonatomic, weak) IBOutlet UILabel* testsTakenLabel;

@property (nonatomic, weak) IBOutlet UILabel* scoresLabel;

@property (nonatomic, weak) IBOutlet UIButton* startButton;

@property (nonatomic, weak) IBOutlet UIButton* chooseTopicsButton;

@property (nonatomic, strong) NSArray* selectedQuestions;


@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (nonatomic, strong) NSArray *products;
@property (nonatomic, strong) NSDictionary *pendingQuiz;

@end

@implementation StatsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self displayCharts];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:[Config sharedInstance].mainBackground]];
    self.view.tintColor = [UIColor whiteColor];
    

    self.testsTakenLabel.font = [UIFont fontWithName:[Config sharedInstance].mainFont size:16];
    self.testsTakenLabel.textColor = [UIColor whiteColor];
    self.testsTakenLabel.adjustsFontSizeToFitWidth = YES;
    self.testsTakenLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
    self.testsTakenLabel.text = @"TESTS TAKEN";
    
    self.testsTakenCount.font = [UIFont fontWithName:[Config sharedInstance].mainFont size:72];
    self.testsTakenCount.textColor = [UIColor whiteColor];
    self.testsTakenLabel.adjustsFontSizeToFitWidth = YES;
    self.testsTakenCount.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
    
    self.scoresLabel.font = [UIFont fontWithName:[Config sharedInstance].mainFont size:16];
    self.scoresLabel.textColor = [UIColor whiteColor];
    self.scoresLabel.adjustsFontSizeToFitWidth = YES;
    self.scoresLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
    self.scoresLabel.text = @"LAST SCORE";
    
    self.scoresProgress.chartBorderWidth = 4.0f;
    self.scoresProgress.chartBorderColor = [UIColor whiteColor];
    self.scoresProgress.fontName = [Config sharedInstance].mainFont;
    
    UIImage* buttonBackground = [[UIImage imageNamed:@"button"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
    buttonBackground = [buttonBackground imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
    [self.startButton setBackgroundImage:buttonBackground forState:UIControlStateNormal];
    self.startButton.titleLabel.font = [UIFont fontWithName:[Config sharedInstance].boldFont size:15.0f];
    [self.startButton setTitle:@"START TEST" forState:UIControlStateNormal];
    
    [self.chooseTopicsButton setBackgroundImage:buttonBackground forState:UIControlStateNormal];
    self.chooseTopicsButton.titleLabel.font = [UIFont fontWithName:[Config sharedInstance].boldFont size:15.0f];
    [self.chooseTopicsButton setTitle:@"TOPICS" forState:UIControlStateNormal];

    
    [self.startButton addTarget:self action:@selector(startTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.chooseTopicsButton addTarget:self action:@selector(chooseTopicsTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(reload) forControlEvents:UIControlEventValueChanged];
    [self.refreshControl beginRefreshing];

}

-(void)displayCharts{
    NSArray* aggregates = [Datasource loadAggregates];
    CGFloat lastScore = [Utils getLastTestScore:aggregates];
    
    self.scoresProgress.progress = lastScore/100.0;
    self.testsTakenCount.text = [NSString stringWithFormat:@"%lu", (unsigned long)aggregates.count];
    
    NSInteger numberOfScoresToShow = 15;
    NSArray* scores = [Utils getLast:numberOfScoresToShow scoresFromAggregates:aggregates];
    NSArray* labels = [Utils getLast:numberOfScoresToShow labelsForAggregates:aggregates];
    
    NSDictionary* dataPoints = @{@"titles" : labels, @"values" : scores};
    
    if(self.scoresBarChart){
        [self.scoresBarChart removeFromSuperview];
        self.scoresBarChart = nil;
    }
    
    CGRect frame = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ? CGRectMake(59, 420, 649, 250) : CGRectMake(40, 245, 240, 120);
    
    self.scoresBarChart = [[PNScrollBarChart alloc] initWithFrame:frame];
    [self.view addSubview:self.scoresBarChart];
    [self.scoresBarChart setHidden:UIInterfaceOrientationIsLandscape(self.interfaceOrientation)];
    [self.scoresBarChart setStrokeColor:[UIColor whiteColor]];
    [self.scoresBarChart setBackgroundColor:[UIColor colorWithWhite:1.0 alpha:0.1]];

    [self.scoresBarChart setXLabels:dataPoints[@"titles"]];
    [self.scoresBarChart setYValues:dataPoints[@"values"]];
    [self.scoresBarChart setLegend:[NSString stringWithFormat:@"Your Last %ld Scores", (long)numberOfScoresToShow]];
    [self.scoresBarChart strokeChart];
}

-(IBAction)startTapped:(id)sender{
    
    NSArray* topics = [Config sharedInstance].topics;
    [self startQuizFromTopics:topics];
}

-(IBAction)chooseTopicsTapped:(id)sender{
    [self performSegueWithIdentifier:@"topics" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"showInfo"]){
        
        QuestionInfoController* controller = segue.destinationViewController;
        controller.questions = self.selectedQuestions;
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone){
            controller.transitioningDelegate = self;
            controller.modalPresentationStyle = UIModalPresentationCustom;
        }
        controller.userPressedStartBlock = ^(){
            [self userDidStartQuiz];
        };
        
    }else if([segue.identifier isEqualToString:@"startTest"]){
        UINavigationController* controller = segue.destinationViewController;
        QuestionContainerController* c = (QuestionContainerController*)controller.topViewController;
        c.questions = self.selectedQuestions;

    } else if([segue.identifier isEqualToString:@"topics"] || [segue.identifier isEqualToString:@"topics-tableView"]){
        
        UINavigationController* nav = segue.destinationViewController;
        TopicCollectionController* controller = (TopicCollectionController*)nav.topViewController;
        controller.delegate = self;
    }
}

-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    
    self.scoresBarChart.hidden = UIInterfaceOrientationIsLandscape(toInterfaceOrientation);
}

-(void)userDidStartQuiz{
    [self performSegueWithIdentifier:@"startTest" sender:self];
}

-(void)didSelectTopics:(NSArray *)topics{
    
    if(topics.count > 0){
        NSInteger questionCount = [Config sharedInstance].numberOfQuestionsToPractice;
        
        [self startDirectQuizWithNumberOfQuestions:questionCount fromTopics:topics];
    }
}

-(void)startQuizFromTopics:(NSArray*)topics {
    NSInteger questionCount = [Config sharedInstance].numberOfQuestionsToAnswer;
    
    self.selectedQuestions = [Utils loadQuestionsFromTopics:topics forTotalNumberOfQuestions:questionCount];
    
    [self performSegueWithIdentifier:@"startTest" sender:self];

}


-(void)startDirectQuizWithNumberOfQuestions:(NSInteger)numberOfQuestions fromTopics:(NSArray*)topics{
    self.selectedQuestions = [Utils loadQuestionsFromTopics:topics forTotalNumberOfQuestions:numberOfQuestions];
    
    [self performSegueWithIdentifier:@"startTest" sender:self];
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
