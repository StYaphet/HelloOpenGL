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
#import <OpenGLES/ES2/glext.h>
#import "PDDSquare.h"

@import GLKit;

@interface PDDViewController ()

@end

@implementation PDDViewController {
	RWTBaseEffect *_shader;
	PDDSquare *_square;
}

- (void)setupScene {
    _shader = [[RWTBaseEffect alloc] initWithVertexShader:@"RWTSimpleVertex.glsl" fragmentShader:@"RWTSimpleFragment.glsl"];
	_square = [[PDDSquare alloc] initWithShader:_shader];
}

- (void)viewDidLoad {
    [super viewDidLoad];
	GLKView *view = (GLKView *)self.view;
	view.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    
    [EAGLContext setCurrentContext:view.context];
	
    [self setupScene];
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
	glClearColor(0, 104.0/255.0, 55.0/255.0, 1.0);
	glClear(GL_COLOR_BUFFER_BIT);
	
	[_square render];
}

@end
