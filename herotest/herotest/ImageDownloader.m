//
//  ImageDownloader.m
//  herotest
//
//  Created by Amarjit on 04/01/2016.
//  Copyright © 2016 Amarjit. All rights reserved.
//

#import "ImageDownloader.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NSString *const kPlaceholderItURL = @"https://placeholdit.imgix.net/~text?txtsize=20&txt=100%C3%97100&w=100&h=100";

@implementation ImageDownloader

-(void) downloadPlaceholder
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];

    NSURL *urlRequest = [NSURL URLWithString:kPlaceholderItURL];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:urlRequest cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60];

    NSURLSession *session = [NSURLSession sharedSession];

    //__block NSDictionary *dictData;

    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];

        NSHTTPURLResponse *httpResp = (NSHTTPURLResponse*) response;
        NSLog(@"HTTP Status code -- %lu", httpResp.statusCode);

        if(!error)
        {
            if (httpResp.statusCode == 200)
            {
                /*
                NSArray *jsonData = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];

                dictData = [jsonData objectAtIndex:0];

                dispatch_async(dispatch_get_main_queue(), ^{
                    [self updateUIWithDictionary:dictData];
                });
                 */
            }
        }
        else
        {
            NSLog(@"Error -- %@", error.localizedDescription);
        }
    }];
    [dataTask resume];

}

@end
