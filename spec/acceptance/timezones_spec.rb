require 'acceptance/acceptance_helper'

feature 'User can manage time zones', %q{
  In order to get local time in different places
  As an user
  I want to be able to manage time zones
 } do
  context 'user', js: true do
    let!(:user) { create(:user) }
    let!(:timezone) { create(:timezone, user: user) }

    let!(:another_user) { create(:user) }
    let!(:another_timezone) { create(:timezone, user: another_user) }
    let!(:second_timezone) { create(:timezone, user: user) }

    before do
      login_as user
    end

    scenario 'creates new time zone' do
      timezone = build(:timezone)

      click_on 'Add time zone'

      expect(page).to have_content 'New time zone'

      fill_form(timezone)
      click_on 'Save'

      within '.timezones' do
        expect_timezone(timezone)
      end
    end

    scenario 'updates existing time zone' do
      new_timezone = build(:timezone)

      within "#timezone-#{timezone.id}" do
        click_on 'Edit'
      end

      fill_form(new_timezone)
      click_on 'Save'

      within "#timezone-#{timezone.id}" do
        expect_timezone(new_timezone)
      end
    end

    scenario 'deletes existing timezone' do
      within "#timezone-#{timezone.id}" do
        page.evaluate_script('window.confirm = function() { return true; }')
        click_on 'Delete'
      end

      expect(page).to_not have_css("#timezone-#{timezone.id}")
    end

    scenario 'sees all timezones' do
      [timezone, second_timezone].each do |t|
        within("#timezone-#{t.id}") { expect_timezone(t) }
      end

      expect(page).to_not have_css("#timezone-#{another_timezone.id}")
    end

    context 'with invalid input data' do
      scenario 'creates time zone with empty fields' do
        click_on 'Add time zone'
        click_on 'Save'

        expect(current_ember_path).to eq '/new'
        within('.alert') { expect(page).to have_content "Time zone isn't valid" }
        within('.name-field') { expect(page).to have_content "can't be blank" }
        within('.city-field') { expect(page).to have_content "can't be blank" }
      end
    end
  end

  def format_gmt(gmt)
    "GMT #{ sprintf('%+03d', gmt)}:00"
  end

  def fill_form(timezone)
    fill_in 'name', with: timezone.name
    fill_in 'city', with: timezone.city
    select format_gmt(timezone.gmt), from: 'gmt'
  end

  def expect_timezone(timezone)
    expect(page).to have_content timezone.name
    expect(page).to have_content timezone.city
    expect(page).to have_content format_gmt(timezone.gmt)
  end
end