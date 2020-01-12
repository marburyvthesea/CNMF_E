min_max = [0, 10]; 
Y_test = Y_156_222_150_211;
T=200

for t=1:T
    h_img = imagesc(Y_test(:,:,t)); 
    %hold on; axis equal; axis off;
    %set(gca, 'children', flipud(get(gca, 'children')));
    %delete(h_img);
    drawnow();
    pause(0.3); 
end
    