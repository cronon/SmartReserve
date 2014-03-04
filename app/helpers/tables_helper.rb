module TablesHelper
	def get_color_table(table, time)
		status = table.status(time)

		color = case
			when status == :free then "green"
			when status == :busy then "red"
			else "gray"
		end
	end

end
