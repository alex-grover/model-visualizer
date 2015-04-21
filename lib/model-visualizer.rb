#!/usr/bin/env ruby

require 'model-visualizer/parser'
require 'model-visualizer/visualizer'

class ModelVisualizer
    # Entry point into the gem. Runs the parser and visualizer to generate the full visualization.
    def self.run
        models = Parser.parse
        visualizer = Visualizer.new(models)
        visualizer.create_visualization
    end
end
