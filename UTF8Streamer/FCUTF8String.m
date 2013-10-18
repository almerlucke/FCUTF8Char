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
    if (character) {
        [_storage addObject:character];
    }
}


#pragma mark - Getters

- (NSUInteger)length
{
    return [_storage count];
}

- (NSData *)data
{
    NSInteger sizeInBytes = 0;
    char *cData = NULL;
    char *cDataPtr = NULL;
    
    // calculate size of buffer
    for (FCUTF8Char *character in _storage) {
        sizeInBytes += character.numBytes;
    }
    
    // try to get memory to store bytes
    cData = (char *)malloc(sizeInBytes * sizeof(char));
    cDataPtr = cData;
    
    // return if we couldn't get memory
    if (NULL == cData) return nil;
    
    // add bytes to buffer
    for (FCUTF8Char *character in _storage) {
        NSInteger numBytes = character.numBytes;
        memcpy(cDataPtr, character.bytes, numBytes);
        cDataPtr += numBytes;
    }
    
    // create NSData from buffer
    NSData *data = [NSData dataWithBytes:cData length:sizeInBytes];
    
    // free memory reserved
    free(cData);
    
    // return NSData
    return data;
}

- (NSString *)systemString
{
    return [[NSString alloc] initWithData:self.data encoding:NSUTF8StringEncoding];
}


#pragma mark - Utilities

- (FCUTF8Char *)characterAtIndex:(NSUInteger)index
{
    return [_storage objectAtIndex:index];
}

- (void)replaceCharacterAtIndex:(NSUInteger)index withCharacter:(FCUTF8Char *)character
{
    [_storage replaceObjectAtIndex:index withObject:character];
}

- (void)insertCharacter:(FCUTF8Char *)character atIndex:(NSUInteger)index
{
    [_storage insertObject:character atIndex:index];
}

@end
