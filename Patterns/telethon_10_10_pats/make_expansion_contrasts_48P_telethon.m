% 12 panels in a circle -> 96 columns, 1 panel high -> 8 rows
%%need to change panel id's for this pattern, so that position 49 is at 45
%%degrees
CA
pattern.x_num = 96;  %% 
pattern.y_num = 6;   %% x is the spatial frequency
pattern.num_panels = 48;
pattern.gs_val = 4;
pattern.row_compression = 1;

Pats = zeros(4, 96, pattern.x_num, pattern.y_num);

Pats(:,:,1,1) = [repmat([6*ones(4,6), 5*ones(4,6)], 1, 4), repmat([5*ones(4,6), 6*ones(4,6)], 1, 4)];
Pats(:,:,1,2) = [repmat([7*ones(4,6), 4*ones(4,6)], 1, 4), repmat([4*ones(4,6), 7*ones(4,6)], 1, 4)];
Pats(:,:,1,3) = [repmat([8*ones(4,6), 3*ones(4,6)], 1, 4), repmat([3*ones(4,6), 8*ones(4,6)], 1, 4)];
Pats(:,:,1,4) = [repmat([9*ones(4,6), 2*ones(4,6)], 1, 4), repmat([2*ones(4,6), 9*ones(4,6)], 1, 4)];
Pats(:,:,1,5) = [repmat([10*ones(4,6), 1*ones(4,6)], 1, 4), repmat([1*ones(4,6), 10*ones(4,6)], 1, 4)];
Pats(:,:,1,6) = [repmat([11*ones(4,6), 0*ones(4,6)], 1, 4), repmat([0*ones(4,6), 11*ones(4,6)], 1, 4)];

for i = 1:6
for j = 2:96
Pats(:,:,j,i) = simple_expansion(Pats(:,:,j-1,i), 49,96);    %centered expansion, from 96/2 + 1    
end
end
  % lazy way, but shifts pattern so it is centered...
  for g = 1:6;
    for i = 1:96
        Pats(:,:,i,g) = ShiftMatrix(Pats(:,:,i,g), 20, 'l', 'y'); 
    end
  end
  
%% complete the pattern
pattern.Pats = Pats;
foo = reshape(1:48, 4, 12);
arrangement  = [1 12 8 4 11 7 3 10 6 2 9 5];

for j =1:4
for i = 1:12
Panel_map(j,i) = foo(j,arrangement(i));
end
end

pattern.Pats = Pats;
pattern.Panel_map = new_controller_48_panel_map;
pattern.BitMapIndex = process_panel_map(pattern);
pattern.data = make_pattern_vector(pattern);
directory_name = 'C:\Matlabroot\Panel_controller_11_18_2009\Patterns\telethon_6_14';
str = [directory_name '\Pattern_expansion_contrasts_48_RC_telethon'];
save(str, 'pattern');
