require 'spec_helper.rb'

describe 'Restuarant Owner' do
	
	before(:each) do 
		@restaurant = FactoryGirl.create(:restaurant)
		@user_attributes = FactoryGirl.attributes_for(:user)
		@user = User.create(@user_attributes)
		visit root_path	
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
	end

	context 'click on restaurant profile' do
		it 'view bookings' do
			# binding.pry
			click_link(@restaurant.name)
			# binding.pry
			page.should have_text('Bookings')
			page.should have_text('Party Size')
			page.should have_text('20')
		end
		it 'should display customers and their loyalty points' do
			@user_attributes = FactoryGirl.attributes_for(:user)
			@user_attributes[:points] = 1
			@user_attributes[:restaurant_id] = 1
			@user2 = User.create(@user_attributes)
			visit root_path
			click_link("Log Out")
			click_link("Log in")
			fill_in('Email', :with => @user_attributes[:email])
			fill_in('Password', :with => @user_attributes[:password])
			click_button('Log in')
			click_link(@restaurant.name)

			page.should have_text(@user2.email)
			page.should have_text(@user.email)
			# binding.pry
			page.should have_text(@user.points+1)
			page.should have_text(@user2.points+1)

		end
			# @user = User.create(@user_attributes)
	end
end
