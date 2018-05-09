//
//  ViewController.m
//  objc_ex
//
//  Created by estgames on 2018. 5. 9..
//  Copyright © 2018년 estgames. All rights reserved.
//

#import "ViewController.h"
#import "objc_ex-Swift.h"

@interface ViewController ()

@end

@implementation ViewController
    EstTest * est;
- (void)viewDidLoad {
    [super viewDidLoad];
    est = [[EstTest alloc] initWithView:self];
    // Do any additional setup after loading the view, typically from a nib.
    //EstgamesCommon *test = [[EstgamesCommon] init];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)bannerShow:(id)sender {
    [est banerShow];
}
    
@end
