#!/usr/bin/env ruby

require_relative 'model'

class ParserSchema(models)
    def parse
        file = Dir['db/schema']
        curr_model = nil

        IO.foreach(file) do |line|
            if line.include? 'create_table'
                name = /"([[:alpha:]]+)"/.match(line)[1]
                name = normalize(name)
                curr_model = models[name]
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

        models[name] = curr_model
        end

        models
    end

    def normalize(name)
        name = name[0..-1]
        curr_index = 0
        while !curr_index.nil?
            name[curr_index] = name[curr_index].upcase
            curr_index = name.index('_', curr_index + 1) + 1
        end
        name.gsub!('_', '')
        return name
    end
end
