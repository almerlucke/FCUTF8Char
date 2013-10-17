//
//  FCUTF8Char.h
//  UTF8Streamer
//
//  Created by Almer Lucke on 10/16/13.
//  Copyright (c) 2013 Farcoding. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FCUTF8Char : NSObject

- (id)initWithBytes:(uint8_t *)bytes numBytes:(NSInteger)numBytes;
- (id)initWithUnicodeCodePoint:(int32_t)codePoint;

- (int32_t)unicodeCodePoint;
- (NSString *)UTF8String;
- (uint8_t *)bytes;
- (NSInteger)numBytes;

@end
