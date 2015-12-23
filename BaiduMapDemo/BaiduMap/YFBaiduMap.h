/**
 *
 快速自定义地图大头针的弹出气泡View
 
 使用方法
 1:
 self.baiduMap = [[YFBaiduMap alloc] init];
 
 2:
 self.baiduMap.YFDelegate = self;
 
 3:
 self.mapView.delegate = self.baiduMap;
 
 4:调用YFBaiduMapDelegate代理方法customCalloutViewWithView返回自定义的UIView
 */
#import <Foundation/Foundation.h>

@protocol YFBaiduMapDelegate <NSObject>
@optional

/**
 *  自定义的calloutView
 *
 *  @return 返回自定义的calloutView
 */
- (UIView *)customCalloutViewWithView;

@end


@interface YFBaiduMap : NSObject<BMKMapViewDelegate>

@property (nonatomic, weak)id<YFBaiduMapDelegate>YFDelegate;
/**
 *  纬度
 */
@property (nonatomic) CGFloat latitude;
/**
 *  经度
 */
@property (nonatomic) CGFloat longitude;
/**
 *  大头针的图片
 */
@property (nonatomic, strong) UIImage *pointImage;
/**
 *  弹出气泡的title
 */
@property (nonatomic, strong) NSString *calloutTitle;
/**
 *  弹出气泡的subtitle
 */
@property (nonatomic, strong) NSString *calloutSubtitle;

- (instancetype)initWithPointLatitude:(CGFloat)latitude pointLongitude:(CGFloat)longitude pointImage:(NSString *)pointImageStr calloutTitle:(NSString *)title calloutSubtitle:(NSString *)subtitle;
@end








