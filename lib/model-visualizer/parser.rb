#!/usr/bin/env ruby

require_relative 'model-parser'
require_relative 'schema-parser'

class Parser
    def self.parse
        models = Hash.new

        model_parser = ModelParser.new(models)
        model_parser.parse

        schema_parser = SchemaParser.new(models)
        schema_parser.parse

        models
    end
end
