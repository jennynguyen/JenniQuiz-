//
//  QuestionDisplayEngine.m
//  QuizApp
//
//  Created by Tope Abayomi on 01/01/2014.
//  Copyright (c) 2014 App Design Vault. All rights reserved.
//

#import "QuestionDisplayEngine.h"

@interface QuestionDisplayEngine ()

@property (nonatomic, assign) NSInteger nextIndex;

@property (nonatomic, strong) QuestionViewController* questionController1;

@property (nonatomic, strong) QuestionViewController* questionController2;


@end

@implementation QuestionDisplayEngine

-(id)init{
    
    self = [super init];
    if(self){
        
        self.nextIndex = 0;
        
        NSString* storybardName = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ? @"Main_iPad" : @"Main_iPhone";
        
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:storybardName bundle:nil];
        
        self.questionController1 = [storyboard instantiateViewControllerWithIdentifier:@"QuestionViewController"];
        
        self.questionController2 = [storyboard instantiateViewControllerWithIdentifier:@"QuestionViewController"];
        
    }
    return self;
}

-(void)attachDelegate:(id<QuestionViewControllerDelegate>)delegate{
    self.questionController1.delegate = delegate;
    self.questionController2.delegate = delegate;
}

-(BOOL)showNextQuestion:(NSArray*)questions inMainView:(UIView*)mainView{
    
    if(self.nextIndex < questions.count){
        
        QuestionViewController* controller = self.nextIndex % 2 == 0 ? self.questionController1 : self.questionController2;
        QuestionViewController* currentController = self.nextIndex % 2 == 1 ? self.questionController1 : self.questionController2;
      
        controller.question = questions[self.nextIndex];
        
        if(self.nextIndex == 0){
    
            [controller.view setTranslatesAutoresizingMaskIntoConstraints:NO];
            [mainView addSubview:controller.view];
            [self addConstraintsToSubview:controller.view toView:mainView];
            
            
            [currentController.view setTranslatesAutoresizingMaskIntoConstraints:NO];
            [mainView addSubview:currentController.view];
            [self addConstraintsToSubview:currentController.view toView:mainView];
        }
        
        [controller loadData];
        [self removeController:currentController andShowController:controller inMainView:mainView];
        

        self.nextIndex++;
        return YES;
    }else{
        
        [self.questionController1.view removeFromSuperview];
        [self.questionController2.view removeFromSuperview];
        return NO;
    }
}

-(void)removeController:(UIViewController*)fromViewController andShowController:(UIViewController*)toViewController inMainView:(UIView*)mainView{
    
    
    CGRect frameOffScreen = mainView.frame;
    frameOffScreen.origin.x = (-1)*mainView.frame.size.width;
    
    NSTimeInterval duration = 0.3;
    
    CATransform3D translate = CATransform3DTranslate(CATransform3DIdentity, 50, 0, 0);
    toViewController.view.layer.transform = translate;
    
    UIView* overlayView = [[UIView alloc] initWithFrame:mainView.frame];
    overlayView.backgroundColor = [UIColor blackColor];
    [toViewController.view addSubview:overlayView];

    [UIView animateWithDuration:duration animations:^{
        
        fromViewController.view.frame = frameOffScreen;
        overlayView.alpha = 0.0;
        
        CATransform3D identityTransform = CATransform3DIdentity;
        toViewController.view.layer.transform = identityTransform;
        
        
    } completion:^(BOOL finished) {
        [overlayView removeFromSuperview];
        [fromViewController.view removeFromSuperview];
        fromViewController.view.frame = mainView.frame;
        [mainView insertSubview:fromViewController.view belowSubview:toViewController.view];
        [self addConstraintsToSubview:fromViewController.view toView:mainView];
        
        [toViewController.view removeFromSuperview];
        [mainView addSubview:toViewController.view];
        [self addConstraintsToSubview:toViewController.view toView:mainView];
        
    }];
    
}

-(void)addConstraintsToSubview:(UIView*)subView toView:(UIView*)mainView{
    
    [self addEdgeConstraint:NSLayoutAttributeLeft superview:mainView subview:subView];
    [self addEdgeConstraint:NSLayoutAttributeRight superview:mainView subview:subView];
    [self addEdgeConstraint:NSLayoutAttributeTop superview:mainView subview:subView];
    [self addEdgeConstraint:NSLayoutAttributeBottom superview:mainView subview:subView];
}

- (void)addEdgeConstraint:(NSLayoutAttribute)edge superview:(UIView *)superview subview:(UIView*)subview {
    
    [superview addConstraint:[NSLayoutConstraint constraintWithItem:subview
                                                          attribute:edge
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:superview
                                                          attribute:edge
                                                         multiplier:1
                                                           constant:0]];
}


@end
