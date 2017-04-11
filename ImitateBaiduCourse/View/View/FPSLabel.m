
//
//  FPSLabel.m
//  ImitateBaiduCourse
//
//  Created by 巴巴罗萨 on 16/8/9.
//  Copyright © 2016年 豆梦霞. All rights reserved.
//

#import "FPSLabel.h"
#import "WeakProxy.h"
#import <CoreText/CoreText.h>
#define kSize CGSizeMake(55, 20)

@implementation FPSLabel

{
    CADisplayLink *_link;
    NSUInteger _count;
    NSTimeInterval _lastTime;
    UIFont *_font;
    UIFont *_subFont;
    NSTimeInterval _lll;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (frame.size.width == 0 && frame.size.width==0) {
        frame.size = kSize;
    }
    self = [super initWithFrame:frame];
    self.layer.cornerRadius = 5;
    self.clipsToBounds = YES;
    self.textAlignment = NSTextAlignmentCenter;
    self.userInteractionEnabled = NO;
    self.backgroundColor = [UIColor colorWithWhite:0.00 alpha:0.7f];
    _font = [UIFont fontWithName:@"Menlo" size:14];
    if (_font) {
        _subFont = [UIFont fontWithName:@"Menlo" size:4];
    } else {
        _font = [UIFont fontWithName:@"Courier" size:14];
        _subFont = [UIFont fontWithName:@"Courier" size:4];
    }
    _link = [CADisplayLink displayLinkWithTarget:[WeakProxy proxyWithTarget:self] selector:@selector(tick:)];
    [_link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    return self;
}

- (void)dealloc {
    [_link invalidate];
}

- (CGSize)sizeThatFits:(CGSize)size {
    return kSize;
}

- (void)tick:(CADisplayLink *)link {
    if (_lastTime==0) {
        _lastTime = link.timestamp;
        return;
    }
    _count ++;
    NSTimeInterval delta = link.timestamp - _lastTime;
    if (delta < 1) {
        return;
    }
    _lastTime = link.timestamp;
    float fps = _count / delta;
    _count = 0;
    CGFloat progress = fps / 60.0;
    UIColor *color = [UIColor colorWithHue:0.27 * (progress -0.2) saturation:1 brightness:0.9 alpha:1];
    //round 四舍五入函数
    //round：如果参数是小数，则求本身的四舍五入。
    //ceil：如果参数是小数，则求最小的整数但不小于本身.
    //floor：如果参数是小数，则求最大的整数但不大于本身.
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%d FPS",(int)round(fps)]];
    [text addAttribute:NSForegroundColorAttributeName  value:color range:NSMakeRange(0, text.length -3)];
    [text addAttribute:NSForegroundColorAttributeName  value:[UIColor whiteColor] range:NSMakeRange(text.length-3, 3)];
    [text addAttribute:NSFontAttributeName value:_font range:NSMakeRange(0, text.length)];
    //当fps为个位数的时候
    [text addAttribute:NSFontAttributeName value:_subFont range:NSMakeRange(text.length - 4, 1)];
    self.attributedText = text;
    
}




@end