//
//  FCUTF8Char.m
//  UTF8Streamer
//
//  Created by Almer Lucke on 10/16/13.
//  Copyright (c) 2013 Farcoding. All rights reserved.
//

#import "FCUTF8Char.h"

//if ((byte1 >> 4) == 15) {
//    // 4 bytes
//    value |= byte1 & 0x7;
//    value <<= 6;
//    value |= _bytes[1] & 0x3F;
//    value <<= 6;
//    value |= _bytes[2] & 0x3F;
//    value <<= 6;
//    value |= _bytes[3] & 0x3F;
//} else if ((byte1 >> 5) == 7) {
//    // 3 bytes
//    value |= byte1 & 0xF;
//    value <<= 6;
//    value |= _bytes[1] & 0x3F;
//    value <<= 6;
//    value |= _bytes[2] & 0x3F;
//} else if ((byte1 >> 6) == 3) {
//    // 2 bytes
//    value |= byte1 & 0x1F;
//    value <<= 6;
//    value |= _bytes[1] & 0x3F;
//} else {
//    value = byte1;
//}


#define FCUTF8_CONTINUE_BYTES_MASK

@interface FCUTF8Char ()
{
    NSInteger _numBytes;
    uint8_t _bytes[4];
}
@end


@implementation FCUTF8Char

- (id)initWithBytes:(uint8_t *)bytes numBytes:(NSInteger)numBytes
{
    if ((self = [super init])) {
        if (numBytes > 4) return nil;
        
        _numBytes = numBytes;
        
        for (NSInteger i = 0; i < numBytes; i++) {
            _bytes[i] = bytes[i];
        }
    }
    
    return self;
}

- (id)initWithUnicodeCodePoint:(int32_t)codePoint
{
    if ((self = [super init])) {
        if (codePoint <= 0x7F) {
            // one byte
            _numBytes = 1;
            _bytes[0] = codePoint;
        } else if (codePoint <= 0x7FF) {
            // two bytes
            _numBytes = 2;
            _bytes[1] = (codePoint & 0x3F) | 0x80;
            codePoint >>= 6;
            _bytes[0] = codePoint | 0xC0;
        } else if (codePoint <= 0xFFFF) {
            // three bytes
            _numBytes = 3;
            _bytes[2] = (codePoint & 0x3F) | 0x80;
            codePoint >>= 6;
            _bytes[1] = (codePoint & 0x3F) | 0x80;
            codePoint >>= 6;
            _bytes[0] = codePoint | 0xE0;
        } else if (codePoint <= 0x1FFFFF) {
            // four bytes
            _numBytes = 4;
        } else {
            // only 4 bytes or less are supported
            self = nil;
        }
    }
    
    return self;
}

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

- (NSString *)string
{
    char uniCString[5];
    
    for (NSInteger i = 0; i < _numBytes; i++) {
        uniCString[i] = _bytes[i];
    }
    
    uniCString[_numBytes] = 0;
    
    return [[NSString alloc] initWithUTF8String:uniCString];
}

@end
