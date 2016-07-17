require './page_object'
require './header.rb'

class TweetEdit < PageObject
  include Header

  def update(body_string)
    fill_in 'ツィート', with: body_string
    click_on 'Update Tweet'
  end
end
