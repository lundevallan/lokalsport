//
//  categoryArticleXML.h
//  lokalsport
//
//  Created by Linus  Karlsson on 5/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

/*<item>
<title>Förlust i hemmapremiären för IK Nordia.</title>
<link>http://lokalsport.nu/fotboll/38-fotboll/3985-al?option=com_mobileapp</link>
<image>images/stories/Fotboll/Nordia/s2011herrar/6.jpg</image>
<description></description>
<category>Fotboll</category>
<pubDate>Lördag 6 maj kl 06:35</pubDate>
</item>*/


@interface categoryArticleXML : NSObject
{
//Elementens values
NSString *title;
NSString *link;
NSString *image;
NSString *description;
NSString *category;
NSString *pubDate;

}

@property(nonatomic, retain) NSString *title;
@property(nonatomic, retain) NSString *link;
@property(nonatomic, retain) NSString *image;
@property(nonatomic, retain) NSString *description;
@property(nonatomic, retain) NSString *category;
@property(nonatomic, retain) NSString *pubDate;

@end
