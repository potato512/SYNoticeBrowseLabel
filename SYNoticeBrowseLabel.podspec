
Pod::Spec.new do |s|

  s.name         = "SYNoticeBrowseLabel"
  s.version      = "0.0.1"
  s.summary      = "跑马灯功能标签SYNoticeBrowseLabel。"
  s.description  = <<-DESC
                    自定义跑马灯功能类标签SYNoticeBrowseLabel。
                   DESC

  s.homepage     = "https://github.com/potato512/SYNoticeBrowseLabel"

  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author             = { "derZhang" => "zhangsy757@163.com" }

  s.platform     = :ios, "5.0"
  s.ios.deployment_target = "5.0"

  s.source       = { :git => "https://github.com/potato512/SYNoticeBrowseLabel.git", :tag => "#{s.version}" }
  s.source_files  = "SYNoticeBrowseLabel", "SYNoticeBrowseLabel/*.{h,m}"
  s.public_header_files = "SYNoticeBrowseLabel/*.h"

  s.requires_arc = true

end
