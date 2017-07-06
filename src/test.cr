require "./genetic_matrix.cr"
require "../lib/matrix/src/matrix.cr"
require "yaml"

include GeneticMatrix

x = [] of Int32
x.push(1)
x.push(2)
x.push(3)

y = x
x = [] of Int32
y.push(4)
x.push(8)


puts y
puts x
