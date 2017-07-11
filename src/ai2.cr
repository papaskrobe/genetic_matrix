require "../../genetic_matrix/src/genetic_matrix.cr"

include GeneticMatrix

module Ai2
	# TODO Put your code here
end

genetic = GeneticAlgorithm.new
fitness = ->(net : Array(Matrix(Float64))) do
	counter = 0
	100.times do
		thing_1 = rand 2
		thing_2 = rand 2
		inputs = Matrix.columns([[1.to_f64, thing_1.to_f64, thing_2.to_f64]])
		hidden = Matrix.columns([ sigmoid(inputs.transpose * net[0]).to_a.unshift(1.to_f64)])
		result = sigmoid(hidden.transpose * net[1])[0]
		if (thing_1 == thing_2 && result > 0.95) || (thing_1 + thing_2 == 1 && result < 0.05)
			counter += 1
		end
	end
	return counter ** 2
end

#puts fitness.call([genetic.generate(3,2,10), genetic.generate(3,1,10)])
#(fitness, sizes, p_c, p_m, epsilon, members, iterations)
genetic.run(fitness, [[3,2],[3,1]], 0.05, 0.01, 25, 50, 250)
