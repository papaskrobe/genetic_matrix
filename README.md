# genetic_matrix

Methods for optimizing matrices with a genetic algorithm in Crystal

## Usage

```crystal
# Create a new genetir algorithm object
genetic = GeneticAlgorithm.new

# Run with the following parameters:
genetic.run(fitness : Proc(Array(Matrix(Float64)), Int32),  # A Proc acting as a fitness function, that takes 
                                                            # a Matrix as argument and returns an Int32
            sizes : Array(Array(Int32)),  # 
            p_c : Float64,                # The probability per generation that two members will "crossover", 
                                          # or swap parts of their data at a random break point
            p_m : Float64,                # The probability that a "mutation" will occur on a given data point, 
                                          # replacing it with a new random number from (-epsilon, epsilon)
			      epsilon : Int32,              # The limits of the individual matrix members from (-epsilon, epsilon)
            members = 100,                # Optional: number of members in the population per generation
            iterations = 1000,            # Optional: number of generations algorithm will run
            p_birth = 0.0)                # Optional: probability that a new randomly generated matrix will be birthed 
      
```      
## Development

## Contributing

1. Fork it ( https://github.com/papaskrobe/genetic_matrix/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- papaskrobe(https://github.com/papaskrobe)  - creator, maintainer
