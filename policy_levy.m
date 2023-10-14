function actions = policy_levy(sensation, beta)
% POLICY_LEVY Generate actions for agents using Levy flight policy.
%
%   actions = POLICY_LEVY(sensation, beta)
%
%   Inputs:
%       - sensation: Sensory information for each agent.
%       - beta: Power law index for Levy flight (1 < beta < 2).
%
%   Outputs:
%       - actions: An array of actions for each agent, including step length (r)
%                 and direction (theta) in polar coordinates.
%
%   Details:
%       This function generates actions for a group of agents using the Levy
%       flight policy. Each agent's action includes a step length (r) and a
%       direction (theta) in polar coordinates. The step length follows a
%       heavy-tailed Levy distribution with the specified power law index
%       'beta'. Sensory information is used to influence the policy, but the
%       core policy is based on Levy flight characteristics.
%
%   Inputs:
%       - sensation: Sensory information for each agent.
%           (You can provide additional details about the 'sensation' data if needed)
%       - beta: Power law index for Levy flight (1 < beta < 2). Higher beta
%               values result in shorter steps and less exploration.
%
%   Outputs:
%       - actions: An array of structs, each containing the following fields:
%           - r: Step length (distance) for the agent.
%           - theta: Direction (angle) in radians for the agent's movement.
%
%   See also: SIMULATE_AGENTS, INITIALIZE_AGENTS, INITIALIZE_ENVIRONMENT,
%             PERCEPTION, POLICY_DIFFUSION, POLICY_SEEK_ODOR, PHYSICS.
%
%   Author: Emily Mackevicius
%   Date: October 13, 2023
%   docstring generated with LLM

n_agents = length(sensation);
for ai = 1:n_agents
    % sample heavy-tailed levy step https://www.mathworks.com/matlabcentral/fileexchange/54203-levy-n-m-beta
    num = gamma(1+beta)*sin(pi*beta/2); 
    den = gamma((1+beta)/2)*beta*2^((beta-1)/2);
    sigma_u = (num/den)^(1/beta); 
    u = normrnd(0,sigma_u^2); 
    v = normrnd(0,1); 
    step = u./(abs(v).^(1/beta));
    
    % store action r & theta
    actions(ai).r = step;
    actions(ai).theta = unifrnd(0, 2*pi);
end
