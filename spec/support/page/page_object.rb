require 'rails_helper'

class PageObject
  include Capybara::DSL

  @@url_helpers = Rails.application.routes.url_helpers

  def wait_load(page_object)
    # セレニウムを使ってfeatureテストを行う際にはページの読み込み待ちが必要
    wait = Selenium::WebDriver::Wait.new(:timeout => 10) # 秒
    wait.until { page.execute_script('return document.readyState') == 'complete' }
    sleep(1)
    page_object
  end
end
