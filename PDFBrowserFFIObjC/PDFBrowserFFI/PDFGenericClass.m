//
//  PDFGenericClass.m
//  PDFBrowserFFI
//
//  Created by Abbie on 10/09/20.
//  Copyright © 2020 Abbie. All rights reserved.
//

#import "PDFGenericClass.h"
#import "PDFBrowserViewController.h"



@implementation PDFGenericClass

+ (id)sharedManager {
    static PDFGenericClass *sharedMyManager = nil;
        sharedMyManager = [[self alloc] init];
    return sharedMyManager;
}
- (void)launchPDFBrowserOnKonyForm{
        PDFBrowserViewController *pdfBrowser = [[PDFBrowserViewController alloc]init];
        UIWindow *window =  [[[UIApplication sharedApplication] windows] firstObject];
        UIViewController *vc = [window rootViewController];
    ////    UINavigationController *navController = (UINavigationController *)[[[UIApplication sharedApplication] keyWindow] rootViewController];
    ////    [navController pushViewController:webview animated:YES];
        [vc presentViewController:pdfBrowser animated:YES completion:nil];
    // [KonyUIContext onCurrentFormControllerPresentModalViewController:pdfBrowser animated:YES];
}

@end
