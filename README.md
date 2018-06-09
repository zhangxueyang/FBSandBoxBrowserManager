# FBSandBoxBrowserManager


##说明
```
项目依赖于 -------   [GCDWebServer](https://github.com/swisspol/GCDWebServer) 
如果不想使用我的,可以自己用 GCDWebServer 自己弄!
  s.dependency 'GCDWebServer', '~> 3.0'
  s.dependency 'GCDWebServer/WebUploader', '~> 3.0'
  
  我只是用了这个第三方库, 自己使用方便!
```

##使用
```
#ifdef DEBUG

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    // Override point for customization after application launch.
#ifdef DEBUG
  //使用的时候 左滑屏幕就可以出现开启服务的页面
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[FBSandBoxBrowserManager shanredSandBoxBrowserManager] swipShowServerPage];
    });
#endif
    return YES;
}
```

##效果
![Image text](https://github.com/zhangxueyang/FBSandBoxBrowserManager/blob/master/Images/Snip20180609_3.png)
![Image text](https://github.com/zhangxueyang/FBSandBoxBrowserManager/blob/master/Images/Snip20180609_4.png)


## 找不到文件解决办法
```
pod 'FBObjcSugar'

-------------------------------------------------------------
如果遇到搜索不出来
Unable to find a pod with name, author, summary, or descriptionmatching 'xxxxxxx'。
-------------------------------------------------------------
解决办法:
1:(手动删除)
找到  ~/Library/Caches/CocoaPods  目录下的 search_index.json 文件,并删除
然后再
pod setup
成功后会生成新的
~/Library/Caches/CocoaPods/search_index.json文件。
-------------------------------------------------------------
2:终端输入以下命令（命令行）
rm ~/Library/Caches/CocoaPods/search_index.json
pod search
-------------------------------------------------------------
```

