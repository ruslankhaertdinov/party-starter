module RangeOperators
	def intersection
		array = self.sort_elements
		array.inject() do |common, element|
			value_first = comparison_value(common, :last)
			value_element = comparison_value(element, :first)
			case value_first <=> value_element
			when -1 then return nil
			when 0 then value_first
			else
				if element.class == Range
					value_element..([value_first, comparison_value(element, :last)].min)
				else
					value_element
				end
			end
		end
	end

  protected

	def sort_elements
		self.uniq.sort_by { |element| comparison_value(element, :first) }
	end

	private

	# For a Range, will return value.first or value.last. A non-Range will return itself.
	def comparison_value(value, position)
		return value if value.class != Range
		position == :first ? value.first : value.last
	end
end

class Array
  include RangeOperators
end
