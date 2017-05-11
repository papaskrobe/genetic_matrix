require "./genetic_matrix/*"
require "../lib/matrix/src/matrix.cr"

	def sigmoid(val : Float64)
		return 1.0 / (1.0 + (2.71828 ** (-val)))
	end

	def sigmoid(val : Matrix(Float64))
		out = Matrix.new(val.rows.size, val.columns.size) {0.0}
		(val.rows.size * val.columns.size).times do |x|
			out[x] = sigmoid(val[x])
		end
		out
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
		out = Matrix.new(matrix.rows.size, matrix.columns.size) { 0.0 }
		(matrix.rows.size * matrix.columns.size).times do |x|
			if rand < p
				out[x] = (rand * 2 * epsilon) - epsilon
			else
				out[x] = matrix[x]
			end
		end
		out
	end

	def run(fitness : Proc(Array(Matrix), Float64), sizes : Array(Array(Int32)), p_c : Float64, p_m : Float64, epsilon : Int32, members = 100, iterations = 1000)

		population = [] of Array(Matrix)
		members.times do
			sizes.size.each do |dimensions|
				population.push(dimensions[0], dimensions[1], epsilon)
			end
		end

	end


end

module GeneticMatrix
	x = GeneticAlgorithm.new.generate(3, 2, 10)
	puts x
	#puts sigmoid(x)
end


