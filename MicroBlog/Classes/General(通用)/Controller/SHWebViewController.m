//
//  SHWebViewController.m
//  MicroBlog
//
//  Created by RenSihao on 16/2/24.
//  Copyright © 2016年 RenSihao. All rights reserved.
//

#import "SHWebViewController.h"

@interface SHWebViewController () <UIWebViewDelegate>

@property(nonatomic,strong)UIWebView *webView;
@property(nonatomic,strong)NSString *url;
@property(nonatomic,strong)NSString *content;
@end

@implementation SHWebViewController

-(instancetype)initWithTitle:(NSString *)title url:(NSString *)url{
    self = [super init];
    if (self) {
        self.url = url;
        self.title = title;
    }
    return self;
}

-(instancetype)initWithTitle:(NSString *)title content:(NSString *)content{
    self = [super init];
    if (self) {
        self.content = content;
        self.title = title;
    }
    return self;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    if (_webView==nil) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        _webView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        _webView.backgroundColor = [UIColor whiteColor];
        _webView.delegate = self;
        [self.view addSubview:_webView];
    }
    
    if (self.url.length > 0) {
        NSURL *u = [[NSURL alloc] initWithString:self.url];
        _webView.scalesPageToFit = YES;
        [_webView loadRequest:[[NSURLRequest alloc] initWithURL:u]];
    } else if (self.content.length > 0) {
        [self loadHTMLWithContent:_content];
    }
    
    if (self.needScalesPageToFit) {
        _webView.scalesPageToFit = YES;
    }
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    if(_webView.isLoading)
    {
        [_webView stopLoading];
    }
    _webView.delegate = nil;
    [SVProgressHUD dismiss];
}

#pragma mark - Click

-(void)didClickBack:(id)sender{
    if (self.webView.canGoBack)
    {
        [self.webView goBack];
    }
    else
    {
        [super didClickBack:sender];
    }
}

#pragma mark - loadHtml

-(void)loadHTMLWithContent:(NSString *) content{
    CGFloat fontSize = 16;
    CGFloat lineHeight =  26;
    NSString *css = @"<style>body{margin:0 0 0 0 ; background:transparent;}\
    p{line-height:%.0fpx;font-size:%.0fpx;font-weight:regular;color:#333333;margin:10 16 %.0f 16;background:transparent;white-space:pre-line;font-family:\"Helvetica Neue\";word-break: break-word;-webkit-hyphens:auto; hyphens: auto;}.imgCenter{text-align:center}\
    </style>";
    css = [NSString stringWithFormat:css,lineHeight,fontSize,lineHeight/2.0];
    
    NSString *html = [NSString stringWithFormat:@"<html><head>%@</head><body>",css];
    html = [html stringByAppendingFormat:@"<p>%@</p>",content];
    html = [html stringByAppendingString:@"</body></html>"];
    
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSURL *baseURL = [NSURL fileURLWithPath:path];
    [_webView loadHTMLString:html baseURL:baseURL];
}

#pragma mark - UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView{
    [SVProgressHUD show];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [SVProgressHUD dismiss];
    // 取消长按webView上的链接弹出actionSheet的问题
    [_webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitTouchCallout = 'none';"];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error
{
    [SVProgressHUD showErrorWithStatus:error.localizedFailureReason];
}


@end
