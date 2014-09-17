//
//  MovieViewController.m
//  Rotten Tomatoes
//
//  Created by Peiqi Zheng on 9/15/14.
//  Copyright (c) 2014 Peiqi Zheng. All rights reserved.
//

#import "MovieViewController.h"
#import "Utils.h"
#import "Pop.h"
#import "UIImage+ImageEffects.h"

@interface MovieViewController () {
    BOOL expand;
}


@property (weak, nonatomic) IBOutlet UITextView *movieTextView;
@property (weak, nonatomic) IBOutlet UIImageView *bgUIImageView;
@property (weak, nonatomic) IBOutlet UIImageView *blurredImageView;
@property (strong, nonatomic) Movie *movie;

@end

@implementation MovieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = self.movie.title;
    self.bgUIImageView.image = self.preloadImage;
    [Utils loadImageUrl:self.movie.posterUrl inImageView:self.bgUIImageView withAnimation:NO];
    
    NSString *html = [NSString stringWithFormat:@"\
                      <span class=\"title\">%@ (%i)</span><br> \
                      <span class=\"scores\">Critics Score: %i, Audience Score: %i</span><br> \
                      <span class=\"mppa\">%@</span><br><br> \
                      <span class=\"synopsis-detail\">%@</span>",
                      self.movie.title,
                      self.movie.year,
                      self.movie.criticsScore,
                      self.movie.audienceScore,
                      self.movie.mpaaRating,
                      self.movie.synopsis];
    NSString *styledHtml = [Utils styledHTMLwithHTMLForMovieDetail:html];
    NSAttributedString *attributedText = [Utils attributedStringWithHTML:styledHtml];
    self.movieTextView.backgroundColor = [UIColor blackColor];
    self.movieTextView.alpha = 0.75;
    self.movieTextView.attributedText = attributedText;
    self.movieTextView.scrollEnabled = YES;
    
    self.blurredImageView.image = [self.bgUIImageView.image copy];
    self.blurredImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.blurredImageView.image applyBlurWithRadius:50 tintColor:[UIColor colorWithWhite:1 alpha:0.2] saturationDeltaFactor:1.5 maskImage:nil];
    self.blurredImageView.alpha = 0.9;
    self.blurredImageView.hidden = YES;
    expand = YES;
}

- (IBAction)tapText:(id)sender {
    [self addBoundsSpringAnimationToView:self.movieTextView];
}

- (void) addBoundsSpringAnimationToView:(UITextView *)textView {
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerBounds];
    if (expand) {
        self.bgUIImageView.hidden = YES;
        self.blurredImageView.hidden = NO;
        anim.toValue = [NSValue valueWithCGRect:CGRectMake(0, 0.0f, 320.0f, 807.0f)];
        anim.springBounciness = 18;
    } else {
        self.bgUIImageView.hidden = NO;
        self.blurredImageView.hidden = YES;
        anim.toValue = [NSValue valueWithCGRect:CGRectMake(0, 355.0f, 320.0f, 225.0f)];
    }
    expand = !expand;
    anim.springSpeed = 10;
    [textView pop_addAnimation:anim forKey:@"popBounds"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (id) initWithMovie:(Movie *) movie
{
    self = [super init];
    if (self) {
        self.movie = movie;
    }
    return self;
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
