//
//  PDFPreviewControllerViewController.m
//  PDFBrowserFFI
//
//  Created by Abbie on 10/09/20.
//  Copyright © 2020 Abbie. All rights reserved.
//

#import "PDFPreviewControllerViewController.h"
#import <WebKit/WebKit.h>

@interface PDFPreviewControllerViewController ()<WKNavigationDelegate,WKUIDelegate>{
WKWebView *_pdfViewer;
}

@end

@implementation PDFPreviewControllerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _pdfViewer = [[WKWebView alloc] initWithFrame:CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height)];
    [_pdfViewer setAutoresizingMask: UIViewAutoresizingFlexibleWidth];
    NSString * base64EncodedString = _base64PDFString;
    NSData *data = [[NSData alloc]initWithBase64EncodedString:base64EncodedString options:NSDataBase64DecodingIgnoreUnknownCharacters];
     [_pdfViewer loadData:data MIMEType:@"application/pdf" characterEncodingName:@"UTF-8" baseURL:[NSURL URLWithString:@""]];
    NSLog(@"Product URL%@", base64EncodedString);
     [self.view addSubview:_pdfViewer];
    
    UIBarButtonItem *sendButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Send"
                                   style:UIBarButtonItemStyleDone
                                   target:self
                                   action:@selector(uploadAction:)];
    self.navigationItem.rightBarButtonItem = sendButton;
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Cancel"
                                   style:UIBarButtonItemStylePlain
                                   target:self
                                   action:@selector(cancelAction:)];
    self.navigationItem.leftBarButtonItem = cancelButton;
    NSLog(@"Preseenting View Controller%@", self.presentingViewController);
}



#pragma mark - Upload Action
 
   -(void)uploadAction:(UIBarButtonItem *)sender{
       NSLog(@"Upload Action");
       [self dismissViewControllerAnimated:YES completion:nil];
    }

#pragma mark - Cancel Action

  -(void)cancelAction:(UIBarButtonItem *)sender{
      NSLog(@"Cancel Action");
      [self dismissViewControllerAnimated:YES completion:nil];
   }

 - (void)viewWillDisappear:(BOOL)animated {
     [super viewWillDisappear:animated];
     [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
 }
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
