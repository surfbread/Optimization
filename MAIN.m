clc;
clear;
close all;

%% Problem

problem.objFunc=@(x) Binh_Korn(x);      % Objective Function

problem.varMin = [0                     % Lower Boundary Vector
                  0];                   
      
problem.varMax = [3                     % Upper Boundary Vector
                  5];                   
              
problem.nVar = length(problem.varMax);  % Number of Variables

problem.varSize=[1 problem.nVar];       % Variables Matrix Size

%% Parameters

% Differential Evolution Algorithm:

param.nIt = 100;              % Maximum Number of Iterations
param.nPop = 100;             % Population Size
param.nBest = 100;            % Number of Best Individuals

param.F_min = 0.2;            % Lower Bound of Scaling Factor
param.F_max = 0.8;            % Upper Bound of Scaling Factor
param.F1 = 0.5;               % Primary Scale Factor
param.F2 = 0.3;               % Secondary Scale Factor
param.Cr = 0.2;               % Crossover Rate
param.mutation_scheme = 2;    % Choice of Mutation-Scheme

% Multi-Objective:

% Objective Function Space Grid
param.nGrid = 50;             % Number of Grid Sub-Divisions
param.alpha = 0.1;            % Inflation Rate

% Global Best Individual Selection
param.beta = 2;               % Best Individual Selection Pressure
param.gamma = 2;              % Best Individual Deletion Pressure

%% Results

NonDominatedSolutions = callMODEA(problem,param);
