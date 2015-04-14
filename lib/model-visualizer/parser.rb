#!/usr/bin/env ruby

require_relative 'model'

class Parser
    def parse
        #TO DO make sure we're only grabbing model files -- not concerns dir
        files = Dir['app/models/*.rb']
        models = Array.new
        curr_model = nil

        for file in files
            IO.foreach(file) do |line|
                if line.include? 'class'
                    name = /class ([[:alpha:]]+)/.match(line)[1]
                    curr_model = Model.new(name)
                    models.push(curr_model)
                    #puts 'new model = ' + name
                elsif line.include? 'has_many'
                    model_neighbor = /has_many :(\w+)/.match(line)[1]
                    curr_model.add_has_many(model_neighbor)
                    #puts "\thas_many : " + model_neighbor

                elsif line.include? 'has_one'
                    model_neighbor = /has_one :(\w+)/.match(line)[1]
                    curr_model.add_has_one(model_neighbor)
                    #puts "\thas_one : " + model_neighbor
                
                elsif line.include? 'has_and_belongs_to_many'
                    model_neighbor = /has_and_belongs_to_many :(\w+)/.match(line)[1]
                    #puts "\thas_and_belongs_to : " + model_neighbor
                    curr_model.add_has_and_belongs_to_many(model_neighbor)
                
                elsif line.include? 'belongs_to'
                    model_neighbor = /belongs_to :(\w+)/.match(line)[1]
                    curr_model.add_belongs_to(model_neighbor)
                    #puts "\tbelongs_to : " + model_neighbor
                end
            end


        end

        models
    end
end
