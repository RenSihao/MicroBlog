//
//  SHModel.h
//  MicroBlog
//
//  Created by RenSihao on 16/3/18.
//  Copyright © 2016年 RenSihao. All rights reserved.
//

#import <Foundation/Foundation.h>

/*************** Model基类 ****************/

@interface SHModel : NSObject

/**
 *  初始化Model
 *
 *  @param dict 需要解析的dict
 *
 *  @return 抽离出来的公用model
 */
-(instancetype)initWithDict:(NSDictionary *) dict;
@end
