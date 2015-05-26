#!/usr/bin/env ruby

class Model

    def initialize(name)
        @name = name
        @belongs_to = Array.new
        @has_one = Array.new
        @has_many = Array.new
        @has_and_belongs_to_many = Array.new
        @integer_attributes = Array.new
        @string_attributes = Array.new
        @primary_key_attributes = Array.new
        @text_attributes = Array.new
        @float_attributes = Array.new
        @decimal_attributes = Array.new
        @datetime_attributes = Array.new
        @timestamp_attributes = Array.new
        @time_attributes = Array.new
        @date_attributes = Array.new
        @binary_attributes = Array.new
        @boolean_attributes = Array.new
        @foreign_keys = Array.new
    end

    def add_belongs_to(model)
        @belongs_to << model
    end

    def add_has_one(model)
        @has_one << model
    end

    def add_has_many(model)
        @has_many << model
    end

    def add_has_and_belongs_to_many(model)
        @has_and_belongs_to_many << model
    end

    def add_integer_attribute(integer)
        @integer_attributes << integer
    end

    def add_string_attribute(string)
        @string_attributes << string
    end

    def add_primary_key_attribute(primary_key)
        @primary_key_attributes << primary_key
    end

    def add_text_attribute(text)
        @text_attributes << text
    end

    def add_float_attribute(float)
        @float_attributes << float
    end

    def add_decimal_attribute(decimal)
        @decimal_attributes << decimal
    end

    def add_datetime_attribute(datetime)
        @datetime_attributes << datetime
    end

    def add_timestamp_attribute(timestamp)
        @timestamp_attributes << timestamp
    end

    def add_time_attribute(time)
        @time_attributes << time
    end

    def add_date_attribute(date)
        @date_attributes << date
    end

    def add_binary_attribute(binary)
        @binary_attributes << binary
    end

    def add_boolean_attribute(boolean)
        @boolean_attributes << boolean
    end

    def add_foreign_key_attribute(key)
        @foreign_keys << key
    end

    def to_json(options = {})
        json = {
            'name' => @name,
            'associations' => {},
            'schema_info' => {}
        }

        if not @belongs_to.empty?
            json['associations']['belongs_to'] = @belongs_to
        end
        if not @has_one.empty?
            json['associations']['has_one'] = @has_one
        end
        if not @has_many.empty?
            json['associations']['has_many'] = @has_many
        end
        if not @has_and_belongs_to_many.empty?
            json['associations']['has_and_belongs_to_many'] = @has_and_belongs_to_many
        end

        if not @integer_attributes.empty?
            json['schema_info']['integer_attributes'] = @integer_attributes
        end
        if not @string_attributes.empty?
            json['schema_info']['string_attributes'] = @string_attributes
        end
        if not @primary_key_attributes.empty?
            json['schema_info']['primary_key_attributes'] = @primary_key_attributes
        end
        if not @text_attributes.empty?
            json['schema_info']['text_attributes'] = @text_attributes
        end
        if not @float_attributes.empty?
            json['schema_info']['float_attributes'] = @float_attributes
        end
        if not @decimal_attributes.empty?
            json['schema_info']['decimal_attributes'] = @decimal_attributes
        end
        if not @date_attributes.empty?
            json['schema_info']['date_attributes'] = @date_attributes
        end
        if not @datetime_attributes.empty?
            json['schema_info']['datetime_attributes'] = @datetime_attributes
        end
        if not @time_attributes.empty?
            json['schema_info']['time_attributes'] = @time_attributes
        end
        if not @timestamp_attributes.empty?
            json['schema_info']['timestamp_attributes'] = @timestamp_attributes
        end
        if not @binary_attributes.empty?
            json['schema_info']['binary_attributes'] = @binary_attributes
        end
        if not @boolean_attributes.empty?
            json['schema_info']['boolean_attributes'] = @boolean_attributes
        end
        if not @foreign_keys.empty?
            json['schema_info']['foreign_keys'] = @foreign_keys
        end

        json.to_json
    end

end
