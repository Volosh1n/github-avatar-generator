require 'chunky_png'

class GithubAvatar
  def call
    draw_squares_with_coordinates(left_figure_coordinates)
    mirror_left_side_to_right
    draw_squares_with_coordinates(central_figure_coordinates)
    save_png
  end

  private

  def figure_coordinates_by_y
    @figure_coordinates_by_y ||= Array.new(rand(5..7)) { nodes.sample }
  end

  def left_figure_coordinates
    @left_figure_coordinates ||= figure_coordinates_by_y.map do |y|
      { x_pixels: nodes.first(2).sample, y_pixels: y }
    end
  end

  def mirror_left_side_to_right
    right_figure_coordinates = left_figure_coordinates.each_with_index.map do |sqaure, index|
      reversed_left_figure_x_coordinate = nodes[4 - nodes.index(sqaure[:x_pixels])]
      { x_pixels: reversed_left_figure_x_coordinate, y_pixels: figure_coordinates_by_y[index] }
    end
    draw_squares_with_coordinates(right_figure_coordinates)
  end

  def central_figure_coordinates
    Array.new(rand(0..5)) { { x_pixels: nodes[2], y_pixels: nodes.sample } }
  end

  def background_color
    @background_color ||= ChunkyPNG::Color.rgb(240, 240, 240)
  end

  def figure_color
    @figure_color ||= ChunkyPNG::Color.rgb(rand(0..255), rand(0..255), rand(0..255))
  end

  def png
    @png ||= ChunkyPNG::Image.new(420, 420, background_color)
  end

  def nodes
    [
      (30..102),
      (102..174),
      (174..246),
      (246..318),
      (318..390)
    ]
  end

  def draw_squares_with_coordinates(squares)
    squares.each do |square_coordinates|
      square_coordinates[:x_pixels].each do |x|
        square_coordinates[:y_pixels].each do |y|
          png[x, y] = figure_color
        end
      end
    end
  end

  def save_png
    png.save('examples/image.png')
  end
end
