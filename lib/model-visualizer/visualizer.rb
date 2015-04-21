#!/usr/bin/env ruby

class Visualizer
    def initialize(models)
        @models = models
    end

    def create_visualization
    	fileHtml = File.new('modelVisualizer.html', 'w+')

    	fileHtml.puts '<!DOCTYPE html>
		<html>
		<meta charset="utf-8">
		<style>
		/* Insert CSS here... */
		</style>
		<body>'

		@models.each do |key, value|
			fileHtml.puts '<p>'
            fileHtml.puts value
            fileHtml.puts '</p>'
        end

		fileHtml.puts '<script src="http://d3js.org/d3.v3.min.js" charset="utf-8"></script>
		
		<script>
		d3.selectAll("p").style("color", "white")
		d3.select("body").style("background-color", "black")

		</script>
		</body>
		</html>'

        fileHtml.close()
    end
end
