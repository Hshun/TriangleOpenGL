//
//  ViewController.m
//  GLSample1
//
//  Created by zdc on 2015/03/08.
//  Copyright (c) 2015年 s_hirose. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    
    GLuint vertexBufferID;
    GLKView * glview;
    
}

@property (nonatomic, retain) GLKView *glview;
@property (nonatomic, strong) GLKBaseEffect * baseEffect;
@end


typedef struct  {
    
    GLKVector3 position;
    
} Vertex;

static const Vertex vertices[] = {

    {{-0.5, -0.5, 0.0}},
    {{0.5, -0.5, 0.0}},
    {{0.0, 0.5, 0.0}}

};


@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    self.glview = [[GLKView alloc] initWithFrame:self.view.bounds];
    
    // OpenGL ES 2.0
    self.glview.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    
    // Contextのセット
    [EAGLContext setCurrentContext:self.glview.context];
    
    
    [self.view addSubview:self.glview];
    self.glview.delegate = self;
    
    //BaseEffect
    self.baseEffect = [[GLKBaseEffect alloc] init];
    self.baseEffect.useConstantColor = GL_TRUE;
    self.baseEffect.constantColor = GLKVector4Make(1.0, 1.0, 1.0, 1.0);
    
    
    self.baseEffect.transform.projectionMatrix = GLKMatrix4MakeScale(1.0, self.glview.bounds.size.width/self.glview.bounds.size.height, 1.0); //アスペクト保持

    glClearColor(0.0, 0.0, 0.0, 1.0);
    
    
    glGenBuffers(1,  &vertexBufferID);
    
    glBindBuffer(GL_ARRAY_BUFFER,  vertexBufferID);
    
    glBufferData(GL_ARRAY_BUFFER, sizeof(vertices), vertices, GL_STATIC_DRAW);
    
    glBindBuffer(GL_ARRAY_BUFFER, 0);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect{


    [self.baseEffect prepareToDraw];
    
    glClear(GL_COLOR_BUFFER_BIT);
    
    glEnableVertexAttribArray(GLKVertexAttribPosition);
    
    glBindBuffer(GL_ARRAY_BUFFER, vertexBufferID);
    
    glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, sizeof(Vertex), 0);
    
    
    glDrawArrays(GL_TRIANGLES, 0, 3);
    

}




















@end







