//
//  ReadZipPlugin.m
//  ReadZip
//
//  Created by Fabien Tillon on 18/06/12.
//  Copyright (c) 2012 Rupil. All rights reserved.
//


#import "ReadZipPlugin.h"
#import "SSZipArchive.h"
#import "NSData+Base64.h"

@implementation ReadZipPlugin

@synthesize callbackID;

- (void)extract:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options
{    
    callbackID = [arguments pop];
    
    NSString *content = [arguments objectAtIndex:0];
    NSString *password = [arguments objectAtIndex:1];
    NSString *filename = [arguments objectAtIndex:2];
    BOOL base64 = [[arguments objectAtIndex:3] boolValue];

    NSData *fileContents;
    if (base64) {
        fileContents = [NSData dataFromBase64String:content];
    }
    else {
        fileContents = [content dataUsingEncoding: NSUTF8StringEncoding allowLossyConversion:FALSE];
    }

    NSString *zipPath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"readzip.zip"];
    NSString *txtPath = [NSTemporaryDirectory() stringByAppendingPathComponent:filename];

    [[NSFileManager defaultManager] createFileAtPath:zipPath contents:fileContents attributes:nil];    
    NSString *destination = NSTemporaryDirectory();
    
    
	
    CDVPluginResult *result;
    if([SSZipArchive unzipFileAtPath:zipPath toDestination:destination overwrite:YES password:password error:nil delegate:nil]) {
        NSError *err = nil;
        NSString *text = [NSString stringWithContentsOfFile:txtPath encoding:NSUTF8StringEncoding error:&err];
        if (nil != err) {
            result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Error with filename or password"];
            [self writeJavascript:[result toErrorCallbackString:callbackID]];       
        }

        
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:text];
        [self writeJavascript:[result toSuccessCallbackString:callbackID]];
    } else {
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Could not extract text"];
        [self writeJavascript:[result toErrorCallbackString:callbackID]];        
    }
}

@end