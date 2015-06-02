#!/usr/bin/env ruby

require 'model-visualizer/parser'
require 'model-visualizer/visualizer'

class ModelVisualizer
    # Entry point into the gem. Runs the parser and visualizer to generate the full visualization.
    def self.run
        # Poor man's option parsing
        if ARGV.length > 1
            abort 'Usage: model-visualizer [path]'
        end

        root = if ARGV.length == 1 then ARGV[0] else '.' end

        path = File.absolute_path root

        unless Dir.exists? path
            abort 'Error: Path given does not exist!'
        end

        models = Parser.parse path
        Visualizer.new(models).create_visualization(File.basename path)
    end
end
