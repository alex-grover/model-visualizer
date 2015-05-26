#!/usr/bin/env ruby

require 'json'

class Visualizer
    FILE_PATH = 'model-visualizer.html'

    def initialize(models)
        @models = models
    end

    def create_visualization(title)
        # Get file from gem directory
        g = Gem::Specification.find_by_name 'model-visualizer'
        template = File.join(g.full_gem_path, 'share/template.html')
        css = File.join(g.full_gem_path, 'share/main.css')
        d3 = File.join(g.full_gem_path, 'share/d3.min.js')

        # Insert data into file
        template_contents = File.read template
        output = template_contents.gsub(/<%= @models %>/, JSON.generate(@models))
                                  .gsub(/<%= @css %>/, css)
                                  .gsub(/<%= @d3 %>/, d3)
                                  .gsub(/<%= @title %>/, title + ' Model Visualization')
                                  .gsub(/<%= @sidebar %>/, create_sidebar)

        # Write and open file
        File.open(FILE_PATH, 'w') {|file| file.puts output}
        self.launch_browser FILE_PATH
    end

    def create_sidebar
        str = '<div class="sidebar">'
        str += '<div class="search"><input type="search" class="searchbox" results=5 size="large" placeholder="Search"></div>' # input type="search" does not let you resize in webkit
        @models.sort.each do |name, model|
            str += '<div class="model" onclick="highlightNode(this.innerHTML)">' + name + '</div>'
        end
        str += '</div>'
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
