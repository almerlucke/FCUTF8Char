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


int main(int argc, const char * argv[])
{
    @autoreleasepool {
        FCUTF8String *utf8String = [[FCUTF8String alloc] initWithSystemString:@"Hello world!"];
        
        [utf8String appendCharacter:[FCUTF8Char charWithUnicodeCodePoint:0x24B62]];
        [utf8String appendCharacter:[FCUTF8Char charWithUnicodeCodePoint:0xA2]];
        [utf8String appendCharacter:[FCUTF8Char charWithUnicodeCodePoint:0x20AC]];
        [utf8String appendCharacter:[FCUTF8Char charWithUnicodeCodePoint:0x24]];
        [utf8String appendSystemString:@"Check it ∞å𤭢"];
        [utf8String replaceCharacterAtIndex:1 withCharacter:[FCUTF8Char charWithUnicodeCodePoint:0x20AC]];
        
        NSLog(@"%@", [utf8String systemString]);
    }
    
    return 0;
}

