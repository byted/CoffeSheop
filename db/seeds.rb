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
Cleaning.delete_all
Cart.delete_all

# Users
User.create(password: '0000', password_confirmation: '0000', email: "admin@coffeeshop.de", level: "Admin", login: "Admin", emptypw: true, balance: 10)
User.create(password: '0000', password_confirmation: '0000', email: "homer@coffeeshop.de", level: "User", login: "Homer", emptypw: false, balance: 0)
User.create(password: '0000', password_confirmation: '0000', email: "jay@coffeeshop.de", level: "User", login: "Jay", emptypw: false, balance: 40)
User.create(password: '0000', password_confirmation: '0000', email: "lisa@coffeeshop.de", level: "User", login: "Lisa", emptypw: false, balance: -2)
User.create(password: '0000', password_confirmation: '0000', email: "barney@coffeeshop.de", level: "User", login: "Barney", emptypw: false, balance: 5)

Product.create(name: 'Coffee',
							price: 0.7,
							in_stock: 1000,
							threshold: 250,
							amount_per_unit: 20
							)
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