//
//  NPReminders.m
//  TrashApp
//
//  Created by Bert Wijnants on 10/11/13.
//
//

#import "NPReminders.h"
#import <Cordova/CDV.h>

@implementation NPReminders

- (void)setReminders:(CDVInvokedUrlCommand*)command
{
    NSLog(@"native reminders plugin");
    
    NSString* echo = [command.arguments objectAtIndex:0];
}

@end
