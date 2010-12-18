# Unit tests for genetic_algorithm.rb

# The Clever Algorithms Project: http://www.CleverAlgorithms.com
# (c) Copyright 2010 David Howden. Some Rights Reserved.
# This work is licensed under a Creative Commons Attribution-Noncommercial-Share Alike 2.5 Australia License.

require "test/unit"
require "../bees_algorithm"

class TC_BEES_ALGORITHM < Test::Unit::TestCase

	#test that create_random_bee returns a correctly initialised bee
	def test_create_random_bee
		problem_size = 3
		search_space = Array.new(problem_size) {|i| [-1, 3]}
		pop = Array.new(1000) {|i| create_random_bee(problem_size, search_space)}
		sum = pop.inject(0){|sum, bee| sum += bee[:vector].inject(0){|sum, dimension| sum+= dimension}}
		assert_in_delta (sum / (pop.length * problem_size)), 1, 0.1
	end
	
	#test that create_neighbourhood_bee centres bee on the correct site
	def test_create_neighbourhood_bee
		problem_size = 5
		search_space = Array.new(problem_size) {|i| [-10, 10]}
		site = Array.new(problem_size){|i| i}
		pop = Array.new(10000) {|i| create_neighborhood_bee(site, 4.5, search_space)}
		problem_size.times{|i| assert_in_delta pop.inject(0){|sum, bee| sum += bee[:vector][i]} / pop.length, i, 0.1}
	end
	
	#test that create_neighbourhood_bee stays within patch_size and does not exceed search_space boundary
	def test_create_neighbourhood_bee_bounds
		problem_size = 5
		patch_size = 2
		search_space = Array.new(problem_size) {|i| [0, 5]}
		site = Array.new(problem_size){|i| i}
		pop = Array.new(1000) {|i| create_neighborhood_bee(site, patch_size, search_space)}
		pop.each {|bee| 
			bee[:vector].each_with_index{|dimension, i|
				(i-patch_size<0) ? (assert_operator dimension, :>=, 0) : (assert_operator dimension, :>=, i-patch_size)
				(i+patch_size>5) ? (assert_operator dimension, :<=, 5) : (assert_operator dimension, :<=, i+patch_size)				
			}
		}		
	end
	
	# test that the random_vector function behaves as expected
	def test_random_vector
		assert_in_delta random_vector(10000, Array.new(10000) {[-3,1]}).inject(0){|sum, v|
			assert_operator v, :>=, -3
			assert_operator v, :<=, 1
			sum += v} / 10000, -1, 0.1 		
	end
	
	# test that objective_function behaves as expected
	def test_objective_function
		vector = [-2, -1.1, 0, 7.9, -5]		
		assert_equal objective_function(vector), vector.inject(0){|sum, v| sum = sum+v*v}
	end
	
end