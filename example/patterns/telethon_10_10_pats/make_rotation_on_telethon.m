% 12 panels in a circle -> 96 columns, 1 panel high -> 8 rows
%%need to change panel id's for this pattern, so that position 49 is at 45
%%degrees
clear all
pattern.x_num = 9;  %% 
pattern.y_num = 3;   %% x is the spatial frequency
pattern.num_panels = 48;
pattern.gs_val = 3;
pattern.row_compression = 1;

Pats = zeros(4, 96, pattern.x_num, pattern.y_num);
Patsy = [repmat([7*ones(4,8), 0*ones(4,8)], 1, 6)];

Pats(:,:,1,1) = [repmat([7*ones(4,8), zeros(4,8)], 1, 6)]+Patsy;
Pats(:,:,1,2) = [repmat([7*ones(4,8), 6*ones(4,8)], 1, 6)]+Patsy;
Pats(:,:,1,3) = [repmat([ones(4,8), zeros(4,8)], 1, 6)]+Patsy;

for i = 1:3
for j = 2:pattern.x_num
    
Pats(:,:,j,i) = ShiftMatrix(Pats(:,:,j-1,i),1,'l','y'); %centered expansion, from 96/2 + 1    
Pats(:,:,j,i) = Pats(:,:,j,i) + Patsy;

end
end
 
toobig = find(Pats > 7);
Pats(toobig) = 7;

% Pats(:,[1:64 89:96],:,:) = 3; %%right

% Pats(:,[1:16 41:63 89:96],:,:) = 3; %%both


%% complete the pattern
pattern.Pats = Pats;
pattern.Panel_map = new_controller_48_panel_map;
pattern.BitMapIndex = process_panel_map(pattern);
pattern.data = make_pattern_vector(pattern);
directory_name = 'C:\MatlabRoot\Panel_controller_11_18_2009\Patterns\telethon_pats_10_9\telethon_10_10_pats';
str = [directory_name '\Pattern_rotation_neg_on_step'];
save(str, 'pattern');
