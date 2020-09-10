//
//  PDFGenericClass.h
//  PDFBrowserFFI
//
//  Created by Abbie on 10/09/20.
//  Copyright © 2020 Abbie. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PDFGenericClass : NSObject

+ (id)sharedManager;
- (void)launchPDFBrowserOnKonyForm;

@end

NS_ASSUME_NONNULL_END
