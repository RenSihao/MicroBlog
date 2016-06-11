//
//  SHGeoModel.h
//  MicroBlog
//
//  Created by RenSihao on 16/4/12.
//  Copyright © 2016年 RenSihao. All rights reserved.
//

#import "SHModel.h"

/*
 地理信息（geo）
 返回值字段    	字段类型 	字段说明
 longitude    	string 	经度坐标
 latitude 	    string 	维度坐标
 city 	        string 	所在城市的城市代码
 province 	    string 	所在省份的省份代码
 city_name 	    string 	所在城市的城市名称
 province_name 	string 	所在省份的省份名称
 address 	    string 	所在的实际地址，可以为空
 pinyin 	    string 	地址的汉语拼音，不是所有情况都会返回该字段
 more 	        string 	更多信息，不是所有情况都会返回该字段
 */

@interface SHGeoModel : SHModel

@end
