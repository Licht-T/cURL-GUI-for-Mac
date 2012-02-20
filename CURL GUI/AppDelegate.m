//
//  AppDelegate.m
//  CURL GUI
//
//  Created by Licht Takeuchi on 12/6/11.
//  Copyright (c) 2011 Licht Takeuchi. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize urlField;
@synthesize postField;
@synthesize logView;
@synthesize htmlView;
@synthesize curl;

- (void)dealloc
{
    [super dealloc];
}
	
- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    curl_global_init(CURL_GLOBAL_ALL);
    self.curl = curl_easy_init();
}

- (IBAction)goBtn:(id)sender
{
    [self.logView setString:@""];
    [self.htmlView setString:@""];
    
    NSString* url;
    url = [[NSString alloc] initWithFormat:[self.urlField stringValue]];
    NSString* poststr;
    poststr = [[NSString alloc] initWithFormat:[self.postField stringValue]];
    //NSLog(url);
    //NSLog(poststr);

    CURLcode res;
    if(self.curl) {
        NSString* log_path = [[NSBundle mainBundle] pathForResource: @"curl" ofType: @"log"];
        FILE *logfp = fopen([ log_path cStringUsingEncoding : 1 ], "w");
        NSString* html_path = [[NSBundle mainBundle] pathForResource: @"curl" ofType: @"html"];
        FILE *htmlfp = fopen([ html_path cStringUsingEncoding : 1 ], "w");
        
        curl_easy_setopt(self.curl, CURLOPT_URL, [url UTF8String]);
        curl_easy_setopt(self.curl, CURLOPT_WRITEFUNCTION, fwrite);
        curl_easy_setopt(self.curl, CURLOPT_WRITEDATA, htmlfp);
        curl_easy_setopt(self.curl, CURLOPT_STDERR, logfp);
        curl_easy_setopt(self.curl, CURLOPT_SSL_VERIFYPEER, 0);
        //curl_easy_setopt(self.curl, CURLOPT_SSL_VERIFYHOST, 0);
        curl_easy_setopt(self.curl, CURLOPT_USERAGENT, "Mozilla/4.0 (compatible; MSIE 5.01; Windows NT 5.0)");
        curl_easy_setopt(self.curl, CURLOPT_NOSIGNAL, 1);
        curl_easy_setopt(self.curl, CURLOPT_VERBOSE,1);
        //curl_easy_setopt(self.curl, CURLOPT_HEADER, 1);
        curl_easy_setopt(self.curl, CURLOPT_FOLLOWLOCATION, 1);
        
        if (![poststr isEqualToString:@""]) {
            //NSLog(@"foo!");
            curl_easy_setopt(self.curl, CURLOPT_POSTFIELDS, [poststr UTF8String]);
        }
        
        curl_easy_setopt(self.curl, CURLOPT_COOKIEFILE, "");
        res = curl_easy_perform(self.curl);
        
        fclose(logfp);
        fclose(htmlfp);

        NSString* log_string;
        NSString* html_string;
        NSError* error;
        
        log_string = [NSString stringWithContentsOfFile:log_path encoding:NSUTF8StringEncoding error:&error];
        html_string = [NSString stringWithContentsOfFile:html_path encoding:NSUTF8StringEncoding error:&error];
        //NSLog(log_string);
        //NSLog(html_string);
        
        
        [self.logView setString:log_string];
        [self.htmlView setString:html_string];
        
    }
}

-(IBAction)clear:(id)sender
{
    [urlField setStringValue:@""];
    [postField setStringValue:@""];
}

@end
