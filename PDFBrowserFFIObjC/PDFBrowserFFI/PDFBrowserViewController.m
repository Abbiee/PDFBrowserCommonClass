//
//  PDFBrowserViewController.m
//  PDFBrowserFFI
//
//  Created by Abbie on 10/09/20.
//  Copyright © 2020 Abbie. All rights reserved.
//

#import "PDFBrowserViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "PDFPreviewControllerViewController.h"

@interface PDFBrowserViewController ()<UIDocumentPickerDelegate,UITableViewDelegate, UITableViewDataSource>
{
    NSArray *tableData;
    UITableView *tableView;
}

@end

@implementation PDFBrowserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    tableData = [NSArray arrayWithObjects:@"Files App",nil];
    tableView=[[UITableView alloc]init];
    tableView.frame = CGRectMake(0,70,self.view.frame.size.width,self.view.frame.size.height);
    tableView.dataSource=self;
    tableView.delegate=self;
    tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"SimpleTableItem"];
    [tableView reloadData];
    [self.view addSubview:tableView];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self
               action:@selector(closeSelectScreen:)
     forControlEvents:UIControlEventTouchUpInside];
    UIImage *btnImage = [UIImage imageNamed:@"Close"];
    [button setImage:btnImage forState:UIControlStateNormal];
    button.frame = CGRectMake(self.view.frame.size.width - 60, 30, 35, 35);
    [self.view addSubview:button];
}


-(void) closeSelectScreen:(UIButton*)sender
 {
     [self dismissViewControllerAnimated:YES completion:nil];
 }

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
 
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
 
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
 
    cell.textLabel.text = [tableData objectAtIndex:indexPath.row];
    cell.imageView.image = [UIImage imageNamed:@"Folder"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)viewDidAppear:(BOOL)animated
{
     [super viewDidAppear:animated];
     
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // Do any additional setup after loading the view.
    NSArray *types = @[(NSString*)kUTTypePDF];
    //Create a object of document picker view and set the mode to Import
    UIDocumentPickerViewController *docPicker = [[UIDocumentPickerViewController alloc] initWithDocumentTypes:types inMode:UIDocumentPickerModeImport];
    //Set the delegate
    docPicker.delegate = self;
    //present the document picker
    [self presentViewController:docPicker animated:YES completion:nil];
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 60)];
    /* Create custom view to display section header... */
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, tableView.frame.size.width, 40)];
    [label setFont:[UIFont boldSystemFontOfSize:25]];
    label.textColor = [UIColor blackColor];
     NSString *string = @"Browse and Upload your file";
    /* Section header is in 0th index... */
    [label setText:string];
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(10,label.frame.size.height, tableView.frame.size.width, 20)];
    [label2 setFont:[UIFont italicSystemFontOfSize:15]];
    label2.textColor = [UIColor grayColor];
    NSString *string2 = @"Select Files App to browse your PDF.";
    [label2 setText:string2];
    [view addSubview:label];
    [view addSubview:label2];
    [view setBackgroundColor:[UIColor whiteColor]]; //your background color...
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 10, tableView.frame.size.width, 20)];
    /* Create custom view to display section header... */
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, tableView.frame.size.width, 20)];
    [label setFont:[UIFont italicSystemFontOfSize:15]];
    label.textColor = [UIColor grayColor];
     NSString *string = @"**Note: Only PDF files are supported and can be uploaded.";
    /* Section header is in 0th index... */
    [label setText:string];
    [view addSubview:label];
    [view setBackgroundColor:[UIColor whiteColor]]; //your background color...
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 100;
}
#pragma mark Delegate-UIDocumentPickerViewController

/**
 *  This delegate method is called when user will either upload or download the file.
 *
 *  @param controller UIDocumentPickerViewController object
 *  @param url        url of the file
 */

- (void)documentPicker:(UIDocumentPickerViewController *)controller didPickDocumentAtURL:(NSURL *)url
{
    if (controller.documentPickerMode == UIDocumentPickerModeImport)
    {
        NSLog(@"%@", url);
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        [request setHTTPMethod:@"HEAD"];
       [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * data, NSURLResponse * response, NSError * error) {
       long long size = [response expectedContentLength];
       NSLog(@"File Size%lld",size);
        }] resume];
        NSData *fileData = [NSData dataWithContentsOfURL:url];
        NSString *pdfBaseString = [fileData base64EncodedStringWithOptions:0];
        NSLog(@"Base 64 sting%@", pdfBaseString);
        NSLog(@"Byte Length%@", [[NSByteCountFormatter new] stringFromByteCount:fileData.length]);
        long long filedata2 = fileData.length;
        NSLog(@"File 2Size%lld",filedata2);
        if (filedata2 > 2097152 ) {
            NSLog(@"Greater than 2 MB");
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Alert" message:@"PDF file should be less than 2 MB" preferredStyle:UIAlertControllerStyleAlert];

            UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                                    //button click event
                                }];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
            [alert addAction:cancel];
            [alert addAction:ok];
            [self presentViewController:alert animated:YES completion:nil];
            
        } else {
        PDFPreviewControllerViewController *webview = [[PDFPreviewControllerViewController alloc]init];
        webview.base64PDFString = pdfBaseString;
        UINavigationController *navigationController =
          [[UINavigationController alloc] initWithRootViewController:webview];
        //now present this navigation controller modally
        [self presentViewController:navigationController
                         animated:YES
                         completion:^{

                              }];
        }
    }
    
}

/**
 *  Delegate called when user cancel the document picker
 *
 *  @param controller - document picker object
 */
- (void)documentPickerWasCancelled:(UIDocumentPickerViewController *)controller {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
