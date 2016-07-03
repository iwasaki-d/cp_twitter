class UserTop < PageObject
  include Header

  def go_edit_user()
    find('#edit_user_header').click
    wait_load(UserRegistrations.new)
  end
end
