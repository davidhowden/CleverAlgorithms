# Learning Classifier System in the Ruby Programming Language

# The Clever Algorithms Project: http://www.CleverAlgorithms.com
# (c) Copyright 2010 Jason Brownlee. Some Rights Reserved. 
# This work is licensed under a Creative Commons Attribution-Noncommercial-Share Alike 2.5 Australia License.

def new_classifier(condition, action, gen)
  other = {}
  other[:condition], other[:action], other[:lasttime] = condition, action, gen
  other[:prediction], other[:error], other[:fitness] =  0.00001,  0.00001,  0.00001
  other[:experience], other[:setsize], other[:num] = 0.0, 1.0, 1.0
  return other
end

def copy_classifier(parent)
  copy = {}  
  parent.keys.each {|k| copy[k] = (parent[k].kind_of? String) ? ""+parent[k] : parent[k]}  
  copy[:num] = 1
  copy[:experience] = 0.0
  return copy
end

def generate_problem_string(length)
  return (0...length).inject(""){|s,i| s+((rand<0.5) ? "1" : "0")}
end

def neg(bit) 
  return (bit==1) ? 0 : 1 
end
  
def target_function(s)
  ints = Array.new(s.length){|i| s[i].chr.to_i}
  x0,x1,x2,x3,x4,x5 = ints
  return neg(x0)*neg(x1)*x2 + neg(x0)*x1*x3 + x0*neg(x1)*x4 + x0*x1*x5
end

def calculate_deletion_vote(classifier, pop, del_thresh)
  vote = classifier[:setsize] * classifier[:num]
  avg_fit = pop.inject(0.0){|s,c| s+c[:fitness]}/pop.inject(0.0){|s,c| s+c[:num]}
  derated = classifier[:fitness] / classifier[:num]
  if classifier[:experience] > del_thresh and derated < 0.1 * avg_fit
    vote *= avg_fit / derated
  end  
  return vote
end

def delete_from_pop(pop, pop_size, del_thresh)
  total = pop.inject(0) {|s,c| s+c[:num]}
  return if total < pop_size
  pop.each {|c| c[:dvote] = calculate_deletion_vote(c, pop, del_thresh)}
  vote_sum = pop.inject(0.0) {|s,c| s+c[:dvote]}
  point = rand() * vote_sum
  vote_sum, index = 0.0, 0
  pop.each_with_index do |c,i|
    vote_sum += c[:dvote]
    if vote_sum > point
      index = i
      break
    end
  end
  if pop[index][:num] > 1
    pop[index][:num] -= 1
  else
    pop.delete_at(index)
  end
end

def generate_random_classifier(input, actions, gen)
  condition = ""
  input.each_char {|s| condition << ((rand<1.0/3.0) ? '#' : s)}
  action = actions[rand(actions.length)]
  return new_classifier(condition, action, gen)
end

def does_match(input, condition)
  i = 0
  condition.each_char do |c|
    return false if c!='#' and c!=input[i].chr
    i += 1
  end
  return true
end

def get_actions(pop)
  return [] if pop.empty?
  set = {}
  pop.each do |classifier|
    key = classifier[:action]
    set[key] = 0 if set[key].nil?
    set[key] += 1
  end 
  return set.keys
end

def generate_match_set(input, pop, all_actions, gen, pop_size, del_thresh)
  match_set = pop.select{|c| does_match(input, c[:condition])}
  actions = get_actions(match_set)
  while actions.length < all_actions.length do
    remaining = all_actions - actions
    classifier = generate_random_classifier(input, remaining, gen)
    pop << classifier
    match_set << classifier
    delete_from_pop(pop, pop_size, del_thresh)
    actions << classifier[:action]
  end
  return match_set
end

def generate_prediction(input, match_set) 
  prediction = {}
  match_set.each do |classifier|
    key = classifier[:action]
    prediction[key] = {:sum=>0.0,:count=>0.0,:weight=>0.0} if prediction[key].nil?
    prediction[key][:sum] += classifier[:prediction]*classifier[:fitness]
    prediction[key][:count] += classifier[:fitness]
  end
  prediction.keys.each do |key| 
    prediction[key][:weight]=prediction[key][:sum]/prediction[key][:count]
  end  
  return prediction
end

def select_action(prediction_array, p_explore)
  keys = prediction_array.keys
  return true, keys[rand(keys.length)] if rand() < p_explore    
  keys.sort!{|x,y| prediction_array[y][:weight]<=>prediction_array[x][:weight]}
  return false, keys.first
end

def update_set(action_set, payoff, l_rate)
  action_set.each do |c| 
    c[:experience] += 1.0    
    pdiff = payoff - c[:prediction]
    c[:prediction] += (c[:experience]<1.0/l_rate) ? pdiff/c[:experience] : l_rate*pdiff
    diff = pdiff.abs - c[:error]
    c[:error] += (c[:experience]<1.0/l_rate) ? diff/c[:experience] : l_rate*diff        
    sum = action_set.inject(0.0) {|s,other| s+other[:num]-c[:setsize]}    
    c[:setsize] += (c[:experience]<1.0/l_rate) ? sum/c[:experience] : l_rate*sum
  end
end

def update_fitness(action_set, min_error, l_rate)
  sum = 0.0
  accuracy = Array.new(action_set.length)
  action_set.each_with_index do |c,i|
    accuracy[i] = (c[:error]<min_error) ? 1.0 : 0.1*(c[:error]/min_error)**-5.0
    sum += accuracy[i] * c[:num]
  end
  action_set.each_with_index do |c,i|
    c[:fitness] += l_rate * (accuracy[i] * c[:num] / sum - c[:fitness])
  end
end

def can_run_genetic_algorithm(action_set, gen, ga_freq)
  total = action_set.inject(0.0) {|s,c| s+c[:lasttime]*c[:num]}
  sum = action_set.inject(0.0) {|s,c| s+c[:num]}
  if gen - (total/sum) > ga_freq
    return true
  end
  return false
end

def select_parent(pop)
  sum = pop.inject(0.0) {|s,c| s+c[:fitness]}
  point = rand() * sum
  sum = 0
  pop.each do |c|
    sum += c[:fitness]
    return c if sum > point
  end  
end

def mutation(classifier, p_mut, action_set, input)
  classifier[:condition].length.times do |i|
    if rand() < p_mut
      if classifier[:condition][i].chr == '#'
        classifier[:condition][i] = input[i]
      else
        classifier[:condition][i] = '#'
      end
    end
  end
  if rand() < p_mut
    new_action = nil
    begin
      new_action = action_set[rand(action_set.length)]
    end until new_action != classifier[:action]
    classifier[:action] = new_action
  end
end

def uniform_crossover(string1, string2)
  rs = ""
  string1.length.times do |i|
    rs << ((rand()<0.5) ? string1[i] : string2[i])
  end  
  return rs
end

def insert_in_pop(classifier, pop)
  pop.each do |c|    
    if classifier[:condition]==c[:condition] and classifier[:action]==c[:action]
      c[:num] += 1
      return
    end
  end
  pop << classifier
end

def crossover(c1, c2, p1, p2)
  c1[:condition] = uniform_crossover(p1[:condition], p2[:condition])
  c2[:condition] = uniform_crossover(p1[:condition], p2[:condition]) 
  c1[:prediction] = (p1[:prediction]+p2[:prediction])/2.0
  c1[:error] = 0.25*(p1[:error]+p2[:error])/2.0
  c1[:fitness] = 0.1*(p1[:fitness]+p2[:fitness])/2.0    
  c2[:prediction] = c1[:prediction]
  c2[:error] = c1[:error]
  c2[:fitness] = c1[:fitness]
end

def run_genetic_algorithm(all_actions, pop, action_set, input, gen, p_cross, p_mut, pop_size, del_thresh)    
  p1, p2 = select_parent(action_set), select_parent(action_set)
  c1, c2 = copy_classifier(p1), copy_classifier(p2)
  crossover(c1, c2, p1, p2) if rand() < p_cross
  [c1,c2].each do |c|
    mutation(c, p_mut, all_actions, input)
    insert_in_pop(c, pop)
    delete_from_pop(pop, pop_size, del_thresh)
  end  
end

def search(length, pop_size, max_gens, all_actions, p_explore, l_rate, min_error, ga_freq, p_cross, p_mut, del_thresh)
  pop, abs = [], 0
  max_gens.times do |gen|
    input = generate_problem_string(length)
    match_set = generate_match_set(input, pop, all_actions, gen, pop_size, del_thresh)
    prediction_array = generate_prediction(input, match_set)    
    explore, action = select_action(prediction_array, p_explore)
    action_set = match_set.select{|c| c[:action]==action}
    expected = target_function(input)
    payoff = ((expected-action.to_i)==0) ? 300.0 : 1.0
    abs += (expected - action.to_i).abs.to_f
    update_set(action_set, payoff, l_rate)
    update_fitness(action_set, min_error, l_rate)
    if can_run_genetic_algorithm(action_set, gen, ga_freq)
      action_set.each {|c| c[:lasttime] = gen}
      run_genetic_algorithm(all_actions, pop, action_set, input, gen, p_cross, p_mut, pop_size, del_thresh)
    end
    if (gen+1).modulo(50)==0
      puts " >gen=#{gen+1} classifiers=#{pop.size}, error=#{abs.to_i}/50 (#{(abs/50*100)}%)"
      abs = 0
    end
  end  
  return pop
end

if __FILE__ == $0
  # problem configuration
  all_actions = ['0', '1']
  # algorithm configuration
  max_gens, length, pop_size = 5000, 6, 150
  l_rate, min_error = 0.2, 0.01
  p_explore, p_cross, p_mut = 0.10, 0.80,  0.04
  ga_freq, del_thresh = 50,  20
  # execute the algorithm
  pop = search(length, pop_size, max_gens, all_actions, p_explore, l_rate, min_error, ga_freq, p_cross, p_mut, del_thresh)
  puts "done! Solution: classifiers=#{pop.size}"
end