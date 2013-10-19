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
        NSString *path = @"/Users/almerlucke/Desktop/test.txt";
        FCUTF8CharacterStream *stream = [[FCUTF8CharacterStream alloc] initWithFileAtPath:path];
        NSError *error = nil;
        FCUTF8Char *character = [stream getCharacter:&error];
        
        while (character) {
            NSLog(@"%@", character);
            character = [stream getCharacter:&error];
        }
        
        if (error) {
            NSLog(@"error: %@", error);
        }
        
        FCUTF8String *str = [FCUTF8String stringWithSystemString:@"Check it ®´¥ät!"];
        
        NSLog(@"%@", str);
    }
    
    return 0;
}

