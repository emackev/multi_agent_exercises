function plot_heatmap(XY_all, xy_max, nbins)
% PLOT_HEATMAP Plot a heatmap of agent positions over time.
%
%   plot_heatmap(XY_all, xy_max, nbins)
%
%   Inputs:
%       - XY_all: Array containing agent positions over time
%                 (n_agents x n_timesteps x 2).
%       - xy_max: Maximum XY coordinate for the environment.
%       - nbins: Number of bins for creating the heatmap.
%
%   Details:
%       This function creates a heatmap of agent positions over time using
%       the provided agent positions stored in 'XY_all'. The heatmap is
%       displayed with the specified number of bins 'nbins' along the X and Y
%       axes within the XY coordinate limits defined by 'xy_max'. The heatmap
%       view is set to a top-down perspective, and axis labels are added.
%
%   Inputs:
%       - XY_all: Array containing agent positions over time (n_agents x n_timesteps x 2).
%       - xy_max: Maximum XY coordinate for the environment.
%       - nbins: Number of bins for creating the heatmap.
%
%   See also: SIMULATE_AGENTS, INITIALIZE_AGENTS, INITIALIZE_ENVIRONMENT,
%             PERCEPTION, POLICY_DIFFUSION, POLICY_LEVY, POLICY_SEEK_ODOR, PHYSICS.
%
%   Author: Emily Mackevicius
%   Date: October 13, 2023
%   docstring generated by LLM

x_edges = linspace(0, xy_max, nbins); 
y_edges = linspace(0, xy_max, nbins); 
histogram2(XY_all(:,:,1)', XY_all(:,:,2)',x_edges, y_edges, 'displaystyle', 'tile', 'showemptybins', 'on')
view(0,90)
xlim([0 xy_max])
ylim([0 xy_max])
axis square
xlabel('x')
ylabel('y')
colorbar