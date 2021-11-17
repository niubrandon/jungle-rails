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


  scenario "They see product details after click details" do
    # ACT
    visit root_path

    # puts page.html

    click_link("Details", match: :first)

    # VERIFY
    expect(page).to have_css 'section.products-show', count:1

    save_screenshot "product_details.png"
  end

end

