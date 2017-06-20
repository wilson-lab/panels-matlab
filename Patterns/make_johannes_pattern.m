clear all;
pattern.x_num = 96;
pattern.y_num = 2; 
pattern.num_panels = 48;
pattern.gs_val = 2;

Pats = zeros(32, 96, pattern.x_num, pattern.y_num);

for j =1
  Pats(:,:,1,16) = [3*ones(32,46) zeros(32,4) 3*ones(32,46)] ;

 for i = 8
  Pats(:,:,1,j) = [3*ones((32-i)/2,96); 3*ones(i,44) zeros(i,8) 3*ones(i,44); 3*ones((32-i)/2,96)] ;

 end
end

for j = 2
  Pats(:,:,1,16) = [zeros(32,44) 3*ones(32,8) zeros(32,44)] ;

 for i = 8
  Pats(:,:,1,j) = [zeros((32-i)/2,96); zeros(i,44) 3*ones(i,8) zeros(i,44); zeros((32-i)/2,96)] ;

 end
end

for k = 1:pattern.y_num
    for j = 2:96
    Pats(:,:,j,k) = ShiftMatrix(Pats(:,:,j-1,k), 1, 'r', 'y'); 
    end
end

for j = 1:96
for k = 1:2
Pats(:,:,j,k) = ShiftMatrix(Pats(:,:,j,k), 43, 'l', 'y'); 
end
end

pattern.Pats = Pats;
pattern.Panel_map = new_controller_48_panel_map;
pattern.BitMapIndex = process_panel_map(pattern);
pattern.data = make_pattern_vector(pattern);
directory_name = 'C:\temp';
str = [directory_name '\Pattern_short_stripe_telethon']     % name must begin with ‘Pattern_’
save(str, 'pattern');
