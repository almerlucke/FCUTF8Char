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
 *   Get unicode 32 bit signed integer representation of the UTF-8 character
 */
@property (nonatomic, readonly) NSInteger unicodeCodePoint;

/**
 *  Get NSString representation of the UTF-8 character
 */
@property (nonatomic, readonly) NSString *UTF8String;

/**
 *  Get the bytes making up the UTF-8 character
 */
@property (nonatomic, readonly) char *bytes;

/**
 *  Get the number of bytes making up the UTF-8 character
 */
@property (nonatomic, readonly) NSInteger numBytes;


/**
 *  Initialize a FCUTF8Char object with a bytes array and the number (max 4) of bytes in the array
 *
 *  @param bytes    array of bytes
 *  @param numBytes number of bytes in the array
 *
 *  @return FCUTF8Char if not more than 4 bytes, otherwise nil
 */
- (id)initWithBytes:(char *)bytes numBytes:(NSInteger)numBytes;

/**
 *  Class wrapper around initWithBytes
 *
 *  @param bytes
 *  @param numBytes
 *
 *  @return FCUTF8Char
 */
+ (FCUTF8Char *)charWithBytes:(char *)bytes numBytes:(NSInteger)numBytes;

/**
 *  Initialize a FCUTF8Char object with a unicode code point
 *
 *  @param codePoint unicode code point integer
 *
 *  @return FCUTF8Char if code point is below 0x200000, otherwise nil
 */
- (id)initWithUnicodeCodePoint:(NSInteger)codePoint;

/**
 *  Class wrapper around initWithUnicodeCodePoint
 *
 *  @param codePoint
 *
 *  @return FCUTF8Char
 */
+ (FCUTF8Char *)charWithUnicodeCodePoint:(NSInteger)codePoint;

@end
