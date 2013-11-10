//
//  Echo.m
//  TrashApp
//
//  Created by Bert Wijnants on 10/11/13.
//
//

#import "Echo.h"
#import <Cordova/CDV.h>

@implementation Echo

- (void)echo:(CDVInvokedUrlCommand*)command
{
    NSLog(@"native echo plugin");
    NSString* json = [command.arguments objectAtIndex:0];
    NSData *data = [json dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *error = nil;
    NSDictionary* dict = [NSJSONSerialization
                          JSONObjectWithData:data
                          options:kNilOptions
                          error:&error];
    
    NSArray* pickups = [dict objectForKey:@"pickups"];
    
    NSLog(@"pickups: %@", pickups);
    
    if(error) { NSLog(@"JSON malformed: %@", error); }
}

@end
