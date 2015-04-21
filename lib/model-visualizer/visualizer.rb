#!/usr/bin/env ruby

class Visualizer
    def initialize(models)
        @models = models
    end

    def create_visualization
        @models.each do |key, value|
            puts value
        end
    end
end
