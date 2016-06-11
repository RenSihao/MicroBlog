//
//  SHNetworkClient.m
//  MicroBlog
//
//  Created by RenSihao on 16/4/5.
//  Copyright © 2016年 RenSihao. All rights reserved.
//

#import "SHNetworkClient.h"

/**
 *  基础URL
 */
static NSString *sh_privateNetworkBaseURL = nil;

/**
 *  是否开启接口打印信息 默认YES
 */
static BOOL sh_isEnableInterfaceDebug = YES;

/**
 *  是否对URL编码 默认NO
 */
static BOOL sh_shouldAutoEncode = NO;

/**
 *  与服务端约定的公共请求头
 */
static NSDictionary *sh_httpHeaders = nil;

/**
 *  返回数据类型 默认JSON
 */
static SHResponseType sh_responseType = kSHResponseTypeJSON;

/**
 *  请求数据类型 默认JSON
 */
static SHRequestType  sh_requestType  = kSHRequestTypeJSON;

/**
 *  所有网络相关请求任务
 */
static NSMutableArray *sh_requestTasks;

/**
 *  GET缓存策略 默认YES
 */
static BOOL sh_cacheGet = YES;

/**
 *  POST缓存策略 默认NO
 */
static BOOL sh_cachePost = NO;

/**
 *  取消请求时，是否回调 默认YES
 */
static BOOL sh_shouldCallbackOnCancelRequest = YES;


@implementation SHNetworkClient

/**
 *	设置哪些请求方式采取缓存策略。默认只缓存GET请求的数据，对于POST请求是不缓存的
 *  对JSON类型数据有效，对于PLIST、XML不确定！
 *
 *	@param isCacheGet       默认为YES
 *	@param shouldCachePost	默认为NO
 */
+ (void)cacheGetRequest:(BOOL)isCacheGet
         shoulCachePost:(BOOL)shouldCachePost
{
    sh_cacheGet = isCacheGet;
    sh_cachePost = shouldCachePost;
}
/**
 *  指定或更新网络请求的基础URL
 *
 *  @param baseURL
 */
+ (void)updateBaseURL:(NSString *)baseURL
{
    sh_privateNetworkBaseURL = baseURL;
}
/**
 *  是否打开接口打印信息
 *
 *  @param isDebug 默认 YES 打开
 */
+ (void)enableInterfaceDebug:(BOOL)isDebug
{
    sh_isEnableInterfaceDebug = isDebug;
}
/**
 *  取消所有网络请求
 */
+ (void)cancelAllRequest
{
    @synchronized(self)
    {
        [[self allTasks] enumerateObjectsUsingBlock:^(SHURLSessionTask * _Nonnull task, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if ([task isKindOfClass:[SHURLSessionTask class]])
            {
                [task cancel];
            }
        }];
        [[self allTasks] removeAllObjects];
    };
}
/**
 *  清除所有缓存
 */
+ (void)clearCaches
{
    NSString *directoryPath = cachePath();
    if ([[NSFileManager defaultManager] fileExistsAtPath:directoryPath isDirectory:nil])
    {
        NSError *error = nil;
        [[NSFileManager defaultManager] removeItemAtPath:directoryPath error:&error];
        
        if (error)
        {
            NSLog(@"SHNetworking clear caches error: %@", error);
        }
        else
        {
            NSLog(@"SHNetworking clear caches ok");
        }
    }
}

#pragma mark - configure

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
  callbackOnCancelRequest:(BOOL)shouldCallbackOnCancelRequest
{
    sh_requestType = requestType;
    sh_responseType = responseType;
    sh_shouldAutoEncode = shouldAutoEncode;
    sh_shouldCallbackOnCancelRequest = shouldCallbackOnCancelRequest;
}

/**
 *  配置公共的请求头
 *
 *  @param httpHeaders 设置与服务端约定的固定参数
 */
+ (void)configCommonHttpHeaders:(NSDictionary *)httpHeaders
{
    sh_httpHeaders = httpHeaders;
}

#pragma mark - getter

+ (NSString *)baseURL
{
    return sh_privateNetworkBaseURL;
}
+ (NSMutableArray *)allTasks
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        if (sh_requestTasks == nil)
        {
            sh_requestTasks = [[NSMutableArray alloc] init];
        }
    });
    return sh_requestTasks;
}

+ (BOOL)shouldEncode
{
    return sh_shouldAutoEncode;
}
+ (BOOL)isDebug
{
    return sh_isEnableInterfaceDebug;
}
+ (unsigned long long)totalCacheSize
{
    NSString *directoryPath = cachePath();
    BOOL isDir = NO;
    unsigned long long total = 0;
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:directoryPath isDirectory:&isDir])
    {
        if (isDir)
        {
            NSError *error = nil;
            NSArray *array = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:directoryPath error:&error];
            
            if (error == nil)
            {
                for (NSString *subpath in array)
                {
                    NSString *path = [directoryPath stringByAppendingPathComponent:subpath];
                    NSDictionary *dict = [[NSFileManager defaultManager] attributesOfItemAtPath:path
                                                                                          error:&error];
                    if (!error)
                    {
                        total += [dict[NSFileSize] unsignedIntegerValue];
                    }
                }
            }
        }
    }
    
    return total;
}
/**
 *  单独取消某个请求
 *
 *  @param url
 */
+ (void)cancelRequestWithURL:(NSString *)url
{
    if (url == nil)
    {
        return;
    }
    
    @synchronized(self)
    {
        [[self allTasks] enumerateObjectsUsingBlock:^(SHURLSessionTask * _Nonnull task, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if ([task isKindOfClass:[SHURLSessionTask class]]
                && [task.currentRequest.URL.absoluteString hasSuffix:url])
            {
                [task cancel];
                [[self allTasks] removeObject:task];
                return;
            }
        }];
    };
}

#pragma mark - GET & POST

+ (SHURLSessionTask *)getWithUrl:(NSString *)url
                    refreshCache:(BOOL)refreshCache
                         success:(SHResponseSuccess)success
                            fail:(SHResponseFail)fail
{
    return [self getWithUrl:url
               refreshCache:refreshCache
                     params:nil
                    success:success
                       fail:fail];
}
+ (SHURLSessionTask *)getWithUrl:(NSString *)url
                    refreshCache:(BOOL)refreshCache
                          params:(NSDictionary *)params
                         success:(SHResponseSuccess)success
                            fail:(SHResponseFail)fail
{
    return [self getWithUrl:url
               refreshCache:refreshCache
                     params:params
                   progress:nil
                    success:success
                       fail:fail];
}
+ (SHURLSessionTask *)getWithUrl:(NSString *)url
                    refreshCache:(BOOL)refreshCache
                          params:(NSDictionary *)params
                        progress:(SHGetProgress)progress
                         success:(SHResponseSuccess)success
                            fail:(SHResponseFail)fail
{
    return [self _requestWithUrl:url
                    refreshCache:refreshCache
                       httpMedth:SHHttpMethodGet
                          params:params
                        progress:progress
                         success:success
                            fail:fail];
}
+ (SHURLSessionTask *)postWithUrl:(NSString *)url
                      refreshCache:(BOOL)refreshCache
                            params:(NSDictionary *)params
                           success:(SHResponseSuccess)success
                              fail:(SHResponseFail)fail {
    return [self postWithUrl:url
                refreshCache:refreshCache
                      params:params
                    progress:nil
                     success:success
                        fail:fail];
}

+ (SHURLSessionTask *)postWithUrl:(NSString *)url
                      refreshCache:(BOOL)refreshCache
                            params:(NSDictionary *)params
                          progress:(SHPostProgress)progress
                           success:(SHResponseSuccess)success
                              fail:(SHResponseFail)fail {
    return [self _requestWithUrl:url
                    refreshCache:refreshCache
                       httpMedth:SHHttpMethodPost
                          params:params
                        progress:progress
                         success:success
                            fail:fail];
}

/**
 *  Get和Post的请求接口
 *
 *  @param url          接口路径，如/path/getArticleList 
 *  @param refreshCache 是否刷新缓存。由于请求成功也可能没有数据，对于业务失败，只能通过人为手动判断
 *  @param httpMethod   请求方式 1、GET 2、POST
 *  @param params       接口中所需要的拼接参数，如@{"categoryid" : @(12)}
 *  @param progress     进度
 *  @param success      接口成功请求到数据的回调
 *  @param fail         接口请求数据失败的回调
 *
 *  @return
 */
+ (SHURLSessionTask *)_requestWithUrl:(NSString *)url
                          refreshCache:(BOOL)refreshCache
                             httpMedth:(SHHttpMethod)httpMethod
                                params:(NSDictionary *)params
                              progress:(SHDownloadProgress)progress
                               success:(SHResponseSuccess)success
                                  fail:(SHResponseFail)fail
{
    //初始化网络请求管理器
    AFHTTPSessionManager *manager = [self manager];
    
    //设置URL绝对路径
    NSString *absolute = [self absoluteUrlWithPath:url];
    
    if ([self baseURL] == nil)
    {
        if ([NSURL URLWithString:url] == nil)
        {
            SHAppLog(@"URLString无效，无法生成URL。可能是URL中有中文，请尝试Encode URL");
            return nil;
        }
    }
    else
    {
        NSURL *absouluteURL = [NSURL URLWithString:absolute];
        if (absouluteURL == nil)
        {
            SHAppLog(@"URLString无效，无法生成URL。可能是URL中有中文，请尝试Encode URL");
            return nil;
        }
    }
    
    //是否需要对URL进行UTF-8编码
    if ([self shouldEncode])
    {
        url = [self encodeURL:url];
    }
    
    SHURLSessionTask *session = nil;
    
    //处理GET请求
    if (httpMethod == SHHttpMethodGet)
    {
        if (sh_cacheGet && !refreshCache)
        {
            // 获取缓存
            id response = [SHNetworkClient cahceResponseWithURL:absolute
                                                   parameters:params];
            if (response)
            {
                if (success)
                {
                    [self successResponse:response callback:success];
                    
                    if ([self isDebug])
                    {
                        [self logWithSuccessResponse:response
                                                 url:absolute
                                              params:params];
                    }
                }
                
                return nil;
            }
        }
        
        session = [manager GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
            
            if (progress)
            {
                progress(downloadProgress.completedUnitCount, downloadProgress.totalUnitCount);
            }
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            [self successResponse:responseObject callback:success];
            if (sh_cacheGet)
            {
                [self cacheResponseObject:responseObject request:task.currentRequest parameters:params];
            }
            
            [[self allTasks] removeObject:task];
            
            if ([self isDebug]) {
                [self logWithSuccessResponse:responseObject
                                         url:absolute
                                      params:params];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            [[self allTasks] removeObject:task];
            [self handleCallbackWithError:error fail:fail];
            
            if ([self isDebug])
            {
                [self logWithFailError:error url:absolute params:params];
            }
        }];
    }
    //处理POST请求
    else if (httpMethod == SHHttpMethodPost)
    {
        if (sh_cachePost && !refreshCache)
        {
            // 获取缓存
            id response = [SHNetworkClient cahceResponseWithURL:absolute
                                                   parameters:params];
            if (response)
            {
                if (success)
                {
                    [self successResponse:response callback:success];
                    if ([self isDebug])
                    {
                        [self logWithSuccessResponse:response
                                                 url:absolute
                                              params:params];
                    }
                }
                return nil;
            }
        }
        
        session = [manager POST:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
            if (progress) {
                progress(downloadProgress.completedUnitCount, downloadProgress.totalUnitCount);
            }
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [self successResponse:responseObject callback:success];
            
            if (sh_cachePost) {
                [self cacheResponseObject:responseObject request:task.currentRequest  parameters:params];
            }
            
            [[self allTasks] removeObject:task];
            
            if ([self isDebug]) {
                [self logWithSuccessResponse:responseObject
                                         url:absolute
                                      params:params];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [[self allTasks] removeObject:task];
            
            [self handleCallbackWithError:error fail:fail];
            
            if ([self isDebug]) {
                [self logWithFailError:error url:absolute params:params];
            }
        }];
    }
    
    if (session)
    {
        [[self allTasks] addObject:session];
    }
    
    return session;
}
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
                                  fail:(SHResponseFail)fail {
    if ([self baseURL] == nil)
    {
        if ([NSURL URLWithString:url] == nil)
        {
            SHAppLog(@"URLString无效，无法生成URL。可能是URL中有中文，请尝试Encode URL");
            return nil;
        }
    }
    else
    {
        if ([NSURL URLWithString:[NSString stringWithFormat:@"%@%@", [self baseURL], url]] == nil)
        {
            SHAppLog(@"URLString无效，无法生成URL。可能是URL中有中文，请尝试Encode URL");
            return nil;
        }
    }
    
    if ([self shouldEncode])
    {
        url = [self encodeURL:url];
    }
    
    NSString *absolute = [self absoluteUrlWithPath:url];
    
    AFHTTPSessionManager *manager = [self manager];
    SHURLSessionTask *session = [manager POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData *imageData = UIImageJPEGRepresentation(image, 1);
        
        NSString *imageFileName = filename;
        if (filename == nil || ![filename isKindOfClass:[NSString class]] || filename.length == 0) {
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            imageFileName = [NSString stringWithFormat:@"%@.jpg", str];
        }
        
        // 上传图片，以文件流的格式
        [formData appendPartWithFileData:imageData name:name fileName:imageFileName mimeType:mimeType];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress.completedUnitCount, uploadProgress.totalUnitCount);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [[self allTasks] removeObject:task];
        [self successResponse:responseObject callback:success];
        
        if ([self isDebug]) {
            [self logWithSuccessResponse:responseObject
                                     url:absolute
                                  params:parameters];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [[self allTasks] removeObject:task];
        
        [self handleCallbackWithError:error fail:fail];
        
        if ([self isDebug]) {
            [self logWithFailError:error url:absolute params:nil];
        }
    }];
    
    [session resume];
    if (session) {
        [[self allTasks] addObject:session];
    }
    
    return session;
}
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
                                   fail:(SHResponseFail)fail
{
    if ([NSURL URLWithString:uploadingFile] == nil)
    {
        SHAppLog(@"uploadingFile无效，无法生成URL。请检查待上传文件是否存在");
        return nil;
    }
    
    NSURL *uploadURL = nil;
    if ([self baseURL] == nil)
    {
        uploadURL = [NSURL URLWithString:url];
    }
    else
    {
        uploadURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", [self baseURL], url]];
    }
    
    if (uploadURL == nil)
    {
        SHAppLog(@"URLString无效，无法生成URL。可能是URL中有中文或特殊字符，请尝试Encode URL");
        return nil;
    }
    
    if ([self shouldEncode])
    {
        url = [self encodeURL:url];
    }
    
    AFHTTPSessionManager *manager = [self manager];
    NSURLRequest *request = [NSURLRequest requestWithURL:uploadURL];
    SHURLSessionTask *session = nil;
    
    [manager uploadTaskWithRequest:request fromFile:[NSURL URLWithString:uploadingFile] progress:^(NSProgress * _Nonnull uploadProgress) {
        
        if (progress)
        {
            progress(uploadProgress.completedUnitCount, uploadProgress.totalUnitCount);
        }
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        [[self allTasks] removeObject:session];
        [self successResponse:responseObject callback:success];
        if (error)
        {
            [self handleCallbackWithError:error fail:fail];
            
            if ([self isDebug])
            {
                [self logWithFailError:error url:response.URL.absoluteString params:nil];
            }
        }
        else
        {
            if ([self isDebug])
            {
                [self logWithSuccessResponse:responseObject
                                         url:response.URL.absoluteString
                                      params:nil];
            }
        }
    }];
    
    if (session)
    {
        [[self allTasks] addObject:session];
    }
    
    return session;
}
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
                              failure:(SHResponseFail)failure
{
    if ([self baseURL] == nil) {
        if ([NSURL URLWithString:url] == nil) {
            SHAppLog(@"URLString无效，无法生成URL。可能是URL中有中文，请尝试Encode URL");
            return nil;
        }
    } else {
        if ([NSURL URLWithString:[NSString stringWithFormat:@"%@%@", [self baseURL], url]] == nil) {
            SHAppLog(@"URLString无效，无法生成URL。可能是URL中有中文，请尝试Encode URL");
            return nil;
        }
    }
    
    NSURLRequest *downloadRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    AFHTTPSessionManager *manager = [self manager];
    
    SHURLSessionTask *session = nil;
    
    session = [manager downloadTaskWithRequest:downloadRequest progress:^(NSProgress * _Nonnull downloadProgress) {
        
        if (progressBlock)
        {
            progressBlock(downloadProgress.completedUnitCount, downloadProgress.totalUnitCount);
        }
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        return [NSURL URLWithString:saveToPath];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
        [[self allTasks] removeObject:session];
        if (error == nil)
        {
            if (success)
            {
                success(filePath.absoluteString);
            }
            
            if ([self isDebug])
            {
                SHAppLog(@"Download success for url %@",
                         [self absoluteUrlWithPath:url]);
            }
        }
        else
        {
            [self handleCallbackWithError:error fail:failure];
            
            if ([self isDebug])
            {
                SHAppLog(@"Download fail for url %@, reason : %@",
                         [self absoluteUrlWithPath:url],
                         [error description]);
            }
        }
    }];
    
    [session resume];
    if (session)
    {
        [[self allTasks] addObject:session];
    }
    return session;
}

#pragma mark - private method

/**
 *  设置网络请求管理器
 *
 *  @return
 */
+ (AFHTTPSessionManager *)manager
{
    // 开启菊花
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    
    AFHTTPSessionManager *manager = nil;;
    if ([self baseURL] != nil)
    {
        manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:[self baseURL]]];
    }
    else
    {
        manager = [AFHTTPSessionManager manager];
    }
    
    switch (sh_requestType)
    {
        case kSHRequestTypeJSON:
        {
            manager.requestSerializer = [AFJSONRequestSerializer serializer];
            break;
        }
        case kSHRequestTypePlainText:
        {
            manager.requestSerializer = [AFHTTPRequestSerializer serializer];
            break;
        }
        default:
        {
            break;
        }
    }
    
    switch (sh_responseType)
    {
        case kSHResponseTypeJSON:
        {
            manager.responseSerializer = [AFJSONResponseSerializer serializer];
            break;
        }
        case kSHResponseTypeXML:
        {
            manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
            break;
        }
        case kSHResponseTypeData:
        {
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            break;
        }
        default:
        {
            break;
        }
    }
    
    manager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
    
    for (NSString *key in sh_httpHeaders.allKeys)
    {
        if (sh_httpHeaders[key] != nil)
        {
            [manager.requestSerializer setValue:sh_httpHeaders[key] forHTTPHeaderField:key];
        }
    }
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",
                                                                              @"text/html",
                                                                              @"text/json",
                                                                              @"text/plain",
                                                                              @"text/javascript",
                                                                              @"text/xml",
                                                                              @"image/*"]];
    
    // 设置允许同时最大并发数量，过大容易出问题
    manager.operationQueue.maxConcurrentOperationCount = 3;
    return manager;
}
/**
 *  设置URL绝对路径
 *
 *  @param path
 *
 *  @return
 */
+ (NSString *)absoluteUrlWithPath:(NSString *)path
{
    if (path == nil || path.length == 0)
    {
        return @"";
    }
    
    if ([self baseURL] == nil || [[self baseURL] length] == 0)
    {
        return path;
    }
    
    NSString *absoluteUrl = path;
    
    if (![path hasPrefix:@"http://"] && ![path hasPrefix:@"https://"])
    {
        absoluteUrl = [NSString stringWithFormat:@"%@%@", [self baseURL], path];
    }
    
    return absoluteUrl;
}

/**
 *  对URL进行UTF-8编码
 *
 *  @param url
 *
 *  @return
 */
+ (NSString *)encodeURL:(NSString *)url
{
    NSString *newString =
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)url,
                                                              NULL,
                                                              CFSTR(":/?#[]@!$ &'()*+,;=\"<>%{}|\\^~`"), CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding)));
    if (newString)
    {
        return newString;
    }
    return url;
}
/**
 *  获取本地网络缓存文件的路径
 *
 *  @return
 */
static inline NSString *cachePath()
{
    return [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/SHNetworkClientCaches"];
}
+ (id)cahceResponseWithURL:(NSString *)url parameters:(NSDictionary *)params
{
    id cacheData = nil;
    if (url)
    {
        // Try to get datas from disk
        NSString *directoryPath = cachePath();
        NSString *absoluteURL = [self generateGETAbsoluteURL:url params:params];
        NSString *key = [NSString md5:absoluteURL];
        NSString *path = [directoryPath stringByAppendingPathComponent:key];
        
        NSData *data = [[NSFileManager defaultManager] contentsAtPath:path];
        if (data)
        {
            cacheData = data;
            SHAppLog(@"Read data from cache for url: %@\n", url);
        }
    }
    return cacheData;
}
/**
 *  请求成功 将得到的数据回调
 *
 *  @param responseData 返回数据
 *  @param success      成功回调block
 */
+ (void)successResponse:(id)responseData callback:(SHResponseSuccess)success
{
    if (success)
    {
        success([self tryToParseData:responseData]);
    }
}
/**
 *  解析NSData类型返回数据
 *
 *  @param responseData 返回数据
 *
 *  @return
 */
+ (id)tryToParseData:(id)responseData
{
    if ([responseData isKindOfClass:[NSData class]])
    {
        // 尝试解析成JSON
        if (responseData == nil)
        {
            return responseData;
        }
        else
        {
            NSError *error = nil;
            NSDictionary *response = [NSJSONSerialization JSONObjectWithData:responseData
                                                                     options:NSJSONReadingMutableContainers
                                                                       error:&error];
            
            if (error != nil)
            {
                return responseData;
            }
            else
            {
                return response;
            }
        }
    }
    else
    {
        return responseData;
    }
}

// 仅对一级字典结构起作用
+ (NSString *)generateGETAbsoluteURL:(NSString *)url params:(id)params
{
    if (params == nil || ![params isKindOfClass:[NSDictionary class]] || [params count] == 0)
    {
        return url;
    }
    
    NSString *queries = @"";
    for (NSString *key in params)
    {
        id value = [params objectForKey:key];
        
        if ([value isKindOfClass:[NSDictionary class]])
        {
            continue;
        }
        else if ([value isKindOfClass:[NSArray class]])
        {
            continue;
        }
        else if ([value isKindOfClass:[NSSet class]])
        {
            continue;
        }
        else
        {
            queries = [NSString stringWithFormat:@"%@%@=%@&",
                       (queries.length == 0 ? @"&" : queries),
                       key,
                       value];
        }
    }
    
    if (queries.length > 1)
    {
        queries = [queries substringToIndex:queries.length - 1];
    }
    
    if (([url hasPrefix:@"http://"] || [url hasPrefix:@"https://"]) && queries.length > 1)
    {
        if ([url rangeOfString:@"?"].location != NSNotFound
            || [url rangeOfString:@"#"].location != NSNotFound)
        {
            url = [NSString stringWithFormat:@"%@%@", url, queries];
        }
        else
        {
            queries = [queries substringFromIndex:1];
            url = [NSString stringWithFormat:@"%@?%@", url, queries];
        }
    }
    
    return url.length == 0 ? queries : url;
}
/**
 *  打印接口信息
 *
 *  @param response 返回数据
 *  @param url      请求的url地址
 *  @param params   请求参数
 */
+ (void)logWithSuccessResponse:(id)response url:(NSString *)url params:(NSDictionary *)params
{
    SHAppLog(@"\n");
    SHAppLog(@"\nRequest success, URL: %@\n params:%@\n response:%@\n\n",
              [self generateGETAbsoluteURL:url params:params],
              params,
              [self tryToParseData:response]);
}
+ (void)logWithFailError:(NSError *)error url:(NSString *)url params:(id)params
{
    NSString *format = @" params: ";
    if (params == nil || ![params isKindOfClass:[NSDictionary class]])
    {
        format = @"";
        params = @"";
    }
    
    SHAppLog(@"\n");
    if ([error code] == NSURLErrorCancelled)
    {
        SHAppLog(@"\nRequest was canceled mannully, URL: %@ %@%@\n\n",
                  [self generateGETAbsoluteURL:url params:params],
                  format,
                  params);
    }
    else
    {
        SHAppLog(@"\nRequest error, URL: %@ %@%@\n errorInfos:%@\n\n",
                  [self generateGETAbsoluteURL:url params:params],
                  format,
                  params,
                  [error localizedDescription]);
    }
}
+ (void)cacheResponseObject:(id)responseObject request:(NSURLRequest *)request parameters:params
{
    if (request && responseObject && ![responseObject isKindOfClass:[NSNull class]])
    {
        NSString *directoryPath = cachePath();
        NSError *error = nil;
        
        if (![[NSFileManager defaultManager] fileExistsAtPath:directoryPath isDirectory:nil])
        {
            [[NSFileManager defaultManager] createDirectoryAtPath:directoryPath
                                      withIntermediateDirectories:YES
                                                       attributes:nil
                                                            error:&error];
            if (error)
            {
                SHAppLog(@"create cache dir error: %@\n", error);
                return;
            }
        }
        
        NSString *absoluteURL = [self generateGETAbsoluteURL:request.URL.absoluteString params:params];
        NSString *key = [NSString md5:absoluteURL];
        NSString *path = [directoryPath stringByAppendingPathComponent:key];
        NSDictionary *dict = (NSDictionary *)responseObject;
        
        NSData *data = nil;
        if ([dict isKindOfClass:[NSData class]])
        {
            data = responseObject;
        }
        else
        {
            data = [NSJSONSerialization dataWithJSONObject:dict
                                                   options:NSJSONWritingPrettyPrinted
                                                     error:&error];
        }
        
        if (data && error == nil)
        {
            BOOL isOk = [[NSFileManager defaultManager] createFileAtPath:path contents:data attributes:nil];
            if (isOk)
            {
                SHAppLog(@"cache file ok for request: %@\n", absoluteURL);
            }
            else
            {
                SHAppLog(@"cache file error for request: %@\n", absoluteURL);
            }
        }
    }
}
+ (void)handleCallbackWithError:(NSError *)error fail:(SHResponseFail)fail
{
    if ([error code] == NSURLErrorCancelled)
    {
        if (sh_shouldCallbackOnCancelRequest)
        {
            if (fail)
            {
                fail(error);
            }
        }
    }
    else
    {
        if (fail)
        {
            fail(error);
        }
    }
}





@end
