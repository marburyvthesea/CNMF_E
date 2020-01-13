

Y_test = demixed;
T=20; 

for t=1:T
    h = imagesc(Y_test(:,:,t)); 
    %hold on; axis equal; axis off;
    cdata = h.CData ;
    cm = colormap(h.Parent); % get axes colormap
    n = size(cm,1); % number of colors in colormap 
    c = linspace(h.Parent.CLim(1),h.Parent.CLim(2),n); % intensity range
    ind = reshape(interp1(c,1:n,Y_test(:,:,t),'nearest'),size(Y_test(:,:,t))); % indexed image
    rgb = ind2rgb(ind,cm); % rgb image
    %image(rgb);
    pause(0.3);
    M(t) =  im2frame(double(ind), cm);
end