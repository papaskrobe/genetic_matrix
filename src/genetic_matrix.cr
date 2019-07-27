require "./genetic_matrix/*"
require "../lib/matrix/src/matrix.cr"

module GeneticMatrix
	def sigmoid(val : Float64)
		return 1.0 / (1.0 + (2.71828 ** (-val)))
	end

	def sigmoid(val : Matrix(Float64))
		out_matrix = Matrix.new(val.rows.size, val.columns.size) {0.0}
		(val.rows.size * val.columns.size).times do |x|
			out_matrix[x] = sigmoid(val[x])
		end
		out_matrix
	end

class GeneticAlgorithm
	def generate(rows, cols, epsilon)
		return Matrix.new(rows, cols) { (rand * 2 * epsilon) - epsilon }
	end

	def crossover(chrom1 : Matrix, chrom2 : Matrix)
		if (chrom1.rows.size != chrom2.rows.size) || (chrom1.columns.size != chrom2.columns.size)
			raise Matrix::DimensionMismatch.new()
		else
			out1 = Matrix.new(chrom1.rows.size, chrom2.columns.size) { 0.0 }
			out2 = Matrix.new(chrom2.rows.size, chrom2.columns.size) { 0.0 }
			cross_point = rand (chrom1.rows.size * chrom2.columns.size)
			(chrom1.rows.size * chrom1.columns.size).times do |x|
				if (x < cross_point)
					out1[x] = chrom1[x]
					out2[x] = chrom2[x]
				else
					out2[x] = chrom1[x]
					out1[x] = chrom2[x]
				end
			end
		end
		return out1, out2
	end
	
	def mutate(matrix : Matrix, p : Float64 , epsilon)
		outp = Matrix.new(matrix.rows.size, matrix.columns.size) { 0.0 }
		(matrix.rows.size * matrix.columns.size).times do |x|
			if rand < p
				outp[x] = (rand * 2 * epsilon) - epsilon
			else
				outp[x] = matrix[x]
			end
		end
		outp
	end

	def run(fitness : Proc(Array(Matrix(Float64)), Int32), sizes : Array(Array(Int32)), p_c : Float64, p_m : Float64, epsilon : Int32, members = 100, iterations = 1000, p_birth = 0.0)
		#population: initial population for a generation
		#generation: next generation
		population = [] of Array(Matrix(Float64))
		generation = [] of Array(Matrix(Float64))
		members.times do |member|
			unit = [] of Matrix(Float64)
			sizes.each do |dimensions|
				unit.push(generate(dimensions[0], dimensions[1], epsilon))
			end
			population.push(unit)
		end
		
		iterations.times do
			scores = [] of Int32
			members.times { |x| scores.push(fitness.call(population[x])) }
	
			members.times do
				position = -1
				if (scores.sum > 0 && rand > p_birth)
					collector = rand * (scores.sum)
				end
				while collector && collector > 0
					position += 1
					collector -= scores[position]
				end
				unit = [] of Matrix(Float64)
				if position == -1
					sizes.each do |dimensions|
						unit.push(generate(dimensions[0], dimensions[1], epsilon))
					end
				else
					unit = population[position].map { |z| mutate(z, p_m, epsilon) }
				end
				generation.push(unit)
			end
	
			(members - 1).times do |member|
				generation[member].size.times do |matrix|
					if (rand < p_c)
						generation[member][matrix], generation[member + 1][matrix] = crossover(generation[member][matrix], generation[member + 1][matrix])
					end
				end
			end
			population = generation
			generation = [] of Array(Matrix(Float64))
		end

		return population[scores.index(scores.max)]
	end
end

end
