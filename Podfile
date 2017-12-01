# SOURCE
source 'http://git.huaaotech.net/base/HASpecs.git'
source 'https://github.com/blodely/LYSpecs.git'
source 'https://github.com/CocoaPods/Specs.git'

# DEFINE A GLOBAL PLATFORM FOR YOUR PROJECT
platform :ios, '8.2'
inhibit_all_warnings!

def libpods
	pod 'BlocksKit', '~> 2.2.5'
	pod 'FreeStreamer', '~> 3.7.2'
	pod 'mp3lame-for-ios', '= 0.1.1'
	pod 'FCUUID', '~> 1.3.1'
	pod 'Masonry'
    pod 'Pingpp', '~> 2.2.13'
    pod 'JTCalendar', '~> 2.0'
	pod 'RongCloudIM/IMLib', '~> 2.8.3'
	pod 'RongCloudIM/IMKit', '~> 2.8.3'
    pod 'AliyunOSSiOS', '=2.6.0'
end

def lypods
	pod 'LYCategory', '~> 1.2.22'
	pod 'ModuleProgressHUD', '~> 1.0.5'
	pod 'ConfigKit', '~> 1.2.6'
	pod 'ModulePullRefresh', '~> 1.0.0'
end

def huaaopods
	pod 'FileManager', '~> 1.0.2'
	pod 'HACore', '~> 1.2.5'
	pod 'HALogKit', '~> 1.0.4'
end

def huaaomodules
    
end

target ‘Ctravel’ do
	use_frameworks!

	huaaopods
	huaaomodules
	lypods
	libpods

end
