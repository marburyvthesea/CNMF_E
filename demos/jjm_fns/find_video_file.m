
frames = [050, 100] ; 

for rf_index=1:size(movie_array_for_analysis, 1) 
    if ((frames(1)>=movie_array_for_analysis{rf_index,1}(1)) && (frames(1)<=movie_array_for_analysis{rf_index,1}(2)))
        video_file = movie_array_for_analysis{rf_index,2} ;
        raw_frames = [frames(1)-movie_array_for_analysis{rf_index,1}(1)+1, frames(2)-movie_array_for_analysis{rf_index,1}(1)+1]; 
    end
end
    
video_file
raw_frames