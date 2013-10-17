//
//  FCUTF8Char.m
//  UTF8Streamer
//
//  Created by Almer Lucke on 10/16/13.
//  Copyright (c) 2013 Farcoding. All rights reserved.
//

#import "FCUTF8Char.h"

/**
 *  Private FCUTF8Char interface
 */
@interface FCUTF8Char ()
{
    NSInteger _numBytes;
    uint8_t _bytes[4];
}
@end


@implementation FCUTF8Char


#pragma mark - Init Methods

- (id)initWithBytes:(uint8_t *)bytes numBytes:(NSInteger)numBytes
{
    if ((self = [super init])) {
        // only 4 bytes or less are supported
        if (numBytes > 4) return nil;
        
        _numBytes = numBytes;
        
        memcpy(_bytes, bytes, numBytes);
    }
    
    return self;
}

- (id)initWithUnicodeCodePoint:(int32_t)codePoint
{
    if ((self = [super init])) {
        if (codePoint < 0x80) {
            // 1 byte
            _numBytes = 1;
            _bytes[0] = codePoint;
        } else if (codePoint < 0x800) {
            // 2 bytes
            _numBytes = 2;
            _bytes[1] = (codePoint & 0x3F) | 0x80;
            codePoint >>= 6;
            _bytes[0] = codePoint | 0xC0;
        } else if (codePoint < 0x10000) {
            // 3 bytes
            _numBytes = 3;
            _bytes[2] = (codePoint & 0x3F) | 0x80;
            codePoint >>= 6;
            _bytes[1] = (codePoint & 0x3F) | 0x80;
            codePoint >>= 6;
            _bytes[0] = codePoint | 0xE0;
        } else if (codePoint < 0x200000) {
            // 4 bytes
            _numBytes = 4;
            _bytes[3] = (codePoint & 0x3F) | 0x80;
            codePoint >>= 6;
            _bytes[2] = (codePoint & 0x3F) | 0x80;
            codePoint >>= 6;
            _bytes[1] = (codePoint & 0x3F) | 0x80;
            codePoint >>= 6;
            _bytes[0] = codePoint | 0xF0;
        } else {
            // only 4 bytes or less are supported
            self = nil;
        }
    }
    
    return self;
}

#pragma mark - Inspection Methods

- (int32_t)unicodeCodePoint
{
    uint32_t value = 0;
    
    if (_numBytes == 4) {
        // 4 bytes
        value |= _bytes[0] & 0x7;
        value <<= 6;
        value |= _bytes[1] & 0x3F;
        value <<= 6;
        value |= _bytes[2] & 0x3F;
        value <<= 6;
        value |= _bytes[3] & 0x3F;
    } else if (_numBytes == 3) {
        // 3 bytes
        value |= _bytes[0] & 0xF;
        value <<= 6;
        value |= _bytes[1] & 0x3F;
        value <<= 6;
        value |= _bytes[2] & 0x3F;
    } else if (_numBytes == 2) {
        // 2 bytes
        value |= _bytes[0] & 0x1F;
        value <<= 6;
        value |= _bytes[1] & 0x3F;
    } else {
        // 1 byte
        value = _bytes[0];
    }
    
    return value;
}

- (NSInteger)numBytes
{
    return _numBytes;
}

- (uint8_t *)bytes
{
    return _bytes;
}

- (NSString *)UTF8String
{
    // 5 chars so last char is always zero terminator for c string
    char utf8CString[5] = {0, 0, 0, 0, 0};
    
    memcpy(utf8CString, _bytes, _numBytes);
    
    return [[NSString alloc] initWithUTF8String:utf8CString];
}

@end
