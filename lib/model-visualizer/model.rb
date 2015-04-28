#!/usr/bin/env ruby

class Model
    attr_reader :belongs_to
    attr_reader :has_one
    attr_reader :has_many
    attr_reader :has_and_belongs_to_many
    attr_reader :integer_attributes
    attr_reader :string_attributes
    attr_reader :primary_key_attributes
    attr_reader :text_attributes
    attr_reader :float_attributes
    attr_reader :decimal_attributes
    attr_reader :datetime_attributes
    attr_reader :timestamp_attributes
    attr_reader :time_attributes
    attr_reader :date_attributes
    attr_reader :binary_attributes
    attr_reader :boolean_attributes
    attr_reader :foreign_keys

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
        {
            'name' => @name,
            'associations' => {
                'belongs_to' => @belongs_to,
                'has_one' => @has_one,
                'has_many' => @has_many,
                'has_and_belongs_to_many' => @has_and_belongs_to_many
            },
            'schema_info' => {
                'integer_attributes' => @integer_attributes,
                'string_attributes' => @string_attributes,
                'primary_key_attributes' => @primary_key_attributes,
                'text_attributes' => @text_attributes,
                'float_attributes' => @float_attributes,
                'decimal_attributes' => @decimal_attributes,
                'date_attributes' => @date_attributes,
                'datetime_attributes' => @datetime_attributes,
                'time_attributes' => @time_attributes,
                'timestamp_attributes' => @timestamp_attributes,
                'binary_attributes' => @binary_attributes,
                'boolean_attributes' => @boolean_attributes,
                'foreign_keys' => @foreign_keys
            }
        }.to_json
    end

end
