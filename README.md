# Traveling salesman problem with simulated annealing
### "Given a list of cities and the distances between each pair of cities, what is the shortest possible route that visits each city and returns to the origin city?"
- The process of annealing starts with a path which simply lists all of the cities in the order their positions were randomly selected.
- On each temperature step, a segment of the path is selected, with its start and end cities chosen at random.
- Reverse transformation: an alternative path is generated in which the cities in the chosen segment are reversed in order of visit
- The length of the modified path is then calculated and compared to the path before modification.
- If the modified path is shorter than the original path, it always replaces it.
- If it is longer, however, the exponential of the cost's negative magnitude divided by the current temperature is compared to 
a uniformly distributed random number between 0 and 1 and, if greater, the modified path will be used even though it increased the cost.