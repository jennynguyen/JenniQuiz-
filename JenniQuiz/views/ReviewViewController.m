//
//  ReviewViewController.m
//  JenniQuiz
//
//  Created by Jennifer Nguyen on 24/10/2014.
//  Copyright (c) 2014 Jennifer Nguyen. All rights reserved.
//


#import "ReviewViewController.h"
#import "QuestionViewController.h"
#import "ReviewCell.h"
#import "Question.h"
#import "Config.h"

@interface ReviewViewController ()

@end

@implementation ReviewViewController

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

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:[Config sharedInstance].mainBackground]];
    self.view.tintColor = [UIColor whiteColor];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.title = @"Review";
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.questions.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ReviewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"ResultCell"];
    
    Question* question = self.questions[indexPath.row];
    
    cell.countLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)indexPath.row + 1];
    cell.questionLabel.text = question.text;
    [cell showCorrectImage:[question hasBeenAnsweredCorrectly]];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self performSegueWithIdentifier:@"reviewDetail" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    NSIndexPath* indexPath = [self.tableView indexPathForSelectedRow];
    Question* question = self.questions[indexPath.row];
    
    QuestionViewController* controller = segue.destinationViewController;
    controller.question = question;
    controller.isForReview = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
