
%Measure wide-field kernels with and without odor using Dawnis's starfield
%pattern. Starfield pattern on 2, dark bar on 1.
%SMW 20140305 (smwasser@gmail.com)

clc, clear
tic;
alldata=[];
Panel_com('ctr_reset')
pause(5)

%GENERAL PARAMETERS
n_tracktime     = 8 ;           %seconds for each EXPERIMENT
n_resttime      = 4     ;           %seconds for each REST
%w_exps          = [1 12 5]  ;      %this is the number of distinct starting YPOS positions
w_exps = 1;                      %50; %For the starfield, there are 50 different patterns, stored under xpos
w_pats          = 1:2;             %these are the CF addresses of distinct patterns
n_reps          = 8;            %this is the number of REPETITIONS of all EXPERIMENTS (length(w_trials)=lengt(w_exps)*n_reps)
n_rest_pat      = 3;               %sets the location of 'rest_pat' on the CF drive.
n_rest_y        = 1;               %sets starting xpos for p_rest_pat
n_rest_x        = 41;               %sets starting ypos for p_rest_pat
n_pats          = length(w_pats);
n_pos           = [29 53];
npause          = 0.001;
n_led           = [4 5];
w_expsx = w_exps(randperm(length(w_exps)));
w_expsy = w_exps(randperm(length(w_exps)));

% EXPERIMENT WAVES: the sequence of experimental parameters to be executed.
wparams=[];
for(i=1:length(w_exps))
    for(j=1:length(w_pats))
        for m = 1:length(n_pos);
        for k = 1:length(n_led); %4 is LED on and 5 is LED off
            wparams(size(wparams,1)+1,1)=w_expsx(i);
            wparams(size(wparams,1),2)=w_pats(j);
            % wparams(size(wparams,1),3)=w_expsy(i)*n_pos;
            wparams(size(wparams,1),3)=n_led(k);    %odor value
            wparams(size(wparams,1),4)=n_pos(m);
        end
        end
    end
end
w_trials        = repmat(wparams',1,n_reps)';
w_randseq       = randperm(size(w_trials,1));
for i=1:length(w_randseq)
    w_out(i,:)=w_trials(w_randseq(i),:);
end

w_trials=w_out;


% Axoscope Trigger to begin acquisition.
% ao = analogoutput('mcc',1);
% chans=addchannel(ao,0:1);
% set(ao,'SampleRate',100);               %100 Hz output
% w_trig = [ones(50,1)*8;zeros(100,1)];   %w_trig=.5 sec6s at 4V, 1 sec back to zero.
% w_mark = w_trig.*0;                     %w_mark is the voltage that marks each expt number.
% putdata(ao,[w_mark w_trig]);
% start(ao);                              %start DAQ w/trigger
% wait(ao,5);                             %wait to complete
% stop(ao);                               %stop analog out
clear w_mark w_trig
disp('Turn LED On')
%-------------------------
% led_ao = analogoutput('mcc',0);
% led_chans = addchannel(led_ao,0);
% set(led_ao,'SampleRate',100);
% shut_led = ones(50,1)*10;
% putdata(led_ao,shut_led);
% start(led_ao);

% 
% 
% pause(npause)
% Panel_com('set_posfunc_id',[2 1]);
% pause(npause)
% Panel_com('set_posfunc_id',[1 0]);
% pause(npause)
% Panel_com('set_funcx_freq',50);
% pause(npause)
% Panel_com('set_funcy_freq',50);
% 

led = ones;
%EXPERIMENT LOOP
%t = 0:1/100:4;

led_stepp = linspace(4,5,100);
led_stepp = fliplr(led_stepp);
led_stepp = [led_stepp ones(1,200)*4 fliplr(led_stepp) led_stepp ones(1,200)*4  fliplr(led_stepp)];
pause(npause)
%     Panel_com('set_posfunc_id',[2 1]);
%     disp(1)
%     pause(npause)
%     Panel_com('set_posfunc_id',[1 0]);
%     disp(2)
%     pause(npause)
%     Panel_com('set_funcx_freq',50);
%     disp(3)
%     pause(npause)
%     Panel_com('set_funcy_freq',50);
%     disp(4)


for i = 1:size(w_trials,1);
    %i = 1:length(w_trials);
    n_pat       = w_trials(i,2);
    n_start_y   = 1 ;%round(rand*10)+1;
    n_start_x   = w_trials(i,4);
    %n_direct    = w_trials(i,4);
    n_led       = w_trials(i,3);
    
    %led_pulse = ones(floor(n_tracktime)*100,1).*n_led;
    if n_led-4
        led_pulse = ones(400,1)*5;
    else
        led_pulse = led_stepp';
    end
    
    %pause(npause)
    %CLOSED LOOP BAR TRACKING for n_rest_pat;
    disp('rest')
    Panel_com('stop')
    pause(npause)
    Panel_com('set_pattern_id',n_rest_pat);        %set output to p_rest_pat
    pause(npause)
    Panel_com('set_position',[n_rest_x,n_rest_y]); %set starting position (xpos,ypos)
    pause(npause)
    Panel_com('set_mode',[1,0]);
    pause(npause)
    Panel_com('set_posfunc_id',[1 0]); 
    pause(npause)
    Panel_com('set_funcx_freq',50);
    pause(npause)
    Panel_com('set_posfunc_id',[2 0]);
    pause(npause)
    Panel_com('set_funcy_freq',50);
    pause(npause)
    Panel_com('send_gain_bias',[-5,0,0,0]);       %[xgain,xoffset,ygain,yoffset]
    pause(npause)
    Panel_com('start');
    pause(n_resttime);
%     stop(ao)                                       %stops analog out, but voltage will hang 'til new start(ao)
    
    %EXPERIMENT
    fprintf('%d,%d,%d; ', i,n_start_x,n_start_y);                             %prints counter to command line
    
    clear w_mark w_trig
    
    w_mark= ones(50,1)*n_pat;
    w_trig=w_mark.*0;
    
    
%     putdata(ao,[w_mark w_trig]);
%     putdata(led_ao,led_pulse);%set w_mark to n_trial/n_mexps V
%     pause(npause)
    Panel_com('stop')
    pause(npause)
    Panel_com('set_pattern_id',n_pat)
    pause(npause)
    Panel_com('set_position',[n_start_x n_start_y])
    pause(npause)
    Panel_com('set_mode',[4 0])
    pause(npause)
    Panel_com('set_posfunc_id',[2 0]);
    pause(npause)
    Panel_com('set_posfunc_id',[1 1]);
    pause(npause)
    Panel_com('set_funcx_freq',50);
    pause(npause)
    Panel_com('set_funcy_freq',50);
    pause(npause)
    Panel_com('send_gain_bias', [0,0,0,0]);
    pause(npause)
    Panel_com('start');
    pause(0.1)
    Panel_com('stop')
    pause(npause) 
%     start(ao);
%     start(led_ao);
    Panel_com('Start');
    pause(n_tracktime)
    Panel_com('Stop')
    pause(npause)
%     stop(ao)
%     stop(led_ao);
    %stop(led_ao);
    %putdata(led_ao,ones(50,1)*10);
    %start(led_ao);
%     putdata(ao,[w_mark*0 w_trig.*0]);
%     
%     putdata(led_ao,ones(50,1)*10);
%     start(led_ao)%set w_mark to n_trial/n_mexps V
%     start(ao)                    %restarts analog out
end


beep
fprintf('done\r');
pause(0.1)
Panel_com('stop');
pause(0.1)
%CLOSED LOOP BAR TRACKING for n_rest_pat;
Panel_com('set_pattern_id',n_rest_pat);        %set output to p_rest_pat
pause(0.1)
Panel_com('set_position',[n_rest_x,n_rest_y]); %set starting position (xpos,ypos)
pause(0.1)
Panel_com('set_mode',[0,1]);                   %closed loop tracking [xpos,ypos] (NOTE: 0=open, 1=closed)
pause(0.1)
Panel_com('send_gain_bias',[0,0,-20,0]);       %[xgain,xoffset,ygain,yoffset]
pause(0.1)
Panel_com('start')
toc;
