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

    def add_foreign_key_attribute(key)
        @foreign_keys << key
    end

    def to_s
        str = @name + ":"
        str += "\n\tbelongs_to: [" + @belongs_to.join(", ") + "]"
        str += "\n\thas_one: [" + @has_one.join(", ") + "]"
        str += "\n\thas_many: [" + @has_many.join(", ") + "]"
        str += "\n\thas_and_belongs_to_many: [" + @has_and_belongs_to_many.join(", ") + "]"
        str += "\n\tinteger attributes: [" + @integer_attributes.join(", ") + "]"
        str += "\n\tstring attributes: [" + @string_attributes.join(", ") + "]"
        str += "\n\tforeign keys: [" + @foreign_keys.join(", ") + "]"
    end
end
