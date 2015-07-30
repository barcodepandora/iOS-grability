//
//  PiattiViewController.h
//  Xgrability
//
//  Created by Juan Manuel Moreno Beltran on 11/03/15.
//  Copyright (c) 2015 Uzupis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"

@interface PiattiViewController : UIViewController {

    NSMutableArray *platos;
    NSString *tu;
}
@property (strong, nonatomic) IBOutlet UITextView *love;

- (NSString *)getTu;

- (void)setTu:(NSString *)newValue;

@end
