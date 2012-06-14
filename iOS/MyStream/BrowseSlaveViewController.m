//
//  BrowseSlaveViewController.m
//  MyStream
//
//  Created by chao-chih lin on 12/6/14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "BrowseSlaveViewController.h"
//#include <sys/socket.h>
#import <sys/types.h>
#import <sys/socket.h>
#import <netinet/in.h>
#import <arpa/inet.h>

@interface BrowseSlaveViewController ()
{
    NSNetServiceBrowser* _serviceBrowser;
    BOOL _isSearchingService;
}

@end

@implementation BrowseSlaveViewController

@synthesize tableView = _tableView;

- (IBAction)browseButtonPressed:(id)sender
{
    if (!_isSearchingService) {
        [_serviceBrowser searchForServicesOfType:@"_mystream._tcp." inDomain:@"local."];
        _isSearchingService = YES;
        
    } else {
        [_serviceBrowser stop];
        _isSearchingService = NO;
    }
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _serviceBrowser = [[NSNetServiceBrowser alloc] init];
        [_serviceBrowser setDelegate:self];
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.tableView = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)netServiceBrowser:(NSNetServiceBrowser *)netServiceBrowser didFindService:(NSNetService *)netService moreComing:(BOOL)moreServicesComing
{
    NSLog(@"[SB] FIND SERVICE%@.", netService);
    [netService setDelegate:self];
    [netService resolveWithTimeout:1];
}

- (void)netServiceBrowserWillSearch:(NSNetServiceBrowser *)netServiceBrowser
{
    NSLog(@"will search");
}

- (void)netServiceBrowser:(NSNetServiceBrowser *)netServiceBrowser didNotSearch:(NSDictionary *)errorInfo
{
    NSLog(@"didnotsearch");
}

- (void)netServiceBrowserDidStopSearch:(NSNetServiceBrowser *)netServiceBrowser
{
    NSLog(@"didstopsearch");
}

- (void)netServiceWillResolve:(NSNetService *)netService
{
    NSLog(@"netServiceWillResolve:");
    
}

- (void)netService:(NSNetService *)netService didNotResolve:(NSDictionary *)errorDict
{
    NSLog(@"didNotResolve:");
    
}

- (void)netServiceDidResolveAddress:(NSNetService *)netService
{
    NSLog(@"netServiceDidResolveAddress:");
    NSArray* addresses = [netService addresses];
    for (NSData* data in addresses) {
        //sockaddr* sockAddress = (sockaddr*)[data bytes];
        struct sockaddr_in* addr = (struct sockaddr_in *) [data bytes];
        NSString* ip = [NSString stringWithCString:(char *) inet_ntoa(addr->sin_addr)];
        int port = ntohs(addr->sin_port);
        NSLog(@"ADDR %@:%d", ip, port);
        
    }
    
    NSLog(@"HOST NAME:%@", [netService hostName]);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    if (indexPath.row==0) 
        cell.textLabel.text = @"Be Master";
    else {
        cell.textLabel.text = @"Be Slave";
    }
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}




@end
