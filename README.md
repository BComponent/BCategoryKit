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
2、创建过程选中public、README文件、.gitignore(选oc)
[![创建过程选中public、README文件、.gitignore(选oc)](https://upload-images.jianshu.io/upload_images/2470124-8d1b930d150a5b9e.png?imageMogr2/auto-orient/strip|imageView2/2/w/1200)](https://www.jianshu.com/p/760d6cd46719)
3、创建本地索引库
1）、打开终端 pod repo 查看一下当前有哪些本地索引库（如果你之前没有创建过，应该只有一个master[![pod repo](https://upload-images.jianshu.io/upload_images/2470124-19cd6ced28bfedbd.png?imageMogr2/auto-orient/strip|imageView2/2/w/816)](https://www.jianshu.com/p/760d6cd46719)
```
pod repo
```
2)、
通过pod repo add <本地索引库的名字>  <远程索引库的地址> ，创建本地索引库并和远程索引库做关联（注：本地索引库的名字建议和远程索引库起的名字一样）
[![本地索引库并和远程索引库做关联](https://upload-images.jianshu.io/upload_images/2470124-3426faffcc634720.png?imageMogr2/auto-orient/strip|imageView2/2/w/1104)](https://www.jianshu.com/p/760d6cd46719)

```
pod repo add BSpecs https://github.com/BComponent/BSpecs.git
```
3、
通过下面的方式可以查看本地索引库的物理地址
[![查看本地索引库的物理地址](https://upload-images.jianshu.io/upload_images/2470124-7b0245fd840089e8.png?imageMogr2/auto-orient/strip|imageView2/2/w/1200)](https://www.jianshu.com/p/760d6cd46719)

### 远程代码库
创建远程代码仓库（和创建远程索引库的方式一样），创建一个BCategoryKit的远程代码库，用来存放BCategory组件的代码。同样获取到benbenFFCategoryKit组件的远程代码库地址
[![创建远程代码仓库](https://upload-images.jianshu.io/upload_images/2470124-2281f90179749ccd.png?imageMogr2/auto-orient/strip|imageView2/2/w/1200)](https://www.jianshu.com/p/760d6cd46719)

1、本地代码库
1）、pod lib create <组件名>  创建本地代码组件模版库（根据自身需求对下面的提示信息做选择就好）
[![创建本地代码组件模版库（](https://upload-images.jianshu.io/upload_images/2470124-e8e386b2c6723e1c.png?imageMogr2/auto-orient/strip|imageView2/2/w/1200)](https://www.jianshu.com/p/760d6cd46719)
```
pod lib create BCategoryKit
``` 
2）、编译运行通过看下效果。接着把组件代码文件夹拖入到组件BCategoryKit的classes路径下。
[![组件代码文件夹拖入到组件BCategoryKit的classes路径下。](https://upload-images.jianshu.io/upload_images/2470124-75b79961043a0156.png?imageMogr2/auto-orient/strip|imageView2/2/w/1200)](https://www.jianshu.com/p/760d6cd46719)

3）、组件的图片资源放到Assets文件夹中，可以使图片可以是.bundle文件，这里注意图片的读取方式和podspec文件配置路径也要做响应改变，具体请看组件图片资源配置
[![组件图片资源配置](https://upload-images.jianshu.io/upload_images/5720820-955a649259a012f6.png?imageMogr2/auto-orient/strip|imageView2/2/w/1170、https://upload-images.jianshu.io/upload_images/5720820-955a649259a012f6.png?imageMogr2/auto-orient/strip|imageView2/2/w/1170)](https://www.jianshu.com/p/760d6cd46719)



4）、接着cd到Example下进行pod install （把刚才拖入到classes里的文件夹pod进来）
[![ pod install](https://upload-images.jianshu.io/upload_images/2470124-8567af6b27766ad4.png?imageMogr2/auto-orient/strip|imageView2/2/w/1126)](https://www.jianshu.com/p/760d6cd46719)

5)、编译组件看是否报错，编译通过后需要修改podspecs索引文件，一般需要修改下面几个问题。
[![修改podspecs索引文件]([https://upload-images.jianshu.io/upload_images/2470124-c2816d8ecfd75e7a.png?imageMogr2/auto-orient/strip|imageView2/2/w/1200]、[https://upload-images.jianshu.io/upload_images/2470124-d5972be616fa47d8.png?imageMogr2/auto-orient/strip|imageView2/2/w/1200])](https://www.jianshu.com/p/760d6cd46719)

a. 修改版本号

b. 修改项目的简单概述和详细描述

c. 修改homepage和source地址

d. 添加依赖库

6）、编译运行通过后，提交组件到远程代码库并打tag
[![打tag](https://upload-images.jianshu.io/upload_images/2470124-549c8d698095a727.png?imageMogr2/auto-orient/strip|imageView2/2/w/1136)](https://www.jianshu.com/p/760d6cd46719)

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

8）、验证通过后，pod repo push <本地索引库> <索引文件> --verbose --allow-warnings 提交索引文件到远程索引库

```
pod repo push BSpecs BCategoryKit.podspec --verbose --allow-warnings
```
本地也可以查看已成功
[![本地也可以查看已成功](https://upload-images.jianshu.io/upload_images/2470124-670ef6b39026bd2c.png?imageMogr2/auto-orient/strip|imageView2/2/w/1200)](https://www.jianshu.com/p/760d6cd46719)

9）、在需要应用改组件的工程podfile文件中pod  BCategoryKit
```
#远程组件索引地址，需要在Podfile中指定组件远程索引库地址，如果不指定默认会从master的索引库查找就会报找不到组件
source 'https://github.com/BComponent/BSpecs.git'
source 'xxxxx'
pod 'BCategoryKit'

```
查看组件远程地址 pod repo
[![pod repo](https://upload-images.jianshu.io/upload_images/2470124-9fbd94fd493bc02b.png?imageMogr2/auto-orient/strip|imageView2/2/w/1066)](https://www.jianshu.com/p/760d6cd46719)
```
pod repo
```

# 组件图片配置
## 图片存放位置和对于podspec配置
1、在组件化时，对于图片资源，我们需要把对应组件的图片资源放到对应组件如下位置
[![Assets](https://upload-images.jianshu.io/upload_images/5720820-955a649259a012f6.png?imageMogr2/auto-orient/strip|imageView2/2/w/1170)](https://www.jianshu.com/p/66da0b4585c3)

这里有个注意的地方：

在上图Assets目录下是直接把相关图片导入进来还是在Assets下新建一个文件夹，再把图片导入到该文件夹，取决于podspec文件的下图位置：

[![Assets](https://upload-images.jianshu.io/upload_images/5720820-c1ad734417244535.png?imageMogr2/auto-orient/strip|imageView2/2/w/1200)](https://www.jianshu.com/p/66da0b4585c3)
对应下图

[![podspec](https://upload-images.jianshu.io/upload_images/5720820-955a649259a012f6.png?imageMogr2/auto-orient/strip|imageView2/2/w/1170)](https://www.jianshu.com/p/66da0b4585c3)

[![Assets](https://upload-images.jianshu.io/upload_images/5720820-bf07bb7b4f000b04.png?imageMogr2/auto-orient/strip|imageView2/2/w/1200)](https://www.jianshu.com/p/66da0b4585c3)
对应下图

[![podspec](https://upload-images.jianshu.io/upload_images/5720820-270bdab67418af55.png?imageMogr2/auto-orient/strip|imageView2/2/w/1200)](https://www.jianshu.com/p/66da0b4585c3)

总的来说，步骤就是

把图片资源放到Assets目录下
修改podspec文件
cd到example下，pod install把图片导入测试项目中，效果如图：


[![pod](https://upload-images.jianshu.io/upload_images/5720820-43da62eafc60314c.png?imageMogr2/auto-orient/strip|imageView2/2/w/438)](https://www.jianshu.com/p/66da0b4585c3)


注意：

显示图片如果使用如下方式的话，是不能正常显示图片的

```
 [UIImage imageNamed:@"Group@%2x.png"];
```

原因是这种方式默认是从mainBundle中去加载图片，然而组件化之后，图片已经不再mainBundle中了，实际是在对应组件下的bundle 里面。

解决办法：
```
NSBundle *currentBundle = [NSBundle bundleForClass:[self class]];
//图片名称要写全称
NSString *patch = [currentBundle pathForResource:@"Group.png" ofType:nil inDirectory:@"BCategoryKit.bundle"];
_imgView.image = [UIImage imageWithContentsOfFile:patch];

```

如果Assets目录下放的不知图片，而是图片合集文件.bundle文件，加载路径如下：
```
NSBundle *currentBundle = [NSBundle bundleForClass:[self class]];
//如果文件夹没有放。bundle这一层就够了
NSBundle * kitBundle = [NSBundle bundleWithPath:[currentBundle pathForResource:@"<#BCategoryKit(组件名称)#>" ofType:@"bundle"]];
//如果文件夹放了bundle要解析第二层
NSBundle * imgBundle  = [NSBundle bundleWithPath:[kitBundle pathForResource:@"<#bundle名称#>" ofType:@"bundle"]];
UIImage * image = [UIImage imageWithContentsOfFile:[imgBundle pathForResource:@"<#完整的图片名称#>" ofType:@".png"]];
```


