min_max = [0, 10]; 
Y_test = demixed;
T=20

for t=1:T
    h_img = imagesc(Y_test(:,:,t), min_max); 
    %hold on; axis equal; axis off;
    %set(gca, 'children', flipud(get(gca, 'children')));
    %delete(h_img);
    drawnow();
    pause(0.3); 
end
    