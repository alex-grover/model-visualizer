# model-visualizer
An easy way to create a visual of the model structure in your Rails projects. A project developed by [ajgrover](https://github.com/ajgrover), [bgott](https://github.com/bgott), [Sxl1092](https://github.com/Sxl1092), and [ryanrperez](https://github.com/ryanrperez).

## Installation
Install from source:

```bash
$ git clone https://github.com/ajgrover/model-visualizer.git
$ cd model-visualizer
$ gem build model-visualizer.gemspec
$ [sudo] gem install model-visualizer-1.0.0.gem
```

Install via RubyGems:

```bash
$ [sudo] gem install model-visualizer
```

## Use

From the root directory of your Rails app, simply run `model-visualizer`. The gem searches the `app/models/` directory as well as `db/schema.rb` (optional) and creates the visualization based on the files found there in an output file named `model-visualizer.html`. You can also pass in the path to the Rails app directory on the command line, but the output file will be created in the current directory. The project is entirely self contained so should not require a network connection to run.

## Support
Tested extensively on Mac but should work on Linux and Windows as well. If not, [let us know](https://github.com/ajgrover/model-visualizer/issues/new) or submit a pull request! Contributions are welcome.
