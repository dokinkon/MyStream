//
//  AppDelegate.h
//  MyStream
//
//  Created by chao-chih lin on 12/6/13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HTTPServer;
@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    HTTPServer *httpServer;
}
@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UINavigationController *navigationController;

@end
