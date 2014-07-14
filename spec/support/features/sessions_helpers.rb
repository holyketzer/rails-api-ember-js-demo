module Features
  module SessionsHelpers
    def sign_in_with(email, password)
      fill_in 'Email', with: email
      fill_in 'Password', with: password
      click_on 'Login'
    end

    def login_as(user)
      visit '#/login'
      sign_in_with user.email, user.password
    end
  end
end