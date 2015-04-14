#!/usr/bin/env ruby

require_relative 'model'

class ParserSchema
    def parse
        file = Dir['db/schema']
        models = Array.new
        curr_model = nil

        
        IO.foreach(file) do |line|
            if line.include? 'create_table'
                name = /"([[:alpha:]]+)"/.match(line)[1]
                curr_model = Model.new(name) #name would be a bit different because capitalization
            end

            if line.include? 't.integer'
                if key = /t.integer "(\w+_id)"/.match(line)[1]
                    curr_model.add_foreign_key(key)     
                else
                    integer = /t.integer "(\w+)"/.match(line)[1]
                    curr_model.add_integer_attribute(integer)
                end
            end

            if line.include? 't.string'
                string = /t.string "(\w+)"/.match(line)[1]
                curr_model.add_string_attribute(string)
            end
        end

        models.push(curr_model)
        end

        models
    end
end
