//
//  AppDelegate.h
//  CURL GUI
//
//  Created by Licht Takeuchi on 12/6/11.
//  Copyright (c) 2011 Licht Takeuchi. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#include <curl/curl.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>{
    IBOutlet NSTextField* urlField;
    IBOutlet NSTextField* postField;
    IBOutlet NSTextView* logView;
    IBOutlet NSTextView* htmlView;
    CURL* curl;
    //IBAction
}

@property (assign) IBOutlet NSWindow *window;
@property (nonatomic,retain) IBOutlet NSTextField* urlField;
@property (nonatomic,retain) IBOutlet NSTextField* postField;
@property (nonatomic,retain) IBOutlet NSTextView* logView;
@property (nonatomic,retain) IBOutlet NSTextView* htmlView;
@property  CURL* curl;

-(IBAction)goBtn:(id)sender;
-(IBAction)clear:(id)sender;

@end
