require 'rails_helper'

RSpec.describe 'Testing user index page', type: :feature do
  describe 'GET index' do
     before(:each) do
         @first_user = User.create(name: 'John', photo: 'john.jpg', bio: 'Developer.', posts_counter: 0)
         @second_user = User.create(name: 'Sarah', photo: 'sarah.jpg', bio: 'Web Developer.', posts_counter: 0)
         @second_user = User.create(name: 'Tobin', photo: 'tobin.jpg', bio: 'Frontend Developer.', posts_counter: 0)
     end

     scenario 'shows the right content' do
        visit users_path
        sleep(5)
        expect(page).to have_content('ALL USERS')
     end

     feature 'User Index' do
         background { visit users_path }
         scenario 'See all usernames' do
           expect(page).to have_content('Sarah')
           expect(page).to have_content('Tobin')
         end

         scenario 'See the number of posts each user has written' do
          expect(page).to have_content('Number of posts: 0')
         end

        scenario 'See profile picture for each user' do
            expect(page.first('img')['src']).to have_content 'john.jpg'
        end

        scenario "When I click on a user, I am redirected to that user's show page" do
            click_link 'John', match: :first
            expect(current_path).to eq user_path(User.first.id)
         end
      end
  end
end

