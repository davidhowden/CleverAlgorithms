# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or create!d alongside the db with db:setup).
#
# Examples:
#   
#   cities = City.create!([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create!(:name => 'Daley', :city => cities.first)


# test data, not real
Algorithm.create!(:name=>"Genetic Algorithm",
:aliases=>"Genetic Algorithm, GA, Simple Genetic Algorithm, SGA, Canonical Genetic Algorithm, CGA",
:taxonomy=>"The Genetic Algorithm is an Adaptive Strategy and a Global Optimization technique. It is an Evolutionary Algorithm and belongs to the broader study of Evolutionary Computation.\nThe Genetic Algorithm is a sibling of other Evolutionary Algorithms such as Genetic Programming, Evolution Strategies, Genetic Programming, and Learning Classifier Systems. The Genetic Algorithm is a parent of a large number of variant techniques and sub-fields too numerous to list.",
:inspiration=>"The Genetic Algorithm is inspired by population genetics (including heredity and gene frequencies), and evolution at the population level, as well as the Mendelian understanding of the structure (such as chromosomes, genes, alleles) and mechanisms (such as recombination and mutation). This is the so-called new or modern synthesis of evolutionary biology.",
:metaphor=>"Individuals of a population contribute their genetic material (called the genotype) proportional to their suitability of their expressed genome (called their phenotype) to their environment. The next generation is create!d through a process of mating that involves recombination of two individuals genomes in the population with the introduction of random copying errors (called mutation). This iterative process may result in an improved adaptive-fit between the phenotypes of individuals in a population and the environment.",
:strategy=>"The objective of the Genetic Algorithm is to maximize the payoff of candidate solutions in the population against a cost function from the problem domain.\nThe strategy for the Genetic Algorithm is to repeatedly employ surrogates for the recombination and mutation genetic mechanisms on the population of candidate solutions, where the cost function (also known as objective or fitness function) applied to a decoded representation of a candidate governs the probabilistic contributions a given candidate solution can make to the subsequent generation of candidate solutions.",
:procedure=>"",
:heuristics=>"Binary strings (bitstrings) are the classical representation as they can be decoded to almost any desired representation. Real-valued variables can be decoded using the binary coded decimal method or the gray code method, the latter of which is generally preferred.\nProblem specific representations and customized genetic operators should be adopted, incorporating as much prior information about the problem domain as possible.\nThe algorithm is highly-modular and a sub-field exists to study each sub-process, such as selection, recombination, mutation, and representation.\nThe Genetic Algorithm is most commonly used as an optimization technique, although it should also be considered a general adaptive strategy \\cite{Jong1992}.\nThe schema theorem is a classical explanation for the power of the Genetic Algorithm proposed by Holland  \\cite{Holland1975}, and investigated by Goldberg under the name of the building block hypothesis \\cite{Goldberg1989}.\nThe size of the population must be large enough to provide sufficient coverage of the domain and mixing of the useful sub-components of the solution  \\cite{Goldberg1992}.\nThe Genetic Algorithm is classically configured with a high probability of recombination (such as 95%-99% of the selected population) and a low probability of mutation (such as $\\frac{1}{L}$ where $L$ is the number of components in a solution) \\cite{Muhlenbein1992} \\cite{Back1993a}.\nThe fitness-proportionate selection of candidate solutions to contribute to the next generation should be neither too greedy (to avoid the takeover of fitter candidate solutions) nor too random.",
:code=>"The code listing provides an example of the Genetic Algorithm implemented in the Ruby Programming Language.\nThe demonstration problem is a maximizing binary optimization problem called OneMax that seeks a binary string of unity (all '1' bits). The objective function provides only an indication of the number of correct bits in a candidate string, not the positions of the correct bits.\nThe Genetic Algorithm is implemented with a conservative configuration including binary tournament selection for the selection operator, uniform crossover for the recombination operator, and point mutations for the mutation operator.",
:code_file=>"http://github.com/jbrownlee/CleverAlgorithms/raw/master/src/algorithms/evolutionary/genetic_algorithm.rb",
:references=>"Holland is the grandfather of the field that became Genetic Algorithms. Holland investigated adaptive systems in the late 1960s proposing an adaptive system formalism and adaptive strategies referred to as 'adaptive plans' \\cite{Holland1962} \\cite{Holland1962a} \\cite{Holland1969}. Holland's theoretical framework was investigated and elaborated by his Ph.D. students at the University of Michigan. Rosenberg investigated a chemical and molecular model of a biological inspired adaptive plan \\cite{Rosenberg1967}. Bagley investigated meta-environments and a genetic adaptive plan referred to as a genetic algorithm applied to a simple game called hexapawn \\cite{Bagley1967}. Cavicchio further elaborated the genetic adaptive plan by proposing numerous variations, referring to some as 'reproductive plans' \\cite{Cavicchio1970}.\nOther important contributions were made by Frantz who investigated what were referred to as genetic algorithms for search \\cite{Frantz1972}, and Hollstien who investigated genetic plans for adaptive control and function optimization \\cite{Hollstien1971}. De Jong performed a seminal investigation of the genetic adaptive model (genetic plans) applied to continuous function optimization and his suite of test problems adopted are still commonly used \\cite{Jong1975}. Holland wrote the the seminal book on his research focusing on the proposed adaptive systems formalism, the reproductive and genetic adaptive plans, and provided a theoretical framework for the mechanisms used and explanation for the capabilities of what would become genetic algorithms \\cite{Holland1975}.\nThe field of genetic algorithms is very large, resulting in large numbers of variations on the canonical technique. Goldberg provides a classical overview of the field in a review article \\cite{Goldberg1994}, as does Mitchell \\cite{Mitchell1995}. Whitley describes a classical tutorial for the genetic algorithm covering both practical and theoretical concerns \\cite{Whitley1994}. The classical book on genetic algorithms as an optimization and machine learning technique was written by Goldberg and provides an in-depth review and practical study of the approach \\cite{Goldberg1989}. Mitchell provides a contemporary reference text introducing the technique and the field \\cite{Mitchell1998}. Finally, Goldberg provides a modern study of the field, the lessons learned, and reviews the broader toolset of optimization algorithms that the field has produced \\cite{Goldberg2002}.",
:bibliography=>"Back1993:Thomas Back. Optimal mutation rates in genetic search. In Proceedings of the 5th International Conference on Genetic Algorithms, 1993.\nBagley1967:John Daniel Bagley. The behavior of adaptive systems which employ genetic and correlation algorithms. PhD thesis, University of Michigan, 1967.\nFrantz1972:D. R. Frantz. Non-linearities in genetic adaptive search. PhD thesis, University of Michigan, 1972.\nGoldberg1992:D. E. Goldberg, K. Deb, and J. H. Clark. Genetic algorithms, noise, and the sizing of populations. Complex Systems, 6:333–362, 1992.\nGoldberg1994:David E. Goldberg. Genetic and evolutionary algorithms come of age. Communications of the ACM, 37(3):113–119, 1994.\nGoldberg1989:David Edward Goldberg. Genetic algorithms in search, optimization, and machine learning. Addison-Wesley, 1989.\nGoldberg2002:David Edward Goldberg. The design of innovation: lessons from and for competent genetic algorithms. Springer, 2002.\nHolland1962a:J. H. Holland. Information processing in adaptive systems. In Processing of Information in the Nervous System, pages 330–338, 1962.\nHolland1969:J. H. Holland. Adaptive plans optimal for payoff-only environments. In Proceedings of the Second Hawaii Conference on Systems Sciences, 1969.\nHolland1962:John H. Holland. Outline for a logical theory of adaptive systems. Journal of the ACM (JACM), 9(3):297–314, 1962.\nHolland1975:John Henry Holland. Adaptation in natural and artificial systems: an introductory analysis with applications to biology, control, and artificial intelligence. University of Michigan Press, 1975.\nHollstien1971:R. B. Hollstien. Artificial genetic adaptation in computer control systems. PhD thesis, The University of Michigan, 1971.\nJong1992:Kenneth A. De Jong. Genetic algorithms are NOT function optimizers. In Proceedings of the Second Workshop on Foundations of Genetic Algorithms, pages 5–17, Morgan Kaufmann, 1992.\nJong1975:Kenneth Alan De Jong. An analysis of the behavior of a class of genetic adaptive systems. PhD thesis, University of Michigan Ann Arbor, MI, USA, 1975.\nCavicchio1970:Daniel Joseph Cavicchio Jr. Adaptive Search Using Simulated Evolution. PhD thesis, The University of Michigan, 1970.\nMitchell1995:M. Mitchell. Genetic algorithms: An overview. Complexity, 1(1):31–39, 1995.\nMitchell1998:Melanie Mitchell. An Introduction to Genetic Algorithms. MIT Press, 1998.\nMuhlenbein1992:Heinz Muhlenbein. How genetic algorithms really work: I. mutation and hillclimbing. In Parallel Problem Solving from Nature 2, pages 15–26, 1992.\nRosenberg1967:Richard Rosenberg. Simulation of genetic populations with biochemical properties. PhD thesis, University of Michigan, 1967.\nWhitley1994:D. Whitley. A genetic algorithm tutorial. Statistics and Computing, 4:65–85, 1994.",
:web=>"Genetic algorithm - Wikipedia$http://en.wikipedia.org/wiki/Genetic_algorithm\nGenetic algorithm - Wolfram MathWorld$http://mathworld.wolfram.com/GeneticAlgorithm.html\nWhat's a Genetic Algorithm (GA)? - The Hitch-Hiker's Guide to Evolutionary Computation$http://www.aip.de/~ast/EvolCompFAQ/Q1_1.htm",
:kingdom=>"Evolutionary",
:released=>1,
:book=>1)



# lots of algo names
Algorithm.create!(:name=>"Random Search",:kingdom=>"Stochastic",:book=>1)
Algorithm.create!(:name=>"Adaptive Random Search",:kingdom=>"Stochastic",:book=>1)
Algorithm.create!(:name=>"Stochastic Hill Climbing",:kingdom=>"Stochastic",:book=>1)
Algorithm.create!(:name=>"Iterated Local Search",:kingdom=>"Stochastic",:book=>1)
Algorithm.create!(:name=>"Guided Local Search",:kingdom=>"Stochastic",:book=>1)
Algorithm.create!(:name=>"Variable Neighborhood Search",:kingdom=>"Stochastic",:book=>1)
Algorithm.create!(:name=>"Greedy Randomized Adaptive Search",:kingdom=>"Stochastic",:book=>1)
Algorithm.create!(:name=>"Scatter Search",:kingdom=>"Stochastic",:book=>1)
Algorithm.create!(:name=>"Tabu Search",:kingdom=>"Stochastic",:book=>1)
Algorithm.create!(:name=>"Reactive Tabu Search",:kingdom=>"Stochastic",:book=>1)

Algorithm.create!(:name=>"Simulated Annealing",:kingdom=>"Physical",:book=>1)
Algorithm.create!(:name=>"Adaptive Simulated Annealing",:kingdom=>"Physical",:book=>1)
Algorithm.create!(:name=>"Memetic Algorithm",:kingdom=>"Physical",:book=>1)
Algorithm.create!(:name=>"Extremal Optimization",:kingdom=>"Physical",:book=>1)
Algorithm.create!(:name=>"Cultural Algorithm",:kingdom=>"Physical",:book=>1)

Algorithm.create!(:name=>"Genetic Programming",:kingdom=>"Evolutionary",:book=>1)
Algorithm.create!(:name=>"Evolutionary Programming",:kingdom=>"Evolutionary",:book=>1)
Algorithm.create!(:name=>"Evolution Strategies",:kingdom=>"Evolutionary",:book=>1)
Algorithm.create!(:name=>"Learning Classifier System",:kingdom=>"Evolutionary",:book=>1)
Algorithm.create!(:name=>"Differential Evolution",:kingdom=>"Evolutionary",:book=>1)
Algorithm.create!(:name=>"Grammatical Evolution",:kingdom=>"Evolutionary",:book=>1)
Algorithm.create!(:name=>"Non-dominated Sorting Genetic Algorithm",:kingdom=>"Evolutionary",:book=>1)
Algorithm.create!(:name=>"Strength Pareto Evolutionary Algorithm",:kingdom=>"Evolutionary",:book=>1)
Algorithm.create!(:name=>"Island Population Genetic Algorithm",:kingdom=>"Evolutionary",:book=>1)

Algorithm.create!(:name=>"Cross-Entropy Method",:kingdom=>"Probabilistic",:book=>1)
Algorithm.create!(:name=>"Population-Based Incremental Learning",:kingdom=>"Probabilistic",:book=>1)
Algorithm.create!(:name=>"Probabilistic Incremental Program Evolution",:kingdom=>"Probabilistic",:book=>1)
Algorithm.create!(:name=>"Compact Genetic Algorithm",:kingdom=>"Probabilistic",:book=>1)
Algorithm.create!(:name=>"Extended Compact Genetic Algorithm",:kingdom=>"Probabilistic",:book=>1)
Algorithm.create!(:name=>"Bayesian Optimization Algorithm",:kingdom=>"Probabilistic",:book=>1)
Algorithm.create!(:name=>"Hierarchical Bayesian Optimization Algorithm",:kingdom=>"Probabilistic",:book=>1)
Algorithm.create!(:name=>"Univariate Marginal Distribution Algorithm",:kingdom=>"Probabilistic",:book=>1)
Algorithm.create!(:name=>"Bivariate Marginal Distribution Algorithm",:kingdom=>"Probabilistic",:book=>1)
Algorithm.create!(:name=>"Gaussian Adaptation",:kingdom=>"Probabilistic",:book=>1)

Algorithm.create!(:name=>"Particle Swarm Optimization",:kingdom=>"Swarm",:book=>1)
Algorithm.create!(:name=>"AntNet",:kingdom=>"Swarm",:book=>1)
Algorithm.create!(:name=>"Ant System",:kingdom=>"Swarm",:book=>1)
Algorithm.create!(:name=>"Max-Min Ant System",:kingdom=>"Swarm",:book=>1)
Algorithm.create!(:name=>"Rank-Based Ant System",:kingdom=>"Swarm",:book=>1)
Algorithm.create!(:name=>"Ant Colony System",:kingdom=>"Swarm",:book=>1)
Algorithm.create!(:name=>"Multiple Ant Colony System",:kingdom=>"Swarm",:book=>1)
Algorithm.create!(:name=>"Population-based Ant Colony Optimization",:kingdom=>"Swarm",:book=>1)
Algorithm.create!(:name=>"Bees Algorithm",:kingdom=>"Swarm",:book=>1)
Algorithm.create!(:name=>"Bacterial Foraging Optimization Algorithm",:kingdom=>"Swarm",:book=>1)

Algorithm.create!(:name=>"Clonal Selection Algorithm",:kingdom=>"Immune",:book=>1)
Algorithm.create!(:name=>"Negative Selection Algorithm",:kingdom=>"Immune",:book=>1)
Algorithm.create!(:name=>"Artificial Immune Recognition System",:kingdom=>"Immune",:book=>1)
Algorithm.create!(:name=>"Immune Network Algorithm",:kingdom=>"Immune",:book=>1)
Algorithm.create!(:name=>"Dendritic Cell Algorithm",:kingdom=>"Immune",:book=>1)

# other 
Algorithm.create!(:name=>"Fitness Sharing Genetic Algorithm",:kingdom=>"Evolutionary",:book=>0)
Algorithm.create!(:name=>"Messy Genetic Algorithm",:kingdom=>"Evolutionary",:book=>0)
Algorithm.create!(:name=>"Linkage Learning Algorithm",:kingdom=>"Evolutionary",:book=>0)
