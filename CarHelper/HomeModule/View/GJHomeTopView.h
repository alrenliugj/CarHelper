//
//  GJHomeTopView.h
//  CarHelper
//
//  Created by hsrd on 2018/7/13.
//  Copyright © 2018年 CAR. All rights reserved.
//

#import "GJBaseView.h"

@interface GJHomeTopView : GJBaseView
@property (nonatomic, copy) void (^blockSearch)(NSString *searchText);
+ (GJHomeTopView *)install;
- (CGFloat)searchHeight;
@end
