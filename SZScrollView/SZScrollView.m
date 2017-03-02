//
//  SZScrollView.m
//  SZScrollView
//
//  Created by 李然豪 on 17/3/2.
//  Copyright © 2017年 liranhao. All rights reserved.
//

#import "SZScrollView.h"

@implementation SZScrollView
{
    UIScrollView *_scrollView;
    UIImageView *_leftImg;
    UIImageView *_centerImg;
    UIImageView *_rightImg;
    
    int _currentIndex;
    
    NSArray *_imgArr;
    
    UIPageControl *pageControl;
    
    int _imageCount;
    
    NSTimer *_timer;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        
        return self;
    }
    
    return nil;
}
-(void)createHeadView:(NSArray *)imgArr{
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];

    _scrollView.contentOffset = CGPointMake(self.frame.size.width, 0.0);
    
    _currentIndex = 0;
    [self createImageView];
    pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 30, self.frame.size.width, 30)];
    [self addSubview:_scrollView];
    [self addSubview:pageControl];
    if (imgArr.count > 2) {
        _scrollView.contentSize = CGSizeMake(self.frame.size.width * imgArr.count, self.frame.size.height);
    }else{
        _scrollView.contentSize = CGSizeMake(self.frame.size.width * (imgArr.count + 1), self.frame.size.height);
    }
    
    
    _scrollView.pagingEnabled = YES;
    
    _scrollView.showsHorizontalScrollIndicator = NO;
    _imgArr = imgArr;
    
     _imageCount = (int)imgArr.count ;
    
    pageControl.numberOfPages = imgArr.count;
    
    pageControl.currentPage = (NSInteger)_currentIndex;
    
    pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    
    pageControl.currentPageIndicatorTintColor = [UIColor grayColor];
    pageControl.userInteractionEnabled = NO;
    
    _scrollView.delegate = self;
    
    
    [self setInfoByCurrentImageIndex:_currentIndex];
    
    if (imgArr.count > 1) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(didScroll) userInfo:nil repeats:YES];
    }
    
}
-(void)didScroll{
    
    CGPoint point;
    
    point = CGPointMake(_scrollView.contentOffset.x + _scrollView.frame.size.width, _scrollView.contentOffset.y);
    
    [_scrollView setContentOffset:point animated:YES];
    
}

-(void)createImageView{
    
    
    _leftImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    
    [_scrollView addSubview:_leftImg];
    _centerImg = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width, 0, self.frame.size.width, self.frame.size.height)];
    [_scrollView addSubview:_centerImg];
    
    _rightImg = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width * 2, 0, self.frame.size.width, self.frame.size.height)];
    [_scrollView addSubview:_rightImg];
    
}
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    [self reloadImage];
    
    _scrollView.contentOffset = CGPointMake(self.frame.size.width, 0.0);
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
     [self reloadImage];

    _scrollView.contentOffset = CGPointMake(self.frame.size.width, 0.0);
    
 }

- (void)reloadImage {
    CGPoint contentOffset = [_scrollView contentOffset];
    if (contentOffset.x > self.frame.size.width) { //向左滑动
        _currentIndex = (_currentIndex + 1) % _imageCount;
    } else if (contentOffset.x < self.frame.size.width) { //向右滑动
        _currentIndex = (_currentIndex - 1 + _imageCount) % _imageCount;
    }
    
    [self setInfoByCurrentImageIndex:_currentIndex];
}
- (void)setInfoByCurrentImageIndex:(NSUInteger)currentImageIndex {
    
    NSString *currentImageNamed = [_imgArr objectAtIndex:currentImageIndex];
    _centerImg.image = [UIImage imageNamed:currentImageNamed];
    
    _leftImg.image = [UIImage imageNamed:[_imgArr objectAtIndex:(currentImageIndex - 1 + _imageCount) % _imageCount]];
    
    _rightImg.image = [UIImage imageNamed:[_imgArr objectAtIndex:(currentImageIndex + 1) % _imageCount]];
    
    pageControl.currentPage = currentImageIndex;
    
}

@end
