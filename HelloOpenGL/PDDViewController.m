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
#import "RWTRainbow.h"

#define kNumHillKeyPoints   10
#define kNumHillVertices    (kNumHillKeyPoints*2)

#define ARC4RANDOM_MAX      0xFFFFFFFFu

// gives a random number between two float values.
CGFloat RandomFloatRange(CGFloat min, CGFloat max) {
	return ((double)arc4random() / ARC4RANDOM_MAX) * (max - min) + min;
}

@import GLKit;

@interface PDDViewController ()

@end

@implementation PDDViewController {
    GLuint _vertextBuffer;
	GLuint _indexBuffer;
    RWTBaseEffect *_shader;
	GLsizei _indexCount;
	CGPoint _hillKeyPoints[kNumHillKeyPoints];   // define the array for the hill key points
	RWTVertex _hillVertices[kNumHillVertices];   // define the array for the hill vertices
	CGRect _rect;								 // define the area in which to render the hills
}

- (void)setupVertexBuffer {
	
	// 画渐变的矩形时候用的
//    const static RWTVertex vertices[] = {
//		{{1, -1, 0}, {1, 0, 0 ,1}},
//		{{1, 1, 0}, {0, 1, 0, 1}},
//		{{-1, 1, 0}, {0, 0, 1, 0}},
//		{{-1, -1, 0}, {0, 0, 0, 0}}
//    };
//
//	const static GLubyte indices[] = {
//		0, 1, 2,
//		2, 3, 0
//	};
//
//	_indexCount = sizeof(indices) / sizeof(indices[0]);
//
//    glGenBuffers(1, &_vertextBuffer);
//    glBindBuffer(GL_ARRAY_BUFFER, _vertextBuffer);
//    glBufferData(GL_ARRAY_BUFFER, sizeof(vertices), vertices, GL_STATIC_DRAW);
//
//	glGenBuffers(1, &_indexBuffer);
//	glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, _indexBuffer);
//	glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(indices), indices, GL_STATIC_DRAW);
	
	//
	_rect = CGRectMake(-1, -1, 2, 2);
	[self genetateHillKeyPoints];
	[self generateHillVertices];
	
	glGenBuffers(1, &_vertextBuffer);
	glBindBuffer(GL_ARRAY_BUFFER, _vertextBuffer);
	glBufferData(GL_ARRAY_BUFFER, sizeof(RWTVertex) * kNumHillVertices, _hillVertices, GL_STATIC_DRAW);
}

- (void)setupShader {
    _shader = [[RWTBaseEffect alloc] initWithVertexShader:@"RWTSimpleVertex.glsl" fragmentShader:@"RWTSimpleFragment.glsl"];
}

- (void)genetateHillKeyPoints {
	float x = _rect.origin.x;
	float y = _rect.origin.y;
	_hillKeyPoints[0] = CGPointMake(x, y);
	for (int i = 1; i < kNumHillKeyPoints - 1; i++) {
		x += _rect.size.width / (kNumHillKeyPoints - 1);
		y = RandomFloatRange(_rect.origin.y, _rect.origin.y + _rect.size.height);
		_hillKeyPoints[i] = CGPointMake(x, y);
	}
	_hillKeyPoints[kNumHillKeyPoints - 1] = CGPointMake(_rect.origin.x + _rect.size.width, _rect.origin.y);
}

- (void)setHillVertexAtIndex:(int)i x:(float)x y:(float)y r:(float)r g:(float)g b:(float)b a:(float)a {
	
	_hillVertices[i].Position[0] = x;
	_hillVertices[i].Position[1] = y;
	_hillVertices[i].Position[2] = 0;
	
	_hillVertices[i].Color[0] = r;
	_hillVertices[i].Color[1] = g;
	_hillVertices[i].Color[2] = b;
	_hillVertices[i].Color[3] = a;
	
	NSLog(@"Point %d: %0.2f %0.2f", i, x, y);
}

- (void)generateHillVertices {
	for (int i = 0; i < kNumHillKeyPoints; ++i) {
		float r, g, b;
		getRainbowColor((float)(kNumHillKeyPoints - i) / (float)kNumHillKeyPoints, &r, &g, &b);
		[self setHillVertexAtIndex:i * 2 x:_hillKeyPoints[i].x y:_hillKeyPoints[i].y r:r g:g b:b a:1];
		[self setHillVertexAtIndex:i * 2 + 1  x:_hillKeyPoints[i].x y:-1.0 r:r g:g b:b a:1];
	}
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
	
	// 画三角形的时候用的
//    glDrawArrays(GL_TRIANGLES, 0, 3);
	// 画渐变的矩形时候用的
//	glDrawElements(GL_TRIANGLES, _indexCount, GL_UNSIGNED_BYTE, 0);
	
	glDrawArrays(GL_TRIANGLE_STRIP, 0, kNumHillVertices);
	
    glDisable(RWTVertexAttribPosition);
	glDisable(RWTVertexAttribColor);
}

@end
