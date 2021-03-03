# frozen_string_literal: true

class ShortFormatFile
  def initialize(file_path, file_name)
    @file_path = file_path
    @file_name = file_name
  end

  def row
    @file_name
  end
end
