#!/usr/bin/env ruby

require 'active_support/inflector'
require_relative 'model'

class ModelParser
    def initialize(models)
        @models = models
    end

    def parse
        unless Dir.exists? 'app/models/'
            abort 'app/models/ directory does not exist! Make sure you are in the root directory of your Rails project.'
        end

        files = Dir['app/models/**/*.rb']
        curr_model = nil

        # TODO: maybe factor this out into a parent class?
        for file in files
            IO.foreach(file) do |line|
                # TODO: hack to skip associations, we need to display these as "has_many: Users AS Managers"
                if line.include? 'class_name'
                    next
                end

                line.strip!
                if !(/^class ([[:alpha:]]+) < ActiveRecord::Base/.match(line)).nil?
                    name = /^class ([[:alpha:]]+) < ActiveRecord::Base/.match(line)[1] 
                    curr_model = Model.new(name)
                    @models[name] = curr_model

                elsif !(/^has_many :(\w+)/.match(line)).nil?
                    model_neighbor = /^has_many :(\w+)/.match(line)[1]
                    curr_model.add_has_many fix_case(model_neighbor)

                elsif !(/^has_one :(\w+)/.match(line)).nil?
                    model_neighbor = /^has_one :(\w+)/.match(line)[1]
                    curr_model.add_has_one fix_case(model_neighbor)

                elsif !(/^has_and_belongs_to_many :(\w+)/.match(line)).nil?
                    model_neighbor = /^has_and_belongs_to_many :(\w+)/.match(line)[1]
                    curr_model.add_has_and_belongs_to_many fix_case(model_neighbor)

                elsif !(/^belongs_to :(\w+)/.match(line)).nil?
                    model_neighbor = /^belongs_to :(\w+)/.match(line)[1]
                    curr_model.add_belongs_to fix_case(model_neighbor)
                end
            end
        end
    end

    def fix_case(string)
        ActiveSupport::Inflector.singularize(ActiveSupport::Inflector.camelize(string))
    end
end
