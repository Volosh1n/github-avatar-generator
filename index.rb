require 'chunky_png'

background_color = ChunkyPNG::Color.rgb(240, 240, 240)
image_size = [420, 420]
nodes = [
  (30..102),
  (102..174),
  (174..246),
  (246..318),
  (318..390)
]

secondary_color = ChunkyPNG::Color.rgb(rand(0..255), rand(0..255), rand(0..255))

squares = Array.new(rand(11..14)) do
  { x_pixels: nodes.sample, y_pixels: nodes.sample }
end

png = ChunkyPNG::Image.new(*image_size, background_color)

squares.each do |square_coordinates|
  square_coordinates[:x_pixels].each do |x|
    square_coordinates[:y_pixels].each do |y|
      png[x, y] = secondary_color
    end
  end
end

png.save('images/image.png')
