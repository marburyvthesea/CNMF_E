%% display neuron contours on full size Cn image 


obj = neuron ; % in future change this to function call 

ctr = obj.estCenter();

Cn = obj.Cn;  

if isempty(Cn)
    fprintf('Please assign obj.Cn with correlation image!\n');
    return;
end
if isempty(obj.Coor) || (size(obj.A, 2)~=length(obj.Coor))   % contours of the neuron has not been calculated
    figure;
    obj.Coor = obj.get_contours();
end
Coor = obj.Coor;

% time
T = size(obj.C, 2);
t = 1:T;
if ~isnan(obj.Fs)
    t = t/obj.Fs;
    str_xlabel = 'Time (Sec.)';
else
    str_xlabel = 'Frame';
end


figure('position', [100, 100, 1024, 512]);

subplot(221); cla; 

obj.image(Cn, [0,1]); hold on; 
axis tight;

