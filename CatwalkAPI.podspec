Pod::Spec.new do |spec|

  spec.name         = "CatwalkAPI"
  spec.version      = "0.9.0"
  spec.summary      = "Catwalk's CocoaPods library for you Fashion Virtual Assistant"

  spec.description  = <<-DESC
  Catwalk's SDK let you offer an intelligent Fashion Virtual Assistant to assist your users during their purchase journey on your applications, creating looks, finding similar items, showing item details, gathering information for clothing, managing multiple SKUs for sale and adding them altogheter into your shopping Cart
                   DESC

    spec.license                        = { :type => 'MIT', :file => 'LICENSE' }
  spec.homepage     = "https://github.com/catwalkhub/CatwalkAPI"
  spec.author             = { "development" => "development@mycatwalk.com" }

  spec.ios.deployment_target = "13.6"
    spec.swift_version = "4.2"

  spec.source       = { :git => "https://github.com/catwalkhub/CatwalkAPI.git", :tag => "#{spec.version}" }

  spec.source_files  = "CatwalkAPI/**/*.{h,m,swift}"

end
