# BCategoryKit

[![CI Status](https://img.shields.io/travis/wangbaoming/BCategoryKit.svg?style=flat)](https://travis-ci.org/wangbaoming/BCategoryKit)
[![Version](https://img.shields.io/cocoapods/v/BCategoryKit.svg?style=flat)](https://cocoapods.org/pods/BCategoryKit)
[![License](https://img.shields.io/cocoapods/l/BCategoryKit.svg?style=flat)](https://cocoapods.org/pods/BCategoryKit)
[![Platform](https://img.shields.io/cocoapods/p/BCategoryKit.svg?style=flat)](https://cocoapods.org/pods/BCategoryKit)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

BCategoryKit is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
source 'https://github.com/BComponent/BSpecs.git'
pod 'BCategoryKit'
```

## Author

wangbaoming, wangbaoming@log56.com

## License

BCategoryKit is available under the MIT license. See the LICENSE file for more info.
# BCategoryKit

# 组件私有库创建过程
参考：
私有库的创建:[https://www.jianshu.com/p/760d6cd46719](https://www.jianshu.com/p/760d6cd46719)
组件图片存放和加载：[https://www.jianshu.com/p/66da0b4585c3](https://www.jianshu.com/p/66da0b4585c3)

## 搭建仓库

一个组件必须具备两个库：
1、索引库
2、组件库

### 索引库
1、组织目录（BComponent）下，新建目录（BSpecs）作为索引库
2、[创建过程选中public、README文件、.gitignore(选oc)](https://upload-images.jianshu.io/upload_images/2470124-8d1b930d150a5b9e.png?imageMogr2/auto-orient/strip|imageView2/2/w/1200)
3、创建本地索引库
1）、[打开终端 pod repo 查看一下当前有哪些本地索引库（如果你之前没有创建过，应该只有一个master](https://upload-images.jianshu.io/upload_images/2470124-19cd6ced28bfedbd.png?imageMogr2/auto-orient/strip|imageView2/2/w/816)
```
pod repo
```
2)、[通过pod repo add <本地索引库的名字>  <远程索引库的地址> ，创建本地索引库并和远程索引库做关联（注：本地索引库的名字建议和远程索引库起的名字一样）](https://upload-images.jianshu.io/upload_images/2470124-3426faffcc634720.png?imageMogr2/auto-orient/strip|imageView2/2/w/1104)

```
pod repo add BSpecs https://github.com/BComponent/BSpecs.git
```
3、[通过下面的方式可以查看本地索引库的物理地址](https://upload-images.jianshu.io/upload_images/2470124-7b0245fd840089e8.png?imageMogr2/auto-orient/strip|imageView2/2/w/1200)

### 远程代码库
[创建远程代码仓库（和创建远程索引库的方式一样），创建一个BCategoryKit的远程代码库，用来存放BCategory组件的代码。同样获取到benbenFFCategoryKit组件的远程代码库地址](https://upload-images.jianshu.io/upload_images/2470124-2281f90179749ccd.png?imageMogr2/auto-orient/strip|imageView2/2/w/1200)

1、本地代码库
1）、[pod lib create <组件名>  创建本地代码组件模版库（根据自身需求对下面的提示信息做选择就好）](https://upload-images.jianshu.io/upload_images/2470124-e8e386b2c6723e1c.png?imageMogr2/auto-orient/strip|imageView2/2/w/1200)
```
pod lib create BCategoryKit
``` 
2）、[编译运行通过看下效果。接着把组件代码文件夹拖入到组件BCategoryKit的classes路径下。](https://upload-images.jianshu.io/upload_images/2470124-75b79961043a0156.png?imageMogr2/auto-orient/strip|imageView2/2/w/1200)

3）、[组件的图片资源放到Assets文件夹中，可以使图片可以是.bundle文件，这里注意图片的读取方式和podspec文件配置路径也要做响应改变，具体请看组件图片资源配置](https://upload-images.jianshu.io/upload_images/5720820-955a649259a012f6.png?imageMogr2/auto-orient/strip|imageView2/2/w/1170、https://upload-images.jianshu.io/upload_images/5720820-955a649259a012f6.png?imageMogr2/auto-orient/strip|imageView2/2/w/1170)



4）、[ 接着cd到Example下进行pod install （把刚才拖入到classes里的文件夹pod进来）](https://upload-images.jianshu.io/upload_images/2470124-8567af6b27766ad4.png?imageMogr2/auto-orient/strip|imageView2/2/w/1126)

5)、[编译组件看是否报错，编译通过后需要修改podspecs索引文件，一般需要修改下面几个问题。](https://upload-images.jianshu.io/upload_images/2470124-c2816d8ecfd75e7a.png?imageMogr2/auto-orient/strip|imageView2/2/w/1200、https://upload-images.jianshu.io/upload_images/2470124-d5972be616fa47d8.png?imageMogr2/auto-orient/strip|imageView2/2/w/1200)

a. 修改版本号

b. 修改项目的简单概述和详细描述

c. 修改homepage和source地址

d. 添加依赖库

6）、[编译运行通过后，提交组件到远程代码库并打tag](https://upload-images.jianshu.io/upload_images/2470124-549c8d698095a727.png?imageMogr2/auto-orient/strip|imageView2/2/w/1136
)
```
-  git add .

- git commit -m “xxx"

- git remote add origin 远程代码仓库地址

- git push origin master

- git tag 版本号 （注：这里的版本号必须和podspec里写的版本号一致）

- git push --tags

```
7）、接下来可以验证podspec索引文件是否正确

首先，通过pod lib lint FFCategoryKit.podspec --verbose --allow-warnings 验证本地索引文件是否正确

也可以略过本地验证

直接通过pod spec lint --verbose --allow-warnings 命令验证podspec索引文件（既验证本地同时验证远程的podspec）

作者：JiaJung
链接：https://www.jianshu.com/p/760d6cd46719
来源：简书
著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。
8）、验证通过后，pod repo push <本地索引库> <索引文件> - -verbose - -allow-warnings 提交索引文件到远程索引库

```
pod repo push BSpecs BCategoryKit.podspec - -verbose - -allow-warnings
```

[本地也可以查看已成功](https://upload-images.jianshu.io/upload_images/2470124-670ef6b39026bd2c.png?imageMogr2/auto-orient/strip|imageView2/2/w/1200)

9）、在需要应用改组件的工程podfile文件中pod  BCategoryKit
```
#远程组件索引地址，需要在Podfile中指定组件远程索引库地址，如果不指定默认会从master的索引库查找就会报找不到组件
source 'https://github.com/BComponent/BSpecs.git'
source 'xxxxx'
pod 'BCategoryKit'

```
[![查看组件远程地址 pod repo](https://upload-images.jianshu.io/upload_images/2470124-9fbd94fd493bc02b.png?imageMogr2/auto-orient/strip|imageView2/2/w/1066)](https://upload-images.jianshu.io/upload_images/2470124-9fbd94fd493bc02b.png?imageMogr2/auto-orient/strip|imageView2/2/w/1066)
```
pod repo
```

# 组件图片配置
