require 'gosu'
require_relative 'board.rb'
require_relative 'game.rb'

# Class to display GosuWindow
class GosuWindow < Gosu::Window
  BACKGROUND = Gosu::Color.new(0xff_000000) #black
  ALIVE = Gosu::Color.new(0xff_808080) #gray
  DEAD = Gosu::Color.new(0xff_000000) #black

  def initialize(height=800, width=600)
    super(height, width, false)
    self.caption = "Game Of Life - @ludico8"
    @height = height
    @width = width
    @iteration = 0
    
    @rows = height/10
    @cols = width/10

    @row_height = height/@rows
    @col_width = width/@cols

    # Initialize new Board and new Game
    @board = Board.new(@rows, @cols)
    @game = Game.new(@board)
    @game.board.auto_populate
  end

  def update
    @game.play
    @iteration += 1
    puts "Iteration ##{@iteration}"
  end

  def draw_cell(x_coordinate, y_coordinate, color)
    first_vertex_x = x_coordinate * @col_width
    first_vertex_y = y_coordinate * @row_height
    second_vertex_x = first_vertex_x + ( @col_width - 1)
    third_vertex = first_vertex_y + (@row_height - 1)
    draw_quad(first_vertex_x, first_vertex_y, color, second_vertex_x, first_vertex_y, color, second_vertex_x, third_vertex, color, first_vertex_x, third_vertex, color)
  end

  def draw
    draw_quad(0, 0, BACKGROUND,width, 0, BACKGROUND, width, height, BACKGROUND, 0, height, BACKGROUND)
    @game.board.cells.each do |cell|
      draw_cell(cell.x, cell.y, (cell.alive? ? ALIVE : DEAD))
    end
  end

  def needs_cursor?
    true
  end
end

puts <<-EOC

  ██████╗  █████╗ ███╗   ███╗███████╗     ██████╗ ███████╗    ██╗     ██╗███████╗███████╗              ██╗     ██╗   ██╗██████╗ ██╗ ██████╗ ██████╗  █████╗ 
  ██╔════╝ ██╔══██╗████╗ ████║██╔════╝    ██╔═══██╗██╔════╝    ██║     ██║██╔════╝██╔════╝              ██║     ██║   ██║██╔══██╗██║██╔════╝██╔═══██╗██╔══██╗
  ██║  ███╗███████║██╔████╔██║█████╗      ██║   ██║█████╗      ██║     ██║█████╗  █████╗      █████╗    ██║     ██║   ██║██║  ██║██║██║     ██║   ██║╚█████╔╝
  ██║   ██║██╔══██║██║╚██╔╝██║██╔══╝      ██║   ██║██╔══╝      ██║     ██║██╔══╝  ██╔══╝      ╚════╝    ██║     ██║   ██║██║  ██║██║██║     ██║   ██║██╔══██╗
  ╚██████╔╝██║  ██║██║ ╚═╝ ██║███████╗    ╚██████╔╝██║         ███████╗██║██║     ███████╗              ███████╗╚██████╔╝██████╔╝██║╚██████╗╚██████╔╝╚█████╔╝
    ╚═════╝ ╚═╝  ╚═╝╚═╝     ╚═╝╚══════╝     ╚═════╝ ╚═╝         ╚══════╝╚═╝╚═╝     ╚══════╝              ╚══════╝ ╚═════╝ ╚═════╝ ╚═╝ ╚═════╝ ╚═════╝  ╚════╝  

    In order to have a better experience try with values greater than 40!
    If some value is empty or less than 40, then, default values will be used.

EOC

puts 'Please indicate the desired width (optional):'
width = gets
width = width.to_i > 40 ? width.to_i : 0

puts 'Please indicate the desiresd height (optional):'
height = gets
height = height.to_i > 40 ? height.to_i : 0

if [width, height].include?(0)
  GosuWindow.new.show
else
  GosuWindow.new(width, height).show
end
