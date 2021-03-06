require 'spec_helper.rb'

feature "User" do

	before(:each) do 
		@restaurant = FactoryGirl.create(:restaurant)
		visit root_path
		@user_attributes = FactoryGirl.attributes_for(:user)
		@user = User.create(@user_attributes)
	end

	context "when user logs in" do
		scenario "User logs in" do
			click_link("Log in")
			expect(page.has_selector?('form')).to be_true
			fill_in('Email', :with => @user_attributes[:email])
			fill_in('Password', :with => @user_attributes[:password])
			click_button('Log in')
			expect(page).to have_text("Logged in!")
		end


		scenario 'user can log in and log out' do
			click_link("Log in")
			fill_in('Email', :with => @user_attributes[:email])
			fill_in('Password', :with => @user_attributes[:password])
			click_button('Log in')
			visit root_path
			click_link("Log Out")
			expect(page).to have_text("Logged Out")
		end

		scenario "User can make a booking online" do
			click_link("Log in")
			expect(page.has_selector?('form')).to be_true
			fill_in('Email', :with => @user_attributes[:email])
			fill_in('Password', :with => @user_attributes[:password])
			click_button('Log in')
			# binding.pry
			click_link(@restaurant.name)

			click_link('Create Booking')
		end

		scenario "User can fill out booking form and submit" do

			click_link("Log in")
			fill_in('Email', :with => @user_attributes[:email])
			fill_in('Password', :with => @user_attributes[:password])
			click_button('Log in')
			click_link(@restaurant.name)
			click_link('Create Booking')
			fill_in('Date', :with => DateTime.new(2013,7,23,4,5,6))
			fill_in('Party', :with => 20)
						
			click_button('Create Booking')
			expect(page).to have_text("Booked!")

		end

		scenario "user can visit their profile page" do
			click_link("Log in")
			fill_in('Email', :with => @user_attributes[:email])
			fill_in('Password', :with => @user_attributes[:password])
			click_button('Log in')
# binding.pry
			click_link('Profile')
			expect(page).to have_text(@user.name)
			expect(page).to have_text(@user.email)
			expect(page).to have_text(@user.points)
		end

		scenario "user makes booking and visits profile page and sees extra point" do
			click_link("Log in")
			fill_in('Email', :with => @user_attributes[:email])
			fill_in('Password', :with => @user_attributes[:password])
			click_button('Log in')
			click_link(@restaurant.name)
			click_link('Create Booking')
			fill_in('Date', :with => DateTime.new(2013,7,23,4,5,6))
			fill_in('Party', :with => 20)
			click_button('Create Booking')
			visit root_path
			click_link('Profile')
			# binding.pry
			expect(page).to have_text('11')
			expect(page).to have_text('20')
			expect(page).to have_text('2013')
		end

		scenario "booking success email successfully sent" do
			click_link("Log in")
			fill_in('Email', :with => @user_attributes[:email])
			fill_in('Password', :with => @user_attributes[:password])
			click_button('Log in')
			click_link(@restaurant.name)
			click_link('Create Booking')
			fill_in('Date', :with => DateTime.new(2013,7,23,4,5,6))
			fill_in('Party', :with => 20)
			click_button('Create Booking')
		end

	end
end