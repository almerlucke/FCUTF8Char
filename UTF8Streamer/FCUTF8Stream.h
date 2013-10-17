//
//  FCUTF8Stream.h
//  UTF8Streamer
//
//  Created by Almer Lucke on 10/16/13.
//  Copyright (c) 2013 Farcoding. All rights reserved.
//

#import <Foundation/Foundation.h>

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

@interface FCUTF8Stream : NSObject

@end
