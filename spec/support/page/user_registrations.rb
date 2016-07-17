require './page_object'

class UserRegistrations < PageObject
  def destroy_user_success
    click_button 'アカウント削除'
    page.driver.browser.switch_to.alert.accept
    wait_load Home.new
  end
end
