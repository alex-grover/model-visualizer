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
            .node {
                    stroke: #fff;
                    stroke-width: 1.5px;
            }

            .link {
                    stroke: #999;
                    stroke-opacity: .6;
            }
        </style>
        <body>
        <script src="http://d3js.org/d3.v3.min.js" charset="utf-8"></script>

        <script type="application/json" id="models">
        {
            "nodes": [{
                "name": "User",
                    "group": 1
            }, {
                "name": "Project",
                    "group": 1
            }, {
                "name": "Data",
                    "group": 1
            }],
                "links": [{
                "source": 0,
                    "target": 1,
                    "value": 1
            }, {
                "source": 1,
                    "target": 2,
                    "value": 1
            }, {
                "source": 0,
                    "target": 2,
                    "value": 1
            }]
        }
        </script>

        <script>

        var width = 960,
            height = 500;

        var color = d3.scale.category20();

        var force = d3.layout.force()
            .charge(-120)
            .linkDistance(30)
            .size([width, height]);

        var svg = d3.select("body").append("svg")
            .attr("width", width)
            .attr("height", height);

        var models = document.getElementById("models").innerHTML;
        graph = JSON.parse(models);
        force
            .nodes(graph.nodes)
            .links(graph.links)
            .start();

        var link = svg.selectAll(".link")
            .data(graph.links)
          .enter().append("line")
            .attr("class", "link")
            .style("stroke-width", function(d) { return Math.sqrt(d.value); });

        var node = svg.selectAll(".node")
            .data(graph.nodes)
          .enter().append("circle")
            .attr("class", "node")
            .attr("r", 5)
            .style("fill", function(d) { return color(d.group); })
            .call(force.drag);

        node.append("title")
            .text(function(d) { return d.name; });

        force.on("tick", function() {
          link.attr("x1", function(d) { return d.source.x; })
              .attr("y1", function(d) { return d.source.y; })
              .attr("x2", function(d) { return d.target.x; })
              .attr("y2", function(d) { return d.target.y; });

          node.attr("cx", function(d) { return d.x; })
              .attr("cy", function(d) { return d.y; });
        });

        </script>
        </body>
        </html>'
        fileHtml.close()
    end
end
