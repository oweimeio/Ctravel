# HACore

华奥科技，核心库

## Example 示例工程

To run the example project, clone the repo, and run `pod install` from the Example directory first.

克隆工程，在example文件夹下，运行`pod install`命令，即可生成示例工程.

## Requirements

系统版本: iOS 8.2 above.

依赖管理: Cocoapods 1.2.0 and above.

## Installation 安装

HACore is available through [HuaaoPods](http://121.43.33.181:10001/summary/ha-comp%2FHACore.git). To install
it, simply add the following line to your Podfile:

```ruby
pod "HACore"
```

添加pod到`Podfile`即可安装本私有库.

## Features

### HACore

方法以单例`[HACore core]`展开. 包括:

1. 内部错误的控制台输出 `-logInnerError:`

2. 基础配置文件项的读取 `-valueForConfWithKey:`

类方法则为各个模块的数据相关功能. 如:

1. 访问鉴权模块, 有登录字段验证, 登录请求等.

2. 微服务模块, 有"社区热点"列表数据获取请求等.

### Core UI Category

包含核心库所需的一些常用UI控件的操作. 如:

UITextField的输入验证等.

### HAModel

核心库模型(Model)基类.

实现协议NSCopying和NSCoding.

带有持久化到Documents沙盒的方法, `-persist`.

和唯一标识符`UID`(NSString *).

### HAUser, HAUserWjw

核心库用户模型. 属于`HAModel`子类.

拥有公司用户模型的基础

### HAApp

该模型的单例[HAApp current]为应用数据实例.

通过属性可获取 token/userID 等.

## Change Logs

1.0.0 -

1.0.16 - HACoreAPI增加OSS访问能力

1.0.18 - 合并Meeting与Class分支功能 - 我的主界面列表数据算法

1.0.19 - 重构Const常量, 按功能拆分

1.0.20 - 服务返回数据结构变更

1.0.21 - 更多菜单用户类型更新

1.0.22 - API目录重构

1.0.23 - 图片视图网络请求

1.0.24 - const键值

1.0.25 - meeting API更新 - App对象支持上次登录账号记录

1.0.26 - App修复因变更导致的登录状态数据持久化不成功的问题 - App新增更新核心库内部登录用户数据的能力 - 核心库新增Notification的Constants

1.0.27 - 核心库App支持AppType类型记录与切换

1.0.28 - 用户模型新增部分字段

1.0.29 - CoreAPI新增本地服务的formData上传图片功能

1.0.30 - 用户模型新增实名认证相关字段 - 用户模型具有判断自身权限能力

1.0.31 - 字符验证

1.0.32 - 服务类人员的辖区坐标

1.0.33 - CoreAPI新增向本地服务进行formData上传文件的功能

1.0.34 - CoreAPI消息字段变更(严重)

1.0.35 - App模型具有自更新当前用户数据的能力

1.0.37 - Core拥有快速获取当前登录的微警务标准版用户数据的功能

1.0.40 - 修复用户数据自更新的token损失问题

1.0.41 - 错误提示语更新(登录段)

1.0.42 - 修复文档注释中的错误

1.0.43 - 根据需求增加未确定的性别类型

1.0.44 - 默认性别的取值

1.0.45 - LYCategory更新 - 核心库新增Color分类

1.0.46 - general fix

1.0.47 - camera and photo access check

1.1.0 - core api (dev/production)

1.1.1 - text - image url with placeholder bundle setter

1.1.2 - update police user cooordinate

1.1.3 - extract user gender for id number

1.1.4 - image url assembler

1.1.5 - coordinate model

1.1.6 - verify

1.1.7 - base view controller

1.1.8 - views

1.1.9 - design initializer

1.1.10 - base view controller import

1.1.11 - image url assembler

1.1.12 - update device token

1.1.13 - device token

1.1.14 - login request

1.1.15 - update device url

1.2.0 - add ygwjw user model

1.2.1 - fix user(yg) module import

1.2.2 - user(yg) add type

1.2.3 - user(yg) add user identity key

1.2.4 - persist user(yg) interface

1.2.5 - number methods; user(yg) model updated

1.2.6 - lock portrait category

1.2.7 - iOS 7.x support

1.2.8 - coordinate reader and converter

1.2.10 - hint view with xb

1.2.11 - additional record type

1.2.12 - map kit

1.2.13 - add HAUserPaxy (梅)

1.2.14 - 更改 s.version版本号 (梅)

1.2.15 - add map view focus on user commmunity area method

1.2.17 - map view focus on user center coordinate with area span

1.2.18 - map pin clean style

1.2.19 - update user persist method

1.2.20 - image url convert

1.2.22 - refactoring focus methods

1.2.23 - let image url transform code with utf8

1.2.24 - image view url setter

1.2.28 - device and user default, fixed key

1.2.29 - 帮扶直通车用户数据更新添加

1.2.30 - New+阳光系列的推送通知的device token更新API

1.2.31 - image url requester

1.2.32 - image url checker and area request parameter changed

1.2.33 - ygwjw-user with userInfo to hold all server user data

1.2.34 - token lose user need login

1.2.35 - add custom bar button item with badge feature

1.2.37 - badge count of message in HAApp.current

1.2.38 - badge count max value conf

1.2.39 - add badge string

1.2.41 - badge 0 value

1.2.42 - 阳光用户数据更新调整

1.2.46 - remove portrait lock

1.2.48 - map view focus method with center coordinate checker

1.2.51 - paxy请求头添加参数用来区分服务端

## Author

骆昱 (Luo Yu), indie.luo@gmail.com

## License

HACore is under a private license.
