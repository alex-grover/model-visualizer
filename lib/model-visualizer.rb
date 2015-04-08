#!/usr/bin/env ruby

require 'model-visualizer/parser.rb'
require 'model-visualizer/visualizer.rb'

class ModelVisualizer
    # Entry point into the gem. Runs the parser and visualizer to generate the full visualization.
    def self.run
        parser = Parser.new(Dir.pwd)
        parser.parse

        visualizer = Visualizer.new(nil)
        visualizer.create_visualization
    end
end
