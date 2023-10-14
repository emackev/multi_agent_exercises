function sensation = perception(state, sensory_range)
% PERCEPTION Calculate sensory information for agents in the environment.
%
%   sensation = PERCEPTION(state, sensory_range)
%
%   Inputs:
%       - state: Current state of the simulation, including agent positions
%                and environment data.
%       - sensory_range: Range of sensory perception for agents.
%
%   Outputs:
%       - sensation: An array of sensory information for each agent,
%                    including odor information within their sensory range.
%
%   Details:
%       This function calculates sensory information for each agent based on
%       their current positions and the environment's odor_map. The 'state'
%       structure contains agent positions and the odor_map. 'sensory_range'
%       determines the range over which agents can perceive odor.
%
%   Inputs:
%       - state: Current state of the simulation, including:
%           - agents: Agent information, including XY positions.
%           - environment: Environment information, including odor_map.
%       - sensory_range: Range of sensory perception for agents.
%
%   Outputs:
%       - sensation: An array of structs, each containing:
%           - odor: Sensory information (odor) within the agent's sensory range.
%                   This information is extracted from the environment's odor_map.
%
%   See also: SIMULATE_AGENTS, INITIALIZE_AGENTS, INITIALIZE_ENVIRONMENT,
%             POLICY_DIFFUSION, POLICY_LEVY, POLICY_SEEK_ODOR, PHYSICS.
%
%   Author: Emily Mackevicius
%   Date: October 13, 2023
%   docstring generated with LLM

sensation = struct();
n_agents = length(state.agents);
odor_map = state.environment.odor_map; 
xy_max = size(state.environment.odor_map,1);
buffer_odor_map = zeros(xy_max+2*sensory_range+2); 
buffer_odor_map(sensory_range+(1:xy_max), sensory_range+(1:xy_max)) = odor_map; 
for ai = 1:n_agents
    xrange = 1 + round(state.agents(ai).XY(1))+(0:2*sensory_range);
    yrange = 1 + round(state.agents(ai).XY(2))+(0:2*sensory_range);
    sensation(ai).odor = buffer_odor_map(yrange, xrange); 
end