//
//  ViewController.h
//  Xgrability
//
//  Created by Juan Manuel Moreno Beltran on 11/03/15.
//  Copyright (c) 2015 Uzupis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SBJson.h"
#import "PiattiViewController.h"

@interface ViewController : UIViewController {

    SBJsonParser *myParser;
    
    NSArray *req;
    NSDictionary *myDict;
    NSMutableDictionary *piatti;
    
    IBOutlet UIButton *menu1;
    IBOutlet UIButton *menu2;

    IBOutlet UITextView *myText;
}

- (IBAction)viewMenu1;

@end

