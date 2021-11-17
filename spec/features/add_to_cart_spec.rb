require 'rails_helper'

RSpec.feature "Visitor navigates to product detail page", type: :feature, js: true do

  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end  


  scenario "add a cart should update the quantity of my cart" do
    # ACT
    visit root_path

    

    click_on("Add", match: :first)

    # VERIFY
    expect(page.has_content?('My Cart (1)')).to eq(true)

    save_screenshot

    puts page.html
  end

end

