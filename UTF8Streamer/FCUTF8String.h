//
//  FCUTF8String.h
//  UTF8Streamer
//
//  Created by Almer Lucke on 10/18/13.
//  Copyright (c) 2013 Farcoding. All rights reserved.
//

#import <Foundation/Foundation.h>


@class FCUTF8Char;


@interface FCUTF8String : NSObject

/**
 *  Get an NSString object
 */
@property (nonatomic, readonly) NSString *systemString;

/**
 *  Get the length of this FCUTF8String, length is expressed in number of UTF8Char objects
 */
@property (nonatomic, readonly) NSUInteger length;

/**
 *  Get an NSData object of this UTF8String containing the raw UTF-8 bytes
 */
@property (nonatomic, readonly) NSData *data;

/**
 *  Initialize a FCUTF8String with NSData
 *
 *  @param data
 *
 *  @return FCUTF8String
 */
- (id)initWithData:(NSData *)data;

/**
 *  Initialize a FCUTF8String with NSString
 *
 *  @param str NSString object
 *
 *  @return FCUTF8String
 */
- (id)initWithSystemString:(NSString *)str;

/**
 *  Class wrapper around initWithSystemData
 *
 *  @param data
 *
 *  @return FCUTF8String
 */
+ (FCUTF8String *)stringWithData:(NSData *)data;

/**
 *  Class wrapper around initWithSystemString
 *
 *  @param str
 *
 *  @return FCUTF8String
 */
+ (FCUTF8String *)stringWithSystemString:(NSString *)str;

/**
 *  Append raw UTF-8 data
 *
 *  @param data
 */
- (void)appendData:(NSData *)data;

/**
 *  Append an NSString object
 *
 *  @param string
 */
- (void)appendSystemString:(NSString *)string;

/**
 *  Add a FCUTF8Char to the end of string
 *
 *  @param character
 */
- (void)appendCharacter:(FCUTF8Char *)character;

/**
 *  Get a FCUTF8Char at a specific index
 *
 *  @param index
 *
 *  @return FCUTF8Char
 */
- (FCUTF8Char *)characterAtIndex:(NSUInteger)index;

/**
 *  Replace a FCUTF8Char at a specific index
 *
 *  @param character
 *  @param index
 */
- (void)replaceCharacterAtIndex:(NSUInteger)index withCharacter:(FCUTF8Char *)character;

/**
 *  Insert a FCUTF8Char at a specific index
 *
 *  @param character
 *  @param index     
 */
- (void)insertCharacter:(FCUTF8Char *)character atIndex:(NSUInteger)index;


@end
