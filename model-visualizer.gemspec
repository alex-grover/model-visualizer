Gem::Specification.new do |s|
  s.name        = 'model-visualizer'
  s.version     = '0.0.2'
  s.executables << 'model-visualizer'
  s.date        = '2015-04-09'
  s.summary     = 'A model visualizer for Rails.'
  s.description = 'An easy way to create a visual of the model structure in your Rails projects.'
  s.authors     = ["Alex Grover", "Brandon Gottfried", "Steven Longoria", "Ryan Perez"]
  s.email       = 'ajgrover@stanford.edu'
  s.files       = ["lib/model-visualizer.rb",
                   "lib/model-visualizer/parser.rb",
                   "lib/model-visualizer/visualizer.rb",
                   "lib/model-visualizer/model.rb",
                   "lib/model-visualizer/model-parser.rb",
                   "lib/model-visualizer/schema-parser.rb",
                   "share/template.html",
                   "share/main.css",
                   "share/background.png",
                   "share/d3.min.js",
                   "share/d3.tip.js"]
  s.homepage    = 'http://rubygems.org/gems/model-visualizer'
  s.license     = 'ISC'
  s.add_runtime_dependency 'activesupport'
end
