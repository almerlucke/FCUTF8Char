//
//  FCUTF8Stream.m
//  UTF8Streamer
//
//  Created by Almer Lucke on 10/16/13.
//  Copyright (c) 2013 Farcoding. All rights reserved.
//

#import "FCUTF8CharacterStream.h"
#import "FCUTF8Char.h"


@interface FCUTF8CharacterStream ()
{
    NSInputStream *_inputStream;
    
    // we buffer calls to input stream read, keep track of buffer
    uint8_t *_buffer;
    uint8_t *_bufferPtr;
    NSUInteger _bufferSize;
    NSUInteger _bytesAvailable;
}
@end


@implementation FCUTF8CharacterStream

#pragma mark - Init

- (void)dealloc
{
    if (NULL != _buffer) free(_buffer);
    
    if (_inputStream.streamStatus != NSStreamStatusClosed) {
        [_inputStream close];
    }
}

- (id)init
{
    if ((self = [super init])) {
        _bytesAvailable = 0;
        _bufferSize = 12;
        _buffer = (uint8_t *)malloc(sizeof(uint8_t) * _bufferSize);
        _bufferPtr = _buffer;
        if (NULL == _buffer) self = nil;
    }
    
    return self;
}

- (id)initWithFileAtPath:(NSString *)filePath
{
    if ((self = [self init])) {
        _inputStream = [[NSInputStream alloc] initWithFileAtPath:filePath];
        if (!_inputStream) self = nil;
        else {
            [_inputStream open];
            if (_inputStream.streamStatus != NSStreamStatusOpen) {
                self = nil;
            }
        }
    }
    
    return self;
}

- (id)initWithData:(NSData *)data
{
    if ((self = [self init])) {
        _inputStream = [[NSInputStream alloc] initWithData:data];
        if (!_inputStream) self = nil;
        else {
            [_inputStream open];
            if (_inputStream.streamStatus != NSStreamStatusOpen) {
                self = nil;
            }
        }
    }
    
    return self;
}

+ (FCUTF8CharacterStream *)characterStreamWithFileAtPath:(NSString *)filePath
{
    return [[self alloc] initWithFileAtPath:filePath];
}

+ (FCUTF8CharacterStream *)characterStreamWithData:(NSData *)data
{
    return [[self alloc] initWithData:data];
}

#pragma mark - Get Characters

- (uint8_t)_getc:(BOOL *)finished
{
    if ((_bufferPtr - _buffer) >= _bytesAvailable) {
        _bytesAvailable = [_inputStream read:(uint8_t *)_buffer maxLength:_bufferSize];
        _bufferPtr = _buffer;
    }
    
    if (_bytesAvailable == 0) {
        if (finished) *finished = YES;
        return 0;
    }
    
    return *_bufferPtr++;
}

- (FCUTF8Char *)getCharacter:(NSError **)error
{
    uint8_t bytes[4];
    uint8_t byte;
    NSInteger numBytes;
    BOOL finished = NO;
    
    bytes[0] = byte = [self _getc:&finished];
    
    if (finished) return nil;
    
    if ((byte >> 4) == 15) {
        // 4 bytes
        numBytes = 4;
        bytes[1] = [self _getc:&finished];
        bytes[2] = [self _getc:&finished];
        bytes[3] = [self _getc:&finished];
        if (finished) {
            if (error) {
                *error = [NSError errorWithDomain:@"com.farcoding.FCUTF8CharacterStream"
                                             code:1
                                         userInfo:@{NSLocalizedDescriptionKey : @"Incomplete UTF-8 character sequence"}];
            }
            
            return nil;
        }
    } else if ((byte >> 5) == 7) {
        // 3 bytes
        numBytes = 3;
        bytes[1] = [self _getc:&finished];
        bytes[2] = [self _getc:&finished];
        if (finished) {
            if (error) {
                *error = [NSError errorWithDomain:@"com.farcoding.FCUTF8CharacterStream"
                                             code:1
                                         userInfo:@{NSLocalizedDescriptionKey : @"Incomplete UTF-8 character sequence"}];
            }
            
            return nil;
        }
    } else if ((byte >> 6) == 3) {
        // 2 bytes
        numBytes = 2;
        bytes[1] = [self _getc:&finished];
        if (finished) {
            if (error) {
                *error = [NSError errorWithDomain:@"com.farcoding.FCUTF8CharacterStream"
                                             code:1
                                         userInfo:@{NSLocalizedDescriptionKey : @"Incomplete UTF-8 character sequence"}];
            }
            
            return nil;
        }
    } else if ((byte >> 7) == 0) {
        // 1 byte
        numBytes = 1;
    } else {
        if (error) {
            *error = [NSError errorWithDomain:@"com.farcoding.FCUTF8CharacterStream"
                                         code:1
                                     userInfo:@{NSLocalizedDescriptionKey : @"Invalid UTF-8 character sequence"}];
        }
        
        return nil;
    }

    return [FCUTF8Char charWithBytes:bytes numBytes:numBytes];
}


@end
