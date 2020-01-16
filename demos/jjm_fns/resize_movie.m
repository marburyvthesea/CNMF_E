function [newmov] = resize_movie(mov,factor)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
% read in the movie

% reduce the movie by 2
figure 
% get dimensions of example.avi
    dims = size(mov(1).cdata);
% scale axes, flip ydir for IMAGE, set units to pixels
    ha = axes( ...
      'units','pixels', ...
      'position',[0 0 dims([2 1])*factor], ...
      'nextplot','replacechildren', ...
      'ydir','reverse');
    axis(ha,'off');
% create new movie
%newmov = avifile('newexample.avi','compression','none');
    for i=1:length(mov)
      % display movie frame by frame on resized axis
      image(mov(i).cdata);
      axis(ha,'tight')
      % add frame to new movie
      newmov(i)= getframe(ha);
    end
% create new movie file
close
end

