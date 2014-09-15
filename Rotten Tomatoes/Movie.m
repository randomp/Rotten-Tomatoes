//
//  Movie.m
//  Rotten Tomatoes
//
//  Created by Peiqi Zheng on 9/14/14.
//  Copyright (c) 2014 Peiqi Zheng. All rights reserved.
//

#import "Movie.h"

@implementation Movie

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.title = dictionary[@"title"];
        self.mpaaRating = dictionary[@"mpaa_Rating"];
        self.synopsis = dictionary[@"synopsis"];
        self.posterThumbUrl = dictionary[@"posters"][@"thumbnail"];
        self.posterUrl = dictionary[@"posters"][@"original"];
        self.year = [dictionary[@"year"] intValue];
        self.criticsScore = [dictionary[@"ratings"][@"critics_score"] intValue];
        self.audienceScore = [dictionary[@"ratings"][@"audience_score"] intValue];
        self.cast = [self getCast:dictionary];
    }
    return self;
}

+ (NSArray *)getMovies:(id) object {
    NSMutableArray *movies = [[NSMutableArray alloc] init];
    for(NSDictionary *dictionary in object[@"movies"])
    {
        Movie *movie = [[Movie alloc] initWithDictionary:dictionary];
        [movies addObject:movie];
    }
    return [movies copy];
}

- (NSString *)getCast:(NSDictionary *) dictionary
{
    return [[dictionary[@"abridged_cast"] valueForKey:@"name"] componentsJoinedByString:@", "];
}

@end
