function actions = policy_diffusion(sensation, lambda)
n_agents = length(sensation);
for ai = 1:n_agents
    actions(ai).r = exprnd(lambda);
    actions(ai).theta = unifrnd(0, 2*pi);
end
