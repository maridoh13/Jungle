require 'rails_helper'

RSpec.feature "Visitor an click the 'Add to Cart' button for a product on the home page and in doing so their cart increases by one", type: :feature, js: true do
  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    3.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(1),
        description: Faker::Hipster.paragraph(3),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "They see the cart has increased by 1" do
    # ACT
    visit root_path
    expect(find('#navbar')).to have_content 'My Cart (0)'

    find('.btn-primary', match: :first).click

    expect(find('#navbar')).to have_content 'My Cart (1)'
    
    # DEBUG
    save_screenshot
    # puts page.html
    
    
  end

end
