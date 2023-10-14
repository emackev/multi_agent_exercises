# Exploring multi-agent behavior
Exercises and demos by Emily Mackevicius, guest lecturing for the Analysis for Neuroscience course at Columbia University. Course Instructors: Itamar Kahn, Ashok Litwin-Kumar, Aniruddha Das. The course is taught using MATLAB. 

Multi-agent behaviors are ubiquitous across the evolutionary tree, with spatial scales ranging from microscopic to global. In these exercises, we'll simulate several simple multi-agent behaviors, with the goal of practicing general-purpose analysis and coding skills along the way.

# Skills we'll practice
- Visualize data
- Use and adapt existing code
- Reason about how agents' decision-making policies, and environmental features, generate behaviors
- Translate ideas into code

# Types of multi-agent behaviors we'll explore
- Random walkers -- diffusion
- Random walkers -- levy flight
- Odor-seeking -- environmental gradient
- Odor-seeking -- following pheromones

# Organization of code
- Demos and exercises in demo.mlx.
- The main simulation function is simulate_agents.m. 
- Relevant information is stored in MATLAB structs state, sensation, and action. 
- This information transforms through time with perception, policy, and physics functions
![](https://github.com/emackev/multi_agent_exercises/blob/main/collaborative%20intelligent%20systems%20-%20page%2073.png?raw=true)

# Getting started
Clone or download the repository, start with demo.mlx

```gh repo clone emackev/multi_agent_exercises```
