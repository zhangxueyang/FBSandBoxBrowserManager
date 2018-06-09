//
//  FBSandBoxBrowserManager.m
//  FBSandBoxBrowserManager
//
//  Created by 张学阳 on 2018/6/9.
//

#import "FBSandBoxBrowserManager.h"
#import "GCDWebUploader.h"


#define fb_ScreenWidth [UIScreen mainScreen].bounds.size.width
#define fb_ScreenHeight [UIScreen mainScreen].bounds.size.height

#define fb_WindowBorderColor [UIColor colorWithWhite:0.2 alpha:1.0]
#define fb_viewBtnColor [UIColor colorWithRed:204/256.0 green:204/256.0 blue:204/256.0 alpha:1]
#define fb_WindowPading  20
#define fb_SandboxBrowserManagerWidth [UIScreen mainScreen].bounds.size.width-20*2


#pragma mark ---------------------------------------------------------------- FBSandboxBrowserManagerCtrl
@interface FBSandboxBrowserManagerCtrl :UIViewController
/*** 服务管理 ***/
@property(nonatomic , strong)GCDWebUploader *webUploader;
/*** iplabel ***/
@property(nonatomic , strong)UILabel *ipLabel;
/*** <#注释#> ***/
@property(nonatomic , strong)UIButton *serverBtn;


@end

@implementation FBSandboxBrowserManagerCtrl

-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupUI];
}
-(void)setupUI{
    
    self.ipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 60, fb_SandboxBrowserManagerWidth, 50)];
    self.ipLabel.text = @"还没有开启服务哦!";
    self.ipLabel.numberOfLines = 2;
    self.ipLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.ipLabel];
    
    self.serverBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.serverBtn setTitle:@"开启服务" forState:UIControlStateNormal];
    [self.serverBtn setTitle:@"关闭服务" forState:UIControlStateSelected];
    [self.serverBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.serverBtn.frame = CGRectMake(0, CGRectGetMaxY(self.ipLabel.frame)+30, fb_SandboxBrowserManagerWidth, 30);
    [self.serverBtn addTarget:self action:@selector(statrWebServer) forControlEvents:UIControlEventTouchUpInside];
    self.serverBtn.backgroundColor = fb_viewBtnColor;
    [self.view addSubview:self.serverBtn];
    
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeBtn setTitle:@"关闭页面" forState:UIControlStateNormal];
    [closeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    closeBtn.frame = CGRectMake(0, CGRectGetMaxY(self.serverBtn.frame)+30, fb_SandboxBrowserManagerWidth, 30);
    [closeBtn addTarget:self action:@selector(hiddendSandboxPage) forControlEvents:UIControlEventTouchUpInside];
    closeBtn.backgroundColor = fb_viewBtnColor;
    [self.view addSubview:closeBtn];
    
}

#pragma mark -------- 开启服务
-(void)statrWebServer{
    if (!_webUploader) {
        _webUploader = [[GCDWebUploader alloc] initWithUploadDirectory:NSHomeDirectory()];
        _webUploader.header = @"管理沙盒文件";
        _webUploader.title = @"管理沙盒文件";
        _webUploader.prologue = @"<p>可以进行沙盒文件删除~上传~移动~重命名等操作!<br/>注意(Documents,Library,SystemData,tmp)是系统文件!<br>使用有问题可以发邮件cocoazxy@gmail.com<br>源码地址:https://github.com/zhangxueyang/FBSandBoxBrowserManager</p>";
        _webUploader.epilogue = @"";
        _webUploader.footer = @"";
    }
    
    if (!self.serverBtn.selected) {
        self.ipLabel.text = [_webUploader start] ? [NSString stringWithFormat:@"请在浏览器中输入:\n%@",_webUploader.serverURL.absoluteString] : @"开启服务失败!";
    }else{
        if (_webUploader.isRunning) {
            [_webUploader stop];
            _webUploader = nil;
            self.ipLabel.text = @"还没有开启服务哦!";
        }
    }
    
    self.serverBtn.selected = !self.serverBtn.selected;
    
}
#pragma mark -------- 隐藏试图
- (void)hiddendSandboxPage{
    self.view.window.hidden = true;
}
@end



#pragma mark ---------------------------------------------------------------- FBSandBoxBrowserManager
@interface FBSandBoxBrowserManager ()<NSCopying>
/*** whindow ***/
@property(nonatomic,strong)UIWindow *sandboxWindow;
/*** 沙盒管理控制器 ***/
@property(nonatomic , strong)FBSandboxBrowserManagerCtrl *sandboxCtrl;

@end

static FBSandBoxBrowserManager *sandboxBrowserManager = nil;

@implementation FBSandBoxBrowserManager

+(instancetype)shanredSandBoxBrowserManager{
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        sandboxBrowserManager = [[super allocWithZone:NULL] init];
    }) ;
    return sandboxBrowserManager ;
}
+(id) allocWithZone:(struct _NSZone *)zone{
    return [FBSandBoxBrowserManager shanredSandBoxBrowserManager];
}
-(id) copyWithZone:(struct _NSZone *)zone{
    return [FBSandBoxBrowserManager shanredSandBoxBrowserManager];
}

-(void)swipShowServerPage{
    UISwipeGestureRecognizer *leftSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftSwipeTargert:)];
    leftSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
    leftSwipe.numberOfTouchesRequired = 1;
    [[UIApplication sharedApplication].keyWindow addGestureRecognizer:leftSwipe];
}

-(void)leftSwipeTargert:(UIGestureRecognizer *)sender{
    [self showSandboxWindow];
}

-(void)showSandboxWindow{
    if (!_sandboxWindow) {
        _sandboxWindow = [[UIWindow alloc] init];
        _sandboxWindow.backgroundColor = [UIColor yellowColor];
        CGRect keyFrame = [UIScreen mainScreen].bounds;
        keyFrame.origin.y += 64;
        keyFrame.size.height -= 64;
        _sandboxWindow.frame = CGRectInset(keyFrame, fb_WindowPading, fb_WindowPading);
        _sandboxWindow.backgroundColor = [UIColor whiteColor];
        _sandboxWindow.layer.borderColor = fb_WindowBorderColor.CGColor;
        _sandboxWindow.layer.borderWidth = 2.0;
        _sandboxWindow.windowLevel = UIWindowLevelStatusBar;
        
        _sandboxCtrl = [FBSandboxBrowserManagerCtrl new];
        _sandboxWindow.rootViewController = _sandboxCtrl;
    }
    _sandboxWindow.hidden = NO;
}



@end
