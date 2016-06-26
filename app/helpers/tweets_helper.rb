module TweetsHelper

  def initialize_remains_body_characters(inputString)
    Constants::MAX_LENGTH_TWEET - inputString.length
  end
end
