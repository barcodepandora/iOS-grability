//
//  ViewController.m
//  Xgrability
//
//  Created by Juan Manuel Moreno Beltran on 11/03/15.
//  Copyright (c) 2015 Uzupis. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://www.getpostman.com/collections/2a9f34a396ef5cd2822a"]];
    NSString *tu = [self parse:url];
    NSDictionary *myDict = [myParser objectWithString:tu];

// myDict tiene en el atributo request un array de dos elementos. Nos interesa el 2.
    //NSLog(@"DICT: %@", myDict);
    //NSLog(@"mi menu es es : %@", [(NSString *)myDict lowercaseString]);
    [self todo:myDict];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSString *)parse:(NSURL *)url {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    myParser = [[SBJsonParser alloc]init];
    
    dispatch_queue_t concurrentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    __block NSString * responseString = nil;
    dispatch_sync(concurrentQueue, ^{
        
        //NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://www.getpostman.com/collections/2a9f34a396ef5cd2822a"]];
        NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc]
                                           initWithURL:url
                                           cachePolicy:NSURLRequestReloadIgnoringCacheData
                                           timeoutInterval:10];
        [urlRequest setHTTPMethod:@"GET"];
        [urlRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        
        NSHTTPURLResponse * response = nil;
        NSError * error = nil;
        NSData * responseData = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&response error:&error];
        responseString = [[NSString alloc] initWithData:responseData encoding:NSASCIIStringEncoding];
        //NSLog(@"responseString: %@", responseString);
        //myText.text = responseString;
        
    });
    //NSLog(@"ok: %@", responseString);

    return responseString;
    
}

- (void)todo:(NSDictionary *)_dict{
    
    req = _dict[@"requests"];

    NSURL *url = [NSURL URLWithString:[(NSString *)[req objectAtIndex: 0][@"url"] lowercaseString]];
    NSString *tu = [self parse:url];
    myDict = [myParser objectWithString:tu];
    [menu1 setTitle:myDict[@"name"] forState:UIControlStateNormal];

    url = [NSURL URLWithString:[(NSString *)[req objectAtIndex: 1][@"url"] lowercaseString]];
    tu = [self parse:url];
    myDict = [myParser objectWithString:tu];
    //NSLog(@"Mi menu es: %@", myDict);
// myDict tiene todas las categorias. Cada categoria tiene subcategorias = platos
    
    int i = 0;
    piatti = [[NSMutableDictionary alloc] init];
    for (NSDictionary *status in myDict) { // Navegamos por categorias
        
        i++;
        switch(i) {
                
            case 1:
                [menu1 setTitle:[(NSString *)status[@"name"] uppercaseString] forState:UIControlStateNormal];
                break;
            case 2:
                [menu2 setTitle:[(NSString *)status[@"name"] uppercaseString] forState:UIControlStateNormal];
                break;
                
        }
            //[menu1 setTitle:[(NSString *)status[@"name"] uppercaseString] forState:UIControlStateNormal];

            NSMutableArray *platos = [[NSMutableArray alloc] init];
            for (NSDictionary *plato in status[@"subcategory"]) {
                
                [platos addObject:[(NSString *)plato[@"name"] uppercaseString]];
                NSLog(@"mi plato es : %@", [(NSString *)plato[@"name"] uppercaseString]);
                //myText.text = [NSString stringWithFormat:@"%@ %@ \r ", myText.text, [(NSString *)plato[@"name"] uppercaseString]];
            }
            [piatti setObject:platos forKey:[(NSString *)status[@"name"] uppercaseString]];
    }
}

- (IBAction)viewMenu1:(id)sender {

    NSMutableArray *platos = [piatti objectForKey:menu1.titleLabel.text];
    PiattiViewController *destinationController = [self.storyboard instantiateViewControllerWithIdentifier:@"Piatti"];
    //[[PiattiViewController alloc] init];
    for (NSString *plato in platos) {
        
        [destinationController setTu: [NSString stringWithFormat:@"%@ %@ \r ", [destinationController getTu], plato]];
        //NSLog(@"go : %@", destinationController.myText.text);
    }

    //[destinationController setTu:@"Anshie"];
    NSLog([destinationController getTu]);
    //destinationController.tu = @"Sandy";
    [self.navigationController pushViewController:destinationController animated:YES];
    //myText.text = [NSString stringWithFormat:@"%@ %@ \r ", myText.text, [(NSString *)plato[@"name"] uppercaseString]];
}

- (IBAction)viewMenu2:(id)sender {
    
    NSURL *url = [NSURL URLWithString:[(NSString *)[req objectAtIndex: 1][@"url"] lowercaseString]];
    NSString *tu = [self parse:url];
    myDict = [myParser objectWithString:tu];
    NSLog(@"MENU 2: %@", myDict);
    //[self todo:myDict];
}
@end
