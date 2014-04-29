module OrdersHelper

	@@MAX_COUNT_COLUMNS = 30

	#return hash: {count_colums => , granularity_col =>}
	def table_params(start_time, end_time)
		length_interval = (end_time - start_time).abs
		count_columns = length_interval / 
		min_intervals = [10, 15, 20, 25, ]
	end
end
