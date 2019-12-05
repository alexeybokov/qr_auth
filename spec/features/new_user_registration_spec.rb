# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Registration', type: :feature do
#feature 'Registration', driver: :selenium_chrome do
  before { visit root_path }

  scenario 'Visit root' do
    expect(page).to have_content 'Welcome'
  end
end
