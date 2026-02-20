# Winter 2026 ECE210 Chip Design project - Jovanni Shen
# Project Title - Leaky Integrate and Fire Network

# This project integrates the LIF neuron model that was shown in the demo lectures into a larger network structure.
# The entire network has 3 layers, including input and output.
# The input layer has two neurons, the middle layer has 4 neurons, and the output layer has 2 neurons.
# Each neuron's spikes are individually weighted to their connected neurons by utilizing different bits of the input current. 
# This allows for separate weights while keeping the neuron model the same overall, with a 4-bit input current. 
# Decreased the input current wire size for the LIF neuron compared to the model in the demo lecture to compensate for having two input neurons, but only 8 bits of input.
