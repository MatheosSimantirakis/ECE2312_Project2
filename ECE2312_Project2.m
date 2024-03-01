%ECE Project 1
classdef ECE2312_Project2
    properties
        recObj = audiorecorder;
    end


    methods
        %Inisilizing Class name to varaible self
        function self = ECE2312_Project2
        end

        %Question 1
        function SineWave_Q1(self)
            %Sample rate
            Fs = 44100;
            %Max time
            t = 5;
            %Incrementation
            n = 0:(1/Fs):t;

            SineWave = sin(2*pi*5000*n);
            %sound(SineWave,44100) 
         
            %plot Wave
            figure;
            plot(SineWave)
            title('Waveform')
            ylabel('Amplitude')
            xlabel('Time')
               
            %plot spectogram sineWave
            figure;
            spectrogram(SineWave, hamming(256), 128, 256, 44100, 'yaxis');
            ylim([0 10])
            colormap('jet'); % Change colormap
            colorbar('off'); % Turn off colorbar
            title('Spectrogram');
            xlabel('Time (seconds)');
            ylabel('Frequency (Hz)');

        

            %Save Audio File
            filename = 'team[3]-sinetone.wav';
            audiowrite(filename,SineWave,Fs);
            sinewave = audioread('team[3]-sinetone.wav');
            disp('Sinetone.wav playing');
            sound(sinewave,Fs);
            pause(t);
        end
        

        function SineWave_Q2(self)
            %Sample rate
            Fs = 44100;
            %Max time
            t = 5;
            %Incrementation
            n = 0:(1/Fs):t;

            %Frequency Range 0 - 8000
            f_begin = 0;
            f_end = 8000;

            C = (f_end - f_begin) / t;

            % Chirp signal
            SineWave = sin(2*pi .* ((C/2) * n.^2 + f_begin .* n));
            
            %plot Wave
            figure;
            plot(SineWave)
            title('Waveform')
            ylabel('Amplitude')
            xlabel('Time')

            %plot spectogram
            figure;
            spectrogram(SineWave, hamming(256), 128, 256, 44100, 'yaxis');
            ylim([0 10])
            colormap('jet'); % Change colormap
            colorbar('off'); % Turn off colorbar
            title('Spectrogram');
            xlabel('Time (seconds)');
            ylabel('Frequency (Hz)');

            %Save Audio File
            filename = 'team[3]-chirp.wav';
            audiowrite(filename,SineWave,Fs);
            chirp = audioread('team[3]-sinetone.wav');
        disp('chirp.wav playing');
        sound(chirp,Fs);
        pause(t);
        end

        function SineWave_Q3(self)
           % Sample rate
            Fs = 44100;
            
            % Time duration
            t = 5;
            
            % Time vector
            t_vec = linspace(0, t, Fs*t);
            
            % Initialize the sine wave pattern
            sine_wave_pattern = zeros(1, length(t_vec));
            
            % Define frequency range and corresponding time intervals
            freq_intervals = [5000, 6000, 3500, 600, 1000]; % Frequency intervals in Hz
            time_intervals = [0.5, 0.7, 1.3, 1, 1.5]; % Time intervals in seconds
            sine_wave_pattern = [];
            % Generate the sine wave pattern
            for i = 1:length(freq_intervals)
             % Generate sine wave for each frequency interval
             freq = freq_intervals(i);
             duration = time_intervals(i);
             sine_wave = sin(2*pi*freq.*t_vec(1:round(Fs*duration)));
             % Add the sine wave to the pattern
             sine_wave_pattern = [sine_wave_pattern, sine_wave];
            end
             sine_wave_pattern = sine_wave_pattern / max(abs(sine_wave_pattern));
              %plot spectogram
             figure;
             spectrogram(sine_wave_pattern, hamming(256), 128, 256, 44100, 'yaxis');
             ylim([0 10])
             colormap('jet'); % Change colormap
             colorbar('off'); % Turn off colorbar
             title('Spectrogram');
             xlabel('Time (seconds)');
             ylabel('Frequency (Hz)');
             
             filename = 'team[3]-cetk.wav';
             audiowrite(filename, sine_wave_pattern, Fs);
             rendetion = audioread('team[3]-cetk.wav');
             disp('rendition.wav playing');
             sound(rendetion,Fs);
             pause(t);
      
        end
         function SineWave_Q45(self)
             % Load speech file
            [speech, Fs] = audioread("The quick brown fox jumps over the lazy dog-original.wav");
            % Take only one channel if it's stereo
            speech = speech(:, 1);
            
            % Generate time vector
            t = (0:length(speech)-1) / Fs;
            
            % Generate sine wave of the same length as the speech signal
            SineWave = sin(2*pi*5000*t);
            
            % Combine speech with sine wave
            combined_signal = speech + SineWave';
            
            % Write the combined audio to a file
            filename = 'team[3]-combined signal.wav';
            audiowrite(filename,combined_signal,Fs);
            disp('Combined signal.wav playing');
            sound(combined_signal,Fs);
            pause(5);
            %plot spectogram for combined signal
            figure;
            spectrogram(combined_signal, hamming(256), 128, 256, 44100, 'yaxis');
            ylim([0 10])
            colormap('jet'); % Change colormap
            colorbar('off'); % Turn off colorbar
            title('Spectrogram');
            xlabel('Time (seconds)');
            ylabel('Frequency (Hz)');
                 
            %Designing a lowpassfilter
            cutoff_freq = 4000; % Hz
            filtered_signal = lowpass(combined_signal, cutoff_freq, Fs);
            filename = 'team[3]-lowpassfiltered signal.wav';
            audiowrite(filename,filtered_signal,Fs);
            disp('Lowpassfiltered signal.wav playing');
            sound(filtered_signal,Fs);
            pause(5);

          %plot spectogram for filtered signal
            figure;
            spectrogram(filtered_signal, hamming(256), 128, 256, 44100, 'yaxis');
            ylim([0 10])
            colormap('jet'); % Change colormap
            colorbar('off'); % Turn off colorbar
            title('Spectrogram');
            xlabel('Time (seconds)');
            ylabel('Frequency (Hz)');
                 
         end
         function SineWave_Q6(self)
                % Load the original speech audio
                [speech, Fs] = audioread("The quick brown fox jumps over the lazy dog-original.wav");
                
                % Generate sine wave
                t = 0:1/Fs:(length(speech)-1)/Fs; % generate time vector based on the length of the speech
                sine_wave = sin(2*pi*5000*t');
                
                % Combine speech with sine wave for the right channel
                combined_speech_right = speech + sine_wave;
                
                % Ensure both audio signals are the same length
                min_length = min(length(speech), length(combined_speech_right));
                speech = speech(1:min_length);
                combined_speech_right = combined_speech_right(1:min_length);
                
                % Create a stereo audio signal by concatenating left and right channels
                combined_speech = [speech, combined_speech_right];
                
                % Write the combined audio to a file
                filename = 'team[3]-combined speech.wav';
                audiowrite(filename, combined_speech, Fs);
                
                % Play the combined audio
                disp('Combined speech.wav playing');
                sound(combined_speech, Fs);
                pause(5);
                % Plot spectrogram for each channel separately
                figure;
                subplot(2,1,1);
                spectrogram(combined_speech(:,1), hamming(256), 128, 256, Fs, 'yaxis');
                ylim([0 10])
                colormap('jet'); % Change colormap
                colorbar('off'); % Turn off colorbar
                title('Left Channel Spectrogram');
                xlabel('Time (seconds)');
                ylabel('Frequency (Hz)');
                
                subplot(2,1,2);
                spectrogram(combined_speech(:,2), hamming(256), 128, 256, Fs, 'yaxis');
                ylim([0 10])
                colormap('jet'); % Change colormap
                colorbar('off'); % Turn off colorbar
                title('Right Channel Spectrogram');
                xlabel('Time (seconds)');
                ylabel('Frequency (Hz)');
            end
         end 
    end
