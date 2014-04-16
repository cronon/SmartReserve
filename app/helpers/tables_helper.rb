module TablesHelper
	def get_color_table(table, time)
		status = table.status(time)

		color = case
			when status == :free then "table-free"
			when status == :busy then "table-busy"
			else "table-booked"
		end
	end

end
