require 'spec_helper'

describe "Static pages" do

  subject { page }

  describe "Home page" do
    before { visit root_path }

    it { should have_content('Bill Split Project') }
    it { should have_title(full_title('| Home')) }
  end

  describe "Help page" do
    before { visit help_path }

    it { should have_content('Help') }
    it { should have_title(full_title('Help')) }
  end

  describe "About page" do
    before { visit about_path }

    it { should have_content('About') }
    it { should have_title(full_title('About Us')) }
  end

  describe "Blog page" do
    before { visit blog_path }

    it { should have_content('Blog') }
    it { should have_title(full_title('Blog')) }
  end

  describe "API page" do
    before { visit api_path }

    it { should have_content('API') }
    it { should have_title(full_title('API')) }
  end
end
