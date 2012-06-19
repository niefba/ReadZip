//
//  ReadZipPlugin.h
//  ReadZip
//
//  Created by Fabien Tillon on 18/06/12.
//  Copyright (c) 2012 Rupil. All rights reserved.
//

#import <Cordova/CDVPlugin.h>
#import "SSZipArchive.h"

@interface ReadZipPlugin : CDVPlugin
{
    NSString *callbackID;
}

@property (nonatomic, copy) NSString* callbackID;

- (void)extract:(NSMutableArray*)arguments withDict:(NSMutableDictionary*)options;

@end
