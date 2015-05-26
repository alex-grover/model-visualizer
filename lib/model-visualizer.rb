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

        models = Parser.parse root
        Visualizer.new(models).create_visualization(File.basename root)
    end
end
