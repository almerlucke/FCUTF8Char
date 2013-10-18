//
//  FCUTF8String.m
//  UTF8Streamer
//
//  Created by Almer Lucke on 10/18/13.
//  Copyright (c) 2013 Farcoding. All rights reserved.
//

#import "FCUTF8String.h"
#import "FCUTF8Char.h"

@interface FCUTF8String ()
{
    NSMutableArray *_storage;
}
@end


@implementation FCUTF8String

#pragma mark - Init

- (id)init
{
    if ((self = [super init])) {
        _storage = [NSMutableArray array];
    }
    
    return self;
}

- (id)initWithSystemString:(NSString *)str
{
    if ((self = [self init])) {
        [self appendSystemString:str];
    }
    
    return self;
}

+ (FCUTF8String *)stringWithSystemString:(NSString *)str
{
    return [[self alloc] initWithSystemString:str];
}


#pragma mark - Append

- (void)appendSystemString:(NSString *)string
{
    const char *utf8Sequence = [string UTF8String];
    
    while (*utf8Sequence != 0) {
        char byte1 = *utf8Sequence;
        if ((byte1 >> 4) == 15) {
            // 4 bytes
            [self appendCharacter:[FCUTF8Char charWithBytes:(char *)utf8Sequence numBytes:4]];
            utf8Sequence += 4;
        } else if ((byte1 >> 5) == 7) {
            // 3 bytes
            [self appendCharacter:[FCUTF8Char charWithBytes:(char *)utf8Sequence numBytes:3]];
            utf8Sequence += 3;
        } else if ((byte1 >> 6) == 3) {
            // 2 bytes
            [self appendCharacter:[FCUTF8Char charWithBytes:(char *)utf8Sequence numBytes:2]];
            utf8Sequence += 2;
        } else {
            // 1 byte
            [self appendCharacter:[FCUTF8Char charWithBytes:(char *)utf8Sequence numBytes:1]];
            utf8Sequence += 1;
        }
    }
}

- (void)appendCharacter:(FCUTF8Char *)character
{
    [_storage addObject:character];
}


#pragma mark - Getters

- (NSString *)systemString
{
    NSInteger sizeInBytes = 0;
    char *cString = NULL;
    char *cStringPtr = NULL;
    
    // calculate size of buffer
    for (FCUTF8Char *character in _storage) {
        sizeInBytes += character.numBytes;
    }
    
    // add 1 byte extra for null terminator char
    cString = (char *)malloc(sizeInBytes * sizeof(char) + 1);
    cStringPtr = cString;
    
    // return if we couldn't get memory
    if (NULL == cString) return nil;
    
    // add bytes to buffer
    for (FCUTF8Char *character in _storage) {
        NSInteger numBytes = character.numBytes;
        memcpy(cStringPtr, character.bytes, numBytes);
        cStringPtr += numBytes;
    }
    
    // set null terminator character
    *cStringPtr = 0;
    
    // create NSString from buffer
    NSString *str = [[NSString alloc] initWithUTF8String:cString];
    
    // free memory reserved
    free(cString);
    
    // return NSString
    return str;
}

@end
