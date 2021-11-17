require 'rails_helper'

RSpec.feature "UserLogins", type: :feature, js: true do

  scenario "show home page after user login" do
    
  User.create!({
  first_name:  'Dong',
  last_name: "Niu",
  email: "niu@gmail.com",
  password: "super12345",
  password_confirmation: "super12345"
  })
    
    # ACT
    visit '/login'

    fill_in 'email', with: 'niu@gmail.com'
    fill_in 'password', with: 'super12345'

    click_on('Submit')
    puts page.html

    expect(page.has_content?('Products')).to eq(true)
    
    save_screenshot "user_login.png"
    
  end

end
