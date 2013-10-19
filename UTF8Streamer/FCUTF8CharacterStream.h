//
//  FCUTF8Stream.h
//  UTF8Streamer
//
//  Created by Almer Lucke on 10/16/13.
//  Copyright (c) 2013 Farcoding. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FCUTF8Char;

/**
 *  Get UTF-8 characters from an NSInputStream
 */
@interface FCUTF8CharacterStream : NSObject

/**
 *  Initialize a FCUTF8CharacterStream with a file path
 *
 *  @param filePath
 *
 *  @return FCUTF8CharacterStream
 */
- (id)initWithFileAtPath:(NSString *)filePath;

/**
 *  Initialize a FCUTF8CharacterStream with a NSData
 *
 *  @param data
 *
 *  @return FCUTF8CharacterStream
 */
- (id)initWithData:(NSData *)data;

/**
 *  Class wrapper around initWithFileAtPath
 *
 *  @param filePath
 *
 *  @return FCUTF8CharacterStream
 */
+ (FCUTF8CharacterStream *)characterStreamWithFileAtPath:(NSString *)filePath;

/**
 *  Class wrapper around initWithData
 *
 *  @param data
 *
 *  @return FCUTF8CharacterStream
 */
+ (FCUTF8CharacterStream *)characterStreamWithData:(NSData *)data;

/**
 *  Get a FCUTF8Char from the stream
 *
 *  @param error When this method returns nil, check if the error is set
 *
 *  @return FCUTF8Char or nil when end of stream is reached or an error occurred
 */
- (FCUTF8Char *)getCharacter:(NSError **)error;

@end
