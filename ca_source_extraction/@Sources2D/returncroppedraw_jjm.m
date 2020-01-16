function [movie_object] = returncroppedraw_jjm(obj, neuron_idx, frame_range, raw_file)
%raw video for comparison 

raw_im_data_subset = smod_bigread2(raw_file,frame_range(1),frame_range(2)-frame_range(1));

c_mean = mean(obj.Coor{neuron_idx, 1}(1, :)) ; 
r_mean = mean(obj.Coor{neuron_idx, 1}(2, :)) ;



c_lims = [round(c_mean) - obj.options.gSiz*3, round(c_mean) + obj.options.gSiz*3]; 
r_lims = [round(r_mean) - obj.options.gSiz*3, round(r_mean) + obj.options.gSiz*3];

raw_cropped = raw_im_data_subset(r_lims(1):r_lims(2), c_lims(1):c_lims(2), :);

max_AC_raw = max(max(max(raw_cropped)));
clims_raw = [0, max_AC_raw];
for frame=1:size(raw_cropped, 3)
    h = imagesc(raw_cropped(:,:,frame));
    cdata = h.CData;
    cm = colormap(h.Parent);
    n = size(cm,1);
    c = linspace(clims_raw(1), clims_raw(2), n);
    ind = reshape(interp1(c,1:n,raw_cropped(:,:,frame),'nearest'),size(raw_cropped(:,:,frame)));
    rgb = ind2rgb(ind,cm);
    pause(0.3);
    M_raw(frame) =  im2frame(double(ind), cm);
end

movie_object = M_raw ; 

end

