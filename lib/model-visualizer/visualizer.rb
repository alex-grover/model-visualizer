#!/usr/bin/env ruby

class Visualizer
    def initialize(models)
        @models = models
    end

    def create_visualization
        for model in @models
            puts model
        end
    end
end
