%make_8_wide_stripe_pattern_12.m
% 12 panels in a circle -> 96 columns, 1 panel high -> 8 rows
clear all
pattern.x_num = 96;
pattern.y_num = 4;
pattern.num_panels = 48;
pattern.gs_val = 4;
pattern.row_compression = 1;

Pats = zeros(4, 96, pattern.x_num, pattern.y_num);

stripewidth = 8;

onon = [];
for i = 1:2:15
onon = [onon i*ones(4,stripewidth)];
end

offoff = [];
for i = 14:-2:0
offoff = [offoff i*ones(4,stripewidth)];
end

Pats(:,:,1,1) = [onon 15*ones(4,32)];
Pats(:,:,1,4) = [onon 0*ones(4,32)];
Pats(:,:,1,2) = [offoff 15*ones(4,32)];
Pats(:,:,1,3) = [offoff 0*ones(4,32)];


for i = [1 3]
  for j = 2:96
    Pats(:,:,j,i) = ShiftMatrix(Pats(:,:,j-1,i), 1, 'r', 'y'); 
  end
% 

for j = 1:96
  Pats(:,:,j,i) = ShiftMatrix(Pats(:,:,j,i), 72, 'r', 'y'); 

end
end

for i = [2 4]
  for j = 2:96
    Pats(:,:,j,i) = ShiftMatrix(Pats(:,:,j-1,i), 1, 'r', 'y'); 
  end
% 

for j = 1:96
  Pats(:,:,j,i) = ShiftMatrix(Pats(:,:,j,i), 32, 'l', 'y'); 

end
end

Pats(:,1:40,:,1) = 15;
Pats(:,65:96,:,1) = 15;

Pats(:,1:40,:,2) = 15;
Pats(:,65:96,:,2) = 15;

Pats(:,1:40,:,4) = 0;
Pats(:,65:96,:,4) = 0;

Pats(:,1:40,:,3) = 0;
Pats(:,65:96,:,3) = 0;


pattern.Pats = Pats;
pattern.Panel_map = new_controller_48_panel_map;
pattern.BitMapIndex = process_panel_map(pattern);
pattern.data = make_pattern_vector(pattern);
directory_name = 'C:\Matlabroot\Panel_controller_11_18_2009\Patterns\telethon_7_24';
str = [directory_name '\Pattern_on_off_motion_telethon_pattern_8wide.mat']
save(str, 'pattern');
