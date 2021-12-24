
%기존 데이터
u=udp('192.168.140.92','remoteport',41475,'Localport',41475,'Timeout',10);
fopen(u)
data=fread(u,32)
%지역설정
site_T=data(1,1)
%기상타입
Weather_T=data(5,1)
%비 단위
Rain_T=data(9,1)
%눈 단위
Snow_T=data(13,1)
%안개설정
Fog_T=data(17,1)
%안개 단위
Fog_T1=data(21,1)
%햇빛
g=data(25,1)
%햇빛 량 단위변화
Intensity_T=(g*1.7/100);
%Intensity_T=0.1

clear Results Run;

% UDP Close
fclose(u);

format short;

%change directory
sn=["D:\ADD\ERROR_copy_210128\Final_Model_working\CW_SA_V2", "D:\ADD\ERROR_copy_210128\Final_Model_working\CW_SB_V2" , "D:\ADD\ERROR_copy_210128\Final_Model_working\CW_SC_V2" , "D:\ADD\ERROR_copy_210128\Final_Model_working\CW_SD_V2", "D:\ADD\ERROR_copy_210128\Final_Model_working\Jipori_V1","D:\ADD\ERROR_copy_210128\Final_Model_working\KCTC_V1"];
set_site=sn(1,site_T);

%string -> char 변환
cha_dir=convertStringsToChars(set_site);

cd (cha_dir);


%set experiment
se=["CW_SA_V2","CW_SB_V2","CW_SC_V2","CW_SD_V2","Jipori_V1","KCTC_V1"];
set_exp=se{1,site_T};




disp('Setting-up variables...');
disp('------------------------');



ExeName = 'PreScan.CLI.exe';
ExperimentName = (set_exp);
MainExperiment = pwd;
ExperimentDir = [pwd '\..'];
ResultsDir = [MainExperiment '\Results\Test_Temp_' sprintf('%04.0f%02.0f%02.0f_%02.0f%02.0f%02.0f',clock)];



    RunName = ['Run_Temp'];
    RunModel = [RunName '_cs'];
    ResultDir = [ResultsDir '\' RunName];
    
    
%Command Predefine
Command = ExeName;  
Command = [Command ' -load ' '"' MainExperiment '"'];
Command = [Command ' -save ' '"' ResultDir '"'];    
    
%variable_set

wt=["Weather_Type","Snow","None","Rain"];
tag1=wt{1,1};
switch Weather_T
    case 3
        val1=wt{1,Weather_T};
        Command = [Command ' -set ' tag1 '=' val1];
    case 4
        val1=wt{1,Weather_T};
        rt=["Rain_Type","Default Drizzle","Default Very_Light_Rain","Default Light_Rain","Default Moderate_Rain","Default Heavy_Rain","Default Very_Heavy_Rain","Default Extreme_Rain"];
        tag2=rt{1,1};
        val2=rt{1,Rain_T};
        Command = [Command ' -set ' tag1 '=' val1];
        Command = [Command ' -set ' tag2 '=' val2];
    case 2
        val1=wt{1,Weather_T};
        st=["Snow_Type","Default Light_Snow","Default Moderate_Snow","Default Heavy_Snow","Default Extreme_Snow"];
        tag3=st{1,1};
        val3=st{1,Snow_T};
        Command = [Command ' -set ' tag1 '=' val1];
        Command = [Command ' -set ' tag3 '=' val3];
    otherwise 
      disp('Please check the network value')
end


fa=["Fog_Active","True","False"];

switch Fog_T
    case 2
        tag4=fa{1,1};
        val4=fa{1,Fog_T};
        Command = [Command ' -set ' tag4 '=' val4];
    case 3
        tag4=fa{1,1};
        val4=fa{1,Fog_T};
        fs=["Fog_Select","Default Normal","Default High","Default Low"];
        tag5=fs{1,1};
        val5=fs{1,Fog_T1};
        Command = [Command ' -set ' tag5 '=' val5];
end
%iv=["Intensity","1.7"];
tag6=('Inten');

val6=(Intensity_T);
Command = [Command ' -set ' tag6 '=' sprintf('%.2f', val6)];
    
 % Create the complete command
    %Settings = cellstr('Altered Settings:');
    %Command = ExeName;
    %Command = [Command ' -load ' '"' MainExperiment '"'];
    %Command = [Command ' -save ' '"' ResultDir '"'];    
%     Command = [Command ' -set ' tag1 '=' val1];
%     Command = [Command ' -set ' tag2 '=' val2];
%     Command = [Command ' -set ' tag3 '=' val3];
%     Command = [Command ' -set ' tag4 '=' val4];
%     Command = [Command ' -set ' tag5 '=' val5];
%     Command = [Command ' -set ' tag6 '=' val6];
    Command = [Command ' -build'];    
    Command = [Command ' -close'];
    
disp(Command) % Command
[cmdStatus, cmdResult] = dos(Command); % dos Command
if cmdStatus ~= 0 ;
    disp(['ERROR: Failed to perform command - ' Command]);
    disp(['       Status - ' cmdStatus]);
    disp(['       Result - ' cmdResult]);
end
    

    cd(ResultDir);
    open_system(RunModel);
    
    % Regenerate compilation sheet.
    regenButtonHandle = find_system(RunModel, 'FindAll', 'on', 'type', 'annotation','text','Regenerate');
    regenButtonCallbackText = get_param(regenButtonHandle,'ClickFcn');
    eval(regenButtonCallbackText);
    
 sim(RunModel, inf);
 
 %{ 

   Store results to file.
   ResultFileDir = [ResultDir '\Results\'];
   [mkDirStatus,mkDirMessage,mkDirMessageid] = mkdir(ResultFileDir);
   resultFileName = [ResultFileDir 'simout.mat'];
   save(resultFileName,'simout');
   
   

%Close the experiment
%    save_system(RunModel);
%    close_system(RunModel);



%}