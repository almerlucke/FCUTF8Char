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
 *  Get a NSString object
 */
@property (nonatomic, readonly) NSString *systemString;


/**
 *  Initialize a FCUTF8String with NSString
 *
 *  @param str NSString object
 *
 *  @return FCUTF8String
 */
- (id)initWithSystemString:(NSString *)str;

/**
 *  Class wrapper around initWithSystemString
 *
 *  @param str
 *
 *  @return FCUTF8String
 */
+ (FCUTF8String *)stringWithSystemString:(NSString *)str;

/**
 *  Append a NSString object
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


@end
