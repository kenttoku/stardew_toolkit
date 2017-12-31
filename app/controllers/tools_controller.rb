class ToolsController < ApplicationController
  def index
  end

  def mines
    @calendar = Calendar.first
    if @calendar.day % 28 != 1
      @calendar.day -= (@calendar.day % 28 - 1)
    end
  	# # Temporary Numbers for testing
  	@game_id = 123456789
  end

  def cart
    @calendar = Calendar.first
    if @calendar.day % 28 != 1
      @calendar.day -= (@calendar.day % 28 - 1)
    end
    # Temporary Numbers for testing
    @game_id = 173578236
  end

  def grange

  end
end