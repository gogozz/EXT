function IAT(varargin)
prompt={'SUBJECT ID' 'Session Number'}; 
defAns={'42' '1' }; % '1' '1'}; 

 
answer=inputdlg(prompt,'Please input subject info',1,defAns); 
 
 
ID=str2double(answer{1}); 
SESS = str2double(answer{2}); 
 
 

rng_num = ID*SESS; 
rng(rng_num); 

cold = KbName('a'); 
warm = KbName('l'); 
KbName('UnifyKeyNames');

KbCheckList = [KbName('return'),KbName('a'), KbName('l')];

RestrictKeysForKbCheck(KbCheckList); 

ListenChar(2);
 

c = struct; 
c.BLACK = [0 0 0]; 
c.WHITE = [255 255 255]; 
c.RED = [255 0 0]; 
c.BLUE = [0 0 255]; 
c.GREEN = [0 255 0]; 
c.YELLOW = [255 255 0]; 
c.rect = c.WHITE; 
 
 
s = struct; 
s.blocks = 1; 
s.trials = 50; 

%% any kind of stimuli

%find the  directory by figuring out where the .m is kept 
 
 
%[mdir,~,~] = fileparts(which('IAT.m')); 
 
 
%imgdir = [mdir filesep 'xxx']; 
 
 
%try 
%     cd(imgdir) 
%catch 
%     error('Could not find and/or open the xxx folder. Are you sure you have added the .m and its folder to the path?'); 
%end 
 
 

%D = 'C:\Users\Yizhen\Desktop\soundIAT\Sound\';  




%illustration
%I=imread([D,num2str(i),'.jpg']); 



%sound
%[y,Fs] = audioread([D,num2str(i),'.wav']);
%sound(y,Fs);



 
%% 
WORDBASE1 =  {'x','x','x','x','x'...   
           
          };      
      
    
        


%Randomlization
V1 = randperm(length(WORDBASE1));
R1 = WORDBASE1(V1(1:x)); 


     
commandwindow;



HideCursor;



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
 
 

 
%% Initial
DrawFormattedText(w,double('x'),'center','center',c.WHITE,50,[],[],1.5); 
Screen('Flip',w); 
KbWait(); 
Screen('Flip',w); 
WaitSecs(1); 



%% Instructions 
instruct = ['x\n' ... 
              'x\n' ...
              ' x\n' ...
              '  x \n ' ...   
              '  x　\n'
             ];  
DrawFormattedText(w,double(instruct),'center','center',c.WHITE,75,[],[],1.5); 
Screen('Flip',w); 
KbWait(); 
Screen('Flip',w); 
WaitSecs(.5); 
 
 

%% Blocks & Trials of the Task 
DrawFormattedText(w,double('Enterキーを押すと実験が始まります'),'center','center',c.WHITE,60,[],[],1.5); 
Screen('Flip',w); 
KbWait([],3); 
Screen('Flip',w); 
WaitSecs(1.5); 





for block = 1:s.blocks; 
 
     old = Screen('TextSize',w,180);
     for trial = 1:s.trials;
        
        
         DrawFormattedText(w, '+', 'center','center',c.WHITE);
         Screen('Flip',w);
         WaitSecs(.8);
  
             judge = V1(:,trial);
             B1 = R1(:,trial);
             X = char(B1);
   
             
           if judge <= x %divided into two catergories 
                DrawFormattedText(w, double(X),'center','center',c.WHITE);
                RT_start = Screen('Flip',w); 
                
                KbCheckList1 = [KbName('a'), KbName('l')];

                RestrictKeysForKbCheck(KbCheckList1); 
                KbWait();
               
               
                
                [Down, ~, Code] = KbCheck();            
             if (Down == 1 && any(find(Code) == cold)) 
                  
                  check = 1;
                  Trt = GetSecs - RT_start;
                 elseif (Down == 1 && any(find(Code) == warm)) 
                  check = 0;
                  Trt = GetSecs - RT_start;
                 
             end
                  
                 
                  
                
                   formatstr = '\n%d\t%d\t%d\t%0f\t%d\n';
                   fid = fopen('rtIAT31s.txt','a');
                   fprintf(fid,formatstr,ID,SESS,judge,Trt,check);
                   fclose(fid);           
                         
         
                  
         
            elseif judge >= x;
                DrawFormattedText(w, double(X),'center','center',c.WHITE);
                RT_start = Screen('Flip',w); 
               
                     KbCheckList2 = [KbName('a'), KbName('l')];

                RestrictKeysForKbCheck(KbCheckList2); 
                
                KbWait(); 
           
           
                
                [Down, ~, Code] = KbCheck();         
               if (Down == 1 && any(find(Code) == warm)) 
                  
                  check = 1;
                  Trt = GetSecs - RT_start;
                  
            
                 elseif (Down == 1 && any(find(Code) == cold)) 
                       check = 0;
                       Trt = GetSecs - RT_start;
                   
               end
                  
           
           
                   formatstr = '\n%d\t%d\t%d\t%0f\t%d\n';
                   fid = fopen('rtIAT31l.txt','a');
                   fprintf(fid,formatstr,ID,SESS,judge,Trt,check);
                   fclose(fid);  
      
                     
           end
     end

  
end

      
         Screen('Flip',w); 
         WaitSecs(.5); 
   
     
       Screen('TextSize',w,old); 
      
     
DrawFormattedText(w,'Done.','center','center',c.WHITE); 
Screen('Flip',w); 



WaitSecs(5); 
Screen('Flip', w); 
 
sca
 
 
end







        