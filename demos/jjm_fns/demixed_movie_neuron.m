
neuron_idx = 1;
frame_range = [500, 527];

%% to recombine individual neuron

A_dense = full(neuron.A(:,1));
A_reshaped = reshape(A_dense, [neuron.options.d1, neuron.options.d2]);
C_neuron = neuron.C(neuron_idx,:);
demixed = zeros(752, 480, frame_range(2)-frame_range(1));
%%
% calcium traces
for frame=1:(frame_range(2)-frame_range(1))
    demixed(:,:,frame) = A_reshaped*C_neuron(frame+frame_range(1)); 
end
%%
[max_C, max_C_idx] = max(C_neuron); 
max_AC = max(max(A_reshaped*C_neuron(max_C_idx)));
clims = [0, max_AC];
%%

for frame=1:(frame_range(2)-frame_range(1))
    h = imagesc(demixed(:,:,frame));
    cdata = h.CData ;
    cm = colormap(h.Parent); % get axes colormap
    n = size(cm,1); % number of colors in colormap
    %c = linspace(h.Parent.CLim(1),h.Parent.CLim(2),n); % intensity range
    c = linspace(clims(1), clims(2), n); 
    ind = reshape(interp1(c,1:n,demixed(:,:,frame),'nearest'),size(demixed(:,:,frame))); % indexed image
    rgb = ind2rgb(ind,cm);
    pause(0.3); 
    M(frame) =  im2frame(double(ind), cm);
end
    