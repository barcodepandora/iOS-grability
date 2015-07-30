//
//  PiattiViewController.m
//  Xgrability
//
//  Created by Juan Manuel Moreno Beltran on 11/03/15.
//  Copyright (c) 2015 Uzupis. All rights reserved.
//

#import "PiattiViewController.h"

@interface PiattiViewController ()

@end

@implementation PiattiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.love.text = [self getTu];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSString *)getTu {
    return tu;
}

- (void)setTu:(NSString *)newValue {
    tu = newValue;
}

@end
