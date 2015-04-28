#!/usr/bin/env ruby

require 'active_support/inflector'
require_relative 'model'

class SchemaParser
    SCHEMA_FILE = 'db/schema.rb'

    def initialize(models)
        @models = models
    end

    def parse
        unless File.file? SCHEMA_FILE
            abort 'db/schema.rb does not exist! Make sure you are in the root directory of your Rails project.'
        end

        curr_model = nil

        IO.foreach(SCHEMA_FILE) do |line|
            if line.include? 'create_table'
                name = /"([a-zA-Z_]+)"/.match(line)[1]
                fixed_name = fix_case(name)
                curr_model = @models[fixed_name]

                # Rails generated models are not in hash
                if curr_model == nil
                    curr_model = Model.new(fixed_name)
                    @models[fixed_name] = curr_model
                end

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

            elsif line.include? 't.primary_key'
                primary_key = /t\.primary_key\s+"(\w+)"/.match(line)[1]
                curr_model.add_primary_key_attribute(primary_key)

            elsif line.include? 't.text'
                text = /t\.text\s+"(\w+)"/.match(line)[1]
                curr_model.add_text_attribute(text)

            elsif line.include? 't.float'
                float = /t\.float\s+"(\w+)"/.match(line)[1]
                curr_model.add_float_attribute(float)

            elsif line.include? 't.decimal'
                decimal = /t\.decimal\s+"(\w+)"/.match(line)[1]
                curr_model.add_decimal_attribute(decimal)

            elsif line.include? 't.datetime'
                datetime = /t\.datetime\s+"(\w+)"/.match(line)[1]
                curr_model.add_datetime_attribute(datetime)

            elsif line.include? 't.timestamp'
                timestamp = /t\.timestamp\s+"(\w+)"/.match(line)[1]
                curr_model.add_timestamp_attribute(timestamp)

            elsif line.include? 't.time'
                time = /t\.time\s+"(\w+)"/.match(line)[1]
                curr_model.add_time_attribute(time)

            elsif line.include? 't.date'
                date = /t\.date\s+"(\w+)"/.match(line)[1]
                curr_model.add_date_attribute(date)

            elsif line.include? 't.binary'
                binary = /t\.binary\s+"(\w+)"/.match(line)[1]
                curr_model.add_binary_attribute(binary)

            elsif line.include? 't.boolean'
                boolean = /t\.boolean\s+"(\w+)"/.match(line)[1]
                curr_model.add_boolean_attribute(boolean)
            end
        end
    end

    def fix_case(string)
        ActiveSupport::Inflector.singularize(ActiveSupport::Inflector.camelize(string))
    end
end
