

Y_indicies = {r_lims(2)-r_lims(1), c_lims(2)-c_lims(1)} ;

for column=1:c_lims(2)-c_lims(1)
    for row=1:r_lims(2)-r_lims(1)
    Y_indicies{row , column} = [row+r_lims(1),column+c_lims(1)];
    end
end

    
