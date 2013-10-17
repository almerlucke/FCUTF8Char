//
//  main.m
//  UTF8Streamer
//
//  Created by Almer Lucke on 10/15/13.
//  Copyright (c) 2013 Farcoding. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FCUTF8Char.h"



int main(int argc, const char * argv[])
{
    @autoreleasepool {
        uint8_t bytes[1] = {0x24};
        FCUTF8Char *utf8Char = [[FCUTF8Char alloc] initWithUnicodeCodePoint:0x20AC];
        
        // insert code here...
        NSLog(@"Hello, World! %@ %x %d", [utf8Char string], [utf8Char unicodeCodePoint], 0x20AC);
        
        
        
    }
    return 0;
}

