require 'json'

class Deykstra
  ADJACENCY_MATR_PATH = 'adjacency_matr.txt'

  def initialize(start_point)
    @visit_array = Array.new(adjacency_matr.size) { |i| false }
    @weight_array = adjacency_matr[0].map { |el| Float::INFINITY }
    @weight_array[start_point] = 0
  end

  def call(end_point)
    adjacency_matr.size.times do
      point = get_point
      adjacency_matr[point].each_with_index do |el, i|
        unless el == -1
          if (@weight_array[point] + el) < @weight_array[i]
            @weight_array[i] = @weight_array[point] + el
          end
        end
      end
      @visit_array[point] = true
    end

    puts @weight_array[end_point]
  end

  private

  def get_point
    @weight_array.rindex(@weight_array.values_at(*@visit_array.map.each_with_index { |el, i| i if !el }.compact).min)
  end

  def adjacency_matr
    @adjacency_matr ||= File.readlines(ADJACENCY_MATR_PATH).map { |el| el.split(',').map(&:to_i) }
  end
end

Deykstra.new(0).call(3)
