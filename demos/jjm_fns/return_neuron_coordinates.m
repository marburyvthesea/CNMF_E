


d1 = 752;
d2 = 480;
thr = 0.9;

cmap = hot(3*size(Aor,2));

CC = cell(size(Aor,2),1);
CR = cell(size(Aor,2),2);
for i = 1:size(Aor,2)
    A_temp = full(reshape(Aor(:,i),d1,d2));
    A_temp = medfilt2(A_temp,[3,3]);
    A_temp = A_temp(:);
    [temp,ind] = sort(A_temp(:).^2,'ascend');
    temp =  cumsum(temp);
    ff = find(temp > (1-thr)*temp(end),1,'first');
        if ~isempty(ff)
            CC{i} = contour(reshape(A_temp,d1,d2),[0,0]+A_temp(ind(ff)),'LineColor',cmap(i+size(Aor,2),:), 'linewidth', 1);
            fp = find(A_temp >= A_temp(ind(ff)));
            [ii,jj] = ind2sub([d1,d2],fp);
            CR{i,1} = [ii,jj]';
            CR{i,2} = A_temp(fp)';
        end
        hold on 
end