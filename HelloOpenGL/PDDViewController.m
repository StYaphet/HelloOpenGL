//
//  PDDViewController.m
//  HelloOpenGL
//
//  Created by 郝一鹏 on 2018/1/7.
//  Copyright © 2018年 郝一鹏. All rights reserved.
//

#import "PDDViewController.h"
#import "RWTVertex.h"
#import "RWTBaseEffect.h"

@import GLKit;

@interface PDDViewController ()

@end

@implementation PDDViewController {
    GLuint _vertextBuffer;
	GLuint _indexBuffer;
    RWTBaseEffect *_shader;
	GLsizei _indexCount;
}

- (void)setupVertexBuffer {
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
	
	_indexCount = sizeof(indices) / sizeof(indices[0]);
	
    glGenBuffers(1, &_vertextBuffer);
    glBindBuffer(GL_ARRAY_BUFFER, _vertextBuffer);
    glBufferData(GL_ARRAY_BUFFER, sizeof(vertices), vertices, GL_STATIC_DRAW);
	
	glGenBuffers(1, &_indexBuffer);
	glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, _indexBuffer);
	glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(indices), indices, GL_STATIC_DRAW);
}

- (void)setupShader {
    _shader = [[RWTBaseEffect alloc] initWithVertexShader:@"RWTSimpleVertex.glsl" fragmentShader:@"RWTSimpleFragment.glsl"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
	GLKView *view = (GLKView *)self.view;
	view.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    
    [EAGLContext setCurrentContext:view.context];
    
    [self setupVertexBuffer];
    [self setupShader];
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
	glClearColor(0, 104.0/255.0, 55.0/255.0, 1.0);
	glClear(GL_COLOR_BUFFER_BIT);   
    [_shader prepareToDraw];
    
    glEnableVertexAttribArray(RWTVertexAttribPosition);
    glVertexAttribPointer(RWTVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, sizeof(RWTVertex), (const GLvoid *)offsetof(RWTVertex, Position));
	glEnableVertexAttribArray(RWTVertexAttribColor);
	glVertexAttribPointer(RWTVertexAttribColor, 4, GL_FLOAT, GL_FALSE, sizeof(RWTVertex), (const GLvoid *)offsetof(RWTVertex, Color));
	
	glBindBuffer(GL_ARRAY_BUFFER, _vertextBuffer);
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, _indexBuffer);
//    glDrawArrays(GL_TRIANGLES, 0, 3);
	glDrawElements(GL_TRIANGLES, _indexCount, GL_UNSIGNED_BYTE, 0);
	
    glDisable(RWTVertexAttribPosition);
	glDisable(RWTVertexAttribColor);
}

@end
