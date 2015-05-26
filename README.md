# model-visualizer
An easy way to create a visual of the model structure in your Rails projects.

## Installation
Install from source: 

```bash
$ git clone https://github.com/ajgrover/model-visualizer.git
$ cd model-visualizer
$ gem build model-visualizer.gemspec
$ gem install model-visualizer-*.gem
```

Install via RubyGems:

```bash
$ gem install model-visualizer
```

## Use

From the root directory of your Rails app, simply run `model-visualizer`. The gem searches the `app/models/` directory and creates the visualization based on the files found there as well as `schema.rb`.
