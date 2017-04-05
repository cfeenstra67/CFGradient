//
//  CFViewController.m
//  CFGradient
//
//  Created by cfeenstra67 on 04/04/2017.
//  Copyright (c) 2017 cfeenstra67. All rights reserved.
//

#import "CFViewController.h"
#import <CFGradient/CFGradient.h>

@interface CFViewController (){
    CFGradientView *layer;
    UISlider *slider;
}

@end

@implementation CFViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    layer=[[CFGradientView alloc] initWithType:AxialGradient];
    layer.frame=self.view.bounds;
    layer.startPoint=CGPointMake(0, 0);
    layer.endPoint=CGPointMake(0, 1);
    layer.startColor=[[UIColor redColor] colorWithAlphaComponent:.75];
    layer.endColor=[UIColor blackColor];
    layer.curveConstant=0.5f;
    [self.view addSubview:layer];
    
    slider=[[UISlider alloc] initWithFrame:self.view.bounds];
    [slider addTarget:self action:@selector(sliderValueChange:) forControlEvents:UIControlEventValueChanged];
    slider.minimumValue=0.0f;
    slider.maximumValue=1.0f;
    [self.view addSubview:slider];
    
    UIButton *button=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 64)];
    [button setTitle:@"Animate" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor whiteColor]];
    [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    button.center=CGPointMake(self.view.center.x, self.view.center.y-100.0f);
    [self.view addSubview:button];
	// Do any additional setup after loading the view, typically from a nib.
}

-(void)sliderValueChange:(UISlider*)slide{
    layer.curveConstant=slide.value;
}

-(void)buttonPressed:(id)sender{
    [UIView animateWithDuration:1 animations:^{
        layer.curveConstant=0.0f;
        slider.value=0.0f;
    } completion:^(BOOL finished){
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
