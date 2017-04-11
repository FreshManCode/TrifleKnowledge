//
//  UIImage+Common.h
//  xunpige
//
//  Created by william on 16/2/1.
//  Copyright © 2016年 陈威. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>


@interface UIImage (Common)

+(UIImage *)imageWithColor:(UIColor *)aColor;
-(UIImage *)imageWithColor:(UIColor * )color;
-(UIImage *)imageWithTintColor:(UIColor *)tintColor;
+(UIImage *)imageWithColor:(UIColor *)aColor withFrame:(CGRect)aFrame;
-(UIImage*)scaledToSize:(CGSize)targetSize;
-(UIImage*)scaledToSize:(CGSize)targetSize highQuality:(BOOL)highQuality;
-(UIImage*)scaledToMaxSize:(CGSize )size;
+ (UIImage *)fullResolutionImageFromALAsset:(ALAsset *)asset;
+ (UIImage *)fullScreenImageALAsset:(ALAsset *)asset;

//**生成组合图片*/
+ (UIImage *)combineImage:(UIImage *)image color:(UIColor *)color height:(CGFloat)height width:(CGFloat)width;
+ (UIImage *)subtractWithImage:(UIImage *)originalImage withScale:(CGSize)newSize;




/**
 生成图片
 @param color  图片颜色
 @param height 图片高度
 @return 生成的图片
 */
+ (UIImage*)GetImageWithColor:(UIColor*)color andHeight:(CGFloat)height;


/**
 修改图片透明度
 @param alpha 指定的透明度
 @return 修改后的图片
 */
- (UIImage*)imageByApplyingAlpha:(CGFloat)alpha;


/**
 给定图片修改图片颜色

 @param tintColor 要修改的颜色
 @param blendMode 方式
 @return 修改后的图片
 */
- (UIImage*)imageWithTintColor:(UIColor *)tintColor blendMode:(CGBlendMode)blendMode;



@end
