require 'acceptance/acceptance_helper'

feature 'User can manage time zones', %q{
  In order to have an account
  As an user
  I want to be able to register and login
 } do
  context 'user', js: true do
    let(:user) { build(:user) }

    scenario 'creates a new account' do
      visit '#/registration'

      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      fill_in 'Confirm Password', with: user.password
      click_on 'Register'

      expect_to_be_logged(user)

      # Logout and login with new account
      click_on 'Logout'
      click_on 'Login'

      sign_in_with user.email, user.password

      expect_to_be_logged(user)
    end
  end

  private

  def expect_to_be_logged(user)
    within '#header' do
      expect(page).to have_content user.email
      expect(page).to have_content 'Logout'
    end
  end
end