function state = physics(actions, prev_state, xy_max, env_type)
% PHYSICS Update agent positions and environment in the simulation.
%
%   state = PHYSICS(actions, prev_state, xy_max, env_type)
%
%   Inputs:
%       - actions: Array of agent actions, including step length (r) and
%                  direction (theta) in polar coordinates.
%       - prev_state: Previous state of the simulation, including agent positions
%                     and environment data.
%       - xy_max: Maximum XY coordinate for the environment.
%       - env_type: Type of environment ('pheromone' or other).
%
%   Outputs:
%       - state: Updated state of the simulation after applying agent actions
%                and environment changes.
%
%   Details:
%       This function updates the positions of agents based on their actions
%       and applies boundary conditions to prevent agents from going outside
%       the environment boundaries. It also updates the environment, especially
%       for 'pheromone' type environments where agents leave pheromone trails
%       and the pheromone diffuses over time.
%
%   Inputs:
%       - actions: Array of agent actions, each including:
%           - r: Step length (distance) for the agent's movement.
%           - theta: Direction (angle) in radians for the agent's movement.
%       - prev_state: Previous state of the simulation, including:
%           - agents: Agent information, including XY positions.
%           - environment: Environment information, including odor_map.
%       - xy_max: Maximum XY coordinate for the environment.
%       - env_type: Type of environment ('pheromone' or other).
%
%   Outputs:
%       - state: Updated state of the simulation, including:
%           - agents: Updated agent positions.
%           - environment: Updated environment data.
%
%   Author: Emily Mackevicius
%   Date: October 13, 2023
%   docstring generated with LLM

n_agents = length(actions);
state = prev_state;

% update agents
for ai = 1:n_agents
    [stepX, stepY] = pol2cart(actions(ai).theta, actions(ai).r);
    state.agents(ai).XY = prev_state.agents(ai).XY + [stepX, stepY];
    
    % boundary conditions
    if state.agents(ai).XY(1) < 0
        state.agents(ai).XY(1) = 0;
    end
    if state.agents(ai).XY(2) < 0
        state.agents(ai).XY(2) = 0;
    end
    if state.agents(ai).XY(1) > xy_max
        state.agents(ai).XY(1) = xy_max;
    end
    if state.agents(ai).XY(2) > xy_max
        state.agents(ai).XY(2) = xy_max;
    end
end

% update environment
switch env_type
    case 'pheromone'
        % add pheromone at current agent locs
        for ai = 1:n_agents
            x = max(1, round(state.agents(ai).XY(1))); 
            y = max(1, round(state.agents(ai).XY(2))); 
            state.environment.odor_map(y,x) = ...
                1 + state.environment.odor_map(y,x); 
        end
        % diffuse all pheromone
        diff_w = 11; % should be odd
        diff_kernel = gausswin(diff_w)*gausswin(diff_w)';
        diff_kernel = diff_kernel/sum(diff_kernel(:)); 
        state.environment.odor_map = conv2(state.environment.odor_map, diff_kernel, 'same');
end