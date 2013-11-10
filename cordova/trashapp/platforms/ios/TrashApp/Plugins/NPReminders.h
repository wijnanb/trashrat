//
//  NPReminders.h
//  TrashApp
//
//  Created by Bert Wijnants on 10/11/13.
//
//

#import <Cordova/CDVPlugin.h>

@interface NPReminders : CDVPlugin

- (void)setReminders:(CDVInvokedUrlCommand*)command;

@end
