//
//  lokalsportSecondViewController.h
//  lokalsport
//
//  Created by Christian Ulf on 2012-04-17.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class lokalsportAppDelegate;

@interface lokalsportBlogViewController : UITableViewController
{
    NSArray *Blogs;
    
        lokalsportAppDelegate *appDelegate;
    
}
@property (strong, nonatomic) NSArray *Blogs;
@end
