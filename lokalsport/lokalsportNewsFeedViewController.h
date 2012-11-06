//
//  lokalsportCategoriesVIewController.h
//  lokalsport
//
//  Created by Christian Ulf on 2012-04-18.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class lokalsportAppDelegate;


@interface lokalsportNewsFeedViewController : UITableViewController 
            
{
    NSArray *News;

    lokalsportAppDelegate *appDelegate;
    
    UIActivityIndicatorView *spinner;
    
    NSTimer *theTimer;
    
    NSTimer *refreshTimer;
    
    BOOL updateIsHappening;
}


@property (nonatomic, assign) BOOL updateIsHappening;

@property (strong, nonatomic) NSArray *News;

@property(strong, nonatomic) UIActivityIndicatorView *spinner;

- (IBAction) refreshMethod:(id)senderId;
-(void)refreshMethod;


@end
