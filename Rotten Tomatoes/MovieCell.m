//
//  MovieCell.m
//  Rotten Tomatoes
//
//  Created by Peiqi Zheng on 9/14/14.
//  Copyright (c) 2014 Peiqi Zheng. All rights reserved.
//

#import "MovieCell.h"
#import "Utils.h"

@interface MovieCell ()
@property (weak, nonatomic) IBOutlet UIImageView *posterImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *synopsisLabel;


@end

@implementation MovieCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    UIView *view = [[UIView alloc] initWithFrame:self.frame];
    view.backgroundColor = [UIColor lightGrayColor];
    self.selectedBackgroundView = view;
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (void)setCell {
    [self.titleLabel setText:self.movie.title];
    NSString *html = [NSString stringWithFormat:@"<span class=\"synopsis\">%@</span>", self.movie.synopsis];
    NSString *styledHtml = [Utils styledHTMLwithHTML:html];
    NSAttributedString *attributedText = [Utils attributedStringWithHTML:styledHtml];
    self.synopsisLabel.attributedText = attributedText;

    [Utils loadImageUrl:self.movie.posterThumbUrl inImageView:self.posterImageView withAnimation:YES];
}

- (void)setMovie:(Movie *)movie {
    _movie = movie;
    [self setCell];
}

+ (NSString *)cellIdentifier {
    return @"MovieCell";
}

- (UIImage *)returnImage {
    return [self.posterImageView image];
}

@end
