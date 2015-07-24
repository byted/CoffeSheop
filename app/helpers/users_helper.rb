module UsersHelper
	def bonus_points_used(hist)
		return "(with #{hist.bonus_points_used} Bonus Points)" if hist.category == "buy"
		return ""
	end
end
