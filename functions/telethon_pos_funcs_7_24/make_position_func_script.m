% make_func_script.m
% make and save some position function files

func_path = 'C:\Matlabroot\Panel_controller_11_18_2009\functions\telethon_pos_funcs_5_5\';

amplitude = -2; %%2*this value gives you the full amplitude of the sine wave
% make a 20 position, 8 LED peak to peak, 1 Hz, position sine wave
func = round(amplitude*make_sine_wave_function(20, 50, 1));
save([ func_path 'position_function_sine_1Hz_20_pp_2wide_negative.mat'], 'func');

amplitude = 2; %%2*this value gives you the full amplitude of the sine wave
func = round(amplitude*make_sine_wave_function(20, 50, 1));
save([ func_path 'position_function_sine_1Hz_20_pp_2wide_positive.mat'], 'func');

amplitude = -4; %%2*this value gives you the full amplitude of the sine wave
% make a 20 position, 8 LED peak to peak, 1 Hz, position sine wave
func = round(amplitude*make_sine_wave_function(20, 50, 1));
save([ func_path 'position_function_sine_1Hz_20_pp_4wide_negative.mat'], 'func');

amplitude = 4; %%2*this value gives you the full amplitude of the sine wave
func = round(amplitude*make_sine_wave_function(20, 50, 1));
save([ func_path 'position_function_sine_1Hz_20_pp_4wide_positive.mat'], 'func');

%%for optic flow stimulus
amplitude = -48; %%2*this value gives you the full amplitude of the sine wave
func = round(amplitude*make_sine_wave_function(20, 50, 1))+50;
save([ func_path 'position_function_sine_1Hz_20_pp_48wide_negative.mat'], 'func');

amplitude = 48; %%2*this value gives you the full amplitude of the sine wave
func = round(amplitude*make_sine_wave_function(20, 50, 1))+50;
save([ func_path 'position_function_sine_1Hz_20_pp_48wide_positive.mat'], 'func');

% % 
% % 
% % 
% % % make a 20 position peak to peak 0.25 Hz position sine wave
% % func = round(10*make_sine_wave_function(16, 50, 1));
% % save([ func_path 'position_function_sine_1Hz_16_pp.mat'], 'func');
% % 
% % % make a 20 position peak to peak 0.25 Hz position sine wave
% % func = round(10*make_sine_wave_function(16, 50, 2));
% % save([ func_path 'position_function_sine_2Hz_16_pp.mat'], 'func');
% % 
% % % make a 20 position peak to peak 0.25 Hz position sine wave
% % func = round(10*make_sine_wave_function(16, 50, 0.5));
% % save([ func_path 'position_function_sine_05Hz_16_pp.mat'], 'func');
% % 
% % % make a 20 position peak to peak 0.25 Hz position sine wave
% % func = round(10*make_sine_wave_function(8, 50, 1));
% % save([ func_path 'position_function_sine_1Hz_8_pp.mat'], 'func');
% % 
% % % make a 20 position peak to peak 0.25 Hz position sine wave
% % func = round(10*make_sine_wave_function(8, 50, 0.5));
% % save([ func_path 'position_function_sine_05Hz_8_pp.mat'], 'func');
% % 
% % % make a 20 position peak to peak 0.25 Hz position sine wave
% % func = round(10*make_sine_wave_function(12, 50, 1));
% % save([ func_path 'position_function_sine_1Hz_12_pp.mat'], 'func');
% % 
% % 
% % 
% % % make a 50 position peak to peak 0.1 Hz position sine wave
% % func = round(25*make_sine_wave_function(20, 50, 0.1));
% % save([ func_path 'position_function_sine_01Hz_50_pp.mat'], 'func');
% % 
% % % make a 50 position peak to peak 0.2 Hz position sine wave, mod 8
% % func = sign_mod(round(25*make_sine_wave_function(20, 50, 0.2)), 8);
% % save([ func_path 'position_function_sine_02Hz_50_pp_moded_8.mat'], 'func');
% % 
% % % make a 50 position peak to peak 0.2 Hz position sine wave, mod 8
% % func = sign_mod(round(25*make_sine_wave_function(20, 50, 0.2)), 16);
% % save([ func_path 'position_function_sine_02Hz_50_pp_moded_16.mat'], 'func');
% % 
% % % make a 100 position peak to peak 0.1 Hz position sine wave
% % func = round(50*make_sine_wave_function(20, 50, 0.1));
% % save([ func_path 'position_function_sine_01Hz_100_pp.mat'], 'func');
% % 
% % % make a 100 position peak to peak 0.1 Hz position sine wave
% % func = round(50*make_sine_wave_function(40, 50, 0.1));
% % save([ func_path 'position_function_sine_01Hz_100_pp_var.mat'], 'func');
% % 
% % % make a 20 position peak to peak 0.25 Hz position sine wave
% % func = round(10*make_sine_wave_function(50, 50, 0.25));
% % save([ func_path 'position_function_sine_025Hz_20_pp_var.mat'], 'func');
% % 
