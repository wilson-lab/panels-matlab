% 12 panels in a circle -> 96 columns, 1 panel high -> 8 rows
%%need to change panel id's for this pattern, so that position 49 is at 45
%%degrees
CA
pattern.x_num = 9;  %% 
pattern.y_num = 1;   %% x is the spatial frequency
pattern.num_panels = 48;
pattern.gs_val = 3;
pattern.row_compression = 1;

Pats = zeros(4, 96, pattern.x_num, pattern.y_num);
Patsy = [0*ones(4,8)  repmat([7*ones(4,8), zeros(4,8)], 1, 5)  7*ones(4,8) ];

% Pats(:,:,1,1) = [repmat([7*ones(4,8), zeros(4,8)], 1, 3), repmat([zeros(4,8), 7*ones(4,8)], 1, 3)];
Pats(:,:,1,1) = [7*ones(4,8) repmat([zeros(4,8), 7*ones(4,8)], 1, 5)  zeros(4,8) ]-Patsy;

% Pats(:,:,1,2) = [repmat([15*ones(4,4), 12*ones(4,4)], 1, 6), repmat([12*ones(4,4), 15*ones(4,4)], 1, 6)];
% Pats(:,:,1,3) = [repmat([ones(4,4), zeros(4,4)], 1, 6), repmat([zeros(4,4), ones(4,4)], 1, 6)];
% Pats(:,:,1,4) = [repmat([15*ones(4,12), zeros(4,12)], 1, 2), repmat([zeros(4,12), 15*ones(4,12)], 1, 2)];

for j = 2:pattern.x_num 
Pats(:,:,j,1) = simple_expansion(Pats(:,:,j-1,1), 49,96);    %centered expansion, from 96/2 + 1    
Pats(:,:,j,1) = Pats(:,:,j,1) - Patsy;
end

  % lazy way, but shifts pattern so it is centered...
  for g = 1:pattern.y_num ;
    for i = 1:pattern.x_num 
        Pats(:,:,i,g) = ShiftMatrix(Pats(:,:,i,g), 16, 'l', 'y'); 
    end
  end
  
  
  toobig = find(Pats < 0);
Pats(toobig) = 0;

sevens = find(Pats == 7);
zeros = find(Pats == 0);
Pats(sevens) = 0; Pats(zeros) = 7;

  
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
directory_name = 'C:\MatlabRoot\Panel_controller_11_18_2009\Patterns\telethon_pats_10_9\telethon_10_10_pats';
str = [directory_name '\Pattern_expansion_on_foeleft_48_RC_telethon'];
save(str, 'pattern');
