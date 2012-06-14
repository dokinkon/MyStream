//
//  BrowseSlaveViewController.h
//  MyStream
//
//  Created by chao-chih lin on 12/6/14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BrowseSlaveViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, NSNetServiceBrowserDelegate, NSNetServiceDelegate>

- (IBAction)browseButtonPressed:(id)sender;

@property (strong, nonatomic) IBOutlet UITableView* tableView;

@end
