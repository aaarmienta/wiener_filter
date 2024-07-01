% -------------------------------------------------------------------------
%  File :
%    wienerFilter.m
%
%  Description :
%    Calculates the optimal Wiener Filter weights and filters data.
%  
%  Input Parameters :
%    x  = Input Signal
%    d  = Desired Signal
%    Nw = Number of Filter Weights
%
%  Output Parameters :
%    y = Output Signal
%    e = Error Signal
%    w = Optimal Weight Vector
% -------------------------------------------------------------------------

function [w] = wienerFilter(x, d, Nw)
  %% Tested Inputs
  % x = [1 9 5];
  % d = [4 3 7];
  % Nw = 3;
  %% Input Length
  Nx = length(x);
  if (Nx ~= length(d))
    error("Training/Desired data needs to be the same length as the input data");
  end

  %% Convolution Length
  convLen = Nx + Nw - 1;
  %% Initialize Function Outputs
  y = zeros(convLen,1);
  e = zeros(convLen,1);
  w = zeros(Nw,1);
  %% Auto-Correlation Matrix
  x = [x zeros(1:Nx-1)];
  X = zeros(2*Nx-1,2*Nx-1);
  X(1,:) = x(1:end);
  for i = 2:2*Nx-1
      x = [zeros(1,i-1), x(i-1:end-1)];
      X(i,:) = x;
  end
  Rxx = X*X';
  Rxx = Rxx(1:Nx,1:Nx);  
  %% Cross-Correlation Vector
  d = [d zeros(1:Nx-1)];
  rxd = X*d';
  rxd = rxd(1:Nx);
  %% Optimal Wiener Filter Weights
  w = Rxx\rxd;