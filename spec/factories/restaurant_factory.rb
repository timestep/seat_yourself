FactoryGirl.define do
	factory :restaurant do
		name Faker::Company.name
		address Faker::Address.street_address
		neighbourhood Faker::Address.city
		price_min 1
		price_max 5
		summary Faker::Lorem.paragraph
		menu Faker::Lorem.sentences
	end	
end