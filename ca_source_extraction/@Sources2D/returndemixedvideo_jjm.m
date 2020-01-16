function [movie_object] = returndemixedvideo_jjm(obj, neuron_idx, frame_range)
%%a few frames of demixed movie for visual inspection
%is cropped to within a few pixels of gSig

%crop
c_mean = mean(obj.Coor{neuron_idx, 1}(1, :)) ; 
r_mean = mean(obj.Coor{neuron_idx, 1}(2, :)) ;

%full image
A_dense = full(obj.A(:,1));
A_reshaped_full = reshape(A_dense, [obj.options.d1, obj.options.d2]);

%cropping movie
c_lims = [round(c_mean) - obj.options.gSiz*3, round(c_mean) + obj.options.gSiz*3]; 
r_lims = [round(r_mean) - obj.options.gSiz*3, round(r_mean) + obj.options.gSiz*3];
A_reshaped = A_reshaped_full(r_lims(1):r_lims(2), c_lims(1):c_lims(2));
demixed = zeros(r_lims(2)-r_lims(1)+1, c_lims(2)-c_lims(1)+1, frame_range(2)-frame_range(1));

C_neuron = obj.C(neuron_idx,:);   

% calcium traces
for frame=1:(frame_range(2)-frame_range(1))
    demixed(:,:,frame) = A_reshaped*C_neuron(frame+frame_range(1)); 
end
% demixed movie
[max_C, max_C_idx] = max(C_neuron); 
max_AC = max(max(A_reshaped*C_neuron(max_C_idx)));
clims = [0, max_AC];

figure
for frame=1:(frame_range(2)-frame_range(1))
    h = imagesc(demixed(:,:,frame));
    cdata = h.CData ;
    cm = colormap(h.Parent); % get axes colormap
    n = size(cm,1); % number of colors in colormap
    c = linspace(clims(1), clims(2), n); 
    ind = reshape(interp1(c,1:n,demixed(:,:,frame),'nearest'),size(demixed(:,:,frame))); % indexed image
    rgb = ind2rgb(ind,cm);
    M_demixed(frame) =  im2frame(double(ind), cm);
    drawnow; 
    pause(0.3);
    
end
close
movie_object = M_demixed 
end

