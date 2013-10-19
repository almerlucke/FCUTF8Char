//
//  main.m
//  UTF8Streamer
//
//  Created by Almer Lucke on 10/15/13.
//  Copyright (c) 2013 Farcoding. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FCUTF8Char.h"
#import "FCUTF8String.h"
#import "FCUTF8CharacterStream.h"


int main(int argc, const char * argv[])
{
    @autoreleasepool {
        NSString *str = @"Check it ®´¥ät!";
        NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
        FCUTF8CharacterStream *stream = [FCUTF8CharacterStream characterStreamWithData:data];
        NSError *error = nil;
        FCUTF8Char *character = [stream getCharacter:&error];
        
        while (character) {
            NSLog(@"%@", character);
            character = [stream getCharacter:&error];
        }
        
        if (error) {
            NSLog(@"error: %@", error);
        }
        
        NSLog(@"%@", [FCUTF8String stringWithSystemString:str]);
    }
    
    return 0;
}

