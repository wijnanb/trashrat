//
//  Echo.h
//  TrashApp
//
//  Created by Bert Wijnants on 10/11/13.
//
//

#import <Cordova/CDVPlugin.h>

@interface Echo : CDVPlugin

- (void)echo:(CDVInvokedUrlCommand*)command;

@end
