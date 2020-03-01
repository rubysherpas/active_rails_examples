require "rails_helper"

RSpec.feature "Creating Purchases" do
  scenario "creating a purchase successfully" do
    visit "/purchases"
    click_link "New Purchase"
    fill_in "Name", with: "Shoes"
    fill_in "Cost", with: 100
    click_button "Create Purchase"

    expect(page).to have_content("Purchase was successfully created.")
  end

  scenario "creating a purchase without a cost" do
    visit "/purchases"
    click_link "New Purchase"
    fill_in "Name", with: "Shoes"
    click_button "Create Purchase"

    expect(page).to have_content("1 error prohibited this purchase from being saved:")
    expect(page).to have_content("Cost is not a number")
  end
end
