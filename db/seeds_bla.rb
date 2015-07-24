# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Product.delete_all
User.delete_all
ItemsInCart.delete_all
Settings.delete_all
Cleaning.delete_all
Cart.delete_all

Product.create(name: 'Mars',
				description: %{Some Description (or not)},
							price: 1,
							picture: 'mars.jpg',
							in_stock: 100,
							threshold: 10
							)
Product.create(name: 'Snickers',
				description: %{Some Description (or not)},
							price: 1,
							picture: 'snickers.jpg',
							in_stock: 100,
							threshold: 10
							)
Product.create(name: 'Twix',
				description: %{Some Description (or not)},
							price: 1,
							picture: 'twix.png',
							in_stock: 100,
							threshold: 10
							)
Product.create(name: 'Coffee',
				description: %{Some Description (or not)},
							price: 2,
							picture: 'coffee.png',
							in_stock: 1000,
							threshold: 250,
							amount_per_unit: 20
							)
(1..10).each do |i|
	Product.create(name: "Product #{i}",
					description: %{Some Description (or not)},
								price: 2,
								picture: 'kilkenny.jpg',
						 		in_stock: 100,
								threshold: 10
								)
end

# Users
User.create(password: '1234', password_confirmation: '1234', email: "homer@test.de", level: "User", login: "Homer", emptypw: false, balance: 20)
User.create(password: '', password_confirmation: '', email: "lisa@test.de", level: "User", login: "Lisa", emptypw: true, balance: 20)
User.create(password: '', password_confirmation: '', email: "bart@test.de", level: "User", login: "Bart", emptypw: true, balance: 20)
User.create(password: '', password_confirmation: '', email: "marge@test.de", level: "User", login: "Marge", emptypw: true, balance: 20)
User.create(password: '', password_confirmation: '', email: "zoidberg@test.de", level: "Admin", login: "Zoidberg", emptypw: true, balance: 20)
User.create(password: '', password_confirmation: '', email: "fry@test.de", level: "Admin", login: "Fry", emptypw: true, balance: 20)
User.create(password: '', password_confirmation: '', email: "cartman@test.de", level: "Admin", login: "Cartman", emptypw: true, balance: 20)
User.create(password: '', password_confirmation: '', email: "kenny@test.de", level: "Admin", login: "Kenny", emptypw: true, balance: 20)

