#!/usr/bin/env ruby

class Model
    attr_reader :belongs_to
    attr_reader :has_one
    attr_reader :has_many
    attr_reader :has_and_belongs_to_many

    def initialize(name)
        @name = name
        @belongs_to = Array.new
        @has_one = Array.new
        @has_many = Array.new
        @has_and_belongs_to_many = Array.new
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

    def to_s
        str = @name + ":"
        str += "\n\tbelongs_to: [" + @belongs_to.join(", ") + "]"
        str += "\n\thas_one: [" + @has_one.join(", ") + "]"
        str += "\n\thas_many: [" + @has_many.join(", ") + "]"
        str += "\n\thas_and_belongs_to_many: [" + @has_and_belongs_to_many.join(", ") + "]"
        str
    end
end
