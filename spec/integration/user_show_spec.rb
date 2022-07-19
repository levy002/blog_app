require 'rails_helper'

RSpec.feature 'Testing user show page', type: :feature do
  before(:each) do
    User.destroy_all
    @first = User.create(name: 'Levy', photo: 'profile.png', bio: 'Developer', posts_counter: 0)
  end

  background { visit user_path(User.first.id) }

  scenario "I can see the user's username" do
    expect(page).to have_content('Levy')
  end

  scenario "I can see the user's profile picture" do
    expect(page.first('img')['src']).to have_content 'profile.png'
  end

  scenario "I can see the user's bio" do
    expect(page).to have_content('Developer')
  end

  scenario "I can see a button that lets me view all of a user's posts" do
    click_link('See all posts')
    expect(current_path).to eq user_posts_path(User.first.id)
  end
end
