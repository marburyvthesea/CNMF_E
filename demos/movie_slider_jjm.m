%https://www.mathworks.com/help/control/ug/build-app-with-interactive-plot-updates.html

Y_test = Y_156_222_150_211;

f = figure ; 
t=1; 

b = uicontrol('Parent',f,'Style','slider','Position',[81,54,419,23],...
              'value',t, 'min',1, 'max',10);

h = imagesc(Y_test(:,:, t));

b.Callback = @(es,ed) updateSystem(h,es.value); 