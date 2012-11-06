//
//  lokalsportCategoryItemsViewController.h
//  lokalsport
//
//  Created by Linus  Karlsson on 4/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@class lokalsportAppDelegate;

@interface lokalsportOneBlogViewController : UITableViewController
{
    NSString *selectedItem;
    lokalsportAppDelegate *appDelegate;    
    UIActivityIndicatorView *spinner;
    UILabel *label;
}


@property (nonatomic, retain) NSString *selectedItem;
@property(strong, nonatomic) UIActivityIndicatorView *spinner;
@property(strong, nonatomic) UILabel *label;

- (IBAction) refreshMethod:(id)senderId;


@end
