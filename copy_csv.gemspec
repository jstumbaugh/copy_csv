
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "copy_csv/version"

Gem::Specification.new do |spec|
  spec.name          = "copy_csv"
  spec.version       = CopyCsv::VERSION
  spec.authors       = ["Jason Stumbaugh"]
  spec.email         = ["stumbaughjason@gmail.com"]

  spec.summary       = %q{Copy an ActiveRecord relation to a CSV formatted string}
  spec.description   = %q{Copy an ActiveRecord relation to a CSV formatted string}
  spec.homepage      = "https://github.com/jstumbaugh/copy_csv"
  spec.license       = "MIT"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_runtime_dependency "activesupport", ">= 5.0"
end
