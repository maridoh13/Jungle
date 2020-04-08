require 'rails_helper'

RSpec.feature "Visitor navigates to product's details", type: :feature, js: true do
  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    # 3.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(1),
        description: Faker::Hipster.paragraph(3),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  # end

  scenario "They see the product's details" do
    # ACT
    visit root_path
    find('.btn-default', match: :first).click
    
    # DEBUG
    save_screenshot
    # puts page.html
    
    # VERIFY
    expect(page).to have_css 'article.product-detail'
    
  end

end
