Pod::Spec.new do |s|
  s.name         = "DBIndexPath"
  s.version      = "0.1.1"
  s.summary      = "A simple Swift struct that allows you to define enums with NSIndexPaths, to allow easier UITableView configuration."
  s.description  = <<-DESC
                   DBIndexPath is a simple wrapper struct around an NSIndexPath, to make it 
                   possible to define an index path enum and switch on its cases. This is 
                   especially useful in UITableViewDataSource/UITableViewDelegate methods, where
                   you might execute different code depending on which row you are dealing with.
                   DESC
  s.homepage     = "https://github.com/danielbyon/DBIndexPath"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "Daniel Byon" => "contact@danielbyon.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/danielbyon/DBIndexPath.git", :tag => s.version.to_s }
  s.source_files = "DBIndexPath/**/*.{h,m,swift}"
  s.frameworks   = "Foundation", "UIKit"
  s.requires_arc = true

end
