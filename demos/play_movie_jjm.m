min_max = [0, 10]; 
Y_test = neuron.P.mat_data.Y_108_145_102_139;

for t=1:T
    h_img = imagesc(Y_test(:,:,t)); 
    %hold on; axis equal; axis off;
    set(gca, 'children', flipud(get(gca, 'children')));
    delete(h_img);
end
    