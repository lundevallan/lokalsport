//
//  newsFeedXML.h
//  lokalsport
//
//  Created by Linus  Karlsson on 4/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
/*
 
 <items>
 
 
 <item>
    <title>Titel</title>
    
 <link>
    http://linuskarlsson.se/joomla-lokalsporttest/index.php/component/content/article/46-titel
    </link>
 
 <guid>
    http://linuskarlsson.se/joomla-lokalsporttest/index.php/component/content/article/46-titel
    </guid>
 
 <image>http://en.wikipedia.org/wiki/File:Feed-icon.svg</image>
 
 <description>Trevligt</description>
 
 <author>joar.leth@telia.com (Administrator)</author>
 
 <category>frontpage</category>
 
 <pubDate>Fri, 13 Apr 2012 19:26:35 +0000</pubDate>
 
 </item>
 
 
 */

#import <UIKit/UIKit.h>

@interface newsFeedXML : NSObject
{
    
    //Elementens values
    NSString *title;
    NSString *link;
    NSString *guid;
    NSString *image;
    NSString *description;
    NSString *author;
    NSString *category;
    NSString *pubDate;

}

@property(nonatomic, retain) NSString *title;
@property(nonatomic, retain) NSString *link;
@property(nonatomic, retain) NSString *guid;
@property(nonatomic, retain) NSString *image;
@property(nonatomic, retain) NSString *description;
@property(nonatomic, retain) NSString *author;
@property(nonatomic, retain) NSString *category;
@property(nonatomic, retain) NSString *pubDate;

@end
















