//
//  lokalsportCategoriesVIewController.h
//  lokalsport
//
//  Created by Christian Ulf on 2012-04-18.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class lokalsportAppDelegate;

@interface lokalsportCategoriesViewController : UITableViewController

{

    lokalsportAppDelegate *appDelegate;
    
     IBOutlet UIActivityIndicatorView *activityIndicator;
    
    UIActivityIndicatorView *spinner;
    
}

@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *activityIndicator;

@property(strong, nonatomic) UIActivityIndicatorView *spinner;

@end
