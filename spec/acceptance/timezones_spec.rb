require 'acceptance/acceptance_helper'

feature 'User can manage time zones', %q{
  In order get local time ni different places
  As an user
  I want to be able to manage time zones
 } do
  context 'user', js: true do
    let!(:user) { create(:user) }

    background do
      login_as user
    end

    scenario 'creates new time zone' do
      timezone = build(:timezone)

      #visit '#/new'
      click_on 'Add time zone'
      #sleep 10
      #save_and_open_page
      expect(page).to have_content 'New time zone'

      fill_in 'name', with: timezone.name
      fill_in 'city', with: timezone.city
      select format_gmt(timezone.gmt), from: 'gmt'

      click_on 'Save'

      expect(current_path).to eq '/'
      within '.timezones' do
        expect(page).to have_content timezone.name
        expect(page).to have_content timezone.city
        expect(page).to have_content format_gmt(timezone.gmt)
      end
    end
  end

  def format_gmt(gmt)
    "GMT #{ sprintf('%+03d', gmt)}:00"
  end
end