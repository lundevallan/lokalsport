//
//  lokalsportFirstViewController.h
//  lokalsport
//
//  Created by Christian Ulf on 2012-04-17.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface lokalsportNewsFeedController : UIViewController
                <UITableViewDelegate, UITableViewDataSource>
{
    NSArray *News;
    
}
@property (strong, nonatomic) NSArray *News;

@end
