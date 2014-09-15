//
//  Utils.h
//  Rotten Tomatoes
//
//  Created by Peiqi Zheng on 9/14/14.
//  Copyright (c) 2014 Peiqi Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Utils : NSObject

+ (void)loadImageUrl:(NSString *)url inImageView:(UIImageView *)imageView withAnimation:(BOOL)enableAnimation;
+ (NSString *)styledHTMLwithHTML:(NSString *)HTML;
+ (NSAttributedString *)attributedStringWithHTML:(NSString *)HTML;
@end