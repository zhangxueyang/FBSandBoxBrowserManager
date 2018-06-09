
Pod::Spec.new do |s|
  s.name             = 'FBSandBoxBrowserManager'
  s.version          = '0.1.0'
  s.summary          = '浏览器中管理沙盒文件'

  s.description      = <<-DESC
                        可以在浏览器中管理APP沙盒中的文件，包括删除.添加 移动 等操作
                       DESC

  s.homepage         = 'https://github.com/zhangxueyang/FBSandBoxBrowserManager'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'zhangxueyang' => 'cocoazxy@gmail.com' }
  s.source           = { :git => 'https://github.com/zhangxueyang/FBSandBoxBrowserManager.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'
  s.source_files = 'FBSandBoxBrowserManager/Classes/**/*'
  
  s.dependency 'GCDWebServer', '~> 3.0'
  s.dependency 'GCDWebServer/WebUploader', '~> 3.0'
end
