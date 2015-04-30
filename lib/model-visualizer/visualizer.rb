#!/usr/bin/env ruby

require 'json'

class Visualizer
    FILE_PATH = 'modelVisualizer.html'

    def initialize(models)
        @models = models
    end

    def create_visualization
        fileHtml = File.new(FILE_PATH, 'w+')

        fileHtml.puts '
        <!DOCTYPE html>
        <html lang="en-US">
            <head>
                <title>Rails Model Visualizer</title>
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
                <script src="http://d3js.org/d3.v3.min.js" charset="utf-8"></script>
            </head>

            <body>
                <script>
                    (function() {
                        var data = ' + JSON.generate(@models) + ';
                        var nodes = [];
                        var links = [];

                        // Create node array and number each one
                        var i = 0;
                        for (var key in data) {
                            if (data.hasOwnProperty(key)) {
                                data[key].node_number = i++;
                                nodes.push({
                                    name: key,
                                    group: 1
                                });
                            }
                        }

                        // Create links array using associations
                        for (var key in data) {
                            if (data.hasOwnProperty(key)) {
                                node = data[key];
                                for (var association_type in node.associations) {
                                    node.associations[association_type].forEach(function(assn) {
                                        links.push({
                                            source: node.node_number,
                                            target: data[assn].node_number,
                                            type: association_type
                                        });
                                    });
                                }
                            }
                        }

                        var width = 960,
                            height = 500;

                        var color = d3.scale.category20();

                        var force = d3.layout
                                      .force()
                                      .charge(-120)
                                      .linkDistance(30)
                                      .size([width, height]);

                        var svg = d3.select("body")
                                    .append("svg")
                                    .attr("width", width)
                                    .attr("height", height);

                        force.nodes(nodes)
                             .links(links)
                             .start();

                        var link = svg.selectAll(".link")
                                      .data(links)
                                      .enter().append("line")
                                      .attr("class", "link")
                                      .style("stroke", function(d) {
                                          switch(d.type) {
                                              case "belongs_to":
                                                  return "#000";
                                              case "has_and_belongs_to_many":
                                                  return "#f00";
                                              case "has_many":
                                                  return "#0f0";
                                              case "has_one":
                                                  return "#00f";
                                              default:
                                                  return "#999";
                                          }
                                      }).style("stroke-width", function(d) { return Math.sqrt(d.value); });

                        var node = svg.selectAll(".node")
                                      .data(nodes)
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
                    })();
                </script>
            </body>
        </html>'
        fileHtml.close()

        self.launch_browser FILE_PATH
    end

    # http://stackoverflow.com/questions/152699/open-the-default-browser-in-ruby
    def launch_browser(path)
        if RbConfig::CONFIG['host_os'] =~ /mswin|mingw|cygwin/
            system "start #{path}"
        elsif RbConfig::CONFIG['host_os'] =~ /darwin/
            system "open #{path}"
        elsif RbConfig::CONFIG['host_os'] =~ /linux|bsd/
            system "xdg-open #{path}"
        end
    end
end
