//
//  ViewController.m
//  PDFBrowserFFI
//
//  Created by Abbie on 10/09/20.
//  Copyright © 2020 Abbie. All rights reserved.
//

#import "ViewController.h"
#import "PDFGenericClass.h"

@interface ViewController ()
{
    PDFGenericClass *sharedPDFGeneric;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)invokeAction:(id)sender {
    sharedPDFGeneric = [PDFGenericClass sharedManager];
    [sharedPDFGeneric launchPDFBrowserOnKonyForm];
}


@end
