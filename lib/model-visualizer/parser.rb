#!/usr/bin/env ruby

require_relative 'model'

class Parser
    def parse
        files = Dir['app/models/*']
        models = Array.new
        for file in files
            IO.foreach(file) do |line|
                if line.include? 'class'
                    name = /class ([[:alpha:]]+)/.match(line)[1]
                    model = Model.new(name)
                    models.push(model)
                end
            end
        end
        models
    end
end
