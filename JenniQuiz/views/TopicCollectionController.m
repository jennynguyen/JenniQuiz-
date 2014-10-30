//
//  ViewController.m
//  JenniQuiz
//
//  Created by Jennifer Nguyen on 24/10/2014.
//  Copyright (c) 2014 Jennifer Nguyen. All rights reserved.
//


#import "TopicCollectionController.h"
#import "QuestionInfoController.h"
#import "TopicCell.h"
#import "TopicTableCell.h"
#import "Topic.h"
#import "Config.h"
#import "Utils.h"

@interface TopicCollectionController ()

@property (nonatomic, strong) NSArray* selectedQuestions;

@property (nonatomic, strong) Topic* topicToPurchase;

@end

@implementation TopicCollectionController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.topics = [Config sharedInstance].topics;
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.allowsMultipleSelection = YES;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.allowsMultipleSelection = YES;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.title = @"Select Topics";
    
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:[Config sharedInstance].mainBackground]];
    self.view.tintColor = [UIColor whiteColor];
    
    self.layout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    self.layout.minimumInteritemSpacing = 5;
    self.layout.minimumLineSpacing = 5;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.topics.count;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    TopicCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TopicCell" forIndexPath:indexPath];
    
    Topic* topic = self.topics[indexPath.row];
    
    cell.topicTitle.text = topic.title;
    cell.topicImageView.image = topic.image;
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.topics.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TopicTableCell* cell = [tableView dequeueReusableCellWithIdentifier:@"TopicTableCell"];
    
    Topic* topic = self.topics[indexPath.row];
    
    cell.topicTitle.text = topic.title;
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
}


-(IBAction)didTapStartButton:(id)sender{
    NSArray* indexPaths = [self.collectionView indexPathsForSelectedItems];
    if(!indexPaths){
        indexPaths = [self.tableView indexPathsForSelectedRows];
    }
    
    if(indexPaths.count == 0){
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"No Topics Selected" message:@"Please select one or more topics to take the quiz" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }else{
        

        NSMutableArray* selectedTopics = [NSMutableArray array];
        for (NSIndexPath* indexPath in indexPaths) {
            [selectedTopics addObject:self.topics[indexPath.row]];
        }
        
        [self dismissViewControllerAnimated:YES completion:^{
            [self.delegate didSelectTopics:selectedTopics];
        }];
    }
}

-(IBAction)didTapCancelButton:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
