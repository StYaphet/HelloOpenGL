//
//  PDDModel.m
//  HelloOpenGL
//
//  Created by 郝一鹏 on 2018/1/13.
//  Copyright © 2018年 郝一鹏. All rights reserved.
//

#import "PDDModel.h"
#import <OpenGLES/ES2/glext.h>
#import "RWTBaseEffect.h"

@implementation PDDModel {
	char *_name;
	GLuint _vertextBuffer;
	GLuint _indexBuffer;
	GLuint _vao;
	unsigned int _vertextCount;
	unsigned int _indexCount;
	RWTBaseEffect *_shader;
}

- (instancetype)initWithName:(char *)name shader:(RWTBaseEffect *)shader vertices:(RWTVertex *)vertices vertexCount:(unsigned int)vertextCount indices:(GLbyte *)indices indexCount:(unsigned int)indexCount {
	
	if ([super init]) {
		_name = name;
		_shader = shader;
		_vertextCount = vertextCount;
		_indexCount = indexCount;
		
		glGenVertexArraysOES(1, &_vao);
		glBindVertexArrayOES(_vao);
		
		glGenBuffers(1, &_vertextBuffer);
		glBindBuffer(GL_ARRAY_BUFFER, _vertextBuffer);
		glBufferData(GL_ARRAY_BUFFER, sizeof(RWTVertex) * _vertextCount, vertices, GL_STATIC_DRAW);
		
		glGenBuffers(1, &_indexBuffer);
		glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, _indexBuffer);
		glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(GLbyte) * _indexCount, indices, GL_STATIC_DRAW);
		
		// enable vertex attribute
		glEnableVertexAttribArray(RWTVertexAttribPosition);
		glVertexAttribPointer(RWTVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, sizeof(RWTVertex), (const GLvoid *)offsetof(RWTVertex, Position));
		glEnableVertexAttribArray(RWTVertexAttribColor);
		glVertexAttribPointer(RWTVertexAttribColor, 4, GL_FLOAT, GL_FALSE, sizeof(RWTVertex), (const GLvoid *)offsetof(RWTVertex, Color));
		
		glBindVertexArrayOES(0);
		glBindBuffer(GL_ARRAY_BUFFER, 0);
		glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, 0);
		
	}
	return self;
}

- (void)render {
	
	[_shader prepareToDraw];
	
	glBindVertexArrayOES(_vao);
	glDrawElements(GL_TRIANGLES, _indexCount, GL_UNSIGNED_BYTE, 0);
	glBindVertexArrayOES(0);
}

@end
