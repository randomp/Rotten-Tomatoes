//
//  Movie.h
//  Rotten Tomatoes
//
//  Created by Peiqi Zheng on 9/14/14.
//  Copyright (c) 2014 Peiqi Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Movie : NSObject
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *mpaaRating;
@property (nonatomic, strong) NSString *synopsis;
@property (nonatomic, strong) NSString *posterThumbUrl;
@property (nonatomic, strong) NSString *posterUrl;
@property NSInteger year;
@property NSInteger criticsScore;
@property NSInteger audienceScore;
@property (nonatomic, strong) NSString *cast;

- (id)initWithDictionary:(NSDictionary *) dictionary;
+ (NSArray *)getMovies:(id) object;

@end
