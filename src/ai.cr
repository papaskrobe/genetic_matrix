require "./ai/*"
require "../lib/matrix/src/matrix.cr"
require "yaml"
require "../../genetic_matrix/src/genetic_matrix.cr"
require "../../connect_4/src/connect_4.cr"

include GeneticMatrix
include Connect4

module Ai
  # TODO Put your code here
end

genetic = GeneticAlgorithm.new
fitness = ->(net : Array(Matrix(Float64))) do
	counter = 0
	20.times do
		game = Game.new
		if game.play(net) == 1
			counter += 1
		end
	end
	return counter ** 2
end

#(fitness, sizes, p_c, p_m, epsilon, members, iterations, p_birth)
genetic.run(fitness, [[85, 84], [85, 84], [85, 7]], 0.03, 0.05, 25, 100, 50, 0.1)
