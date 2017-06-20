% 12 panels in a circle -> 96 columns, 1 panel high -> 8 rows
%%need to change panel id's for this pattern, so that position 49 is at 45
%%degrees
clear all
pattern.x_num = 96;  %% 
pattern.y_num = 3;   %% x is the spatial frequency
pattern.num_panels = 48;
pattern.gs_val = 3;
pattern.row_compression = 1;

Pats = zeros(4, 96, pattern.x_num, pattern.y_num);

Pats(:,:,1,1) = [repmat([7*ones(4,4), zeros(4,4)], 1, 12)];
Pats(:,:,1,2) = [repmat([7*ones(4,4), 6*ones(4,4)], 1, 12)];
Pats(:,:,1,3) = [repmat([ones(4,4), zeros(4,4)], 1, 12)];

for i = 1:3
for j = 2:96
Pats(:,:,j,i) = ShiftMatrix(Pats(:,:,j-1,i),1,'r','y'); %centered expansion, from 96/2 + 1    
end
end
  
% Pats(:,[41:96 1:16],:,:) = 3; %%left

Pats(:,[1:56],:,:) = 3; %%right

% Pats(:,[1:16 41:63 89:96],:,:) = 3; %%both

%% complete the pattern
pattern.Pats = Pats;
pattern.Panel_map = new_controller_48_panel_map;
pattern.BitMapIndex = process_panel_map(pattern);
pattern.data = make_pattern_vector(pattern);
directory_name = 'C:\Matlabroot\Panel_controller_11_18_2009\Patterns\telethon_7_24_pats';
str = [directory_name '\Pattern_rotation_right_half_gs3'];
save(str, 'pattern');
