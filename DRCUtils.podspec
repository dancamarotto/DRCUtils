Pod::Spec.new do |spec|

    spec.name           = "DRCUtils"
    spec.version        = "1.0.0"
    spec.summary        = "iOS SDK for utilities"
    spec.description    = "iOS SKD with different utilities to be used on different projects"
    spec.homepage       = "https://github.com/dancamarotto/DRCUtils"
    spec.license           = { :type => 'Copyright' }
    spec.author         = { "dancamarotto" => "danilo.camarotto@gmail.com" }
    spec.platform       = :ios, "13.0"
    spec.swift_version  = "5"
    spec.source         = {
        :git => "https://github.com/dancamarotto/DRCUtils.git",
        :tag => "#{spec.version}"
    }
    spec.source_files   = "DRCUtils/**/*.{h,m,swift}"
    spec.exclude_files = "DRCUtils/Tests/**/*.*"

    spec.test_spec 'Tests' do |test_spec|
        test_spec.source_files = "DRCUtils/Tests/**/*.*"
    end
end
