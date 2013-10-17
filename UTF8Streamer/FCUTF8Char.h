//
//  FCUTF8Char.h
//  UTF8Streamer
//
//  Created by Almer Lucke on 10/16/13.
//  Copyright (c) 2013 Farcoding. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FCUTF8Char : NSObject

/**
 *  Initialize a FCUTF8Char object with a bytes array and the number (max 4) of bytes in the array
 *
 *  @param bytes    uint8_t array of bytes
 *  @param numBytes number of bytes in the array
 *
 *  @return FCUTF8Char if not more than 4 bytes, otherwise nil
 */
- (id)initWithBytes:(uint8_t *)bytes numBytes:(NSInteger)numBytes;

/**
 *  Initialize a FCUTF8Char object with a unicode code point
 *
 *  @param codePoint unicode code point integer
 *
 *  @return FCUTF8Char if code point is below 0x200000, otherwise nil
 */
- (id)initWithUnicodeCodePoint:(int32_t)codePoint;

/**
 *  Get unicode 32 bit signed integer representation of the UTF-8 character
 *
 *  @return int32_t unicode code point
 */
- (int32_t)unicodeCodePoint;

/**
 *  Get NSString representation of the UTF-8 character
 *
 *  @return NSString
 */
- (NSString *)UTF8String;

/**
 *  Get the bytes making up the UTF-8 character
 *
 *  @return uint8_t array
 */
- (uint8_t *)bytes;

/**
 *  Get the number of bytes making up the UTF-8 character
 *
 *  @return number of bytes
 */
- (NSInteger)numBytes;

@end
