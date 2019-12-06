# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Registration', type: :feature do
  before { visit root_path }

  scenario 'root page have registration links' do
    expect(page).to have_content 'Welcome'
    expect(page).to have_link 'Log In'
    expect(page).to have_link 'Sign Up'
  end

  scenario 'success redirect to set up 2nd auth page, and show qr_code' do
    click_link('Sign Up')
    fill_in 'user[email]', with: 'capybara@gmail.com'
    fill_in 'user[password]', with: 'password'
    fill_in 'user[password_confirmation]', with: 'password'
    click_button('Create User')
    expect(page).to have_selector('.qr_code')
  end
end
