function make_pattern_x_11x3(pattern_matrix, pattern_name)

pattern.x_num=88;
pattern.y_num=1;
pattern.num_panels=36;
pattern.gs_val=1;
pattern.row_compression = 1;

Pats=zeros(3,96, pattern.x_num, pattern.y_num);
Pats(:,:,1,1)=pattern_matrix;

for j=2:88
    %Pats(:,:,j,1)=ShiftMatrix(Pats(:,:,j-1,1),1,'r','y');
    %non wrapping
    Pats(:,:,j,1)=ShiftMatrix(Pats(:,:,j-1,1),1,'r',0);
end

pattern.Pats=Pats;

% a=[1:33];
% a=reshape(a,3,11);
% a=flipud(a);

% A = 1:48;
% pattern.Panel_map = flipud(reshape(A, 4, 12));
% %     4     8    12    16    20    24    28    32    36    40    44    48
% %     3     7    11    15    19    23    27    31    35    39    43    47
% %     2     6    10    14    18    22    26    30    34    38    42    46
% %     1     5     9    13    17    21    25    29    33    37    41    45

% pattern.Panel_map = [12 8 4 11 7 3 10 6 2  9 5 1;...
%     24 20 16 23 19 15 22 18 14 21 17 13;...
%     36 32 28 35 31 27 34 30 26 33 29 25];

pattern.Panel_map = [11 7 3 10 6 2  9 5 1 12 8 4;...
    23 19 15 22 18 14 21 17 13 24 20 16;...
    35 31 27 34 30 26 33 29 25 36 32 28];

pattern.BitMapIndex = process_panel_map(pattern);
pattern.data = make_pattern_vector(pattern);
directory_name='c:\';
file_name=[directory_name,pattern_name]
save(file_name,'pattern');