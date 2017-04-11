//
//  ColorfulPaintView.m
//  ImitateBaiduCourse
//
//  Created by 巴巴罗萨 on 2016/10/25.
//  Copyright © 2016年 豆梦霞. All rights reserved.
//

#import "ColorfulPaintView.h"
#import "ColorfulPaintStep.h"
@implementation ColorfulPaintView {
    NSMutableArray *_stepPoints;
    UISlider *_slider;
    UIColor  *_currentColor;
    
    
}

- (instancetype)init {
    if (self = [super init]) {
        [self initPaintViews];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initPaintViews];
        [self createWhitePaintView];
        [self createStrokeWithLineSlider];
    }
    return self;
}

- (void)initPaintViews {
    self.backgroundColor = [UIColor whiteColor];
    _stepPoints   = [[NSMutableArray alloc]init];
    _currentColor = [UIColor blackColor];
    [self createWhitePaintView];
    [self createStrokeWithLineSlider];
    
}

- (void)createWhitePaintView {
    //白板的view
    UIView *colorBoardView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, SCREENWIDTH, 20)];
    //色板样式
    colorBoardView.layer.borderWidth = 1;
    colorBoardView.layer.borderColor = [UIColor blackColor].CGColor;

    [self addSubview:colorBoardView];
    NSArray *colorsArray = [NSArray arrayWithObjects:
                            [UIColor blackColor],[UIColor redColor],[UIColor blueColor],
                            [UIColor greenColor],[UIColor yellowColor],[UIColor brownColor],
                            [UIColor orangeColor],[UIColor whiteColor],[UIColor orangeColor],
                            [UIColor purpleColor],[UIColor cyanColor],[UIColor lightGrayColor], nil];
    for (int i = 0;i<colorsArray.count;i++) {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake((SCREENWIDTH/colorsArray.count)*i, 0, SCREENWIDTH/colorsArray.count, 20)];
        [btn setBackgroundColor:colorsArray[i]];
        [btn addTarget:self action:@selector(changePaintColor:) forControlEvents:UIControlEventTouchUpInside];
        [colorBoardView addSubview:btn];
    }
}

- (void)changePaintColor:(UIButton *)sender {
    UIColor *currentColor = sender.backgroundColor;
    _currentColor = currentColor;
}

- (void)createStrokeWithLineSlider {
    if (!_slider) {
        _slider = [[UISlider alloc]initWithFrame:CGRectMake(0, 50, SCREENWIDTH, 20)];
        _slider.maximumValue = 20;
        _slider.minimumValue = 1;
    }
    [self addSubview:_slider];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    ColorfulPaintStep *paintStep = [[ColorfulPaintStep alloc]init];
    paintStep.color       = _currentColor.CGColor;
    paintStep.lineWidth   = _slider.value;
    paintStep.paintPoints = [[NSMutableArray alloc]init];
    [_stepPoints addObject:paintStep];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    //获得路径
    ColorfulPaintStep *paintStep = [_stepPoints lastObject];
    NSMutableArray *pathPoints = paintStep.paintPoints;
    CGPoint point =[[touches anyObject]locationInView:self];
    [pathPoints addObject:[NSValue valueWithCGPoint:point]];
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //渲染所有路径
    for (int i=0;i <_stepPoints.count;i++) {
        CGMutablePathRef path = CGPathCreateMutable();
        ColorfulPaintStep *pointStep = _stepPoints[i];
        for (int j=0; j < pointStep.paintPoints.count; j ++) {
            CGPoint point = [pointStep.paintPoints[j] CGPointValue];
            if (j ==0) {
                CGPathMoveToPoint(path, &CGAffineTransformIdentity, point.x, point.y);
            } else {
                CGPathAddLineToPoint(path, &CGAffineTransformIdentity, point.x, point.y);
            }
        }
        //设置path样式
        CGContextSetStrokeColorWithColor(ctx, pointStep.color);
        CGContextSetLineWidth(ctx, pointStep.lineWidth);

        //路径添加到ctx
        CGContextAddPath(ctx, path);
        CGContextStrokePath(ctx);
    }
}


@end
