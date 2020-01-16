
neuron_idx = 1;
frame_range = [500, 550];
cropped = true ;
raw_data_file = '/Volumes/My_passport/cnmfe_analysis_files/GRIN032/H17_M30_S22/motion_corrected/memmap_0003_d1_480_d2_752_d3_1_order_C_frames_1000__subset_600_800_resized.h5' ;
raw_frame_range = [100, 150]; 
raw_im_data_subset=smod_bigread2(raw_data_file, raw_frame_range(1), raw_frame_range(2)-raw_frame_range(1));

%% to recombine individual neuron

%% for cropping image 

c_mean = mean(neuron.Coor{neuron_idx, 1}(1,:)) ; 
r_mean = mean(neuron.Coor{neuron_idx, 1}(2,:)) ;

%% full image
A_dense = full(neuron.A(:,neuron_idx));
A_reshaped_full = reshape(A_dense, [neuron.options.d1, neuron.options.d2]);

%% for cropping 
if cropped 
    c_lims = [round(c_mean) - neuron.options.gSiz*3, round(c_mean) + neuron.options.gSiz*3]; 
    r_lims = [round(r_mean) - neuron.options.gSiz*3, round(r_mean) + neuron.options.gSiz*3]; 
    A_reshaped = A_reshaped_full(r_lims(1):r_lims(2), c_lims(1):c_lims(2));
    demixed = zeros(r_lims(2)-r_lims(1)+1, c_lims(2)-c_lims(1)+1, frame_range(2)-frame_range(1));
    raw_cropped = raw_im_data_subset(r_lims(1):r_lims(2), c_lims(1):c_lims(2), :);
else
    c_lims = [0, neuron.options.d1];
    r_lims = [0, neuron.options.d2];
    A_reshaped = A_reshaped_full ;
    demixed = zeros(r_lims(2)-r_lims(1), c_lims(2)-c_lims(1), frame_range(2)-frame_range(1));
end 

C_neuron = neuron.C(neuron_idx,:);
%demixed = zeros(c_lims(2)-c_lims(1), r_lims(2)-r_lims(1), frame_range(2)-frame_range(1));
%%
% calcium traces
for frame=1:(frame_range(2)-frame_range(1))
    demixed(:,:,frame) = A_reshaped*C_neuron(frame+frame_range(1)); 
end
%% demixed movie
[max_C, max_C_idx] = max(C_neuron); 
max_AC = max(max(A_reshaped*C_neuron(max_C_idx)));
clims = [0, max_AC];
%% raw movie
max_AC_raw = max(max(max(raw_cropped)));
clims_raw = [0, max_AC_raw];

fig = figure('position',[100 100 850 600]); 

for frame=1:(frame_range(2)-frame_range(1))
    subplot(1,2,1);
    figure
    h = imagesc(demixed(:,:,frame));
    cdata = h.CData ;
    cm = colormap(h.Parent); % get axes colormap
    close; 
    n = size(cm,1); % number of colors in colormap
    %c = linspace(h.Parent.CLim(1),h.Parent.CLim(2),n); % intensity range
    c = linspace(clims(1), clims(2), n); 
    ind = reshape(interp1(c,1:n,demixed(:,:,frame),'nearest'),size(demixed(:,:,frame))); % indexed image
    rgb = ind2rgb(ind,cm);
    %M_demixed(frame) =  im2frame(double(ind), cm);
    image(rgb); 
    %pause(0.3); 
    
    subplot(1,2,2);
    figure
    h_raw = imagesc(raw_cropped(:,:,frame));
    cdata_raw = h_raw.CData;
    cm_raw = colormap(h_raw.Parent);
    close; 
    n_raw = size(cm_raw,1);
    c_raw = linspace(clims_raw(1), clims_raw(2), n);
    ind_raw = reshape(interp1(c_raw,1:n,raw_cropped(:,:,frame),'nearest'),size(raw_cropped(:,:,frame)));
    rgb_raw = ind2rgb(ind_raw,cm_raw);
    image(rgb_raw); 
    %M_raw(frame) =  im2frame(double(ind_raw), cm_raw);
    joint_movie(frame) = getframe(gcf); 
    pause(0.3); 
    
end

    
    
    
    