require 'gosu'

# Class to display GosuWindow
class GosuWindow < Gosu::Window

  def initialize(height=800, width=600)
    super(height, width, false)
    self.caption = "Game Of Life - @ludico8"
  end

  def update
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
