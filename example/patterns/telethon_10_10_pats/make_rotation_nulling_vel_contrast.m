% 12 panels in a circle -> 96 columns, 1 panel high -> 8 rows
%%need to change panel id's for this pattern, so that position 49 is at 45
%%degrees

clear all

    for ref = [7] %%%reference peak brightness
        for index = 1:3 %%number of contrast levels
        
            mean_lum = 5.5;%%the mean_luminance;
            
            test_values  = [6 7 8];
            test = test_values(index);%%%test brightness
            
            base = 2*mean_lum-test; %%dimmer layer of test
            ref_base = 4;%%dimmer layer of ref
            
pattern.x_num = 12;  %% 
pattern.y_num = 12;   %% x is the spatial frequency
pattern.num_panels = 48;
pattern.gs_val = 4;
pattern.row_compression = 1;

HPats = zeros(4, 96, pattern.x_num, pattern.y_num);
SPats = zeros(4, 96, pattern.x_num, pattern.y_num);
Pats = zeros(4, 96, pattern.x_num, pattern.y_num);

for j = 1:12
HPats(:,:,j,1) = [repmat([ref*ones(4,6), ref_base*ones(4,6)], 1, 8)];%%%y is the reference pattern
SPats(:,:,1,j) = [repmat([test*ones(4,6), base*ones(4,6)], 1, 8)];%%%x is the test pattern
end

for i = 2:12
    for j = 1:12
SPats(:,:,i,j) = ShiftMatrix(SPats(:,:,i-1,1),1,'r','y');%%x is the test pattern
    end
end

for j = 2:12
    for i = 1:12
HPats(:,:,i,j) = ShiftMatrix(HPats(:,:,1,j-1),1,'r','y');%%y is the reference pattern
    end
end

Pats = SPats+HPats;

%% complete the pattern
pattern.Pats = Pats;
pattern.Panel_map = new_controller_48_panel_map;
pattern.BitMapIndex = process_panel_map(pattern);
pattern.data = make_pattern_vector(pattern);
directory_name = 'C:\Matlabroot\Panel_controller_11_18_2009\Patterns\telethon_6_14\';
str = [directory_name '\Pattern_nulling_6wide_rotation_' num2str(ref) num2str(ref_base) '_' num2str(test) num2str(base)];
save(str, 'pattern');
    end
end
