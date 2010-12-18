# Genetic Algorithm in the Ruby Programming Language

# The Clever Algorithms Project: http://www.CleverAlgorithms.com
# (c) Copyright 2010 Jason Brownlee. Some Rights Reserved. 
# This work is licensed under a Creative Commons Attribution-Noncommercial-Share Alike 2.5 Australia License.

def binary_tournament(population)
  s1, s2 = population[rand(population.size)], population[rand(population.size)]
  return (s1[:fitness] < s2[:fitness]) ? s1 : s2
end

def point_mutation(grammar, genome, p_mutation, head_length)
  child, i = "", 0
  genome.each_char do |v|
    if rand()<p_mutation
      if (i<head_length)
        child << grammar["FUNC"][rand(grammar["FUNC"].length)]
      else 
        child << grammar["TERM"][rand(grammar["TERM"].length)]
      end
    else 
      child << v
    end
    i += 1
  end
  return child
end

def uniform_crossover(parent1, parent2, p_crossover)
  return ""+parent1 if rand()>=p_crossover
  child = ""
  parent1.length.times do |i| 
    child << ((rand()<0.5) ? parent1[i] : parent2[i])
  end
  return child
end

def reproduce(grammar, selected, pop_size, p_crossover, p_mutation, head_length)
  children = []  
  selected.each_with_index do |p1, i|    
    p2 = (i.even?) ? selected[i+1] : selected[i-1]
    child = {}
    child[:genome] = uniform_crossover(p1[:genome], p2[:genome], p_crossover)
    child[:genome] = point_mutation(grammar, child[:genome], p_mutation, head_length)
    children << child
  end
  return children
end

def random_genome(grammar, head_length, tail_length)
  s = ""
  head_length.times { s<<grammar["FUNC"][rand(grammar["FUNC"].length)]}
  tail_length.times { s<<grammar["TERM"][rand(grammar["TERM"].length)]}
  return s
end

def target_function(x)
  return x**4.0 + x**3.0 + x**2.0 + x
end

def cost(program, bounds)
  errors = 0.0    
  20.times do
    x = bounds[0] + ((bounds[1] - bounds[0]) * rand())
    expression = program.gsub("x", x.to_s)
    target = target_function(x)
    begin score = eval(expression) rescue score = 0.0/0.0 end    
    errors += (((score.nan? or score.infinite?) ? 0.0 : score) - target).abs
  end    
  return errors
end

def breadth_first_mapping(genome, grammar)
  off, queue = 0, Array.new
  root = {}
  root[:node] = genome[off].chr;off+=1
  queue.push(root)
  while !queue.empty? do
    current = queue.shift
    if grammar["FUNC"].include?(current[:node])
      current[:left] = {}
      current[:left][:node] = genome[off].chr;off+=1 
      queue.push(current[:left])
      current[:right] = {}
      current[:right][:node] = genome[off].chr;off+=1
      queue.push(current[:right])
    end
  end
  return root
end

def tree_to_string(exp)
  return exp[:node] if (exp[:left].nil? or exp[:right].nil?)
  left = tree_to_string(exp[:left])
  right = tree_to_string(exp[:right])
  return "(#{left} #{exp[:node]} #{right})"
end

def evaluate(candidate, grammar, bounds)
  candidate[:expression] = breadth_first_mapping(candidate[:genome], grammar)
  candidate[:program] = tree_to_string(candidate[:expression])
  candidate[:fitness] = cost(candidate[:program], bounds)
end

def search(grammar, bounds, head_length, tail_length, generations, pop_size, p_crossover, p_mutation)
  pop = Array.new(pop_size) do
    {:genome=>random_genome(grammar, head_length, tail_length)}
  end
  pop.each{|c| evaluate(c, grammar, bounds)}
  best = pop.sort{|x,y| x[:fitness] <=> y[:fitness]}.first  
  generations.times do |gen|
    selected = Array.new(pop){|i| binary_tournament(pop)}
    children = reproduce(grammar, selected, pop_size, p_crossover, p_mutation, head_length)    
    children.each{|c| evaluate(c, grammar, bounds)}
    children.sort!{|x,y| x[:fitness] <=> y[:fitness]}
    best = children.first if children.first[:fitness] <= best[:fitness]
    pop = children
    gen += 1
    puts " > gen=#{gen}, f=#{best[:fitness]}, g=#{best[:genome]}"
  end  
  return best
end

if __FILE__ == $0
  # problem configuration
  grammar = {"FUNC"=>["+","-","*","/"], "TERM"=>["x"]}
  bounds = [-1, 1]
  # algorithm configuration
  head_length = 24
  tail_length = head_length * (2-1) + 1
  generations = 100
  pop_size = 100
  p_crossover = 0.70
  p_mutation = 2.0/(head_length+tail_length).to_f
  # execute the algorithm
  best = search(grammar, bounds, head_length, tail_length, generations, pop_size, p_crossover, p_mutation)
  puts "done! Solution: f=#{best[:fitness]}, g=#{best[:genome]}, b=#{best[:program]}"
end