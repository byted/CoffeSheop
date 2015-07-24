module ApplicationHelper
	def input_nbr(divClass, inputName, defaultValue = "", sign = "")
			btn1 = button_tag "+", type: "button", class: "plus_btn"
			field = text_field_tag inputName, defaultValue, min: 0, class: "keyboard"
			btn2 = button_tag "-", type: "button", class: "minus_btn"
			span = content_tag :span, sign 

		content_tag :div, btn1 + field + btn2 + span, class: "#{divClass} input_nbr"
	end

	def is_numeric(string)
    return true if string.is_a?(Numeric) or (string.is_a?(String) and Float(string)) rescue return false
		return false
	end
end
