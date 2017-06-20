% 12 panels in a circle -> 96 columns, 1 panel high -> 8 rows
%%need to change panel id's for this pattern, so that position 49 is at 45
%%degrees

clear all
    num = 0;

for jj = [4 8 12]
    
    num = num+1; %%for naming files

ref = [7]; %%%reference peak brightness        
            test_values  = [6 7 8];
        for index = 1:3
   
    
            mean_lum = 5.5;%%the mean_luminance;
            

            test = test_values(index);%%%test brightness
            
            base = 2*mean_lum-test; %%dimmer layer of test
            ref_base = 4;%%dimmer layer of ref
    
length = 48;
pattern.x_num = length;  %% 
pattern.y_num = length;   %% x is the spatial frequency
pattern.num_panels = 48;
pattern.gs_val = 4;
pattern.row_compression = 1;

HPats = zeros(4, 96, pattern.x_num, pattern.y_num);
SPats = zeros(4, 96, pattern.x_num, pattern.y_num);
Pats = zeros(4, 96, pattern.x_num, pattern.y_num);

for j = 1:length
HPats(:,:,j,1) = [repmat([ref*ones(4,8), ref_base*ones(4,8)], 1, 6)];%%%y is the reference pattern
SPats(:,:,1,j) = [repmat([test*ones(4,jj), base*ones(4,jj)], 1, 48/jj)];%%%x is the test pattern
end

for i = 2:length
    for j = 1:length
SPats(:,:,i,j) = ShiftMatrix(SPats(:,:,i-1,1),1,'r','y');%%x is the test pattern
    end
end

for j = 2:length
    for i = 1:length
HPats(:,:,i,j) = ShiftMatrix(HPats(:,:,1,j-1),1,'r','y');%%y is the reference pattern
    end
end

Pats = SPats+HPats;

%% complete the pattern
pattern.Pats = Pats;
pattern.Panel_map = new_controller_48_panel_map;
pattern.BitMapIndex = process_panel_map(pattern);
pattern.data = make_pattern_vector(pattern);
directory_name = 'C:\MatlabRoot\Panel_controller_11_18_2009\Patterns\telethon_pats_10_9\telethon_10_10_pats\';
str = [directory_name '\Pattern_' num2str(num) '_nulling_' num2str(jj) '_8_wide_rotation' num2str(ref) num2str(ref_base) '_' num2str(test) num2str(base)];
save(str, 'pattern');
end
end