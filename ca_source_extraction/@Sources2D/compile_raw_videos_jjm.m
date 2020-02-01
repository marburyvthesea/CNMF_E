function [movie_array_for_analysis] = compile_raw_videos_jjm(obj, raw_movie_list)
% add raw movie files to file id column of Sources2D  

num_batches = size(obj.batches, 1);

movie_array_for_analysis = cell(num_batches, 2);

num_frames_per_batch = size(obj.C, 2)/num_batches; 

for i = 1:num_batches
    
    movie_array_for_analysis{i, 1} = [(num_frames_per_batch*(i-1))+1, num_frames_per_batch*i] ;
    movie_array_for_analysis{i, 2} = raw_movie_list{i,1} ;
end
end

