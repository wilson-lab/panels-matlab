% 12 panels in a circle -> 96 columns, 1 panel high -> 8 rows
% centered expansion with rotation, with row compression business
% this pattern makes use of inter-step values for increased temporal
% resolution.

%% now try to make a triple resolution pattern
clear all
pattern.x_num = 96;
pattern.y_num = 4;
pattern.num_panels = 48;
pattern.gs_val = 4;
pattern.row_compression = 1;

Pats = zeros(4, 96, pattern.x_num, pattern.y_num);

stripewidth = 4;

onon = [];
for i = 0:2:15
onon = [onon i*ones(4,3*stripewidth)];
end

offoff = [];
for i = 15:-2:0
offoff = [offoff i*ones(4,3*stripewidth)];
end

InitPat(:,:,1) = [onon 15*ones(4,288 - (3*stripewidth*8))];
InitPat(:,:,2) = [offoff 15*ones(4,288 - (3*stripewidth*8))  ];
InitPat(:,:,3) = [offoff 0*ones(4,288 - (3*stripewidth*8)) ];
InitPat(:,:,4) = [onon 0*ones(4,288 - (3*stripewidth*8))];

for tr = 1:4
temp_Pats = [];
% InitPat = [repmat([zeros(1,3*4), 7*ones(1,3*4)], 1,6), repmat([7*ones(1,3*4), zeros(1,3*4)], 1,6)];
temp_Pats(:,:,1) = InitPat(:,:,tr);

if any(tr == [1 3])
    
   for j = 2:96 
    temp_Pats(:,:,j) = ShiftMatrix(temp_Pats(:,:,j-1),1,'r','y');
   end
   
else
       for j = 2:96 
    temp_Pats(:,:,j) = ShiftMatrix(temp_Pats(:,:,j-1),1,'r','y');
       end
       
          switch tr
       case 1
       case 2
           for j = 1:96
            temp_Pats(:,:,j) = ShiftMatrix(temp_Pats(:,:,j), 96-11, 'r', 'y'); 
             end
       case 3
       case 4
            for j = 1:96
            temp_Pats(:,:,j) = ShiftMatrix(temp_Pats(:,:,j), 96-11, 'r', 'y'); 
            end
   end
   

end

   for j = 1:96
    for i = 1:96
        for k = 1:4
        Pats(k,i,j,tr) = round(sum(temp_Pats(1,((i*3)-2):i*3,j))./3);
        end
    end    
   end

end
% 
% for j = 1:96
% %   Pats(:,:,j,1) = ShiftMatrix(Pats(:,:,j,1), 4, 'r', 'y'); 
% %   Pats(:,:,j,4) = ShiftMatrix(Pats(:,:,j,4), 1, 'l', 'y'); 
%     Pats(:,:,j,2) = ShiftMatrix(Pats(:,:,j,2), 1, 'l', 'y'); 
% %   Pats(:,:,j,3) = ShiftMatrix(Pats(:,:,j,3), 4, 'r', 'y'); 
% end

% 
Pats(:,1:32,:,1) = 15;
Pats(:,65:96,:,1) = 15;

Pats(:,1:32,:,2) = 15;
Pats(:,65:96,:,2) = 15;

Pats(:,1:32,:,3) = 0;
Pats(:,65:96,:,3) = 0;

Pats(:,1:32,:,4) = 0;
Pats(:,65:96,:,4) = 0;


%% complete the pattern


pattern.Pats = Pats;
pattern.Panel_map = new_controller_48_panel_map;
pattern.BitMapIndex = process_panel_map(pattern);
pattern.data = make_pattern_vector(pattern);
directory_name = 'C:\Matlabroot\Panel_controller_11_18_2009\Patterns\telethon_7_24';
str = [directory_name '\Pattern_on_off_motion_TR_telethon_pattern.mat']
save(str, 'pattern');

