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
        FCUTF8Char *utf8Char = [[FCUTF8Char alloc] initWithUnicodeCodePoint:0x24B62];
        
        // insert code here...
        NSLog(@"Hello, World! %@ %x %d", utf8Char.UTF8String, (unsigned int)utf8Char.unicodeCodePoint, 0x24B62);
        
        
        
    }
    return 0;
}

