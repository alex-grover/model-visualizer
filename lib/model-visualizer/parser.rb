#!/usr/bin/env ruby

require_relative 'model'

class Parser
    def parse
        files = Dir['app/models/*']
        models = Array.new
        curr_model = nil
        for file in files
            IO.foreach(file) do |line|
                if line.include? 'class'
                    name = /class ([[:alpha:]]+)/.match(line)[1]
                    curr_model = Model.new(name)
                    #puts 'model name = ' + curr_model.to_s
                end
                if line.include? 'has_many'
                    model_neighbor = /has_many :(\w+)/.match(line)[1]
                    curr_model.add_has_many(model_neighbor)
                    #puts 'has_many = ' + model_neighbor
                end
                if line.include? 'has_one'
                    model_neighbor = /has_one :(\w+)/.match(line)[1]
                    curr_model.add_has_one(model_neighbor)
                    #puts 'has_one = ' + model_neighbor
                end
                if line.include? 'belongs_to'
                    model_neighbor = /belongs_to :(\w+)/.match(line)[1]
                    curr_model.add_belongs_to(model_neighbor)
                    #puts 'belongs_to = ' + model_neighbor
                end
                if line.include? 'has_and_belongs_to_many'
                    model_neighbor = /has_and_belongs_to_many :(\w+)/.match(line)[1]
                    curr_model.add_has_and_belongs_to_many(model_neighbor)
                    #puts 'has_and_belongs_to_many = ' + model_neighbor
                end
            end
            puts curr_model
            models.push(curr_model)
        end
        models
    end
end
