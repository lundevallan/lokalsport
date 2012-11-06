//
//  newsItemViewController.h
//  lokalsport
//
//  Created by Christian Ulf on 2012-04-18.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface newsItemViewController : UIViewController <UIWebViewDelegate>
{
  
    IBOutlet UILabel *label1;
    
    IBOutlet UIWebView *webView;
    
    NSString *selectedItem;
    NSInteger selectedIndex;
    
    NSString *selectedCategory;
    
    UIActivityIndicatorView *spinner;
       UILabel *label;
    
    
    BOOL interceptLinks;
}
@property(strong, nonatomic) UILabel *label;

@property (nonatomic, assign) BOOL interceptLinks;

@property (nonatomic) NSInteger selectedIndex;
@property (nonatomic, retain) NSString *selectedItem;

@property (nonatomic, retain) UIActivityIndicatorView *spinner;

@property (nonatomic, retain) NSString *selectedCategory;

@property (nonatomic, retain) UIWebView *webView;



@end
