function XY_all = simulate_agents(n_agents, n_timesteps, xy_max, start_pos_min, start_pos_max, ...
    type_of_agents, env_type, sensory_range, plot_realtime); 

% SIMULATE_AGENTS Simulate the movement of agents in an environment.
%
%   XY_all = SIMULATE_AGENTS(n_agents, n_timesteps, xy_max, start_pos_min, start_pos_max,
%                           type_of_agents, env_type, sensory_range, plot_realtime)
%
%   Inputs:
%       - n_agents: Number of agents.
%       - n_timesteps: Number of simulation time steps.
%       - xy_max: Maximum XY coordinate for the environment.
%       - start_pos_min: Minimum starting position for agents.
%       - start_pos_max: Maximum starting position for agents.
%       - type_of_agents: Type of agents ('diffusion', 'levy', 'seek_odor').
%       - env_type: Type of environment.
%       - sensory_range: Range of sensory perception for agents.
%       - plot_realtime: Flag to enable real-time plotting (1 or 0).
%
%   Outputs:
%       - XY_all: Array containing agent positions over time (n_agents x n_timesteps x 2).
%
%   Details:
%       This function simulates the movement of agents in a specified environment
%       based on their policies and sensory perception. The agents can follow
%       different types of policies: 'diffusion', 'levy', or 'seek_odor'. The
%       simulation results are stored in the XY_all array, which contains the
%       X and Y coordinates of each agent at each time step.
%
%   See also: INITIALIZE_AGENTS, INITIALIZE_ENVIRONMENT, PERCEPTION,
%             POLICY_DIFFUSION, POLICY_LEVY, POLICY_SEEK_ODOR, PHYSICS.
%
%   Emily Mackevicius
%   October 14, 2023
%   docstring generated with LLM

% initialize
state.agents = initialize_agents(n_agents, n_timesteps, start_pos_min, start_pos_max);
state.environment = initialize_environment(xy_max, env_type);
XY_all = zeros(n_agents, n_timesteps, 2);

% simulate
if plot_realtime
    figure; 
    im = imagesc(0:xy_max, 0:xy_max, state.environment.odor_map); 
    colormap gray
    axis image
    hold on
    sc = scatter(XY_all(:,end,1), XY_all(:,end,2), 'ro', 'filled');
    set(gca, 'ydir', 'normal')
    xlim([0, xy_max])
    ylim([0, xy_max])
    xlabel('x')
    ylabel('y')
end
for ti = 1:n_timesteps
    % sense the environment, if it's not empty
    if length(state.environment.odor_map)>0
        sensation = perception(state, sensory_range);
    else
        sensation = zeros(1,n_agents); 
    end
    
    % decide on an action, according to policy
    switch type_of_agents
        case 'diffusion'
            lambda = 1; % for diffusion, average step size
            actions = policy_diffusion(sensation, lambda);
        case 'levy'
            beta = 1.2; % for levy flight, power law index  % Note: 1 < beta < 2
            actions = policy_levy(sensation, beta);
        case 'seek_odor'
            actions = policy_seek_odor(sensation);
        case 'elm_try_something_new'
            p_levy = .1; 
            if rand<p_levy
                beta = 1.2; % for levy flight, power law index  % Note: 1 < beta < 2
                actions = policy_levy(sensation, beta);
            else
                actions = policy_seek_odor(sensation);
                for ai = 1:n_agents
                    actions(ai).theta = actions(ai).theta+pi/2;
                end
            end
        case 'your_policy'
            % insert your policy here, feel free to call existing functions
    end
    
    % step environment
    state = physics(actions, state, xy_max, env_type);
    
    % store trajectories
    for ai = 1:n_agents
        XY_all(ai, ti, :) = state.agents(ai).XY; 
    end
    if plot_realtime
        figure; 
        im.CData = state.environment.odor_map; 
        sc.XData = XY_all(:,ti,1);
        sc.YData = XY_all(:,ti,2);
        drawnow;
    end
end