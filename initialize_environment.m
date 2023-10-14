function environment = initialize_environment(xy_max, env_type)
% INITIALIZE_ENVIRONMENT Initialize an environment for agent simulation.
%
%   environment = INITIALIZE_ENVIRONMENT(xy_max, env_type)
%
%   Inputs:
%       - xy_max: Maximum XY coordinate for the environment.
%       - env_type: Type of environment ('gradient', 'plume', 'pheromone', 'random', 'empty').
%
%   Outputs:
%       - environment: A struct containing the initialized environment data.
%
%   Details:
%       This function initializes an environment for use in an agent simulation.
%       The environment type is specified by 'env_type', and the maximum
%       XY coordinate is given by 'xy_max'. Depending on the 'env_type', the
%       function creates an odor_map that represents the environmental cues
%       that agents may perceive during simulation. The structure 'environment'
%       contains the initialized environment data.
%
%   Environment Types:
%       - 'gradient': Creates an environment with a gradient odor map.
%       - 'plume': Imports an image, resizes it, and converts it to grayscale
%                  to use as the odor map.
%       - 'pheromone': Initializes an environment with no odor (zero values).
%       - 'random': Generates a random odor map.
%       - 'empty': Initializes an empty environment with no odor map.
%
%   See also: SIMULATE_AGENTS, INITIALIZE_AGENTS, PERCEPTION, POLICY_DIFFUSION,
%             POLICY_LEVY, POLICY_SEEK_ODOR, PHYSICS.
%
%   Author: Emily Mackevicius
%   Date: October 14, 2023
%   docstring generated with LLM

environment = struct();
switch env_type
    case 'gradient'
        environment.odor_map = (1:xy_max)+(1:xy_max)';
    case 'plume'
        % import image
        imported_image = imread('plume.png');
        % resize, make grayscale
        use_me = imresize(mean(imported_image,3), [xy_max, xy_max]);
        environment.odor_map = use_me;
    case 'pheromone'
        environment.odor_map = zeros(xy_max); 
    case 'random' 
        environment.odor_map = rand(xy_max);
    case 'empty' 
        environment.odor_map = [];
end