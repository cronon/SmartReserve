module TablesHelper
	def get_color_table(table, time)
		status = table.status(time)

		color = case
			when status == :free then "btn-success"
			when status == :busy then "btn-danger"
			else "btn-default"
		end
	end

end
