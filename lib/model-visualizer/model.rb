#!/usr/bin/env ruby

class Model
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
        @name
    end

end
