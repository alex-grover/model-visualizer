#!/usr/bin/env ruby

require 'active_support/inflector'
require_relative 'model'

class SchemaParser
    def initialize(models)
        @models = models
    end

    def parse
        curr_model = nil
        skip = false

        IO.foreach('db/schema.rb') do |line|
            if skip == true
                if line.include? 'end'
                    skip = false
                end
                next
            end

            if line.include? 'create_table'
                if line.include? 'slug' or line.include? 'tag' or line.include? 'version'
                    skip = true
                    next
                end

                name = /"([a-zA-Z_]+)"/.match(line)[1]
                curr_model = @models[fix_case(name)]

            elsif line.include? 't.integer'
                match = /t\.integer\s+"([[:alpha:]]+_id)"/.match(line)
                if match
                    curr_model.add_foreign_key_attribute(match[1])
                else
                    integer = /t\.integer\s+"([a-zA-Z_]+)"/.match(line)[1]
                    curr_model.add_integer_attribute(integer)
                end

            elsif line.include? 't.string'
                string = /t\.string\s+"(\w+)"/.match(line)[1]
                curr_model.add_string_attribute(string)
            end
        end
    end

    def fix_case(string)
        ActiveSupport::Inflector.singularize(ActiveSupport::Inflector.camelize(string))
    end
end
