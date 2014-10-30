//
//  QuestionViewController.m
//  JenniQuiz
//
//  Created by Jennifer Nguyen on 24/10/2014.
//  Copyright (c) 2014 Jennifer Nguyen. All rights reserved.
//


#import "QuestionViewController.h"
#import "AnswerCell.h"
#import "Answer.h"
#import "Config.h"

@interface QuestionViewController ()

@property (nonatomic, weak) IBOutlet UIImageView* questionImageView;

@property (nonatomic, weak) IBOutlet UIView* headerView;

@property (nonatomic, weak) IBOutlet UILabel* questionLabel;

@property (nonatomic, weak) IBOutlet UITableView* answerTableView;

@property (nonatomic, weak) IBOutlet NSLayoutConstraint *imageViewConstraint;

@property (nonatomic, weak) IBOutlet NSLayoutConstraint *topMarginConstraint;

@property (nonatomic, weak) IBOutlet NSLayoutConstraint *bottomMarginConstraint;

@property (nonatomic, weak) IBOutlet UIButton* answerButton;

@property (nonatomic, weak) IBOutlet UIView* footerView;

@property (nonatomic, assign) BOOL correctAnswerShown;

@property (nonatomic, strong) NSArray* alphabets;


-(void)showCorrectAnswer;

@end

@implementation QuestionViewController

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
    
    self.answerTableView.delegate = self;
    self.answerTableView.dataSource = self;
  
    self.view.tintColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = YES;
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:[Config sharedInstance].mainBackground]];
    
    self.answerTableView.backgroundColor = [UIColor clearColor];
    self.answerTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UIImage* buttonBackground = [[UIImage imageNamed:@"button"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
    buttonBackground = [buttonBackground imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    UIImage* buttonDisabledBackground = [[UIImage imageNamed:@"button-disabled"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
    buttonDisabledBackground = [buttonDisabledBackground imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
    [self.answerButton setBackgroundImage:buttonBackground forState:UIControlStateNormal];
    [self.answerButton setBackgroundImage:buttonDisabledBackground forState:UIControlStateDisabled];
    self.answerButton.titleLabel.font = [UIFont fontWithName:[Config sharedInstance].boldFont size:17.0f];
    [self.answerButton addTarget:self action:@selector(answerTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.answerButton setTitle:@"NEXT" forState:UIControlStateNormal];
    self.answerButton.enabled = NO;
    self.answerButton.hidden = self.isForReview;

    self.footerView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.1];
    UIToolbar* toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 60)];
    [toolbar setBarStyle:UIBarStyleBlack];
    [self.footerView insertSubview:toolbar belowSubview:self.answerButton];
    self.footerView.hidden = self.isForReview;
    
    
    self.headerView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.1];
    
    self.questionLabel.font = [UIFont fontWithName:[Config sharedInstance].boldFont size:19];
    self.questionLabel.textColor = [UIColor whiteColor];
    self.questionLabel.numberOfLines = 0;
    self.questionLabel.preferredMaxLayoutWidth = CGRectGetWidth(self.questionLabel.frame);
    
    self.questionImageView.contentMode = UIViewContentModeScaleAspectFit;
     
    self.alphabets = @[@"A.", @"B.", @"C.", @"D.", @"E.", @"F.", @"G.", @"H.", @"I.", @"J.", @"K.", @"L.", @"M.", @"N.", @"O.", @"P.", @"Q.", @"R.", @"S.", @"T.", @"U.", @"V.", @"W.", @"X.", @"Y.", @"Z."];
    
    self.topMarginConstraint.constant = self.isForReview ? 10 : 70;
    self.bottomMarginConstraint.constant = self.isForReview ? 0 : 60;
    
    [self loadData];
}

-(void)loadData{
    
    self.answerTableView.allowsMultipleSelection = [self.question numberOfCorrectAnswers] > 1;
    self.answerButton.enabled = NO;
    self.questionLabel.text = self.question.text;
    self.correctAnswerShown = NO;

    if(self.question.image){

        self.imageViewConstraint.constant = 135;
        
        UIImage* image = [UIImage imageNamed:self.question.image];
        self.questionImageView.image = image;
  
    }else{
        self.imageViewConstraint.constant = 0;
        self.questionImageView.image = nil;
    }
    
    [self.answerTableView reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.question.answers.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AnswerCell* cell = nil;
    Answer* answer = self.question.answers[indexPath.row];
    
    if(answer.image){
        cell = [tableView dequeueReusableCellWithIdentifier:@"AnswerCellImage"];
        cell.answerImageView.image = [UIImage imageNamed:answer.image];
    }else{
        cell = [tableView dequeueReusableCellWithIdentifier:@"AnswerCell"];
        cell.answerLabel.preferredMaxLayoutWidth = CGRectGetWidth(cell.answerLabel.frame);
        cell.answerLabel.text = answer.text;
    }
    
    cell.indexLabel.text = [self getAlphabetFromIndex:indexPath.row];
    cell.isForReview = self.isForReview;
    cell.backgroundColor = [UIColor clearColor];
    
    if(self.isForReview){
        BOOL isChosenAnswer = [self.question indexIsChosenAnswer:indexPath.row];
        BOOL isCorrectAnswer = [self.question indexIsCorrectAnswer:indexPath.row];
        
        [cell showImageForCorrectAnswer:isCorrectAnswer AndChosenAnswer:isChosenAnswer];
    }
    
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    
    [cell.contentView setNeedsLayout];
    [cell.contentView layoutIfNeeded];
    
    cell.answerLabel.preferredMaxLayoutWidth = CGRectGetWidth(cell.answerLabel.frame);
    [cell.contentView layoutIfNeeded];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self doAnswerButtonState];
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self doAnswerButtonState];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    AnswerCell *cell = (AnswerCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    Answer* answer = self.question.answers[indexPath.row];
    
    if(answer.image){
        return UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ? 170 : 95;
    }else{
        
        CGFloat height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
        height += 10.0f;
        
        return height;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 3;
}

-(IBAction)answerTapped:(id)sender{
  
    if(self.correctAnswerShown){
        [self enableInteractionOnCells:YES];
        [self.answerButton setTitle:@"NEXT" forState:UIControlStateNormal];
        [self.delegate questionHasBeenAnswered:self.question withController:self];
    }else{
        
        NSArray* indexPaths = self.answerTableView.indexPathsForSelectedRows;
        
        for (NSIndexPath* indexPath in indexPaths) {
            
            Answer* answer = self.question.answers[indexPath.row];
            answer.chosen = YES;
        }
        
        self.answerTableView.contentOffset = CGPointMake(0, 0 - self.answerTableView.contentInset.top);
        
        [self showCorrectAnswer];
        
        [self.answerButton setTitle:@"CONTINUE" forState:UIControlStateNormal];
    }
}

-(void)doAnswerButtonState{
    
    NSArray* indexPaths = self.answerTableView.indexPathsForSelectedRows;
    
    self.answerButton.enabled = indexPaths && indexPaths.count >= [self.question numberOfCorrectAnswers];
}

-(void)showCorrectAnswer{
    
    self.correctAnswerShown = YES;
    
    if([self.question hasBeenAnsweredCorrectly]){
        [self.delegate questionHasBeenAnswered:self.question withController:self];
    }else{
        
        [self enableInteractionOnCells:NO];
        for (NSInteger i = 0; i < self.question.answers.count; i++) {

            AnswerCell* cell = (AnswerCell*)[self.answerTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
            
            Answer* answer = self.question.answers[i];
            
            if(answer.correct){
                [cell showCorrectAnswerWithAnimation];
                
            }else{
                [cell showWrongAnswerWithAnimation];
            }
        }
    }
}

-(void)enableInteractionOnCells:(BOOL)enable{
    
    
    for (NSInteger i = 0; i < self.question.answers.count; i++) {
        AnswerCell* cell = (AnswerCell*)[self.answerTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
    
        [cell setUserInteractionEnabled:enable];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSString*)getAlphabetFromIndex:(NSInteger)index{
    
    return self.alphabets[index % self.alphabets.count];
}

@end
