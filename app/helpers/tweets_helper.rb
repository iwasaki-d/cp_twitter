module TweetsHelper

  def initialize_remains_body_characters(input_string)
    Constants::MAX_LENGTH_TWEET - input_string.length
  end
end
