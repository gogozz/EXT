function GNG(varargin)
prompt={'SUBJECT ID' 'Session Number'}; 
defAns={'42' '1' }; % '1' '1'}; 
rt = 0;
 
answer=inputdlg(prompt,'Please input subject info',1,defAns); 
 
 
ID=str2double(answer{1}); 
SESS = str2double(answer{2}); 
 
 

 
rng_num = ID*SESS; 
rng(rng_num); 

 
KEY = struct; 
KEY.rt = KbName('SPACE'); 
 
 
c = struct; 
c.BLACK = [0 0 0]; 
c.WHITE = [255 255 255]; 
c.RED = [255 0 0]; 
c.BLUE = [0 0 255]; 
c.GREEN = [0 255 0]; 
c.YELLOW = [255 255 0]; 
c.rect = c.WHITE; 
 
 
s = struct; 
s.blocks = 2; 
s.trials = 60; 

s.trialdur = 3; 
s.rest = 45;         
 
%Small and Large Numbers
NOBASE =  [ 11 12 13 14 15 16 17 18 19 20 ...
            21 22 23 24 25 26 27 28 29 30  ... 
            31 32 33 34 35 36 37 38 39 40 ...
            61 62 63 64 65 66 67 68 69 70 ...
            71 72 73 74 75 76 77 78 79 80   ... 
            81 82 83 84 85 86 87 88 89 90 ... 
           ]; 
        
       
%Randomlization
V1 = randperm(length(NOBASE));
R1 = NOBASE(V1(1:60)); 

V2 = randperm(length(NOBASE));
R2 = NOBASE(V2(1:60)); 


commandwindow;







%% 
DEBUG=0; 
 
Screen('Preference', 'SkipSyncTests', 1); 

 
screenNumber=max(Screen('Screens')); 

 
if DEBUG==1; 
   winRect=[0 0 640 480]; 
     XCENTER=320; 
     YCENTER=240; 
else 
 
     [swidth, sheight] = Screen('WindowSize', screenNumber); 
     XCENTER=fix(swidth/2); 
     YCENTER=fix(sheight/2); 
     winRect=[]; 
end 
 
 

[w, ~]=Screen('OpenWindow', screenNumber, 0,winRect,32,2); 

 

 
%% Font  
Screen('TextFont', w, 'Arial'); 
Screen('TextSize',w,30); 
 
 
KbName('UnifyKeyNames'); 
 

 
%% Initial 
DrawFormattedText(w,'Welcome to the reaction time task.\nPress any key to continue.','center','center',c.WHITE,50,[],[],1.5); 
Screen('Flip',w); 
KbWait(); 
Screen('Flip',w); 
WaitSecs(1); 

HideCursor;
 
%% Instructions 
instruct = 'In this task, we will show you a series numbers. We want you to press the space bar as quickly & accurately as you can when you see certain ranges of numbers -- either SMALL or LARGE numbers. \n\nBefore each round we will tell you whether to press the space bar for SMALL or LARGE numbers.\n\nPress any key to continue.';  
DrawFormattedText(w,instruct,'center','center',c.WHITE,75,[],[],1.5); 
Screen('Flip',w); 
KbWait(); 
Screen('Flip',w); 
WaitSecs(.5); 
 
 

%% Blocks & Trials of the Task 
DrawFormattedText(w,'The task is about to begin.\n\n\nPress any key to begin the task.','center','center',c.WHITE,60,[],[],1.5); 
Screen('Flip',w); 
KbWait([],3); 
Screen('Flip',w); 
WaitSecs(1.5); 




for block = 1:s.blocks; 
     
     
         if block == 1
         T = R1;  
         go_word = 'SMALL'; 
         nogo_word = 'LARGE'; 
         
         msg = sprintf('Prepare for Round %d. \n\nIn this round, press the space bar when you see %s no. \n\nIf you see %s no. do not press the button. \n\nPress any key when you are ready to begin.',block,go_word,nogo_word); 
         DrawFormattedText(w,msg,'center','center',c.WHITE,80,[],[],1.5); 
         Screen('Flip',w); 
         KbWait(); 
         end

        
         if block == 2
         T = R2;      
         go_word = 'LARGE'; 
         nogo_word = 'SMALL'; 
          
         msg = sprintf('Prepare for Round %d. \n\nIn this round, press the space bar when you see %s no. \n\nIf you see %s no. do not press the button. \n\nPress any key when you are ready to begin.',block,go_word,nogo_word); 
         DrawFormattedText(w,msg,'center','center',c.WHITE,80,[],[],1.5); 
         Screen('Flip',w); 
         KbWait(); 
         end
        
     
      
    

     
     old = Screen('TextSize',w,180);
     
     for trial = 1:s.trials;
         tnum = (block-1)*s.trials + trial; 

         DrawFormattedText(w, '+', 'center','center',c.WHITE);
         Screen('Flip',w);
         WaitSecs(.5);
         
         B = T(:,trial);
         X = num2str(B);
         DrawFormattedText(w, X,'center','center',c.WHITE);
         WaitSecs(.5);
         RT_start = Screen('Flip',w,[],1); 
         telap = GetSecs() - RT_start; 
         
         
          
         
      correct = -999;
      while telap <= (s.trialdur); 
              
              
             telap = GetSecs() - RT_start; 
             [Down, ~, Code] = KbCheck();           
             if (Down == 1 && any(find(Code) == KEY.rt)) 
                 respTime = GetSecs;
                 rt = respTime - RT_start; 
                  
                 if block == 1 
                     
                    if B <= 41; % go test
                    Screen('Flip',w); 
                    WaitSecs(.5);   
                    correct = 1; 
              
                    break;                     
                     
                    elseif B >= 61;  % no-go test
                      DrawFormattedText(w,'X','center','center',c.RED); 
                      Screen('Flip',w); 
                      WaitSecs(.5); 
                      correct = 0; 
                      break; 
                    end
                 end
                 
                 if block == 2  % no-go test
                     
                      if B >= 61;
                      Screen('Flip',w); 
                      WaitSecs(.5); 
                      correct = 1; 
                      break;
                     
                      elseif B <= 41;  % no-go test
                      DrawFormattedText(w,'X','center','center',c.RED); 
                      Screen('Flip',w); 
                      WaitSecs(.5); 
                      correct = 0; 
                      break;
                      end
                 end 
             end 
      end
          
         
          
           if correct == -999 
              rt = s.trialdur; 
       
                if block == 1 
                   if B >= 61; 
            
                 Screen('Flip',w); 
                      
                 correct = 1;  
              
                   elseif B <= 41; 
     
                      DrawFormattedText(w,'X','center','center',c.RED); 
                      Screen('Flip',w); 
                      WaitSecs(.5); 
                      correct = 0; 
                   end
                end
             
                if block == 2 
       
                 if B <= 41; 
                 Screen('Flip',w); 
                      
                 correct = 1; 
                 
                 elseif B >= 61;
                 DrawFormattedText(w,'X','center','center',c.RED); 
                 Screen('Flip',w); 
                 WaitSecs(.5); 
                  
                 correct = 0; 
                end
               end
           end
             
        
         formatstr = '\n%d\t%d\t%d\t%0f\t%d\n';
         fid = fopen('responseGNGs.txt','a');
         fprintf(fid,formatstr,ID,SESS,B,rt,correct);
         fclose(fid);   
           
     end
          
           
   

             
      
         Screen('Flip',w); 
         WaitSecs(.5); 
   
     
   
   
   
     
     Screen('TextSize',w,old); 
      
      if block < s.blocks 
         postbloc_text = sprintf('REST. \n\nThe next round will begin in %d seconds.',s.rest); 
         DrawFormattedText(w,postbloc_text,'center','center',c.WHITE); 
         Screen('Flip',w); 
          
         for elap = 1:s.rest 
          
             if rem(elap,5) == 0 
                countd = s.rest - elap; 
                 postbloc_text = sprintf('REST. \n\nThe next round will begin in %d seconds.',countd); 
                 DrawFormattedText(w,postbloc_text,'center','center',c.WHITE); 
                 Screen('Flip',w);   
             end 
             WaitSecs(1); 
         end 

     end 

DrawFormattedText(w,'It is the end of the experiment. Please let the experimenter know you are finished.','center','center',c.WHITE); 
Screen('Flip',w); 


end







        