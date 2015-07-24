module HistoriesHelper
	def color_balance_change(price)
		 if price > 0 
		 	class_name = "fg-color-green"
		 elsif price < 0
		 	class_name = "fg-color-red"
		 else 
		 	class_name =""
		 end
		 return content_tag "span", number_to_currency(price), class: class_name
	end
end
