%Make_4x4_blocks_12Panels

% 48 panel pattern
pattern.x_num = 2;
pattern.y_num = 1;
pattern.num_panels = 48;
pattern.gs_val = 1;
pattern.row_compression = 1;

%48 panels in a circle -> 96 columns, 4 panel high -> 32 rows

Pats = zeros(32, 96, pattern.x_num, pattern.y_num);

Pats(:,:,1,1) = zeros(32, 96);
Pats(:,:,2,1) = ones(32, 96);

pattern.Pats = Pats;

% A = 1:48;
% pattern.Panel_map = flipud(reshape(A, 4, 12));
% %     4     8    12    16    20    24    28    32    36    40    44    48
% %     3     7    11    15    19    23    27    31    35    39    43    47
% %     2     6    10    14    18    22    26    30    34    38    42    46
% %     1     5     9    13    17    21    25    29    33    37    41    45
pattern.Panel_map = [12 8 4 11 7 3 10 6 2  9 5 1; 24 20 16 23 19 15 22 18 14 21 17 13; 36 32 28 35 31 27 34 30 26 33 29 25; 48 44 40 47 43 39 46 42 38 45 41 37];
pattern.BitMapIndex = process_panel_map(pattern);
pattern.data = make_pattern_vector(pattern);
directory_name = 'C:\Documents and Settings\liuj\My Documents\MATLAB\Xmega_Panel_controller\Patterns';
%directory_name = 'c:\matlabroot\Panels\Patterns';
str = [directory_name '\Pattern_4x4_blocks_48']
save(str, 'pattern');