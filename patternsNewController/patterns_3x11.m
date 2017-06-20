%--------------------------------------------------------------------------
a = ones(3,4);
b = zeros(3,(96-4)/2);
brightStripe = [a,b,b];
figure, imagesc(brightStripe)
make_pattern_x_11x3(brightStripe, 'Pattern_brightStripeNonWrap_3x11')

a = ones(3,4);
b = zeros(3,(96-4)/2);
brightStripe = [a,b,b];
figure, imagesc(brightStripe)
make_pattern_x_12x3(brightStripe, 'Pattern_brightStripeNonWrap_3x12')

%--------------------------------------------------------------------------






%--------------------------------------------------------------------------
%3*11 arena for closed loop

%brigth stripe
a = ones(1,4);
b = zeros(1,(88-4)/2);
brightStripe = [b,a,b];
figure, imagesc(brightStripe)

%dark stripe
c = ones(3, 88);
darkStripe = c - brightStripe;
figure, imagesc(darkStripe)

%wide dark sripe
a = ones(3,8);
b = zeros(3,(88-8)/2);
brightWideStripe = [b,a,b];
figure, imagesc(brightWideStripe)

%wide bright stripe
c = ones(3, 88);
darkWideStripe = c - brightWideStripe;
figure, imagesc(darkWideStripe)

%horizontal grating
a=[0 0 0 0 1 1 1 1];
horizontalGrating =repmat(a,3,11);
figure, imagesc(horizontalGrating)


%birght dot small
a = [zeros(11,1); 1; 1; zeros(11,1)];
a = repmat(a, 1, 2);  
b = zeros(24,(88-2)/2);
brightDotSmall = [b,a,b];
figure, imagesc(brightDotSmall)


%dark dot small
c = ones(24, 88);
darkDotSmall = c - brightDotSmall;
figure, imagesc(darkDotSmall)


%bright dot large
a = [zeros(10,1); 1; 1; 1; 1;  zeros(10,1)];
a = repmat(a, 1, 4);  
b = zeros(24,(88-4)/2);
brightDotLarge = [b,a,b];
figure, imagesc(brightDotLarge)


%dark dot large
c = ones(24, 88);
darkDotLarge = c - brightDotLarge;
figure, imagesc(darkDotLarge)



%make pattern for closed loop flying, use same stripe patterns as above
make_pattern_x2_11x3CL(brightStripe, 'brightStripeCL_3x11dim')
make_pattern_x2_11x3CL(darkStripe, 'darkStripeCL_3x11dim')
make_pattern_x2_11x3CL(brightWideStripe, 'brightWideStripeCL_3x11dim')
make_pattern_x2_11x3CL(darkWideStripe, 'darkWideStripeCL_3x11dim')
make_pattern_x2_11x3CL(horizontalGrating, 'horizontalGratingCL_3x11dim')

make_pattern_x_11x3(brightDotSmall, 'brightDotSmall_3x11')
make_pattern_x_11x3(darkDotSmall, 'darkDotSmall_3x11')
make_pattern_x_11x3(brightDotLarge, 'brightDotLarge_3x11')
make_pattern_x_11x3(darkDotLarge, 'darkDotLarge_3x11')

% 
% %horizontal grating
% 
% a=[0 0 0 0 1 1 1 1];
% horizontalGrating =repmat(a,3,11);
% figure, imagesc(horizontalGrating)
% make_pattern_x2_11x3(horizontalGrating, 'test2223')


%sine gratings for closed loop
%vertical sine grating hihg intensity
ampl = 3;
a = round(ampl * sin((2*pi/8)*[0:7]))+ampl;
figure, plot(a, '-*')
verticalSineGratingHigh =repmat(a,2,7);
figure, imagesc(verticalSineGratingHigh)

%vertical sine grating medium intensity
ampl = 2;
a = round(ampl * sin((2*pi/8)*[0:7]))+ampl;
figure, plot(a, '-*')
verticalSineGratingMedium =repmat(a,2,7);
figure, imagesc(verticalSineGratingMedium)

%vertical sine grating low intensity
ampl = 1;
a = round(ampl * sin((2*pi/8)*[0:7]))+ampl;
figure, plot(a, '-*')
verticalSineGratingLow =repmat(a,2,7);
figure, imagesc(verticalSineGratingLow)


make_pattern_x2_7x2(verticalSineGratingHigh, 'verticalSineGratingHigh')
make_pattern_x2_7x2(verticalSineGratingMedium, 'verticalSineGratingMedium')
make_pattern_x2_7x2(verticalSineGratingLow, 'verticalSineGratingLow')


%horizontal sine grating
%vertical grating
ampl = 3;
a = [round(ampl * sin((2*pi/8)*[0:7]))+ampl]';
horizontalSineGratingHigh =repmat(a,2,56);
figure, imagesc(horizontalGratingHigh);

ampl = 2;
a = [round(ampl * sin((2*pi/8)*[0:7]))+ampl]';
horizontalSineGratingMedium =repmat(a,2,56);
figure, imagesc(horizontalGratingMedium)

ampl = 1;
a = [round(ampl * sin((2*pi/8)*[0:7]))+ampl]';
horizontalSineGratingLow =repmat(a,2,56);
figure, imagesc(horizontalGratingLow)

make_pattern_y(horizontalSineGratingHigh, 'horizontalSineGratingHigh')
make_pattern_y(horizontalSineGratingMedium, 'horizontalSineGratingMedium')
make_pattern_y(horizontalSineGratingLow, 'horizontalSineGratingLow')



%--------------------------------------------------------------------------
%dot pattern for receptive field measurements

%dot pattern for receptive field measurements

%bright dot diagonal (dot that can be moved in x and y)
brightDotDiagonal = zeros(16, 56);
brightDotDiagonal(1:6, 1:6) = 1;
figure, imagesc(brightDotDiagonal);
make_pattern_xy(brightDotDiagonal, 'brightDotDiagonal')

%dark dot diagonal
darkDotDiagonal = 1 - brightDotDiagonal;
figure, imagesc(darkDotDiagonal);
make_pattern_xy(darkDotDiagonal, 'darkDotDiagonal')


%horizontal grating column
horizontalGratingCol = zeros(16, 56);
a = [0 0 0 0 1 1 1 1]';
horizontalGratingCol = repmat(a,2,56);
horizontalGratingCol(:, 13:end) = 0;
figure, imagesc(horizontalGratingCol);
make_pattern_xy(horizontalGratingCol, 'horizontalGratingCol')



% brighthorizontal stripe column
a = ones(4,56);
b = zeros(6,56);
brightStripeHorCol = [b;a;b];
brightStripeHorCol(:, 13:end) = 0;
figure, imagesc(brightStripeHorCol)
make_pattern_xy(brightStripeHorCol, 'brightStripeHorCol')

%dark stripe horizontal column
darkStripeHorCol = 1-brightStripeHorCol;
figure, imagesc(darkStripeHorCol)
make_pattern_xy(darkStripeHorCol, 'darkStripeHorCol')

%allOn Pattern (dim)
allOn = ones(2, 56);
make_pattern_x2_7x2(allOn, 'allOn')

%all off pattern
allOff = zeros(2, 56);
make_pattern_x2_7x2(allOff, 'allOff')


make_pattern_x2_7x2NonWrap(darkWideStripe, 'darkWideStripeCLNonWrap_left0')







