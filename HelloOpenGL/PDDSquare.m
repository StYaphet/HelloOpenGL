//
//  PDDSquare.m
//  HelloOpenGL
//
//  Created by 郝一鹏 on 2018/1/14.
//  Copyright © 2018年 郝一鹏. All rights reserved.
//

#import "PDDSquare.h"

const static RWTVertex vertices[] = {
	{{1, -1, 0}, {1, 0, 0 ,1}},
	{{1, 1, 0}, {0, 1, 0, 1}},
	{{-1, 1, 0}, {0, 0, 1, 0}},
	{{-1, -1, 0}, {0, 0, 0, 0}}
};

const static GLubyte indices[] = {
	0, 1, 2,
	2, 3, 0
};

@implementation PDDSquare

- (instancetype)initWithShader:(RWTBaseEffect *)shader {
	self = [super initWithName:"suqare" shader:shader vertices:(RWTVertex *)vertices vertexCount:sizeof(vertices) / sizeof(vertices[0]) indices:(GLbyte *)indices indexCount:sizeof(indices) / sizeof(indices[0])];
	if (self) {
		
	}
	return self;
}

@end
