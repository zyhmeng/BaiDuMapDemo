/**
 *
 快速自定义地图大头针的弹出气泡View
 
 使用方法：在baiduMapVC里面先设置相关代理，再完成相关代理的方法
 
 1: self.yfBaiduMapTool= [[YFBaiduMapTool alloc]init];
 
 2: self.yfBaiduMapTool.yfBaiduMapToolDelegate = self;

 3: self.mapView.delegate = self.yfBaiduMapTool;
 
 4: [self.yfBaiduMapViewShowDataList addObjects..];
 
 5: 调用YFBaiduMapToolDelegate代理方法customCalloutViewWithView返回自定义的UIView
 */
#import <Foundation/Foundation.h>
#import "YFBaiduMapModel.h"
@protocol YFBaiduMapToolDelegate <NSObject>
@optional

/**
 *  自定义的calloutView
 *
 *  @param object  自定义calloutView的数据模型
 *
 *  @return 自定义的calloutView
 */
- (UIView *)yfBaiDuMapCustomCalloutViewWith:(id)object;
/**
 *  选中地图大头针的callout调用此方法
 *
 *  @param object callout需要展示的数据模型
 */
- (void)yfBaiduMapSelectedCalloutView:(id)object;

/**
 *  显示大头针的位置
 *
 *  @param object 显示大头针的其他情况传入(相当于其他情况的扩展)
 *
 *  @return 要显示大头针的数据源
 */
- (NSMutableArray *)yfBaiduMapShowPinAnnotationWith:(id)object;
@end


@interface YFBaiduMapTool : NSObject<BMKMapViewDelegate>

@property (nonatomic, weak)id<YFBaiduMapToolDelegate>yfBaiduMapToolDelegate;
/**
 *  地图需要显示的大头针，paopaoView的数据源
 */
@property (nonatomic, strong) NSMutableArray *yfBaiduMapViewShowDataList;

@property (nonatomic, strong)YFBaiduMapModel *baiduMapModel;
@end








