Pod::Spec.new do |s|
  s.name             = "BGTableViewManager"
  s.version          = "1.0"
  s.summary          = "BGTableViewManager is supposed to simplify logic implementation for UITableView delegate and dataSource"

  s.description      = <<-DESC
  BGTableViewManager is supposed to simplify logic implementation for UITableView delegate and dataSource
                       DESC

  s.homepage         = "https://github.com/bartguminiak/BGTableViewManager"
  s.license          = 'MIT'
  s.author           = { "Bartłomiej Guminiak" => "guminiak.bartlomiej@gmail.com" }
  s.source           = { :git => "https://github.com/bartguminiak/BGTableViewManager.git", :tag => "1.0" }

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'BGTableViewManager/**/*'
  s.resource_bundles = { } 
  s.frameworks = 'UIKit'
end
