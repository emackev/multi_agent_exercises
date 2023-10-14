function actions = policy_seek_odor(sensation)
% POLICY_SEEK_ODOR Generate actions for agents seeking odor sources.
%
%   actions = POLICY_SEEK_ODOR(sensation)
%
%   Inputs:
%       - sensation: Sensory information for each agent, including odor
%                    concentration in their vicinity.
%
%   Outputs:
%       - actions: An array of actions for each agent, including step length (r)
%                 and direction (theta) in polar coordinates.
%
%   Details:
%       This function generates actions for a group of agents seeking odor
%       sources based on their sensory information. Each agent's action is
%       determined by calculating a weighted average of odor concentrations
%       within their sensory range. The resulting action includes a step length
%       (r) and a direction (theta) in polar coordinates.
%
%   Inputs:
%       - sensation: Sensory information for each agent, including:
%           - odor: Concentration of odor in the agent's vicinity.
%
%   Outputs:
%       - actions: An array of structs, each containing the following fields:
%           - r: Step length (distance) for the agent's movement.
%           - theta: Direction (angle) in radians for the agent's movement.
%
%   Author: Emily Mackevicius
%   Date: October 13, 2023
%   docstring generated with LLM

n_agents = length(sensation);
sensory_range = floor(size(sensation(1).odor,1)/2); 
for ai = 1:n_agents
    % weighted ave
    if sum(sensation(ai).odor(:))>0
        [yy,xx] = meshgrid(-sensory_range:sensory_range); 
        x = sum(xx(:).*sensation(ai).odor(:))/sum(sensation(ai).odor(:)); 
        y = sum(yy(:).*sensation(ai).odor(:))/sum(sensation(ai).odor(:)); 
    else
        x = 0; y = 0; 
    end
    [theta,r] = cart2pol(y, x);
    
    % store action r & theta
    actions(ai).r = r;
    actions(ai).theta = theta;
end
