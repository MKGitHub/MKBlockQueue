Pod::Spec.new do |s|

  s.name         = "MKBlockQueue"
  s.version      = "1.0.0"
  s.summary      = "MKBlockQueue allows you to create a chain of blocks and execute them one after the other in a queue."

  s.homepage     = "https://github.com/MKGitHub/MKBlockQueue"
  s.screenshots  = "https://raw.githubusercontent.com/MKGitHub/MKBlockQueue/master/MKBlockQueue.png"

  s.license      = { :type => "Apache License, Version 2.0", :file => "LICENSE.txt" }

  s.author             = { "Mohsan Khan" => "git.mk@xybernic.com" }

  s.osx.deployment_target = "10.11"
  s.ios.deployment_target = "9.0"
  s.tvos.deployment_target = "9.0"
  s.watchos.deployment_target = "2.0" 

  s.source       = { :git => "https://github.com/MKGitHub/MKBlockQueue.git", :tag => "#{s.version}" }

  s.source_files  = "MKBlockQueue/", "MKBlockQueue.swift"

  s.requires_arc = true

end
