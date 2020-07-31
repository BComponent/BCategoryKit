//
//  BViewController.m
//  BCategoryKit
//
//  Created by wangbaoming on 07/30/2020.
//  Copyright (c) 2020 wangbaoming. All rights reserved.
//

#import "BViewController.h"
#import <SWQRCodeViewController.h>

@interface BViewController ()

@end

@implementation BViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    UIButton * scanButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:scanButton];
    [scanButton setTitle:@"扫一扫" forState:UIControlStateNormal];
    scanButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [scanButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [scanButton setBackgroundColor:[UIColor redColor]];
   
    [scanButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    scanButton.frame = CGRectMake(100, 100, 50, 50);
    
   
}
- (void)buttonAction:(UIButton *)sender
   {
       SWQRCodeConfig *config = [[SWQRCodeConfig alloc]init];
       config.scannerCornerColor = [UIColor redColor];
       config.scannerBorderColor = [UIColor redColor];
       config.scannerType = SWScannerTypeBoth;
       
       SWQRCodeViewController *qrcodeVC = [[SWQRCodeViewController alloc]init];
       qrcodeVC.codeConfig = config;
       
       qrcodeVC.block = ^(NSString *baseUrl) {
          
           
       };
       
       [self presentViewController:qrcodeVC animated:YES completion:nil];
   }
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
