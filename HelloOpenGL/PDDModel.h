//
//  PDDModel.h
//  HelloOpenGL
//
//  Created by 郝一鹏 on 2018/1/13.
//  Copyright © 2018年 郝一鹏. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RWTVertex.h"
@import GLKit;
@class RWTBaseEffect;

@interface PDDModel : NSObject

- (instancetype)initWithName:(char *)name shader:(RWTBaseEffect *)shader vertices:(RWTVertex *)vertices vertexCount:(unsigned int)vertextCount indices:(GLbyte *)indices indexCount:(unsigned int)indexCount;

- (void)render;

@end
