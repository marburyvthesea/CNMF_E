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