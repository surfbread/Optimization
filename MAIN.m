clc;
clear;
close all;

%% Problem:

problem.objFunction = @(x) Binh_Korn(x);  % Objective Function

problem.varMin = [0                       % Lower Boundary Vector of Variables
                  0];          
    
problem.varMax = [3                       % Upper Boundary Vector of Variables
                  5];                         

problem.nVar = numel(problem.varMax);     % Number of Variables

problem.varSize = [1 problem.nVar];       % Size of Variables Matrix


%% Parameters

% General:
param.nIt = 100;            	% Number of Iterations
param.nParticles = 100;         % Number of Particles (Swarm Size)
param.nArchivedParticles = 100; % Archive Size (Non-Dominated Solutions)

% Particle Movement
param.w = 0.5;                  % Inertia Weight (Inertia Coefficient)
param.wDamp = 0.99;             % Intertia Weight Damping Rate (Damping Ratio)
param.c1 = 1;                   % Personal Learning Coefficient (Personal Acceleration Coefficient)
param.c2 = 2;                   % Global Learning Coefficient (Social Acceleration Cofficient)

% Objective Function Space Grid
param.nGrid = 30;               % Number of Grid Sub-Divisions
param.alpha = 0.1;              % Inflation Rate

% Global Best Particle Selection
param.beta = 2;                 % Leader Selection Pressure
param.gamma = 2;                % Deletion Selection Pressure

% Particle Mutation
param.mu = 0.1;                 % Mutation Rate

%% Call Multi-Objective Particle Swarm Optimization

NonDominatedSolutions = callMOPSO(problem,param);

