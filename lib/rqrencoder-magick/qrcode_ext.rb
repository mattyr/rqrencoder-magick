require 'rqrencoder'
require 'rvg/rvg'
require 'erb'
include Magick

module RQREncoder
	class QRCode
		
		@@default_render_options = {:module_pixels => 10, :margin => 4, :fill_color => 'black', :background_color => 'white'}		

		def draw(render_options = {})
			render_rvg(@@default_render_options.merge(render_options)).draw
		end

		def save(filename, render_options = {})
			draw(render_options).write(filename)
		end

		# imagemagick's svg output is messed up
		def draw_svg(render_options = {})
			render_svg(@@default_render_options.merge(render_options))
		end

		def save_svg(filename, render_options = {})
			file = File.new(filename, "w")
			file.puts(draw_svg(render_options))
			file.close
		end

		private
		def render_rvg(options)
			pp_module = options[:module_pixels]
			margin = options[:margin]
			pixel_size = (size + (margin * 2)) * pp_module
			grid_size = size + (margin * 2)
			
			RVG.new(pixel_size, pixel_size).viewbox(0, 0, grid_size, grid_size) do |canvas|
				canvas.background_fill = options[:background_color]
				modules.each_index do |row_index|
					modules[row_index].each_with_index do |val, col_index|
						canvas.rect(1, 1, col_index + margin, row_index + margin).styles(:fill => options[:fill_color]) if val
					end
				end
			end
		end

		def render_svg(options)
			margin = options[:margin]
			pp_module = options[:module_pixels]
			overall_size = (size + (margin * 2)) * pp_module
			
			ERB.new(svg_template, nil, "%<>").result(binding)
		end

		def svg_template
			%q{<?xml version="1.0" standalone="yes"?>
				<svg version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:ev="http://www.w3.org/2001/xml-events" width="<%= overall_size %>" height="<%= overall_size %>">
				<rect style="fill:<%= options[:background_color] %>; stroke:none;" x="0" y="0" width="<%= overall_size %>" height="<%= overall_size %>" />
				% modules.each_index do |row_index|
				% 	modules[row_index].each_with_index do |val, col_index|
				% 		if val
				<rect style="fill:<%= options[:fill_color] %>; stroke:none;" x="<%= pp_module * (col_index + margin) %>" y="<%= pp_module * (row_index + margin) %>" width="<%= pp_module %>" height="<%= pp_module %>" />
				%			end
				%		end
				% end
				</svg>
			}.gsub(/^				/, '')
		end
	end
end
