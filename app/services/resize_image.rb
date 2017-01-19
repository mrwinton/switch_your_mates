require 'RMagick'

class ResizeImage
  attr_reader :target, :destination

  MAX_WIDTH = 2400
  MAX_HEIGHT = 1440

  def initialize(target:, destination:)
    @target = target
    @destination = destination
  end

  def call
    `convert #{target} -resize '#{MAX_WIDTH}x#{MAX_HEIGHT}' #{destination}`
  end
end
