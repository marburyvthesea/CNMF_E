
neuron_idx = 1;
frame_range = [150, 300];

%% to recombine individual neuron

A_dense = full(neuron.A(:,1));
A_reshaped = reshape(A_dense, [neuron.options.d1, neuron.options.d2]);

demixed = zeros(752, 480, frame_range(2)-frame_range(1));

% calcium traces
for frame=frame_range(1):frame_range(2)
    C_neuron = neuron.C(1,:);
    demixed(:,:,1) = A_reshaped*C_neuron(frame); 
    h = imagesc(demixed(:,:,frame));
    cdata = h.CData ;
    cm = colormap(h.Parent); % get axes colormap
    n = size(cm,1); % number of colors in colormap
    c = linspace(h.Parent.CLim(1),h.Parent.CLim(2),n); % intensity range
    ind = reshape(interp1(c,1:n,demixed(:,:,frame),'nearest'),size(demixed(:,:,frame))); % indexed image
    M(frame) =  im2frame(double(ind), cm);
end
    