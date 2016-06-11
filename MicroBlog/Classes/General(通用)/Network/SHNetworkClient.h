//
//  SHNetworkClient.h
//  MicroBlog
//
//  Created by RenSihao on 16/4/5.
//  Copyright © 2016年 RenSihao. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifdef DEBUG
#define SHAppLog(s, ... ) NSLog( @"[%@ in line %d] ===============>%@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
#else
#define SHAppLog(s, ... )
#endif

/**
 *  Http请求方式
 */
typedef NS_ENUM(NSUInteger, SHHttpMethod) {
    /**
     *  GET
     */
    SHHttpMethodGet = 1,
    /**
     *  POST
     */
    SHHttpMethodPost = 2
};

/**
 *  服务器返回数据类型
 */
typedef NS_ENUM(NSUInteger, SHResponseType) {
    /**
     *  默认 JSON
     */
    kSHResponseTypeJSON = 1,
    /**
     *  XML
     */
    kSHResponseTypeXML  = 2,
    /**
     *  特殊情况下，一转换服务器就无法识别的，默认会尝试转换成JSON，若失败则需要自己去转换
     */
    kSHResponseTypeData = 3
};

/**
 *  请求上传服务器数据类型
 */
typedef NS_ENUM(NSUInteger, SHRequestType) {
    /**
     *  默认 JSON
     */
    kSHRequestTypeJSON = 1,
    /**
     *  普通text/html
     */
    kSHRequestTypePlainText  = 2
};

/**
 *  下载进度
 *
 *  @param bytesRead      已下载大小
 *  @param totalBytesRead 下载文件总大小
 */
typedef void (^SHDownloadProgress)(int64_t bytesRead, int64_t totalBytesRead);

/**
 *  使用GET方式下载
 */
typedef SHDownloadProgress SHGetProgress;

/**
 *  使用POST方式下载
 */
typedef SHDownloadProgress SHPostProgress;

/**
 *  上传进度
 *
 *  @param bytesWritten      已上传大小
 *  @param totalBytesWritten 上传文件总大小
 */
typedef void (^SHUploadProgress)(int64_t bytesWritten, int64_t totalBytesWritten);

@class NSURLSessionTask;

// 请勿直接使用NSURLSessionDataTask,以减少对第三方的依赖
// 所有接口返回的类型都是基类NSURLSessionTask，若要接收返回值
// 且处理，请转换成对应的子类类型
typedef NSURLSessionTask SHURLSessionTask;

/**
 *  请求的成功回调
 *
 *  @param response
 */
typedef void(^SHResponseSuccess)(id response);

/**
 *  请求的失败回调
 *
 *  @param error
 */
typedef void(^SHResponseFail)(NSError *error);


@interface SHNetworkClient : NSObject

/**
 *  指定或更新网络请求的基础URL
 *
 *  @param baseURL
 */
+ (void)updateBaseURL:(NSString *)baseURL;

/**
 *  获取网络请求的基础URL
 *
 *  @return
 */
+ (NSString *)baseURL;

/**
 *  是否打开接口打印信息
 *
 *  @param isDebug 默认 YES 打开
 */
+ (void)enableInterfaceDebug:(BOOL)isDebug;

/**
 *  配置请求格式和响应格式 默认均为JSON
 *
 *  @param requestType                   请求格式
 *  @param responseType                  响应格式
 *  @param shouldAutoEncode              默认为NO，是否自动encode url
 *  @param shouldCallbackOnCancelRequest 当取消请求时，是否要回调，默认为YES
 */
+ (void)configRequestType:(SHRequestType)requestType
             responseType:(SHResponseType)responseType
      shouldAutoEncodeUrl:(BOOL)shouldAutoEncode
  callbackOnCancelRequest:(BOOL)shouldCallbackOnCancelRequest;

/**
 *  配置公共的请求头
 *
 *  @param httpHeaders 设置与服务端约定的固定参数
 */
+ (void)configCommonHttpHeaders:(NSDictionary *)httpHeaders;


/**
 *  取消所有请求
 */
+ (void)cancelAllRequest;

/**
 *  单独取消某个请求
 *
 *  @param url
 */
+ (void)cancelRequestWithURL:(NSString *)url;

/**
 *	设置哪些请求方式采取缓存策略。默认只缓存GET请求的数据，对于POST请求是不缓存的
 *  对JSON类型数据有效，对于PLIST、XML不确定！
 *
 *	@param isCacheGet       默认为YES
 *	@param shouldCachePost	默认为NO
 */
+ (void)cacheGetRequest:(BOOL)isCacheGet
         shoulCachePost:(BOOL)shouldCachePost;

/**
 *	获取缓存总大小/bytes
 *
 *	@return 缓存大小
 */
+ (unsigned long long)totalCacheSize;

/**
 *  清除所有缓存
 */
+ (void)clearCaches;


/**
 *  GET请求接口，若不指定baseurl，可传完整的url
 *
 *  @param url     接口路径，如/path/getArticleList
 *  @param refreshCache 是否刷新缓存。由于请求成功也可能没有数据，对于业务失败，只能通过人为手动判断
 *  @param params  接口中所需要的拼接参数，如@{"categoryid" : @(12)}
 *  @param success 接口成功请求到数据的回调
 *  @param fail    接口请求数据失败的回调
 *
 *  @return 返回的对象中有可取消请求的API
 */

+ (SHURLSessionTask *)getWithUrl:(NSString *)url
                     refreshCache:(BOOL)refreshCache
                          success:(SHResponseSuccess)success
                             fail:(SHResponseFail)fail;
// 多一个params参数
+ (SHURLSessionTask *)getWithUrl:(NSString *)url
                     refreshCache:(BOOL)refreshCache
                           params:(NSDictionary *)params
                          success:(SHResponseSuccess)success
                             fail:(SHResponseFail)fail;
// 多一个进度回调
+ (SHURLSessionTask *)getWithUrl:(NSString *)url
                     refreshCache:(BOOL)refreshCache
                           params:(NSDictionary *)params
                         progress:(SHGetProgress)progress
                          success:(SHResponseSuccess)success
                             fail:(SHResponseFail)fail;



/*!
 *  POST请求接口，若不指定baseurl，可传完整的url
 *
 *  @param url     接口路径，如/path/getArticleList
 *  @param refreshCache 是否刷新缓存。由于请求成功也可能没有数据，对于业务失败，只能通过人为手动判断
 *  @param params  接口中所需的参数，如@{"categoryid" : @(12)}
 *  @param success 接口成功请求到数据的回调
 *  @param fail    接口请求数据失败的回调
 *
 *  @return 返回的对象中有可取消请求的API
 */
+ (SHURLSessionTask *)postWithUrl:(NSString *)url
                      refreshCache:(BOOL)refreshCache
                            params:(NSDictionary *)params
                           success:(SHResponseSuccess)success
                              fail:(SHResponseFail)fail;

// 多一个进度回调
+ (SHURLSessionTask *)postWithUrl:(NSString *)url
                      refreshCache:(BOOL)refreshCache
                            params:(NSDictionary *)params
                          progress:(SHPostProgress)progress
                           success:(SHResponseSuccess)success
                              fail:(SHResponseFail)fail;


/**
 *	图片上传接口，若不指定baseurl，可传完整的url
 *
 *	@param image		图片对象
 *	@param url			上传图片的接口路径，如/path/images/
 *	@param filename		给图片起一个名字，默认为当前日期时间,格式为"yyyyMMddHHmmss"，后缀为`jpg`
 *	@param name			与指定的图片相关联的名称，这是由后端写接口的人指定的，如imagefiles
 *	@param mimeType		默认为image/jpeg
 *	@param parameters	参数
 *	@param progress		上传进度
 *	@param success		上传成功回调
 *	@param fail			上传失败回调
 *
 *	@return
 */
+ (SHURLSessionTask *)uploadWithImage:(UIImage *)image
                                   url:(NSString *)url
                              filename:(NSString *)filename
                                  name:(NSString *)name
                              mimeType:(NSString *)mimeType
                            parameters:(NSDictionary *)parameters
                              progress:(SHUploadProgress)progress
                               success:(SHResponseSuccess)success
                                  fail:(SHResponseFail)fail;

/**
 *	上传文件操作
 *
 *	@param url						上传路径
 *	@param uploadingFile	待上传文件的路径
 *	@param progress			上传进度
 *	@param success				上传成功回调
 *	@param fail					上传失败回调
 *
 *	@return
 */
+ (SHURLSessionTask *)uploadFileWithUrl:(NSString *)url
                           uploadingFile:(NSString *)uploadingFile
                                progress:(SHUploadProgress)progress
                                 success:(SHResponseSuccess)success
                                    fail:(SHResponseFail)fail;
/*!
*  下载文件
*
*  @param url           下载URL
*  @param saveToPath    下载到哪个路径下
*  @param progressBlock 下载进度
*  @param success       下载成功后的回调
*  @param failure       下载失败后的回调
*/
+ (SHURLSessionTask *)downloadWithUrl:(NSString *)url
                            saveToPath:(NSString *)saveToPath
                              progress:(SHDownloadProgress)progressBlock
                               success:(SHResponseSuccess)success
                               failure:(SHResponseFail)failure;


@end


