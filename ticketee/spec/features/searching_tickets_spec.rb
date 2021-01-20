require "rails_helper"

RSpec.feature "Users can search for tickets matching specific criteria" do
  let(:user) { FactoryBot.create(:user) }
  let(:project) { FactoryBot.create(:project) }
  let!(:ticket_1) do
    tags = [FactoryBot.create(:tag, name: "Iteration 1")]
    FactoryBot.create(:ticket, name: "Create projects",
      project: project, author: user, tags: tags)
  end

  let!(:ticket_2) do
    tags = [FactoryBot.create(:tag, name: "Iteration 2")]
    FactoryBot.create(:ticket, name: "Create users",
      project: project, author: user, tags: tags)
  end

  before do
    login_as(user)
    visit project_path(project)
  end

  scenario "searching by tag" do
    fill_in "Search", with: %q{tag:"Iteration 1"}
    click_button "Search"
    within(".tickets") do
      expect(page).to have_link "Create projects"
      expect(page).to_not have_link "Create users"
    end
  end
end
