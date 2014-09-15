//
//  Utils.m
//  Rotten Tomatoes
//
//  Created by Peiqi Zheng on 9/14/14.
//  Copyright (c) 2014 Peiqi Zheng. All rights reserved.
//

#import "Utils.h"
#import "UIImageView+AFNetworking.h"

@implementation Utils

+ (void)loadImageUrl:(NSString *)url inImageView:(UIImageView *)imageView withAnimation:(BOOL)enableAnimation {
    NSURL *urlObject = [NSURL URLWithString:url];
    __weak UIImageView *iv = imageView;
    
    [imageView
     setImageWithURLRequest:[NSURLRequest requestWithURL:urlObject]
     placeholderImage:nil
     success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
         if (enableAnimation) {
             iv.alpha = 0.0;
             iv.image = image;
             [UIView animateWithDuration:0.5
                              animations:^{
                                  iv.alpha = 1.0;
                              }];
         } else {
             iv.image = image;
         }
     }
     failure:nil];
}

+ (NSString *)styledHTMLwithHTML:(NSString *)HTML {
    NSString *style = @"<meta charset=\"UTF-8\"><style> \
    body { \
    font-family: 'Cochin'; \
    } \
    span.title { \
    font-size: 15px; \
    font-weight: bold; \
    } \
    span.synopsis { \
    font-size: 12px; \
    color: #000; \
    } \
    span.scores { \
    font-size: 12px; \
    line-height: 20px; \
    color: #000; \
    } \
    span.synopsis-detail { \
    font-size: 12px; \
    line-height: 20px; \
    color: #000; \
    } \
    span.mppa { \
    color: #000; \
    font-size: 12px; \
    font-weight: bold; \
    margin-right: 5px; \
    border: 1px solid #000; \
    } \
    </style>";
    
    return [NSString stringWithFormat:@"%@%@", style, HTML];
}

+ (NSAttributedString *)attributedStringWithHTML:(NSString *)HTML {
    NSDictionary *options = @{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType };
    return [[NSAttributedString alloc] initWithData:[HTML dataUsingEncoding:NSUTF8StringEncoding] options:options documentAttributes:NULL error:NULL];
}


@end
