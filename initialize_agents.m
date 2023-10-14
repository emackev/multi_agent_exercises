function agents = initialize_agents(n_agents, n_timesteps, xy_min, xy_max)
agents = struct();
for ai = 1:n_agents
    agents(ai).XY = unifrnd(xy_min, xy_max, 1, 2);
end