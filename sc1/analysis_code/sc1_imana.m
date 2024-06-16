function varargout=sc1_imana(what,varargin)
% super_cerebellum project (3T scanner at Robarts, UWO, 03/2016 to ?)

% UPDATE INFO IN SECTION 2 WITH EVERY NEW SUBJECT
%
numDummys = 3;                                                              % per run
numTRs    = 601;                                                            % per run (includes dummies)

%========================================================================================================================
% % (1) Directories
% baseDir         = '/Users/mking/Documents/Cerebellum_Cognition/sc1'; dircheck(baseDir);
baseDir         = '/Volumes/MotorControl/data/super_cerebellum/sc1'; % server
behavDir        =[baseDir '/data'];
imagingDir      =[baseDir '/imaging_data'];
imagingDirNA    =[baseDir '/imaging_data_nonaggr'];
imagingDirA     =[baseDir '/imaging_data_aggr'];
imagingDirRaw   =[baseDir '/imaging_data_raw'];
dicomDir        =[baseDir '/imaging_data_dicom'];
anatomicalDir   =[baseDir '/anatomicals'];
freesurferDir   =[baseDir '/surfaceFreesurfer'];
suitDir         =[baseDir '/suit'];
caretDir        =[baseDir '/surfaceCaret'];
regDir          =[baseDir '/RegionOfInterest/'];
eyeDirRaw       =[baseDir '/eyeTracking_raw'];
eyeDir          =[baseDir '/eyeTracking'];
physioDir       =[baseDir '/physio'];
encodeDir       =[baseDir '/encoding'];

%========================================================================================================================
% % (2) PRE-PROCESSING: Study AND Subject AND Session specific info. EDIT W/ EVERY NEW SUBJECT AND W/ EVERY NEW
% SESSION

subj_name = {'s01','s02','s03','s04','s05','s06','s07','s08','s09','s10','s11','s12','s13','s14','s15','s16','s17','s18','s19','s20','s21','s22'};

returnSubjs=[2,3,4,6,7,8,9,10,12,14,15,17,18,19,20,21,22];

DicomName  = {'2016_03_15_HP10.MR.DIEDRICHSEN_FEB2016',...
    '2016_03_23_HP10.MR.DIEDRICHSEN_FEB2016',...
    '2016_04_13_I011.MR.DIEDRICHSEN_FEB2016',...
    '2016_04_156_I011.MR.DIEDRICHSEN_FEB2016',...
    '2016_04_18_UH11.MR.DIEDRICHSEN_FEB2016',...
    '2016_04_19_UH11.MR.DIEDRICHSEN_FEB2016',...
    '2016_04_26_CC23.MR.DIEDRICHSEN_FEB2016',...
    '2016_04_29_CC23.MR.DIEDRICHSEN_FEB2016',...
    '2016_05_18_EK05.MR.DIEDRICHSEN_FEB2016',...
    '2016_05_19_EK05.MR.DIEDRICHSEN_FEB2016',...
    '2016_05_24_M028.MR.DIEDRICHSEN_FEB2016',...
    '2016_05_30_M028.MR.DIEDRICHSEN_FEB2016',...
    '2016_05_25_HI15.MR.DIEDRICHSEN_FEB2016',...
    '2016_05_26_HI15.MR.DIEDRICHSEN_FEB2016',...
    '2016_05_31_NL20.MR.DIEDRICHSEN_FEB2016',...
    '2016_06_01_NL20.MR.DIEDRICHSEN_FEB2016',...
    '2016_06_02_OH14.MR.DIEDRICHSEN_FEB2016',...
    '2016_06_03_OH14.MR.DIEDRICHSEN_FEB2016',...
    '2016_07_07_RV14.MR.DIEDRICHSEN_FEB2016',...
    '2016_07_08_RV14.MR.DIEDRICHSEN_FEB2016',...
    '2016_07_15_AC15.MR.DIEDRICHSEN_FEB2016',...
    '2016_07_22_AC15.MR.DIEDRICHSEN_FEB2016',...
    '2016_07_20_RM20.MR.DIEDRICHSEN_FEB2016',...
    '2016_07_21_RM20.MR.DIEDRICHSEN_FEB2016',...
    '2016_07_28_AW12.MR.DIEDRICHSEN_FEB2016',...
    '2016_07_29_AW12.MR.DIEDRICHSEN_FEB2016',...
    '2016_07_28_SR12.MR.DIEDRICHSEN_FEB2016',...
    '2016_07_29_SR12.MR.DIEDRICHSEN_FEB2016',...
    '2016_08_04_RT25.MR.DIEDRICHSEN_FEB2016',...
    '2016_08_05_RT25.MR.DIEDRICHSEN_FEB2016',...
    '2016_08_04_FW03.MR.DIEDRICHSEN_FEB2016',...
    '2016_08_05_FW03.MR.DIEDRICHSEN_FEB2016',...
    '2016_08_22_AR14.MR.DIEDRICHSEN_FEB2016',...
    '2016_08_23_AR14.MR.DIEDRICHSEN_FEB2016',...
    '2017_02_14_AO21.MR.DIEDRICHSEN_MAEBDH',...
    '2017_02_22_AO21.MR.DIEDRICHSEN_MAEBDH',...
    '2017_03_09_HA31.MR.DIEDRICHSEN_MAEBDH',...
    '2017_03_13_HA31.MR.DIEDRICHSEN_MAEBDH',...
    '2017_03_15_ML24.MR.DIEDRICHSEN_MAEBDH',...
    '2017_03_20_ML24.MR.DIEDRICHSEN_MCC',...
    '2017_03_13_AZ18.MR.DIEDRICHSEN_MAEBDH',...
    '2017_03_20_AZ18.MR.DIEDRICHSEN_MCC',...
    '2017_03_15_VE14.MR.DIEDRICHSEN_MAEBDH',...
    '2017_03_16_VE14.MR.DIEDRICHSEN_MCC',...
    };

NiiRawName = {'160315140823DST131221107524367007',...%s01
    '160323140933DST131221107524367007',...%s01
    '160413101535DST131221107524367007',...%s02
    '160415100919DST131221107524367007',...%s02
    '160418140549DST131221107524367007',...%s03
    '160419152813DST131221107524367007',...%s03
    '160426135807DST131221107524367007',...%s04
    '160429150526DST131221107524367007',...%s04
    '160518145625DST131221107524367007',...%s05
    '160519140503DST131221107524367007',...%s05
    '160524143451DST131221107524367007',...%s06
    '160530143056DST131221107524367007',...%s06
    '160525145854DST131221107524367007',...%s07
    '160526150947DST131221107524367007',...%s07
    '160531141052DST131221107524367007',...%s08
    '160601140606DST131221107524367007',...%s08
    '160602145638DST131221107524367007',...%s09
    '160603144457DST131221107524367007',...%s09
    '160707141119DST131221107524367007',...%s10
    '160708125723DST131221107524367007',...%s10
    '160715123900DST131221107524367007',...%s11
    '160722143518DST131221107524367007',...%s11
    '160720110707DST131221107524367007',...%s12
    '160721105741DST131221107524367007',...%s12
    '160728100746DST131221107524367007',...%s13
    '160729100321DST131221107524367007',...%s13
    '160728120942DST131221107524367007',...%s14
    '160729120849DST131221107524367007',...%s14
    '160804140003DST131221107524367007',...%s15
    '160805130528DST131221107524367007',...%s15
    '160804100807DST131221107524367007',...%s16
    '160805100423DST131221107524367007',...%s16
    '160822095244DST131221107524367007',...%s17
    '160823100118DST131221107524367007',...%s17
    '170214144242STD131221107524367007',...%s18
    '170222143758STD131221107524367007',...%s18
    '170309121041STD131221107524367007',...%s19
    '170313120111DST131221107524367007',...%s19
    '170315121648DST131221107524367007',...%s20
    '170320120712DST131221107524367007',...%s20
    '170313095950DST131221107524367007',...%s21
    '170320100001DST131221107524367007',...%s21
    '170315144047DST131221107524367007',...%s22
    '170316144945DST131221107524367007',...%s22
    };

fscanNum   = {[3,4,5,6,8,9,10,11],...%s01 functional scans (series number)
    [2,3,4,5,6,7,8,9],...%s01
    [3,4,5,6,8,10,11,12],...%s02
    [2,3,4,5,6,7,8,9],...%s02
    [3,4,5,6,7,8,9,10],...%s03
    [3,4,5,6,8,9,10,11],...%s03
    [4,7,8,9,10,11,12,13],...%s04
    [2,3,4,5,6,7,8,9],...%s04
    [3,4,5,6,7,8,9,10],...%s05
    [2,3,4,5,6,7,8,9],...%s05
    [3,4,5,6,7,8,9,10],...%s06
    [2,3,4,5,6,7,8,9],...%s06
    [3,4,5,6,7,8,9,10],...%s07
    [2,3,4,5,6,7,8,9],...%s07
    [3,4,5,6,7,8,9,10],...%s08
    [2,3,4,5,6,7,8,9],...%s08
    [3,4,5,6,7,8,9,10],...%s09
    [2,3,4,5,6,7,8,9],...%s09
    [3,4,5,6,7,8,9,10],...%s10
    [2,3,4,5,6,7,8,9],...%s10
    [4,5,6,7,8,9,10,11],...%s11
    [3,4,5,6,7,8,9,10],...%s11
    [3,4,5,7,8,9,10,11],...%s12
    [2,3,4,5,6,7,8,9],...%s12
    [4,5,6,7,8,9,10,11],...%s13
    [2,3,4,5,6,7,9,10],...%s13
    [4,5,6,7,8,9,10,11],...%s14
    [2,3,4,5,6,7,8,9],...%s14
    [3,4,5,6,7,8,9,10],...%s15
    [2,3,4,6,7,8,9,10],...%s15
    [3,4,5,6,7,8,9,10],...%s16
    [2,3,4,5,6,7,8,9],...%s16
    [3,4,5,6,7,8,9,10],...%s17
    [2,3,4,5,6,7,8,9],...%s17
    [3,4,5,6,7,8,9,10],...%s18
    [2,4,5,6,7,8,10,11],...%s18
    [3,4,5,6,7,8,9,10],...%s19
    [2,3,4,5,6,7,8,9],...%s20
    [3,4,5,6,7,8,9,10],...%s20
    [2,3,4,5,6,7,8,9],...%s21
    [3,4,5,6,7,9,10,11],...%s21
    [3,4,5,7,8,9,10,11],...%s22
    [3,4,5,6,7,8,9,10],...%s22
    [2,3,4,5,6,7,8,9],...%s22
    };

anatNum = {7,...                     % anatomical scans (series number)
    2,...                            % one scan per subject (collected in session 1)
    2,...
    2,...
    2,...
    2,...
    2,...
    2,...
    2,...
    2,...
    2,...
    2,...
    2,...
    3,...
    2,...
    2,...
    2,...
    2,...
    2,...
    2,...
    2,...
    2,...
    };

saccRun = {[],...           % runs to be included for saccade analysis
    [1],...
    [],...
    [],...
    [1,2,3,4],...
    [1,2,3,4],...
    [3,4],...
    [1,2,3],...
    [1,2,3,4],...
    [3,4],...
    [2,3,4],...
    [1,2],...
    [2],...
    [1,2,3],...
    [1,2],...
    [2],...
    [1,2],...
    [1,2],...
    [1,2],...
    [1],...
    [1,2],...
    [1],...
    };

T2Num   = {[],...                     % T2 scans (series number)
    [],...                            % collected during session 1 and 2
    [],...
    3,...
    11,...
    11,...
    11,...
    11,...
    11,...
    11,...
    11,...
    12,...
    };

% The values of loc_AC should be acquired manually prior to the preprocessing
%   Step 1: open .nii file with MRIcron and manually find AC and read the xyz coordinate values
%           (note: these values are not [0 0 0] in the MNI coordinate)
%   Step 2: set those values into loc_AC (subtract from zero)

loc_AC = {[-108,-128,-149],...
    [-84, -124,-131],...
    [-93,-132,-151],...
    [-91,-136,-147],...
    [-89, -133,-125],...
    [-93,-139,-136],...
    [-90,-130,-149],...
    [-90,-132,-145],...
    [-98,-141,-127],...
    [-93,-132,-122],...
    [-102,-132,-137],...
    [-96,-146,-147],...
    [-95,-141,-143],...
    [-90,-138,-146],...
    [-98,-147,-142],...
    [-93,-126,-157],...
    [-92,-131,-134],...
    [-94,-139,-137],...
    [-92,-137,-127],...
    [-95,-140,-152],...
    [-94,-139,-137],...
    [-94,-143,-145],...
    };

%========================================================================================================================
% % (3) GLM.

% GLM Directories - change glmNum when appropriate
glm_type = {'complex-fast','simple-noInstruct','complex-fast-clean'};

funcRunNum = [51,66];  % first and last behavioural run numbers (16 runs per subject)

run        = {'01','02','03','04','05','06','07','08','09','10','11','12','13','14','15','16'};

runB = [51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66];  % Behavioural labelling of runs

sess = [1,1,1,1,1,1,1,1,2,2,2,2,2,2,2,2]; % session number

taskNames = {'GoNoGo','ToM','actionObservation','affective','arithmetic',...
    'checkerBoard','emotional','intervalTiming','motorImagery','motorSequence',...
    'nBack', 'nBackPic','spatialNavigation','stroop', 'verbGeneration',...
    'visualSearch','rest'};

condNames = {'1.instructions','2.GoNoGo-negative', '3.GoNoGo-positive', '4.ToM',...
    '5.actionObs-action', '6.actionObs-control', '7.affective-unpleas',...
    '8.affective-pleas', '9.arithmetic-equat', '10.arithmetic-con', '11.checkerBoard',...
    '12.emotion-sad', '13.emotion-happy','14.intervalTiming', '15.motorImagery',...
    '16.motorSequence-con', '17.motorSeq-seq', '18.nBack-no-resp', '19.nBack-resp', '20.nBackPic-no-resp',...
    '21.nBackPic-resp', '22.spatialNav', '23.stroop-incon', '24.stroop-con',...
    '25.verbGen-gen', '26.verbGen-read', '27.visualSearch-load-small', '28.visualSearch-load-med',...
    '29.visualSearch-load-large','30.rest'};

condNamesNoInstruct={'1.NoGo','2.Go','3.Theory of Mind','4.Video Actions','5.Video Knots',...
    '6.Unpleasant Scenes','7.Pleasant Scenes','8.Math','9.Digit Judgment','10.Checkerboard',...
    '11.Sad Faces','12.Happy Faces','13.Interval Timing','14.Motor Imagery','15.Finger Simple',...
    '16.Finger Sequence','17.Verbal 0-Back','18.Verbal 2-Back','19.Object 0-Back','20.Object 2-Back',...
    '21.Spatial Navigation','22.Stroop Incongruent','23.Stroop Congruent','24.Verb Generation','25.Word Reading',...
    '26.Visual Search - small','27.Visual Search - medium','28.Visual Search - large','29.rest'};

contrasts{1} = {'negative','positive'};                % GoNoGo
contrasts{2} = {'ToM','rest'};                         % ToM
contrasts{3} = {'action','control'};                   % actionObservation
contrasts{4} = {'unpleasant','pleasant'};              % affective
contrasts{5} = {'equation','control'};                 % arithmetic
contrasts{6} = {'checkerboard','rest'};                % checkerBoard
contrasts{7} = {'sad','happy'};                        % emotional
contrasts{8} = {'intervalTiming','rest'};              % intervalTiming
contrasts{9} = {'motorImagery','rest'};                % motorImagery
contrasts{10} = {'control','sequence'};                % motorSequence
contrasts{11}= {'no response','response'};             % nBack
contrasts{12}= {'no response','response'};             % nBackPic
contrasts{13}= {'spatialNavigation','rest'};           % spatialNavigation
contrasts{14}= {'incongruent','congruent'};            % stroop
contrasts{15}= {'generate','read'};                    % verbGeneration
contrasts{16}= {'load_small','load_med','load_large'}; % visualSearch
contrasts{17}= {'rest'};                               % rest

numRegress ={repmat([1],16,1),...         % glm1
    repmat([1],16,1),...                  % glm2
    repmat([1],16,1),...                  % glm3
    [2;1;2;2;2;1;2;1;1;2;2;2;1;2;2;3],... % glm4
    [2;1;2;2;2;1;2;1;1;2;2;2;1;2;2;3],... % glm5
    [2;1;2;2;2;1;2;1;1;2;2;2;1;2;2;3],... % glm6
    };

taskNumbers = [1;2;3;4;5;6;7;8;9;10;11;12;13;14;15;16;17];

PW = {'betasNW','betasUW'}; % methods of noise normalisation (none and univariate noise normalisation)

% RightHand = {'nBackPic','emotional','arithmetic','intervalTiming'};
% LeftHand = {'nBack','visualSearch','GoNoGo','affective','ToM'};
% BothHands = {'stroop','motorSequence'};

%========================================================================================================================
% % (4) Hemisphere and Region Names
hem        = {'lh','rh'};
regSide    = 1:2;
atlasA    = 'x';
atlasname = 'fsaverage_sym';
hemName   = {'LeftHem','RightHem'};

%========================================================================================================================
% % (5) MODELS

yeoNames = {'Network1','Network2','Network3','Network4','Network5','Network6','Network7','Network8',...
    'Network9','Network10','Network11','Network12','Network13','Network14','Network15','Network16','Network17'};

yeoHemNames = {'Network1_lh','Network2_lh','Network3_lh','Network4_lh','Network5_lh','Network6_lh','Network7_lh',...
    'Network8_lh','Network9_lh','Network10_lh','Network11_lh','Network12_lh','Network13_lh','Network14_lh','Network15_lh','Network16_lh',...
    'Network17_rh','Network1_rh','Network2_rh','Network3_rh','Network4_rh','Network5_rh','Network6_rh','Network7_rh','Network8_rh',...
    'Network9_rh','Network10_rh','Network11_rh','Network12_rh','Network13_rh','Network14_rh','Network15_rh','Network16_rh','Network17_rh'};

corticalNames = {'frontal','parietal','occipital','temporal'};

cerebralNames = {'frontal','parietal','occipital','temporal','limbic','medialWall'};

desikanNames = {'bankssts','caudalACC','caudalmiddlefrontal','corpuscallosum','cuneus','entorhinal','fusiform',...
    'infparietal','inftemporal','isthmuscingulate','lateraloccipital','lateralorbitofrontal','lingual','medialorbitofrontal',...
    'middletemporal','parahippocampal','paracentral','parsopercularis','parsorbitalis','parstriangularis','pericalcarine',...
    'postcentral','posteriorcingulate','precentral','precuneus','rostralACC','rostralmiddlefrontal','superiorfrontal','superiorparietal',...
    'superiortemporal','supramarginal','frontalpole','temporalpole','transversetemporal','insula'};

desikanSpecialNames={'FrontalPole','LingualGyrus','PrecentralGyrus','PostcentralGyrus','SuperiorParietalLobule','ParacentralLobule','ParsOpercularis',...
    'RostralMiddleFrontalGyrus','Parstriangularis','Pericalcarine','Precuneus','CaudalMiddleFrontalGyrus',...
    'Cuneus','ParsOrbitalis','InferiorTemporalGyrus','SupramarginalGyrus','MiddleTemporalGyrus'};

cerebellarNames = {'I_IV','V','VI','CrusI','CrusII','VIIb','VIIIa','VIIIb','IX','X'};

cortical_lambdas={[0,50,100],[0,25,50,150,300,500,700,1000]}; % L1, L2
yeo_lambdas={[0,5,10,25,50,100],[0,25,50,150,300,500,700,1000]}; % L1, L2
yeo_hem_lambdas={[0,5,10,25,50,100],[0,25,50,150,300,500,700,1000]}; % L1, L2
desikan_lambdas={[0,5,10,25,50,100],[0,5,10,25,50,100]}; % L1, L2
desikan_hem_lambdas={[0,25,50,100],[0,25,50,150,300,500,700,1000]}; % L1, L2
tessel162_lambdas={[0,25,100],[0,50,500,1000]}; % L1, L2
tessel162_hem_lambda={[0,25,100],[0,50,500,1000]}; % L1, L2

%========================================================================================================================

switch(what)
    
    case 'temp'
        sn=varargin{1};
        
        subjs=length(sn);
        for s=1:subjs,
            for r=1:16,
                sourceDir=fullfile('/Volumes/MotorControl/data/super_cerebellum/','Aroma/sc1',subj_name{sn(s)},sprintf('B_%2.2d',r));
                destDir=fullfile(baseDir,'imaging_data_agg',subj_name{sn(s)});
                dircheck(destDir);
                
                % imagingFiles
                imagingFiles=fullfile(sourceDir,'denoised_func_data_aggr.nii.gz');
                
                % classification overview
                classOverview=fullfile(sourceDir,'classification_overview.txt');
                
                % classified motion
                classMotion=fullfile(sourceDir,'classified_motion_ICs.txt');
                
                % move imaging
                imagDest=fullfile(destDir,sprintf('rrun_%2.2d.nii.gz',r));
                copyfile(char(imagingFiles),char(imagDest))
                gunzip(imagDest);
                delete(imagDest);
                
                % move classification
                classDest=fullfile(destDir,sprintf('aICs_%2.2d.txt',r));
                copyfile(char(classOverview),char(classDest))
                
                % move classMotion
                motionDest=fullfile(destDir,sprintf('mICs_%2.2d.txt',r));
                copyfile(char(classMotion),char(motionDest))
                fprintf('run %d done \n',r)
            end
            fprintf('subj%d done \n',sn(s))
        end
        
    case 'process_eyeTracking'          % STEP 1.1: enter subjNum
        % converts all edf files and saves 'events','samples' &
        % 'regressors'
        sn=varargin{1};
        step=varargin{2}; % 'events_samples','regressors'
        
        taskNames_Eye={'Go','To','ac','af','ar','ch','em',...
            'in','ry','ce','ck','ic','sp','st','ve','vi','re'
            };
        
        subjs=length(sn);
        
        for s=1:subjs,
            % preallocate structures
            E=[];
            S=[];
            Rr=[];
            I=[];
            R=[];
            switch step,
                case 'events_samples'
                    % read in all filenames
                    dircheck(fullfile(eyeDirRaw,subj_name{sn(s)}));
                    filenames=dir(fullfile(eyeDirRaw,subj_name{sn(s)},'*edf*'));
                    for ii=1:length(filenames),
                        raw=Edf2Mat(fullfile(eyeDirRaw,subj_name{sn(s)},filenames(ii).name));
                        [~,name,~] = fileparts(raw.filename); % edf filename
                        
                        % Events
                        Ee=raw.Events;
                        Ee.taskName={name(7:8)}; % taskName
                        Ee.subjName=str2double(name(1:2)); % subjNum
                        Ee.runNum=str2double(name(3:4)); % runNum
                        Ee.blockNum=str2double(name(5:6)); % blockNum
                        Ee.SN=sn(s);
                        E=addstruct(E,Ee);
                        
                        % Samples
                        Ss=raw.Samples;
                        Ss.taskName={name(7:8)};
                        Ss.subjName=str2double(name(1:2)); % subjNum
                        Ss.runNum=str2double(name(3:4)); % runNum
                        Ss.blockNum=str2double(name(5:6)); % blockNum
                        Ss.SN=sn(s);
                        S=addstruct(S,Ss);
                    end
                    dircheck(fullfile(eyeDir,subj_name{sn(s)}));
                    save(fullfile(eyeDir,subj_name{sn(s)},'events.mat'),'E');
                    save(fullfile(eyeDir,subj_name{sn(s)},'samples.mat'),'S');
                case 'regressors_glm13'
                    % Regressors (avgNum saccades per task)
                    load(fullfile(eyeDir,subj_name{sn(s)},'events.mat'));
                    runs=unique(E.runNum);
                    for r=runs(1):runs(end), % loop over runs
                        Tr=getrow(E,E.runNum==r);
                        for tt=1:numel(taskNames_Eye), % loop over tasks
                            idx=find(strcmp(Tr.taskName,taskNames_Eye{tt}));
                            S.numSacc=length(Tr.Ssacc(idx).time); % count number of saccades (per task)
                            S.num=tt;
                            Rr=addstruct(Rr,S); % get num of saccades for all runs
                        end
                    end
                    % get average saccades per task across runs
                    for t=1:length(Rr.num)/length(saccRun{sn(s)}), % loop over task conditions
                        Q.avgSacc=round(mean(Rr.numSacc(Rr.num==t)));
                        Q.taskName=taskNames(t);
                        Q.condNum=t;
                        R=addstruct(R,Q);
                    end
                    
                    save(fullfile(eyeDir,subj_name{sn(s)},'glm13_saccades.mat'),'R');
                case 'regressors_glm4'
                    % Regressors (avgNum saccades per task)
                    load(fullfile(eyeDir,subj_name{sn(s)},'events.mat'));
                    runs=unique(E.runNum);
                    A = dload(fullfile(baseDir, 'data', subj_name{sn(s)},['sc1_',subj_name{sn(s)},'.dat']));
                    A = getrow(A,A.runNum>=runs(1) & A.runNum<=runs(end));
                    glm=4;
                    announceTime=5000;
                    
                    for r=runs(1):runs(end), % loop over runs
                        Tr=getrow(E,E.runNum==r);
                        % Get 'instructions' regressor (for all tasks)
                        for tt=1:numel(taskNames_Eye),
                            idx=find(strcmp(Tr.taskName,taskNames_Eye{tt}));
                            endInstruct=Tr.Start(idx).time+announceTime;
                            taskDur=Tr.Ssacc(idx).time-endInstruct;
                            T.numSacc=length(find(taskDur<0)); % count number of saccades (instructions)
                            T.endInstruct=endInstruct;
                            I=addstruct(I,T);
                        end
                        S.numSacc(1)=round(mean(I.numSacc));
                        S.num(1)=1;
                        Rr=addstruct(Rr,S);
                        
                        indx=2;
                        for tt=1:numel(taskNames_Eye), % loop over tasks
                            D=dload(fullfile(baseDir, 'data', subj_name{sn(s)},['sc1_',subj_name{sn(s)},'_',taskNames{tt},'.dat']));
                            numRegress{glm}(17)=1; % add rest
                            trialType=1:numRegress{glm}(tt);
                            idx=find(strcmp(Tr.taskName,taskNames_Eye{tt}));
                            for regs=trialType, % loop through trial-types (ex. congruent and incongruent)
                                taskDur=Tr.Ssacc(idx).time-I.endInstruct(tt);
                                S.numSacc=length(find(taskDur>0))/trialType(end); % count number of saccades (per task)
                                S.num=indx;
                                Rr=addstruct(Rr,S);
                                indx=indx+1;
                            end
                        end
                    end
                    % get average saccades per task across runs
                    for c=1:30, % loop over task conditions
                        Q.avgSacc=round(mean(Rr.numSacc(Rr.num==c)));
                        Q.taskName=condNames(c);
                        Q.condNum=c;
                        R=addstruct(R,Q);
                    end
                    save(fullfile(eyeDir,subj_name{sn(s)},'glm4_saccades.mat'),'R');
                otherwise
                    disp('case does not exist')
            end
            fprintf('%s saved for %s \n',step,subj_name{sn(s)})
        end
    case 'process_physio'               % STEP 1.2: enter subjNum
        % Read raw physio and make regressors for both sessions
        sn=varargin{1};
        T=[];P=[];
        for ss=1:2, % number of sessions
            physioRawDir=[dicomDir,'/',sprintf('%s_%d',subj_name{sn},ss),'/physio'];
            fnameInfo = dir(fullfile(physioRawDir,'*info*'));
            fnameInfo = {fnameInfo.name};
            pS=physio_readPrisma(fnameInfo,numDummys);
            T=horzcat(T,pS);
            t=physio_getCardiacPrisma(pS); % fig,'1'
            P=horzcat(P,t);
        end
        dircheck(fullfile(physioDir,subj_name{sn}));
        save(fullfile(physioDir,subj_name{sn},'physioReg.mat'),'P');
        save(fullfile(physioDir,subj_name{sn},'physioData.mat'),'T');
        
    case 'process_raw'
        sn=varargin{1};
        sessN=varargin{2};
        
        sc1_imana('func_dicom_import',sn,sessN)
        sc1_imana('anat_dicom_import',sn,sessN)
        sc1_imana('reslice_LPI',sn)
    case 'func_dicom_import'            % STEP 2.1: enter subjNum and sessNum
        % converts dicom to nifti files w/ spm_dicom_convert
        % example: sc1_imana('func_dicom_import',1,1)
        s=varargin{1}; % subjNum
        sessN=varargin{2}; % sessNum
        
        dircheck(fullfile(dicomDir,[subj_name{s},sprintf('_%d',sessN)]));
        cd(fullfile(dicomDir,[subj_name{s},sprintf('_%d',sessN)]));
        
        if sessN==1,
            ss=(s*2)-1;
        else
            ss=(s*2);
        end
        for i=1:length(fscanNum{ss})
            r=fscanNum{ss}(i);
            DIR=dir(sprintf('%s.%4.4d.*.IMA',DicomName{ss},r));              % Get DICOM FILE NAMES
            Names=vertcat(DIR.name);
            if (~isempty(Names))
                HDR=spm_dicom_headers(Names,1);                             % Load dicom headers
                dirname{r}=sprintf('series%2.2d',r);
                if (~exist(dirname{r}))
                    mkdir(dirname{r});                                      % make dir for series{r} for .nii file output
                end;
                dircheck(fullfile(dicomDir,[subj_name{s},sprintf('_%d',sessN)],dirname{r}));
                cd(fullfile(dicomDir,[subj_name{s},sprintf('_%d',sessN)],dirname{r}));
                
                spm_dicom_convert(HDR,'all','flat','nii');                  % Convert the data to nifti
                cd ..
            end;
            display(sprintf('Series %d done \n',fscanNum{ss}(i)))
        end;
        fprintf('Functional runs have been imported. Be sure to copy the unique .nii name for subj files and place into section (4).\n')
    case 'anat_dicom_import'            % STEP 2.2: enter subjNum and sessNum
        % converts dicom to nifti files w/ spm_dicom_convert
        % example: sc1_imana('func_dicom_import',1,1)
        s=varargin{1}; % subjNum
        sessN=varargin{2}; % sessNum (anatomical always collected in sess 1)
        
        dircheck(fullfile(dicomDir,[subj_name{s},sprintf('_%d',sessN)]));
        cd(fullfile(dicomDir,[subj_name{s},sprintf('_%d',sessN)]));
        
        for i=1:length(anatNum{s})
            r=anatNum{s}(i);
            if sessN==1,
                ss=(s*2)-1;
            else
                ss=(s*2);
            end
            DIR=dir(sprintf('%s.%4.4d.*.IMA',DicomName{ss},r)); % Get DICOM FILE NAMES
            Names=vertcat(DIR.name);
            if (~isempty(Names))
                HDR=spm_dicom_headers(Names,1);  % Load dicom headers
                dirname{r}=sprintf('series%2.2d',r);
                if (~exist(dirname{r}))
                    mkdir(dirname{r}); %make dir for series{r} for .nii file output
                end;
                dircheck(fullfile(dicomDir,[subj_name{s},sprintf('_%d',sessN)],dirname{r}));
                cd(fullfile(dicomDir,[subj_name{s},sprintf('_%d',sessN)],dirname{r}));
                spm_dicom_convert(HDR,'all','flat','nii');%,dirname{r});  % Convert the data to nifti
                cd ..
            end;
            fprintf('Series %d done \n',anatNum{s}(i))
        end;
        fprintf('Anatomical runs have been imported. Please locate the anatomical img and move to the anatomical folder.\n')
        
        % MAKE SURE TO FIND ANATOMICAL AFTER THIS STEP AND MOVE TO FOLDER
        % Rename to 'anatomical_raw
    case 'T2_dicom_import'              % STEP 2.3: enter subjNum and sessNum
        % converts dicom to nifti files w/ spm_dicom_convert
        % example: sc1_imana('func_dicom_import',1,1)
        s=varargin{1}; % subjNum
        sessN=varargin{2}; % sessNum (anatomical always collected in sess 1)
        
        dircheck(fullfile(dicomDir,[subj_name{s},sprintf('_%d',sessN)]));
        cd(fullfile(dicomDir,[subj_name{s},sprintf('_%d',sessN)]));
        
        for i=1:length(T2Num{s})
            r=T2Num{s}(i);
            if sessN==1,
                ss=(s*2)-1;
            else
                ss=(s*2);
            end
            DIR=dir(sprintf('%s.%4.4d.*.IMA',DicomName{ss},r)); % Get DICOM FILE NAMES
            Names=vertcat(DIR.name);
            if (~isempty(Names))
                HDR=spm_dicom_headers(Names,1);  % Load dicom headers
                dirname{r}=sprintf('series%2.2d',r);
                if (~exist(dirname{r}))
                    mkdir(dirname{r}); %make dir for series{r} for .nii file output
                end;
                dircheck(fullfile(dicomDir,[subj_name{s},sprintf('_%d',sessN)],dirname{r}));
                cd(fullfile(dicomDir,[subj_name{s},sprintf('_%d',sessN)],dirname{r}));
                spm_dicom_convert(HDR,'all','flat','nii');%,dirname{r});  % Convert the data to nifti
                cd ..
            end;
            fprintf('Series %d done \n',T2Num{s}(i))
        end;
        fprintf('T2 image has been imported. Please locate the T2 img and move to the anatomical folder.\n')
        
        % MAKE SURE TO FIND TW AFTER THIS STEP AND MOVE TO FOLDER
        % Rename to 'T2_raw
    case 'reslice_LPI'                  % STEP 3.1: Reslice anatomical image within LPI coordinate systems
        s  = varargin{1}; % subjNum
        % example: sc1_imana('reslice_LPI',1)
        
        % (1) Reslice anatomical image to set it within LPI co-ordinate frames
        source  = fullfile(anatomicalDir,subj_name{s},['anatomical_raw','.nii']);
        dest    = fullfile(anatomicalDir,subj_name{s},['anatomical','.nii']);
        spmj_reslice_LPI(source,'name', dest);
        
        % (2) In the resliced image, set translation to zero
        V               = spm_vol(dest);
        dat             = spm_read_vols(V);
        V.mat(1:3,4)    = [0 0 0];
        spm_write_vol(V,dat);
        display 'Manually retrieve the location of the anterior commissure (x,y,z) before continuing'
        
    case 'process_anatomical'           % STEP 3.1-9: Run all anatomical steps. Runs for ~8 hours
        % need to have anat_dicom_import done prior to this step.
        s=varargin{1};
        sc1_imana('centre_AC',s);
        %         sc1_imana('segmentation',s);
        sc1_imana('process_surf',s);
        %         sc1_imana('suit_isolate_segment',s);
    case 'resample_anat'                % (optional): Change voxel dimensions
        sn=varargin{1};
        % example: sc1_imana('resample_anat',1)
        factor = .75; % change according to preferred voxel dim
        anat_orig = fullfile(anatomicalDir,subj_name{sn},'anatomical_raw.nii');
        filename = fullfile(anatomicalDir,subj_name{sn},'anatomical_raw.nii');
        spmj_resample(anat_orig,filename,factor)
    case 'centre_AC'                    % STEP 3.1: Re-centre AC
        % Set origin of anatomical to anterior commissure (must provide
        % coordinates in section (4)).
        % example: sc1_imana('centre_AC',1)
        s      = varargin{1}; % subjNum
        
        img    = fullfile(anatomicalDir,subj_name{s},['anatomical','.nii']);
        V               = spm_vol(img);
        dat             = spm_read_vols(V);
        V.mat(1:3,4)    = loc_AC{s};
        spm_write_vol(V,dat);
        display 'Done'
    case 'segmentation'                 % STEP 3.2: Segmentation + Normalisation
        % example: sc1_imana('segmentation',1)
        s=varargin{1}; % subjNum
        
        SPMhome=fileparts(which('spm.m'));
        J=[];
        for s=s
            J.channel.vols = {fullfile(anatomicalDir,subj_name{s},'anatomical.nii,1')};
            J.channel.biasreg = 0.001;
            J.channel.biasfwhm = 60;
            J.channel.write = [0 0];
            J.tissue(1).tpm = {fullfile(SPMhome,'tpm/TPM.nii,1')};
            J.tissue(1).ngaus = 1;
            J.tissue(1).native = [1 0];
            J.tissue(1).warped = [0 0];
            J.tissue(2).tpm = {fullfile(SPMhome,'tpm/TPM.nii,2')};
            J.tissue(2).ngaus = 1;
            J.tissue(2).native = [1 0];
            J.tissue(2).warped = [0 0];
            J.tissue(3).tpm = {fullfile(SPMhome,'tpm/TPM.nii,3')};
            J.tissue(3).ngaus = 2;
            J.tissue(3).native = [1 0];
            J.tissue(3).warped = [0 0];
            J.tissue(4).tpm = {fullfile(SPMhome,'tpm/TPM.nii,4')};
            J.tissue(4).ngaus = 3;
            J.tissue(4).native = [1 0];
            J.tissue(4).warped = [0 0];
            J.tissue(5).tpm = {fullfile(SPMhome,'tpm/TPM.nii,5')};
            J.tissue(5).ngaus = 4;
            J.tissue(5).native = [1 0];
            J.tissue(5).warped = [0 0];
            J.tissue(6).tpm = {fullfile(SPMhome,'tpm/TPM.nii,6')};
            J.tissue(6).ngaus = 2;
            J.tissue(6).native = [0 0];
            J.tissue(6).warped = [0 0];
            J.warp.mrf = 1;
            J.warp.cleanup = 1;
            J.warp.reg = [0 0.001 0.5 0.05 0.2];
            J.warp.affreg = 'mni';
            J.warp.fwhm = 0;
            J.warp.samp = 3;
            J.warp.write = [1 1];
            matlabbatch{1}.spm.spatial.preproc=J;
            spm_jobman('run',matlabbatch);
            fprintf('Check segmentation results for %s\n', subj_name{s})
        end;
    case 'process_surf'                 % STEP 3.3-3.6: enter sn - runs all surface constructions (freesurfer + caret format transformation)
        s = varargin{1};
        sc1_imana('surf_freesurfer',s);
        sc1_imana('surf_xhemireg',s);
        sc1_imana('surf_map_ico',s);
        sc1_imana('surf_make_caret',s);
    case 'surf_freesurfer'              % STEP 3.3: Calls recon_all
        % Calls recon-all, which performs, all of the
        % FreeSurfer cortical reconstruction process
        % example: sc1_imana('surf_freesurfer',1)
        s=varargin{1}; % subjNum
        
        for i=s
            freesurfer_reconall(freesurferDir,subj_name{i},fullfile(anatomicalDir,subj_name{s},['anatomical.nii']));
        end
    case 'surf_xhemireg'                % STEP 3.4: cross-register surfaces left / right hem
        % surface-based interhemispheric registration
        % example: sc1_imana('surf_xhemireg',1)
        s=varargin{1}; % subjNum
        
        for i=s
            freesurfer_registerXhem({subj_name{i}},freesurferDir,'hemisphere',[1 2]); % For debug... [1 2] orig
        end;
    case 'surf_map_ico'                 % STEP 3.5: Align to the new atlas surface (map icosahedron)
        % Resampels a registered subject surface to a regular isocahedron
        % This allows things to happen in atlas space - each vertex number
        % corresponds exactly to an anatomical location
        % Makes a new folder, called ['x' subj] that contains the remapped subject
        % Uses function mri_surf2surf
        % mri_surf2surf: resamples one cortical surface onto another
        % example: sc1_imana('surf_map_ico',1)
        s=varargin{1}; % subjNum
        
        for i=s
            freesurfer_mapicosahedron_xhem(subj_name{i},freesurferDir,'smoothing',1,'hemisphere',[1:2]);
        end;
    case 'surf_make_caret'              % STEP 3.6: Translate into caret format
        % Imports a surface reconstruction from Freesurfer automatically into Caret
        % Makes a new spec file and moves the coord-files to respond to World,
        % rather than to RAS_tkreg coordinates.
        % example: sc1_imana('surf_make_caret',1)
        s=varargin{1}; % subjNum
        
        for i=s
            caret_importfreesurfer(['x' subj_name{i}],freesurferDir,caretDir);
        end;
    case 'suit_isolate_segment'         % STEP 3.8: Segment cerebellum into grey and white matter
        sn=varargin{1};
        %         spm fmri
        for s=sn,
            suitSubjDir = fullfile(suitDir,'anatomicals',subj_name{s});dircheck(suitSubjDir);
            source=fullfile(anatomicalDir,subj_name{s},'anatomical.nii');
            dest=fullfile(suitSubjDir,'anatomical.nii');
            copyfile(source,dest);
            cd(fullfile(suitSubjDir));
            suit_isolate_seg({fullfile(suitSubjDir,'anatomical.nii')},'keeptempfiles',1);
        end
        
    case 'process_functional'           % STEP 4.1-4:Run all functional steps
        s=varargin{1};
        sc1_imana('make_4dNifti',s,1);
        sc1_imana('make_4dNifti',s,2);
        sc1_imana('realign',s,'both');
        sc1_imana('move_data',s,'both');
    case 'make_4dNifti'                 % STEP 4.2:  Make 4dNifti
        % merges nifti files for each image into a 4-d nifti (time is 4th
        % dimension) w/ spm_file_merge
        % example: sc1_imana('make_4dNifti',1,1)
        s=varargin{1}; % subjNum
        sn=varargin{2}; % sessNum
        
        dircheck(fullfile(imagingDirRaw,subj_name{s}));
        if sn==1,
            runs=[1:8];
            ss=(s*2)-1;
        else runs=[9:16];
            ss=(s*2);
        end
        for i=1:length(fscanNum{ss}),  % run number
            outfilename = fullfile(imagingDirRaw,subj_name{s},sprintf('run_%2.2d.nii',runs(i)));
            for j=1:numTRs-numDummys    % doesn't include dummy scans in .nii file
                P{j}=fullfile(dicomDir,[subj_name{s},sprintf('_%d',sn)],sprintf('series%2.2d',fscanNum{ss}(i)),...
                    sprintf('f%s-%4.4d-%5.5d-%6.6d-01.nii',NiiRawName{ss},fscanNum{ss}(i),j+numDummys,j+numDummys));
            end;
            spm_file_merge(char(P),outfilename);
            fprintf('Run %d done\n',runs(i));
        end;
    case 'realign'                      % STEP 4.3:  Realign functional images (both sessions)
        % SPM realigns first volume in each run to first volume of first
        % run, and then registers each image in that run to the first
        % volume of that run. Hence also why it's often better to run
        % anatomical before functional scans.
        
        % SPM does this with 4x4 affine transformation matrix in nifti
        % header (see function 'coords'). These matrices convert from voxel
        % space to world space(mm). If the first image has an affine
        % transformation matrix M1, and image two has one (M2), the mapping
        % from 1 to 2 is: M2/M1 (map image 1 to world space-mm - and then
        % mm to voxel space of image 2).
        
        % Registration determines the 6 parameters that determine the rigid
        % body transformation for each image (described above). Reslice
        % conducts these transformations; resampling each image according
        % to the transformation parameters. This is for functional only!
        % example: sc1_imana('realign',1,'both')
        
        s=varargin{1}; %subjNum
        sn=varargin{2}; % input: 'one' or 'both' (sessions)
        
        cd(fullfile(imagingDirRaw,subj_name{s}));
        spm_jobman % run this step first
        
        if strcmp(sn,'first'),
            runs=[1:8];
        elseif strcmp(sn,'both'),
            runs=[1:16];
        end
        
        data={};
        for i = 1:length(runs),
            for j=1:numTRs-numDummys;
                data{i}{j,1}=sprintf('run_%2.2d.nii,%d',runs(i),j);
            end;
        end;
        spmj_realign(data);
        fprintf('%s session realigned for %s\n',sn,subj_name{s});
    case 'move_data'                    % STEP 4.4:  Move realigned data
        % Moves image data from imaging_dicom_raw into a "working dir":
        % imaging_dicom.
        % example: sc1_imana('move_data',1,'both')
        s=varargin{1}; % subjNum
        sn=varargin{2}; % input: 'one' or 'both' (sessions)
        
        if strcmp(sn,'one'),
            runs=[1:8];
        else
            runs=[1:16];
        end
        
        dircheck(fullfile(baseDir, 'imaging_data',subj_name{s}))
        for r=1:numel(runs);
            % move realigned data for each run
            source = fullfile(baseDir, 'imaging_data_raw', subj_name{s}, sprintf('rrun_%2.2d.nii',runs(r)));
            dest = fullfile(baseDir, 'imaging_data', subj_name{s}, sprintf('rrun_%2.2d.nii',runs(r)));
            copyfile(source,dest);
            
            % move realignment parameter files for each run
            source = fullfile(baseDir, 'imaging_data_raw', subj_name{s},sprintf('rp_run_%2.2d.txt',runs(r)));
            dest = fullfile(baseDir, 'imaging_data',subj_name{s}, sprintf('rp_run_%2.2d.txt',runs(r)));
            
            copyfile(source,dest);
        end;
        % move mean_epis
        source = fullfile(baseDir, 'imaging_data_raw',subj_name{s},'meanrun_01.nii');
        dest = fullfile(baseDir, 'imaging_data',subj_name{s},'meanepi.nii');
        
        copyfile(source,dest);
        
    case 'coreg'                        % STEP 5: Adjust meanepi to anatomical image REQUIRES USER INPUT
        % (1) Manually seed the functional/anatomical registration
        % - Do "coregtool" on the matlab command window
        % - Select anatomical image and meanepi image to overlay
        % - Manually adjust meanepi image and save result as rmeanepi
        %   image
        % example: sc1_imana('coreg',1)
        s = varargin{1};% subjNum
        
        cd(fullfile(anatomicalDir,subj_name{s}));
        %                 coregtool;
        %                 keyboard();
        
        % (2) Automatically co-register functional and anatomical images
        J.ref = {fullfile(anatomicalDir,subj_name{s},['anatomical.nii'])};
        J.source = {fullfile(imagingDir,subj_name{s},['rmeanepi.nii'])};
        J.other = {''};
        J.eoptions.cost_fun = 'nmi';
        J.eoptions.sep = [4 2];
        J.eoptions.tol = [0.02 0.02 0.02 0.001 0.001 0.001 0.01 0.01 0.01 0.001 0.001 0.001];
        J.eoptions.fwhm = [7 7];
        matlabbatch{1}.spm.spatial.coreg.estimate=J;
        spm_jobman('run',matlabbatch);
        
        % (3) Manually check again
        coregtool;
        keyboard();
        
        % NOTE:
        % Overwrites meanepi, unless you update in step one, which saves it
        % as rmeanepi.
        % Each time you click "update" in coregtool, it saves current
        % alignment by appending the prefix 'r' to the current file
        % So if you continually update rmeanepi, you'll end up with a file
        % called r...rrrmeanepi.
        
    case 'preprocess_2'                 % STEP 6.1-2: Run AFTER COREG - REQUIRES USER INPUT
        sn = varargin{1};
        sc1_imana('make_samealign',sn,'both');
        sc1_imana('make_maskImage',sn);
        %             display('Run spmj_checksamealign to check alignment of run_epi to rmean_epi')
    case 'make_samealign'               % STEP 6.1: Align functional images to rmeanepi
        % Aligns all functional images to rmeanepi
        % example: sc1_imana('make_samealign',1,'both')
        prefix='r';
        s=varargin{1}; % subjNum
        sn=varargin{2}; % input: 'one' or 'both' (session)
        
        if strcmp(sn,'one'),
            runs=[1:8];
        else
            runs=[1:16];
        end
        
        cd(fullfile(imagingDir,subj_name{s}));
        
        % Select image for reference
        P{1} = fullfile(imagingDir,subj_name{s},'rmeanepi.nii');
        
        % Select images to be realigned
        Q={};
        for r=1:numel(runs)
            for i=1:numTRs-numDummys;
                Q{end+1}    = fullfile(imagingDir, subj_name{s},...
                    sprintf('%srun_%2.2d.nii,%d',prefix,runs(r),i));
            end;
        end;
        
        % Run spmj_makesamealign_nifti
        spmj_makesamealign_nifti(char(P),char(Q));
        
        %spmj_checksamealign
    case 'make_maskImage'               % STEP 6.2: Make mask images (noskull and grey_only)
        % Make maskImage meanepi
        % example: sc1_imana('make_maskImage',1)
        s  = varargin{1}; % subjNum
        
        for s=s
            cd(fullfile(imagingDir,subj_name{s}));
            
            nam{1}  = fullfile(imagingDir,subj_name{s}, 'rmeanepi.nii');
            nam{2}  = fullfile(anatomicalDir, subj_name{s}, 'c1anatomical.nii');
            nam{3}  = fullfile(anatomicalDir, subj_name{s}, 'c2anatomical.nii');
            nam{4}  = fullfile(anatomicalDir, subj_name{s}, 'c3anatomical.nii');
            spm_imcalc(nam, 'rmask_noskull.nii', 'i1>1 & (i2+i3+i4)>0.2')
            
            nam={};
            nam{1}  = fullfile(imagingDir,subj_name{s}, 'rmeanepi.nii');
            nam{2}  = fullfile(anatomicalDir, subj_name{s}, 'c1anatomical.nii');
            spm_imcalc(nam, 'rmask_gray.nii', 'i1>2 & i2>0.4')
            
            nam={};
            nam{1}  = fullfile(imagingDir,subj_name{s}, 'rmeanepi.nii');
            nam{2}  = fullfile(anatomicalDir, subj_name{s}, 'c1anatomical.nii');
            nam{3}  = fullfile(anatomicalDir, subj_name{s}, 'c5anatomical.nii');
            spm_imcalc(nam, 'rmask_grayEyes.nii', 'i1>2400 & i2+i3>0.4')
            
            nam={};
            nam{1}  = fullfile(imagingDir,subj_name{s}, 'rmeanepi.nii');
            nam{2}  = fullfile(anatomicalDir, subj_name{s}, 'c5anatomical.nii');
            nam{3}  = fullfile(anatomicalDir, subj_name{s}, 'c1anatomical.nii');
            nam{4}  = fullfile(anatomicalDir, subj_name{s}, 'c2anatomical.nii');
            nam{5}  = fullfile(anatomicalDir, subj_name{s}, 'c3anatomical.nii');
            spm_imcalc(nam, 'rmask_noskullEyes.nii', 'i1>2000 & (i2+i3+i4+i5)>0.2')
        end
        
    case 'run_postProcessing'           % For new subjects - run the following steps
        sn=varargin{1};
        
        sc1_imana('process_glm',sn,4,'conditions_vs_rest')
        sc1_imana('process_suit',sn,4)
        sc1_imana('process_ROI',sn,4,'cortical_lobes')
        sc1_imana('process_ROI',sn,4,'yeo')
        sc1_imana('process_ROI',sn,4,'yeo_hem')
        sc1_imana('process_ROI',sn,4,'desikan')
        sc1_imana('process_ROI',sn,4,'desikan_hem')
        sc1_imana('process_ROI',sn,4,'cerebellum')
        sc1_imana('process_ROI',sn,4,'cerebellum_grey')
        sc1_imana('process_ROI',sn,4,'162_tessellation')
        sc1_imana('process_ROI',sn,4,'162_tessellation_hem')
        sc1_imana('process_ROI',sn,4,'dentate')
        sc1_imana('process_surface',sn,4,'cortex','con')
        sc1_imana('process_surface',sn,4,'cereb','con')
        sc1_imana('prepare_encoding_data',sn,4,{'cortical_lobes','yeo','yeo_hem','desikan','desikan_hem','162_tessellation','162_tessellation_hem'})
    case 'process_glm'                  % STEP 7.1a-h -7.5: Makes and runs glms. ~ 70 min per glm
        % 'make_glm' - 'spm_rwls_run_fmri_spec' function - sets up GLM
        % 'estimate_glm' - 'spm_rwls_spm' function - estimates GLM
        sn=varargin{1};
        glm=varargin{2};
        type=varargin{3};
        
        for s=sn,
            for g=glm,
                if g==4,
                    sc1_imana('make_glm4',s)
                elseif g==13,
                    sc1_imana('make_glm13',s)
                elseif g==5,
                    sc1_imana('make_glm5',s)
                elseif g==6,
                    sc1_imana('make_glm6',s)
                end
                sc1_imana('estimate_glm',s,g)
                sc1_imana('contrast',s,g,type)
            end
        end
    case 'make_glm4'                    % STEP 7.2c: FAST glm w/out hpf (complex:rest as baseline) - model one instruct period
        % GLM with FAST and no high pass filtering
        % 'spm_get_defaults' code modified to allow for -v7.3 switch (to save
        % >2MB FAST GLM struct)
        % Be aware: this switch (from -v6 to -v7.3) slows down the code!
        sn=varargin{1};
        prefix='r';
        announceTime=5;
        VS_trials = [4;8;12];
        glm=4;
        
        for s=sn,
            T=[];
            A = dload(fullfile(baseDir, 'data', subj_name{s},['sc1_',subj_name{s},'.dat']));
            A = getrow(A,A.runNum>=funcRunNum(1) & A.runNum<=funcRunNum(2));
            
            glmSubjDir =[baseDir sprintf('/GLM_firstlevel_%d/',glm),subj_name{s}];dircheck(glmSubjDir);
            
            J.dir = {glmSubjDir};
            J.timing.units = 'secs';
            J.timing.RT = 1.0;
            J.timing.fmri_t = 16;
            J.timing.fmri_t0 = 1;
            
            % annoying but reorder behavioural runs slightly for 2
            % subjects...
            if strcmp(subj_name{s},'s18')
                runB = [51,52,53,54,55,56,57,58,59,61,62,63,64,65,66,60];
            elseif strcmp(subj_name{s},'s21'),
                runB = [51,52,53,54,55,56,57,58,59,60,61,63,64,65,66,62];
            end
            
            for r=1:numel(run)                                              % loop through runs
                P=getrow(A,A.runNum==runB(r));
                for i=1:(numTRs-numDummys)
                    N{i} = [fullfile(baseDir, 'imaging_data',subj_name{s},[prefix 'run_',run{r},'.nii,',num2str(i)])];
                end;
                J.sess(r).scans= N;                                    % number of scans in run
                
                % Get 'announce' regressor (for all tasks)
                J.sess(r).cond(1).name = sprintf('allTasks-%s','announce');
                J.sess(r).cond(1).onset = [P.realStartTime-J.timing.RT*numDummys];    % correct start time for numDummys removed and convert to seconds
                J.sess(r).cond(1).duration = announceTime;             % durations of task we are modeling
                J.sess(r).cond(1).tmod = 0;
                J.sess(r).cond(1).orth = 0;
                J.sess(r).cond(1).pmod = struct('name', {}, 'param', {}, 'poly', {});
                S.SN    = s;
                S.run   = r;
                S.task  = 0;
                S.cond  = 1;
                S.TN    = {'instructions'};
                S.sess  = sess(r);
                S.leftHand = 0;
                S.rightHand = 0;
                T=addstruct(T,S);
                
                indx=2;
                for task=1:numel(taskNames)-1, % not modelling rest
                    D=dload(fullfile(baseDir, 'data', subj_name{s},['sc1_',subj_name{s},'_',taskNames{task},'.dat']));
                    R=getrow(D,D.runNum==runB(r)); % functional runs
                    trialType=1:numRegress{glm}(task);
                    for regs=trialType, % loop through trial-types (ex. congruent and incongruent)
                        
                        % Determine number of presses per hand
                        % TOO MANY IF STATEMENTS - CLEAN UP!!!
                        if isfield(R,'hand'),
                            if R.hand(1)==1, % left hand
                                if isfield(R,'trialType'),
                                    leftHand =  sum(R.respMade(R.trialType==regs));
                                else
                                    leftHand=sum(R.respMade);
                                end
                                rightHand= 0;
                            elseif R.hand(1)==2, % right hand
                                if isfield(R,'trialType'),
                                    rightHand = sum(R.respMade(R.trialType==regs));
                                else
                                    rightHand=sum(R.respMade);
                                end
                                leftHand  = 0;
                            elseif R.hand(1)==0, % bimanual
                                leftHand= (sum(R.respMade(R.trialType==regs)))/2;
                                rightHand=(sum(R.respMade(R.trialType==regs)))/2;
                            end
                        else
                            leftHand=0;
                            rightHand=0;
                        end
                        % Determine trialType
                        if strcmp(taskNames{task},'visualSearch'),
                            % (1)
                            tt=(R.setSize==VS_trials(regs));
                            % (2)
                        elseif strcmp(taskNames{task},'motorImagery') || strcmp(taskNames{task},'spatialNavigation') || strcmp(taskNames{task},'intervalTiming') || strcmp(taskNames{task},'ToM') || strcmp(taskNames{task},'checkerBoard'),
                            tt=1;
                            % (3)
                        elseif strcmp(taskNames{task},'nBack') || strcmp(taskNames{task},'nBackPic')
                            conditions=[0;1];
                            tt=(R.respMade==conditions(regs));
                        else
                            % (4)
                            tt=(R.trialType==regs);
                        end
                        % Determine duration
                        if strcmp(taskNames{task},'actionObservation')
                            duration=15;
                        elseif strcmp(taskNames{task},'ToM') || strcmp(taskNames{task},'intervalTiming') || strcmp(taskNames{task},'checkerBoard'),
                            duration=30;
                        else
                            duration=unique(ceil(R.trialDur(tt)));
                        end
                        
                        cond=contrasts{task}{regs};
                        ST = find(strcmp(P.taskName,taskNames{task}));
                        condName = sprintf('%s-%s',char(R.taskName(1)),cond);
                        % loop through trial-types (ex. congruent or incongruent)
                        J.sess(r).cond(indx).name = condName;
                        J.sess(r).cond(indx).onset = [P.realStartTime(ST)+R.startTimeReal(tt)+announceTime-(J.timing.RT*numDummys)]; % correct start time for numDummys and announcetime included
                        J.sess(r).cond(indx).duration = duration;  % duration of trials (+ fixation cross) we are modeling
                        J.sess(r).cond(indx).tmod = 0;
                        J.sess(r).cond(indx).orth = 0;
                        J.sess(r).cond(indx).pmod = struct('name', {}, 'param', {}, 'poly', {});
                        S.SN    = s;
                        S.run   = r;
                        S.task  = task;
                        S.cond  = indx;
                        S.TN    = {condName};
                        S.sess  = sess(r);
                        S.leftHand  = leftHand;
                        S.rightHand = rightHand;
                        T=addstruct(T,S);
                        indx=indx+1;
                    end
                end
                J.sess(r).multi = {''};
                J.sess(r).regress = struct('name', {}, 'val', {});
                J.sess(r).multi_reg = {''};
                J.sess(r).hpf = inf;                                        % set to 'inf' if using J.cvi = 'FAST'. SPM HPF not applied
            end
            J.fact = struct('name', {}, 'levels', {});
            J.bases.hrf.derivs = [0 0];
            J.bases.hrf.params = [4.5 11];                                  % set to [] if running wls
            J.volt = 1;
            J.global = 'None';
            J.mask = {fullfile(baseDir, 'imaging_data',subj_name{s},'rmask_noskull.nii,1')};
            J.mthresh = 0.05;
            J.cvi_mask = {fullfile(baseDir, 'imaging_data',subj_name{s},'rmask_gray.nii')};
            J.cvi =  'fast';
            
            spm_rwls_run_fmri_spec(J);
            
            save(fullfile(J.dir{1},'SPM_info.mat'),'-struct','T');
            fprintf('glm_%d has been saved for %s \n',glm, subj_name{s});
        end
    case 'make_glm13'                   % STEP 7.2l: FAST glm w/out hpf (simple:rest as baseline) - model one instruction regressor
        s=varargin{1};
        
        prefix='r';
        dur=30;                                                              % secs (length of task dur, not trial dur)
        announcetime=5;                                                     % length of task announce time                                                    % length of task announce time
        for s=s,
            T=[];
            glmSubjDir =[baseDir '/GLM_firstlevel_13/' subj_name{s}];dircheck(glmSubjDir);
            
            D=dload(fullfile(baseDir, 'data', subj_name{s},['sc1_',subj_name{s},'.dat']));
            D = getrow(D,D.runNum>=funcRunNum(1) & D.runNum<=funcRunNum(2)); % Get imaging behavioural data
            
            J.dir = {glmSubjDir};
            J.timing.units = 'secs';
            J.timing.RT = 1.0;
            J.timing.fmri_t = 16;
            J.timing.fmri_t0 = 1;
            
            for r=1:numel(run)                                              % loop through runs
                R=getrow(D,D.runNum==runB(r));
                for i=1:(numTRs-numDummys)
                    N{i} = [fullfile(baseDir, 'imaging_data',subj_name{s},[prefix 'run_',run{r},'.nii,',num2str(i)])];
                end;
                J.sess(r).scans= N;                                         % number of scans in run
                
                % Get 'announce' regressor (for all tasks)
                J.sess(r).cond(1).name = sprintf('allTasks-%s','announce');
                J.sess(r).cond(1).onset = R.realStartTime-J.timing.RT*numDummys;    % correct start time for numDummys removed and convert to seconds
                J.sess(r).cond(1).duration = announcetime;             % durations of task we are modeling
                J.sess(r).cond(1).tmod = 0;
                J.sess(r).cond(1).orth = 0;
                J.sess(r).cond(1).pmod = struct('name', {}, 'param', {}, 'poly', {});
                S.SN    = s;
                S.run   = r;
                S.task  = 0;
                S.cond  = 1;
                S.type  = 1; % instructions
                S.TN    = {sprintf('allTasks-%s','announce')};
                S.sess  = sess(r);
                T=addstruct(T,S);
                
                % Get 'execution' regressors
                for cond=1:length(taskNumbers)-1;
                    % loop through tasks
                    idx=find(strcmp(R.taskName,taskNames{cond}));                                       % find indx of all trials in run of that condition (should be 17)
                    J.sess(r).cond(cond+1).name = sprintf('%s-%s',char(R.taskName(idx(1))),'execution');
                    J.sess(r).cond(cond+1).onset = R.realStartTime(idx)+announcetime-(J.timing.RT*numDummys);    % correct start time for numDummys removed and convert to seconds
                    J.sess(r).cond(cond+1).duration = dur;                       % durations of task we are modeling
                    J.sess(r).cond(cond+1).tmod = 0;
                    J.sess(r).cond(cond+1).orth = 0;
                    J.sess(r).cond(cond+1).pmod = struct('name', {}, 'param', {}, 'poly', {});
                    S.SN    = s;
                    S.run   = r;
                    S.task  = cond;
                    S.cond  = cond+1;
                    S.type  = 2;   % execution
                    S.TN    = {sprintf('%s-%s',char(R.taskName(idx(1))),'execution')};
                    S.sess  = sess(r);
                    T=addstruct(T,S);
                end;
                
                J.sess(r).multi = {''};
                J.sess(r).regress = struct('name', {}, 'val', {});
                J.sess(r).multi_reg = {''};
                J.sess(r).hpf = inf;                                        % set to 'inf' if using J.cvi = 'FAST'. SPM HPF not applied
            end;
            J.fact = struct('name', {}, 'levels', {});
            J.bases.hrf.derivs = [0 0];
            J.bases.hrf.params = [4.5 11];                                  % set to [] if running wls
            J.volt = 1;
            J.global = 'None';
            J.mask = {fullfile(baseDir, 'imaging_data',subj_name{s},'rmask_noskull.nii,1')};
            J.mthresh = 0.05;
            J.cvi_mask = {fullfile(baseDir, 'imaging_data',subj_name{s},'rmask_gray.nii')};
            J.cvi =  'fast';
            
            spm_rwls_run_fmri_spec(J);
            
            save(fullfile(J.dir{1},'SPM_info.mat'),'-struct','T');
            fprintf('glm_13 has been saved for %s \n',subj_name{s});
        end
    case 'make_glm5'                    % STEP 7.2d: FAST glm w/out hpf (complex: rest as baseline) - model one instruct period - nonaggr!
        % GLM with FAST and no high pass filtering
        % 'spm_get_defaults' code modified to allow for -v7.3 switch (to save
        % >2MB FAST GLM struct)
        % Be aware: this switch (from -v6 to -v7.3) slows down the code!
        sn=varargin{1};
        prefix='r';
        announceTime=5;
        VS_trials = [4;8;12];
        glm=5;
        
        for s=sn,
            T=[];
            A = dload(fullfile(baseDir, 'data', subj_name{s},['sc1_',subj_name{s},'.dat']));
            A = getrow(A,A.runNum>=funcRunNum(1) & A.runNum<=funcRunNum(2));
            
            glmSubjDir =[baseDir sprintf('/GLM_firstlevel_%d/',glm),subj_name{s}];dircheck(glmSubjDir);
            
            J.dir = {glmSubjDir};
            J.timing.units = 'secs';
            J.timing.RT = 1.0;
            J.timing.fmri_t = 16;
            J.timing.fmri_t0 = 1;
            
            % annoying but reorder behavioural runs slightly for 2
            % subjects...
            if strcmp(subj_name{s},'s18')
                runB = [51,52,53,54,55,56,57,58,59,61,62,63,64,65,66,60];
            elseif strcmp(subj_name{s},'s21'),
                runB = [51,52,53,54,55,56,57,58,59,60,61,63,64,65,66,62];
            end
            
            for r=1:numel(run)                                              % loop through runs
                P=getrow(A,A.runNum==runB(r));
                for i=1:(numTRs-numDummys)
                    N{i} = [fullfile(baseDir, 'imaging_data_nonaggr',subj_name{s},[prefix 'run_',run{r},'.nii,',num2str(i)])];
                end;
                J.sess(r).scans= N;                                    % number of scans in run
                
                % Get 'announce' regressor (for all tasks)
                J.sess(r).cond(1).name = sprintf('allTasks-%s','announce');
                J.sess(r).cond(1).onset = [P.realStartTime-J.timing.RT*numDummys];    % correct start time for numDummys removed and convert to seconds
                J.sess(r).cond(1).duration = announceTime;             % durations of task we are modeling
                J.sess(r).cond(1).tmod = 0;
                J.sess(r).cond(1).orth = 0;
                J.sess(r).cond(1).pmod = struct('name', {}, 'param', {}, 'poly', {});
                S.SN    = s;
                S.run   = r;
                S.task  = 0;
                S.cond  = 1;
                S.TN    = {'instructions'};
                S.sess  = sess(r);
                S.leftHand = 0;
                S.rightHand = 0;
                T=addstruct(T,S);
                
                indx=2;
                for task=1:numel(taskNames)-1, % not modelling rest
                    D=dload(fullfile(baseDir, 'data', subj_name{s},['sc1_',subj_name{s},'_',taskNames{task},'.dat']));
                    R=getrow(D,D.runNum==runB(r)); % functional runs
                    trialType=1:numRegress{glm}(task);
                    for regs=trialType, % loop through trial-types (ex. congruent and incongruent)
                        
                        % Determine number of presses per hand
                        % TOO MANY IF STATEMENTS - CLEAN UP!!!
                        if isfield(R,'hand'),
                            if R.hand(1)==1, % left hand
                                if isfield(R,'trialType'),
                                    leftHand =  sum(R.respMade(R.trialType==regs));
                                else
                                    leftHand=sum(R.respMade);
                                end
                                rightHand= 0;
                            elseif R.hand(1)==2, % right hand
                                if isfield(R,'trialType'),
                                    rightHand = sum(R.respMade(R.trialType==regs));
                                else
                                    rightHand=sum(R.respMade);
                                end
                                leftHand  = 0;
                            elseif R.hand(1)==0, % bimanual
                                leftHand= (sum(R.respMade(R.trialType==regs)))/2;
                                rightHand=(sum(R.respMade(R.trialType==regs)))/2;
                            end
                        else
                            leftHand=0;
                            rightHand=0;
                        end
                        % Determine trialType
                        if strcmp(taskNames{task},'visualSearch'),
                            % (1)
                            tt=(R.setSize==VS_trials(regs));
                            % (2)
                        elseif strcmp(taskNames{task},'motorImagery') || strcmp(taskNames{task},'spatialNavigation') || strcmp(taskNames{task},'intervalTiming') || strcmp(taskNames{task},'ToM') || strcmp(taskNames{task},'checkerBoard'),
                            tt=1;
                            % (3)
                        elseif strcmp(taskNames{task},'nBack') || strcmp(taskNames{task},'nBackPic')
                            conditions=[0;1];
                            tt=(R.respMade==conditions(regs));
                        else
                            % (4)
                            tt=(R.trialType==regs);
                        end
                        % Determine duration
                        if strcmp(taskNames{task},'actionObservation')
                            duration=15;
                        elseif strcmp(taskNames{task},'ToM') || strcmp(taskNames{task},'intervalTiming') || strcmp(taskNames{task},'checkerBoard'),
                            duration=30;
                        else
                            duration=unique(ceil(R.trialDur(tt)));
                        end
                        
                        cond=contrasts{task}{regs};
                        ST = find(strcmp(P.taskName,taskNames{task}));
                        condName = sprintf('%s-%s',char(R.taskName(1)),cond);
                        % loop through trial-types (ex. congruent or incongruent)
                        J.sess(r).cond(indx).name = condName;
                        J.sess(r).cond(indx).onset = [P.realStartTime(ST)+R.startTimeReal(tt)+announceTime-(J.timing.RT*numDummys)]; % correct start time for numDummys and announcetime included
                        J.sess(r).cond(indx).duration = duration;  % duration of trials (+ fixation cross) we are modeling
                        J.sess(r).cond(indx).tmod = 0;
                        J.sess(r).cond(indx).orth = 0;
                        J.sess(r).cond(indx).pmod = struct('name', {}, 'param', {}, 'poly', {});
                        S.SN    = s;
                        S.run   = r;
                        S.task  = task;
                        S.cond  = indx;
                        S.TN    = {condName};
                        S.sess  = sess(r);
                        S.leftHand  = leftHand;
                        S.rightHand = rightHand;
                        T=addstruct(T,S);
                        indx=indx+1;
                    end
                end
                J.sess(r).multi = {''};
                J.sess(r).regress = struct('name', {}, 'val', {});
                J.sess(r).multi_reg = {''};
                J.sess(r).hpf = inf;                                        % set to 'inf' if using J.cvi = 'FAST'. SPM HPF not applied
            end
            J.fact = struct('name', {}, 'levels', {});
            J.bases.hrf.derivs = [0 0];
            J.bases.hrf.params = [4.5 11];                                  % set to [] if running wls
            J.volt = 1;
            J.global = 'None';
            J.mask = {fullfile(baseDir, 'imaging_data',subj_name{s},'rmask_noskull.nii,1')};
            J.mthresh = 0.05;
            J.cvi_mask = {fullfile(baseDir, 'imaging_data',subj_name{s},'rmask_gray.nii')};
            J.cvi =  'fast';
            
            spm_rwls_run_fmri_spec(J);
            
            save(fullfile(J.dir{1},'SPM_info.mat'),'-struct','T');
            fprintf('glm_%d has been saved for %s \n',glm, subj_name{s});
        end
    case 'make_glm6'                    % STEP 7.2d: FAST glm w/out hpf (complex: rest as baseline) - model one instruct period - nonaggr!
        % GLM with FAST and no high pass filtering
        % 'spm_get_defaults' code modified to allow for -v7.3 switch (to save
        % >2MB FAST GLM struct)
        % Be aware: this switch (from -v6 to -v7.3) slows down the code!
        sn=varargin{1};
        prefix='r';
        announceTime=5;
        VS_trials = [4;8;12];
        glm=6;
        
        for s=sn,
            T=[];
            A = dload(fullfile(baseDir, 'data', subj_name{s},['sc1_',subj_name{s},'.dat']));
            A = getrow(A,A.runNum>=funcRunNum(1) & A.runNum<=funcRunNum(2));
            
            glmSubjDir =[baseDir sprintf('/GLM_firstlevel_%d/',glm),subj_name{s}];dircheck(glmSubjDir);
            
            J.dir = {glmSubjDir};
            J.timing.units = 'secs';
            J.timing.RT = 1.0;
            J.timing.fmri_t = 16;
            J.timing.fmri_t0 = 1;
            
            % annoying but reorder behavioural runs slightly for 2
            % subjects...
            if strcmp(subj_name{s},'s18')
                runB = [51,52,53,54,55,56,57,58,59,61,62,63,64,65,66,60];
            elseif strcmp(subj_name{s},'s21'),
                runB = [51,52,53,54,55,56,57,58,59,60,61,63,64,65,66,62];
            end
            
            for r=1:numel(run)                                              % loop through runs
                P=getrow(A,A.runNum==runB(r));
                for i=1:(numTRs-numDummys)
                    N{i} = [fullfile(baseDir, 'imaging_data_aggr',subj_name{s},[prefix 'run_',run{r},'.nii,',num2str(i)])];
                end;
                J.sess(r).scans= N;                                    % number of scans in run
                
                % Get 'announce' regressor (for all tasks)
                J.sess(r).cond(1).name = sprintf('allTasks-%s','announce');
                J.sess(r).cond(1).onset = [P.realStartTime-J.timing.RT*numDummys];    % correct start time for numDummys removed and convert to seconds
                J.sess(r).cond(1).duration = announceTime;             % durations of task we are modeling
                J.sess(r).cond(1).tmod = 0;
                J.sess(r).cond(1).orth = 0;
                J.sess(r).cond(1).pmod = struct('name', {}, 'param', {}, 'poly', {});
                S.SN    = s;
                S.run   = r;
                S.task  = 0;
                S.cond  = 1;
                S.TN    = {'instructions'};
                S.sess  = sess(r);
                S.leftHand = 0;
                S.rightHand = 0;
                T=addstruct(T,S);
                
                indx=2;
                for task=1:numel(taskNames)-1, % not modelling rest
                    D=dload(fullfile(baseDir, 'data', subj_name{s},['sc1_',subj_name{s},'_',taskNames{task},'.dat']));
                    R=getrow(D,D.runNum==runB(r)); % functional runs
                    trialType=1:numRegress{glm}(task);
                    for regs=trialType, % loop through trial-types (ex. congruent and incongruent)
                        
                        % Determine number of presses per hand
                        % TOO MANY IF STATEMENTS - CLEAN UP!!!
                        if isfield(R,'hand'),
                            if R.hand(1)==1, % left hand
                                if isfield(R,'trialType'),
                                    leftHand =  sum(R.respMade(R.trialType==regs));
                                else
                                    leftHand=sum(R.respMade);
                                end
                                rightHand= 0;
                            elseif R.hand(1)==2, % right hand
                                if isfield(R,'trialType'),
                                    rightHand = sum(R.respMade(R.trialType==regs));
                                else
                                    rightHand=sum(R.respMade);
                                end
                                leftHand  = 0;
                            elseif R.hand(1)==0, % bimanual
                                leftHand= (sum(R.respMade(R.trialType==regs)))/2;
                                rightHand=(sum(R.respMade(R.trialType==regs)))/2;
                            end
                        else
                            leftHand=0;
                            rightHand=0;
                        end
                        % Determine trialType
                        if strcmp(taskNames{task},'visualSearch'),
                            % (1)
                            tt=(R.setSize==VS_trials(regs));
                            % (2)
                        elseif strcmp(taskNames{task},'motorImagery') || strcmp(taskNames{task},'spatialNavigation') || strcmp(taskNames{task},'intervalTiming') || strcmp(taskNames{task},'ToM') || strcmp(taskNames{task},'checkerBoard'),
                            tt=1;
                            % (3)
                        elseif strcmp(taskNames{task},'nBack') || strcmp(taskNames{task},'nBackPic')
                            conditions=[0;1];
                            tt=(R.respMade==conditions(regs));
                        else
                            % (4)
                            tt=(R.trialType==regs);
                        end
                        % Determine duration
                        if strcmp(taskNames{task},'actionObservation')
                            duration=15;
                        elseif strcmp(taskNames{task},'ToM') || strcmp(taskNames{task},'intervalTiming') || strcmp(taskNames{task},'checkerBoard'),
                            duration=30;
                        else
                            duration=unique(ceil(R.trialDur(tt)));
                        end
                        
                        cond=contrasts{task}{regs};
                        ST = find(strcmp(P.taskName,taskNames{task}));
                        condName = sprintf('%s-%s',char(R.taskName(1)),cond);
                        % loop through trial-types (ex. congruent or incongruent)
                        J.sess(r).cond(indx).name = condName;
                        J.sess(r).cond(indx).onset = [P.realStartTime(ST)+R.startTimeReal(tt)+announceTime-(J.timing.RT*numDummys)]; % correct start time for numDummys and announcetime included
                        J.sess(r).cond(indx).duration = duration;  % duration of trials (+ fixation cross) we are modeling
                        J.sess(r).cond(indx).tmod = 0;
                        J.sess(r).cond(indx).orth = 0;
                        J.sess(r).cond(indx).pmod = struct('name', {}, 'param', {}, 'poly', {});
                        S.SN    = s;
                        S.run   = r;
                        S.task  = task;
                        S.cond  = indx;
                        S.TN    = {condName};
                        S.sess  = sess(r);
                        S.leftHand  = leftHand;
                        S.rightHand = rightHand;
                        T=addstruct(T,S);
                        indx=indx+1;
                    end
                end
                J.sess(r).multi = {''};
                J.sess(r).regress = struct('name', {}, 'val', {});
                J.sess(r).multi_reg = {''};
                J.sess(r).hpf = inf;                                        % set to 'inf' if using J.cvi = 'FAST'. SPM HPF not applied
            end
            J.fact = struct('name', {}, 'levels', {});
            J.bases.hrf.derivs = [0 0];
            J.bases.hrf.params = [4.5 11];                                  % set to [] if running wls
            J.volt = 1;
            J.global = 'None';
            J.mask = {fullfile(baseDir, 'imaging_data',subj_name{s},'rmask_noskull.nii,1')};
            J.mthresh = 0.05;
            J.cvi_mask = {fullfile(baseDir, 'imaging_data',subj_name{s},'rmask_gray.nii')};
            J.cvi =  'fast';
            
            spm_rwls_run_fmri_spec(J);
            
            save(fullfile(J.dir{1},'SPM_info.mat'),'-struct','T');
            fprintf('glm_%d has been saved for %s \n',glm, subj_name{s});
        end
    case 'estimate_glm'                 % STEP 7.3:  Enter subjNum & glmNum Takes approx 70 minutes!!
        % example: sc1_imana('estimate_glm',1,1)
        sn=varargin{1};
        glm=varargin{2};
        
        for s=sn,
            for g=glm,
                glmDir =[baseDir sprintf('/GLM_firstlevel_%d/',g) subj_name{s}];
                load(fullfile(glmDir,'SPM.mat'));
                SPM.swd=glmDir;
                spm_rwls_spm(SPM);
            end
        end
    case 'contrast'                     % STEP 7.4:  Define linear contrasts
        % 'SPM_light' is created in this step (xVi is removed as it slows
        % down code for FAST GLM)
        % example: sc1_imana('contrast',1,1,'task_variability')
        s=varargin{1}; % subjNum
        glm=varargin{2}; % glmNum
        type=varargin{3}; % type of linear contrast
        
        glmSubjDir =[baseDir sprintf('/GLM_firstlevel_%d/%s',glm,subj_name{s})];
        cd(glmSubjDir);
        switch (type)
            case 'tasks_vs_rest' % glm1 or glm3 (tasks against rest)
                load SPM;
                SPM=rmfield(SPM,'xCon');
                T = load('SPM_info.mat');
                nrun=numel(SPM.nscan);
                ncolX   = size(SPM.xX.X,2);
                
                % T contrast for tasks (execution)
                for sp = 1:length(taskNumbers)-1; % 16 contrasts (tasks vs. rest)
                    con=zeros(1,size(SPM.xX.X,2));
                    con(:,T.task==sp & T.type==2)=1; % individual tasks (execution)
                    con=con/abs(sum(con));
                    SPM.xCon(sp)=spm_FcUtil('Set',sprintf('%s_rest',char(taskNames{sp})), 'T', 'c',con',SPM.xX.xKXs);
                end;
                
                % T contrast for rest (against averaged)
                con=zeros(1,size(SPM.xX.X,2));
                con(:,T.type==2)=-1; % all-tasks (execution)
                con=con/abs(sum(con));
                SPM.xCon(length(SPM.xCon)+1)=spm_FcUtil('Set','rest_averaged', 'T', 'c',con',SPM.xX.xKXs);
                
                SPM=spm_contrasts(SPM,[1:length(SPM.xCon)]);
                save('SPM.mat','SPM','-v7.3');
                SPM=rmfield(SPM,'xVi'); % 'xVi' take up a lot of space and slows down code!
                save(fullfile(glmSubjDir,'SPM_light.mat'),'SPM');
                
                % rename contrast images and spmT images
                conName = {'con','spmT'};
                for i=1:length(SPM.xCon),
                    for n=1:numel(conName),
                        oldName{i} = fullfile(glmSubjDir,sprintf('%s_%2.4d.nii',conName{n},i));
                        newName{i} = fullfile(glmSubjDir,sprintf('%s_%s.nii',conName{n},SPM.xCon(i).name));
                        movefile(oldName{i},newName{i});
                    end
                end
            case 'conditions_vs_rest' % glm4 (tasks conditions against rest)
                load SPM;
                SPM=rmfield(SPM,'xCon');
                T=load('SPM_info.mat');
                nrun=numel(SPM.nscan);
                
                % t contrast for tasks vs. rest
                for tt=1:length(unique(T.cond)), % 1 is "instruct" regressor
                    con=zeros(1,size(SPM.xX.X,2));
                    con(:,T.cond==tt)=1; % contrast against rest
                    con=con/abs(sum(con));
                    name=sprintf('%s-rest',char(unique(T.TN(T.cond==tt))));
                    SPM.xCon(tt)=spm_FcUtil('Set',name, 'T', 'c',con',SPM.xX.xKXs);
                end
                
                SPM=spm_contrasts(SPM,[1:length(SPM.xCon)]);
                save('SPM.mat','SPM','-v7.3');
                SPM=rmfield(SPM,'xVi'); % 'xVi' take up a lot of space and slows down code!
                save(fullfile(glmSubjDir,'SPM_light.mat'),'SPM');
                
                % rename contrast images and spmT images
                conName = {'con','spmT'};
                for i=1:length(SPM.xCon),
                    for n=1:numel(conName),
                        oldName{i} = fullfile(glmSubjDir,sprintf('%s_%2.4d.nii',conName{n},i));
                        newName{i} = fullfile(glmSubjDir,sprintf('%s_%s.nii',conName{n},SPM.xCon(i).name));
                        movefile(oldName{i},newName{i});
                    end
                end
        end
    case 'rename_SPM'                   % (optional): rename fname field in SPM struct (SPM.xY.VY.fname)
        sn=varargin{1};
        
        subjs=length(sn);
        SPMFiles={'SPM.mat','SPM_light.mat'};
        for s=1:subjs,
            for f=1:2,
                load(fullfile(baseDir,'GLM_firstlevel_4',subj_name{sn(s)},SPMFiles{f}));
                idx=1;
                for r=1:16,
                    for i=1:598,
                        SPM.xY.VY(idx).fname=fullfile(imagingDir,subj_name{sn(s)},sprintf('rrun_%2.2d.nii',r));
                        idx=idx+1;
                    end
                end
                save(fullfile(baseDir,'GLM_firstlevel_4',subj_name{sn(s)},SPMFiles{f}),'SPM','-v7.3')
            end
        end
        
    case 'process_suit'                 % STEP 8.1-8.5
        % example: sc1_imana('process_suit',2,4,'contrast')
        sn = varargin{1}; % subjNum
        glm = varargin{2}; % glmNum
        %         spm fmri
        
        for s=sn,
            sc1_imana('make_mask_cortex',s)
            sc1_imana('corr_cereb_cortex_mask',s)
            sc1_imana('suit_normalise_dartel',s,'grey');
            %             sc1_imana('suit_normalise_dentate',s,'grey');
            sc1_imana('suit_make_mask',s,glm,'grey');
            %             sc1_imana('suit_reslice',s,glm,'betas','cereb_prob_corr_grey');
            %             sc1_imana('suit_reslice',s,glm,'contrast','cereb_prob_corr_grey');
            %             sc1_imana('suit_reslice',s,glm,'ResMS','cereb_prob_corr_grey');
            sc1_imana('suit_reslice',s,glm,'cerebellarGrey','cereb_prob_corr_grey');
            fprintf('suit data processed for %s',subj_name{s})
        end
    case 'make_mask_cortex'
        sn=varargin{1};
        
        subjs=length(sn);
        for s=1:subjs,
            glmSubjDir =[baseDir '/GLM_firstlevel_4/' subj_name{sn(s)}];
            
            for h=regSide,
                C=caret_load(fullfile(caretDir,atlasname,hemName{h},[hem{h} '.cerebral_cortex.paint'])); % freesurfer
                caretSubjDir=fullfile(caretDir,[atlasA subj_name{sn(s)}]);
                file=fullfile(glmSubjDir,'mask.nii');
                r{h}.type='surf_nodes';
                r{h}.location=find(C.data(:,1)~=6); % we don't want the medial wall
                r{h}.white=fullfile(caretSubjDir,hemName{h},[hem{h} '.WHITE.coord']);
                r{h}.pial=fullfile(caretSubjDir,hemName{h},[hem{h} '.PIAL.coord']);
                r{h}.topo=fullfile(caretSubjDir,hemName{h},[hem{h} '.CLOSED.topo']);
                r{h}.linedef=[5,0,1];
                r{h}.image=file;
                r{h}.file=file;
                r{h}.name=[hem{h}];
            end;
            r=region_calcregions(r);
            r{1}.location=vertcat(r{1}.location,r{2}.location);
            r{1}.linvoxidxs=vertcat(r{1}.linvoxidxs,r{2}.linvoxidxs);
            r{1}.data=vertcat(r{1}.data,r{2}.data);
            r{1}.weight=vertcat(r{1}.weight,r{2}.weight);
            r{1}.name='cortical_mask_grey';
            R{1}=r{1};
            cd(fullfile(regDir,'data',subj_name{sn(s)}))
            region_saveasimg(R{1},R{1}.file);
        end
    case 'corr_cereb_cortex_mask'
        sn=varargin{1};
        
        subjs=length(sn);
        
        for s=1:subjs,
            
            cortexGrey= fullfile(regDir,'data',subj_name{sn(s)},'cortical_mask_grey.nii'); % cerebellar mask grey (corrected)
            cerebGrey = fullfile(suitDir,'anatomicals',subj_name{sn(s)},'c1anatomical.nii'); % was 'cereb_prob_corr_grey.nii'
            bufferVox = fullfile(suitDir,'anatomicals',subj_name{sn(s)},'buffer_voxels.nii');
            
            % isolate overlapping voxels
            spm_imcalc({cortexGrey,cerebGrey},bufferVox,'(i1.*i2)')
            
            % mask buffer
            spm_imcalc({bufferVox},bufferVox,'i1>0')
            
            cerebGrey2 = fullfile(suitDir,'anatomicals',subj_name{sn(s)},'cereb_prob_corr_grey.nii');
            cortexGrey2= fullfile(regDir,'data',subj_name{sn(s)},'cortical_mask_grey_corr.nii');
            
            % remove buffer from cerebellum
            spm_imcalc({cerebGrey,bufferVox},cerebGrey2,'i1-i2')
            
            % remove buffer from cortex
            spm_imcalc({cortexGrey,bufferVox},cortexGrey2,'i1-i2')
        end
    case 'suit_normalise_dartel'        % STEP 8.2: Normalise the cerebellum into the SUIT template.
        % Normalise an individual cerebellum into the SUIT atlas template
        % Dartel normalises the tissue segmentation maps produced by suit_isolate
        % to the SUIT template
        % !! Make sure that you're choosing the correct isolation mask
        % (corr OR corr1 OR corr2 etc)!!
        % if you are running multiple subjs - change to 'job.subjND(s)."'
        % example: sc1_imana('suit_normalise_dartel',1)
        sn=varargin{1}; %subjNum
        type=varargin{2}; % 'grey' or 'whole' cerebellar mask
        
        cd(fullfile(suitDir,'anatomicals',subj_name{sn}));
        job.subjND.gray      = {'c_anatomical_seg1.nii'};
        job.subjND.white     = {'c_anatomical_seg2.nii'};
        switch type,
            case 'grey'
                job.subjND.isolation= {'cereb_prob_corr_grey.nii'};
            case 'whole'
                job.subjND.isolation= {'cereb_prob_corr.nii'};
        end
        suit_normalize_dartel(job);
        
        % 'spm_dartel_warp' code was changed to look in the working
        % directory for 'u_a_anatomical_segment1.nii' file - previously it
        % was giving a 'file2mat' error because it mistakenly believed that
        % this file had been created
    case 'suit_normalise_dentate'       % STEP 8.3: Uses an ROI from the dentate nucleus to improve the overlap of the DCN
        sn=varargin{1}; %subjNum
        type=varargin{2}; % 'grey' or 'whole' cerebellum
        
        cd(fullfile(suitDir,'anatomicals',subj_name{sn}));
        job.subjND.gray       = {'c_anatomical_seg1.nii'};
        job.subjND.white      = {'c_anatomical_seg2.nii'};
        job.subjND.dentateROI = {fullfile(suitDir,'glm4',subj_name{sn},'dentate_mask.nii')};
        switch type,
            case 'grey'
                job.subjND.isolation  = {'cereb_prob_corr_grey.nii'};
            case 'whole'
                job.subjND.isolation  = {'cereb_prob_corr.nii'};
        end
        
        suit_normalize_dentate(job);
    case 'suit_make_mask'               % STEP 8.4: Make cerebellar mask using SUIT
        % example: sc1_imana('suit_make_mask',1,1)
        sn=varargin{1}; % subjNum
        glm=varargin{2}; % glmNum
        type=varargin{3}; % 'grey' or 'whole'
        
        subjs=length(sn);
        
        for s=1:subjs,
            glmSubjDir = fullfile(baseDir,sprintf('GLM_firstlevel_%d',glm),subj_name{sn(s)});
            mask      = fullfile(glmSubjDir,'mask.nii'); % mask for functional image
            switch type
                case 'grey'
                    suit  = fullfile(suitDir,'anatomicals',subj_name{sn(s)},'cereb_prob_corr_grey.nii'); % cerebellar mask grey (corrected)
                    omask = fullfile(suitDir,'anatomicals',subj_name{sn(s)},'maskbrainSUITGrey.nii'); % output mask image - grey matter
                case 'whole'
                    suit  = fullfile(suitDir,'anatomicals', subj_name{sn(s)},'cereb_prob_corr.nii'); % cerebellar mask (corrected)
                    omask = fullfile(suitDir, sprintf('glm%d',glm),subj_name{sn(s)},'maskbrainSUIT.nii'); % output mask image
            end
            dircheck(fullfile(suitDir,'anatomicals',subj_name{sn(s)}));
            cd(fullfile(suitDir,'anatomicals',subj_name{sn(s)}));
            spm_imcalc({mask,suit},omask,'i1>0 & i2>0.7',{});
        end
    case 'suit_reslice'                 % STEP 8.5: Reslice the contrast images from first-level GLM
        % Reslices the functional data (betas, contrast images or ResMS)
        % from the first-level GLM using deformation from
        % 'suit_normalise_dartel'.
        % example: sc1_imana('suit_reslice_dartel',1,1,'contrast')
        % make sure that you reslice into 2mm^3 resolution
        sn=varargin{1}; % subjNum
        glm=varargin{2}; % glmNum
        type=varargin{3}; % 'betas' or 'contrast' or 'ResMS' or 'cerebellarGrey'
        mask=varargin{4}; % 'cereb_prob_corr_grey' or 'cereb_prob_corr' or 'dentate_mask'
        
        subjs=length(sn);
        
        for s=1:subjs,
            switch type
                case 'betas'
                    glmSubjDir = fullfile(baseDir,sprintf('GLM_firstlevel_%d',glm),subj_name{sn(s)});
                    outDir=fullfile(suitDir,sprintf('glm%d',glm),subj_name{sn(s)});
                    images='beta_0';
                    source=dir(fullfile(glmSubjDir,sprintf('*%s*',images))); % images to be resliced
                    cd(glmSubjDir);
                case 'contrast'
                    glmSubjDir = fullfile(baseDir,sprintf('GLM_firstlevel_%d',glm),subj_name{sn(s)});
                    outDir=fullfile(suitDir,sprintf('glm%d',glm),subj_name{sn(s)});
                    images='con';
                    source=dir(fullfile(glmSubjDir,sprintf('*%s*',images))); % images to be resliced
                    cd(glmSubjDir);
                case 'ResMS'
                    glmSubjDir = fullfile(baseDir,sprintf('GLM_firstlevel_%d',glm),subj_name{sn(s)});
                    outDir=fullfile(suitDir,sprintf('glm%d',glm),subj_name{sn(s)});
                    images='ResMS';
                    source=dir(fullfile(glmSubjDir,sprintf('*%s*',images))); % images to be resliced
                    cd(glmSubjDir);
                case 'cerebellarGrey'
                    source=dir(fullfile(suitDir,'anatomicals',subj_name{sn(s)},'c1anatomical.nii')); % image to be resliced
                    cd(fullfile(suitDir,'anatomicals',subj_name{sn(s)}));
            end
            job.subj.affineTr = {fullfile(suitDir,'anatomicals',subj_name{sn(s)},'Affine_c_anatomical_seg1.mat')};
            job.subj.flowfield= {fullfile(suitDir,'anatomicals',subj_name{sn(s)},'u_a_c_anatomical_seg1.nii')};
            job.subj.resample = {source.name};
            job.subj.mask     = {fullfile(suitDir,'anatomicals',subj_name{sn(s)},sprintf('%s.nii',mask))};
            job.vox           = [2 2 2];
            suit_reslice_dartel(job);
            if ~strcmp(type,'cerebellarGrey'),
                source=fullfile(glmSubjDir,'*wd*');
                dircheck(fullfile(outDir));
                destination=fullfile(suitDir,sprintf('glm%d',glm),subj_name{sn(s)});
                movefile(source,destination);
            end
            fprintf('%s have been resliced into suit space for %s \n\n',type,glm,subj_name{sn(s)})
        end
        
    case 'process_ROI'                  % STEP 9.1-9.6
        sn=varargin{1}; % subjNum
        glm=varargin{2}; % glmNum
        type=varargin{3}; %'cortical_lobes','whole_brain','yeo','desikan','cerebellum'
        for s=sn,
            for t=1:numel(type),
                sc1_imana('ROI_define',s,type{t})
                sc1_imana('ROI_get_betas',s,glm,type{t})
                sc1_imana('ROI_stats',s,glm,1,type{t}) % remove mean
                %             sc1_imana('ROI_RDM_stability',s,glm,type)
            end
        end
    case 'ROI_define'                   % STEP 9.1: Enter subjNum and glmNum. Defines ROIs that are referenced in (2) at start of sc1_imana
        % Run FREESURFER before this step!
        sn=varargin{1}; % subjNum
        type=varargin{2}; % 'cortical_lobes','yeo','desikan','cerebellum','cerebellum_grey'
        
        subjs=length(sn);
        idx=0;
        for s=1:subjs,
            
            switch type
                case 'cortical_lobes'
                    for h=regSide,
                        C=caret_load(fullfile(caretDir,atlasname,hemName{h},[hem{h} '.cerebral_cortex.paint'])); % freesurfer
                        caretSubjDir=fullfile(caretDir,[atlasA subj_name{sn(s)}]);
                        file=fullfile(regDir,'data',subj_name{sn(s)},'cortical_mask_grey_corr.nii');
                        if h==2,
                            idx=numel(C.paintnames)-1; % we don't want medial wall
                        end
                        % Get cortical regions
                        for i=1:numel(C.paintnames)-1, % we don't want the medial wall
                            r{i+idx}.type='surf_nodes';
                            r{i+idx}.location=find(C.data(:,1)==i);
                            r{i+idx}.white=fullfile(caretSubjDir,hemName{h},[hem{h} '.WHITE.coord']);
                            r{i+idx}.pial=fullfile(caretSubjDir,hemName{h},[hem{h} '.PIAL.coord']);
                            r{i+idx}.topo=fullfile(caretSubjDir,hemName{h},[hem{h} '.CLOSED.topo']);
                            r{i+idx}.linedef=[5,0,1];
                            r{i+idx}.image=file;
                            r{i+idx}.file=file;
                            r{i+idx}.name=[C.paintnames{i}];
                        end;
                    end;
                    r=region_calcregions(r);
                    for i=1:numel(C.paintnames)-1,
                        r{i}.location=vertcat(r{i}.location,r{i+idx}.location);
                        r{i}.linvoxidxs=vertcat(r{i}.linvoxidxs,r{i+idx}.linvoxidxs);
                        r{i}.data=vertcat(r{i}.data,r{i+idx}.data);
                        r{i}.weight=vertcat(r{i}.weight,r{i+idx}.weight);
                        R{i}=r{i};
                    end
                case 'yeo',
                    for h=regSide, % loop over hemispheres
                        % define Yeo networks as regions
                        C=caret_load(fullfile(caretDir,atlasname,hemName{h},[hem{h} '.Yeo17.paint'])); % freesurfer
                        caretSubjDir=fullfile(caretDir,[atlasA subj_name{sn(s)}]);
                        file=fullfile(regDir,'data',subj_name{sn(s)},'cortical_mask_grey_corr.nii');
                        if h==2,
                            idx=numel(C.paintnames);
                        end
                        for i=1:numel(C.paintnames),
                            r{i+idx}.type='surf_nodes';
                            r{i+idx}.location=find(C.data(:,1)==i);
                            r{i+idx}.white=fullfile(caretSubjDir,hemName{h},[hem{h} '.WHITE.coord']);
                            r{i+idx}.pial=fullfile(caretSubjDir,hemName{h},[hem{h} '.PIAL.coord']);
                            r{i+idx}.topo=fullfile(caretSubjDir,hemName{h},[hem{h} '.CLOSED.topo']);
                            r{i+idx}.linedef=[5,0,1];
                            r{i+idx}.image=file;
                            r{i+idx}.file=file;
                            r{i+idx}.name=[C.paintnames{i}];
                        end;
                    end
                    r=region_calcregions(r);
                    for i=1:numel(C.paintnames),
                        r{i}.location=vertcat(r{i}.location,r{i+idx}.location);
                        r{i}.linvoxidxs=vertcat(r{i}.linvoxidxs,r{i+idx}.linvoxidxs);
                        r{i}.data=vertcat(r{i}.data,r{i+idx}.data);
                        r{i}.weight=vertcat(r{i}.weight,r{i+idx}.weight);
                        R{i}=r{i};
                    end
                case 'yeo_hem'
                    for h=regSide,
                        % define desikan as regions
                        C=caret_load(fullfile(caretDir,atlasname,hemName{h},[hem{h} '.Yeo17.paint'])); % freesurfer
                        caretSubjDir=fullfile(caretDir,[atlasA subj_name{sn(s)}]);
                        file=fullfile(regDir,'data',subj_name{sn(s)},'cortical_mask_grey_corr.nii');
                        if h==2,
                            idx=numel(C.paintnames);
                        end
                        for i=1:numel(C.paintnames),
                            r{i+idx}.type='surf_nodes';
                            r{i+idx}.location=find(C.data(:,1)==i);
                            r{i+idx}.white=fullfile(caretSubjDir,hemName{h},[hem{h} '.WHITE.coord']);
                            r{i+idx}.pial=fullfile(caretSubjDir,hemName{h},[hem{h} '.PIAL.coord']);
                            r{i+idx}.topo=fullfile(caretSubjDir,hemName{h},[hem{h} '.CLOSED.topo']);
                            r{i+idx}.linedef=[5,0,1];
                            r{i+idx}.image=file;
                            r{i+idx}.file=file;
                            r{i+idx}.name=[C.paintnames{i} '_' hem{h}];
                        end;
                    end
                    R=region_calcregions(r);
                case 'desikan'
                    for h=regSide,
                        % define desikan as regions
                        C=caret_load(fullfile(caretDir,atlasname,hemName{h},[hem{h} '.desikan.paint'])); % freesurfer
                        caretSubjDir=fullfile(caretDir,[atlasA subj_name{sn(s)}]);
                        file=fullfile(regDir,'data',subj_name{sn(s)},'cortical_mask_grey_corr.nii');
                        if h==2,
                            idx=numel(C.paintnames);
                        end
                        for i=1:numel(C.paintnames),
                            r{i+idx}.type='surf_nodes';
                            r{i+idx}.location=find(C.data(:,1)==i);
                            r{i+idx}.white=fullfile(caretSubjDir,hemName{h},[hem{h} '.WHITE.coord']);
                            r{i+idx}.pial=fullfile(caretSubjDir,hemName{h},[hem{h} '.PIAL.coord']);
                            r{i+idx}.topo=fullfile(caretSubjDir,hemName{h},[hem{h} '.CLOSED.topo']);
                            r{i+idx}.linedef=[5,0,1];
                            r{i+idx}.image=file;
                            r{i+idx}.file=file;
                            r{i+idx}.name=[C.paintnames{i}];
                        end;
                    end
                    r=region_calcregions(r);
                    for i=1:numel(C.paintnames),
                        r{i}.location=vertcat(r{i}.location,r{i+idx}.location);
                        r{i}.linvoxidxs=vertcat(r{i}.linvoxidxs,r{i+idx}.linvoxidxs);
                        r{i}.data=vertcat(r{i}.data,r{i+idx}.data);
                        r{i}.weight=vertcat(r{i}.weight,r{i+idx}.weight);
                        R{i}=r{i};
                    end
                case 'desikan_hem'
                    for h=regSide,
                        % define desikan as regions
                        C=caret_load(fullfile(caretDir,atlasname,hemName{h},[hem{h} '.desikan.paint'])); % freesurfer
                        caretSubjDir=fullfile(caretDir,[atlasA subj_name{sn(s)}]);
                        file=fullfile(regDir,'data',subj_name{sn(s)},'cortical_mask_grey_corr.nii');
                        if h==2,
                            idx=numel(C.paintnames);
                        end
                        for i=1:numel(C.paintnames),
                            r{i+idx}.type='surf_nodes';
                            r{i+idx}.location=find(C.data(:,1)==i);
                            r{i+idx}.white=fullfile(caretSubjDir,hemName{h},[hem{h} '.WHITE.coord']);
                            r{i+idx}.pial=fullfile(caretSubjDir,hemName{h},[hem{h} '.PIAL.coord']);
                            r{i+idx}.topo=fullfile(caretSubjDir,hemName{h},[hem{h} '.CLOSED.topo']);
                            r{i+idx}.linedef=[5,0,1];
                            r{i+idx}.image=file;
                            r{i+idx}.file=file;
                            r{i+idx}.name=[C.paintnames{i} '_' hem{h}];
                        end;
                    end
                    R=region_calcregions(r);
                case 'cerebellum_grey'
                    % Get cerebellum
                    file = fullfile(suitDir,'anatomicals',subj_name{sn(s)},'maskbrainSUITGrey.nii');
                    R{1}.type = 'roi_image';
                    R{1}.file= file;
                    R{1}.name = ['cerebellum_grey'];
                    R{1}.value = 1;
                    R=region_calcregions(R);
                case '162_tessellation'
                    caretSubjDir=fullfile(caretDir,[atlasA subj_name{sn(s)}]);
                    file=fullfile(regDir,'data',subj_name{sn(s)},'cortical_mask_grey_corr.nii');
                    for h=regSide,
                        C=caret_load(fullfile(caretDir,atlasname,hemName{h},sprintf('%s.tessel162.paint',hem{h}))); % freesurfer
                        tesselNames=unique(C.data);
                        if h==2,
                            idx=numel(C.paintnames);
                        end
                        for i=1:numel(C.paintnames),
                            r{i+idx}.type='surf_nodes';
                            r{i+idx}.location=find(C.data(:,1)==tesselNames(i));
                            r{i+idx}.white=fullfile(caretSubjDir,hemName{h},[hem{h} '.WHITE.coord']);
                            r{i+idx}.pial=fullfile(caretSubjDir,hemName{h},[hem{h} '.PIAL.coord']);
                            r{i+idx}.topo=fullfile(caretSubjDir,hemName{h},[hem{h} '.CLOSED.topo']);
                            r{i+idx}.linedef=[5,0,1];
                            r{i+idx}.image=file;
                            r{i+idx}.file=file;
                            r{i+idx}.name=[C.paintnames{i}];
                        end;
                        r{149}.name='medial_wall'; % tessel 149 is the medial wall
                    end
                    r=region_calcregions(r);
                    for i=1:numel(C.paintnames),
                        r{i}.location=vertcat(r{i}.location,r{i+idx}.location);
                        r{i}.linvoxidxs=vertcat(r{i}.linvoxidxs,r{i+idx}.linvoxidxs);
                        r{i}.data=vertcat(r{i}.data,r{i+idx}.data);
                        r{i}.weight=vertcat(r{i}.weight,r{i+idx}.weight);
                        R{i}=r{i};
                    end
                case '162_tessellation_hem'
                    caretSubjDir=fullfile(caretDir,[atlasA subj_name{sn(s)}]);
                    file=fullfile(regDir,'data',subj_name{sn(s)},'cortical_mask_grey_corr.nii'); % used to be 'mask'
                    for h=regSide,
                        C=caret_load(fullfile(caretDir,atlasname,hemName{h},sprintf('%s.tessel162.paint',hem{h}))); % freesurfer
                        tesselNames=unique(C.data);
                        if h==2,
                            idx=numel(C.paintnames);
                        end
                        for i=1:numel(C.paintnames),
                            r{i+idx}.type='surf_nodes';
                            r{i+idx}.location=find(C.data(:,1)==tesselNames(i));
                            r{i+idx}.white=fullfile(caretSubjDir,hemName{h},[hem{h} '.WHITE.coord']);
                            r{i+idx}.pial=fullfile(caretSubjDir,hemName{h},[hem{h} '.PIAL.coord']);
                            r{i+idx}.topo=fullfile(caretSubjDir,hemName{h},[hem{h} '.CLOSED.topo']);
                            r{i+idx}.linedef=[5,0,1];
                            r{i+idx}.image=file;
                            r{i+idx}.file=file;
                            r{i+idx}.name=[C.paintnames{i} '_' hem{h}];
                        end;
                        r{149}.name='medial_wall_lh'; % tessel 149 is the medial wall
                        r{149+158}.name='medial_wall_rh'; % tessel 149+158 is the other medial wall
                    end
                    R=region_calcregions(r);
                case 'cortex_grey'
                    for h=regSide,
                        C=caret_load(fullfile(caretDir,atlasname,hemName{h},[hem{h} '.cerebral_cortex.paint'])); % freesurfer
                        caretSubjDir=fullfile(caretDir,[atlasA subj_name{sn(s)}]);
                        file=fullfile(regDir,'data',subj_name{sn(s)},'cortical_mask_grey_corr.nii'); % used to be just 'mask'
                        r{h}.type='surf_nodes';
                        r{h}.location=find(C.data(:,1)~=6); % we don't want the medial wall
                        r{h}.white=fullfile(caretSubjDir,hemName{h},[hem{h} '.WHITE.coord']);
                        r{h}.pial=fullfile(caretSubjDir,hemName{h},[hem{h} '.PIAL.coord']);
                        r{h}.topo=fullfile(caretSubjDir,hemName{h},[hem{h} '.CLOSED.topo']);
                        r{h}.linedef=[5,0,1];
                        r{h}.image=file;
                        r{h}.file=file;
                        r{h}.name=[hem{h}];
                    end;
                    r=region_calcregions(r);
                    R=r;
                case 'dentate'
                    % Get dentate nucleus
                    file = fullfile(suitDir,'anatomicals',subj_name{sn(s)},'dentate_mask.nii');
                    R{1}.type = 'roi_image';
                    R{1}.file= file;
                    R{1}.name = ['dentate'];
                    R{1}.value = 1;
                    R=region_calcregions(R);
            end
            dircheck(fullfile(regDir,'data',subj_name{sn(s)}));
            %             dircheck(fullfile(regDir,'glm4',subj_name{sn(s)},sprintf('%s_masks',type)));
            %             cd(fullfile(regDir,sprintf('glm%d',glm),subj_name{sn(s)},sprintf('%s_masks',type)));
            %             for ii=1:length(R),
            %                 region_saveasimg(R{ii},R{ii}.file);
            %             end
            save(fullfile(regDir,'data',subj_name{sn(s)},sprintf('regions_%s.mat',type)),'R');
            fprintf('ROIs have been defined for %s for %s \n',type,subj_name{sn(s)})
        end
    case 'ROI_get_betas'                % STEP 9.4: Extract betas and prewhiten (apply none, uni and multi noise normalisation)
        % Betas are not multivariately noise-normalised in this version of
        % the code. See 'sc1_imana_backUp' code for this option
        % Betas are computed for all regions (both hemispheres for cortical ROIs).
        % Regions are defined in section (2)
        sn=varargin{1}; % subjNum
        glm=varargin{2}; % glmNum
        type=varargin{3}; % 'cortical_lobes','whole_brain','yeo','desikan','cerebellum','yeo_cerebellum'
        
        B = [];
        glmDir =[baseDir sprintf('/GLM_firstlevel_%d',glm)];dircheck(glmDir);
        subjs=length(sn);
        
        for s=1:subjs,
            glmDirSubj=fullfile(glmDir, subj_name{sn(s)});
            load(fullfile(glmDirSubj,'SPM.mat'));
            
            % load data
            load(fullfile(regDir,'data',subj_name{sn(s)},sprintf('regions_%s.mat',type))); % 'regions' are defined in 'ROI_define'
            
            % Get the raw data files
            V=SPM.xY.VY;
            
            Y = region_getdata(V,R);  % Data is N x P
            
            for r=1:numel(R), % R is the output 'regions' structure from 'ROI_define'
                % Get betas (univariately prewhitened)
                [resMS,beta_hat]=rsa.spm.noiseNormalizeBeta(Y{r},SPM,'normmode','none');
                
                % option to include empty betasUW matrix (no betas for some
                % ROIs for some subjects)
                if isempty(beta_hat),
                    betasUW=zeros(size(beta_hat,1),1);
                else
                    betasUW = bsxfun(@rdivide,beta_hat,sqrt(resMS)); % univariate noise normalisation
                end
                
                B{r}.betasNW = beta_hat; % no noise normalisation
                B{r}.betasUW = betasUW; % univariate noise normalisation
                B{r}.region  = r;
                B{r}.regName = R{r}.name;
                B{r}.SN      = sn(s);
            end
            
            % Save output for each subject
            outfile = sprintf('betas_%s.mat',type);
            dircheck(fullfile(regDir,sprintf('glm%d',glm),subj_name{sn(s)}));
            save(fullfile(regDir,sprintf('glm%d',glm),subj_name{sn(s)},outfile),'B');
            fprintf('betas computed and saved for %s (%s) for %s \n',subj_name{sn(s)},sprintf('glm%d',glm),type);
        end
    case 'ROI_stats'                    % STEP 9.5: Calculate G/second-moment matrix,distance estimates (Mahalanobis),pattern consistencies for all regions
        sn=varargin{1}; % subjNum
        glm =varargin{2}; % glmNum
        remove_mean=varargin{3}; % better to remove mean for accurate pattern consistencies (input:1)
        type=varargin{4}; % 'all','yeo','desikan','cerebellum' 'cerebellum_grey'
        
        glmDir =[baseDir sprintf('/GLM_firstlevel_%d',glm)];dircheck(glmDir);
        
        subjs=length(sn);
        
        for s=1:subjs,
            Ts=[];  % Seperated by tasks
            To=[];  % Overall
            
            glmDirSubj=fullfile(glmDir, subj_name{sn(s)});
            load(fullfile(glmDirSubj,'SPM_light.mat'));
            D=load(fullfile(glmDirSubj,'SPM_info.mat'));
            
            % load activity patterns
            load(fullfile(regDir,sprintf('glm%d',glm),subj_name{sn(s)},sprintf('betas_%s.mat',type)));
            
            for r=1:numel(B), % loop over regions
                
                for w=1:numel(PW), % loop over different noise normalisation approaches
                    
                    betas = B{r}.(sprintf('%s',PW{w})); % get correct betas;
                    
                    % remove instructions
                    switch glm,
                        case 4
                            tt = D.cond.*(D.cond~=1); % we're not interested in the instructions
                            runTrial=D.run.*(D.cond~=1);
                            glmType=1;
                        case 13
                            tt = D.task.*(D.type==2);
                            runTrial=D.run.*(D.type==2); % we're interested in execution-only conditions (not instructions)
                            glmType=2;
                        case 5
                            tt = D.cond.*(D.cond~=1); % we're not interested in the instructions
                            runTrial=D.run.*(D.cond~=1);
                            glmType=3;
                    end
                    
                    % Pattern consistency and Split-Half Reliability
                    
                    % Split half reliability
                    split = [1;2];
                    
                    % loop over datasets (odd and even runs for distance measures and
                    % session 1 and session 2 for pattern consistency)
                    for i=1:numel(split),
                        % Get distances
                        hPart =D.run .* (mod(D.run+i-1,2)); % shouldn't trialType be specified here?? (D.run.*D.type==2.*(mod(Drun+i-1,2));
                        So{r}.(sprintf('RDMh_%d',i))  = rsa.distanceLDC(betas,hPart,tt); % LDC is the crossval Mahalanobis distance (+ multiv noise normalisation)
                        
                        % Get pattern consistencies within sessions
                        b = betas; % betas load from 'ROI_get_betas' output
                        partition = runTrial.*(D.sess==i); % partition is usually defined as runs
                        if remove_mean==0
                            So{r}.(sprintf('R2_Sess%d',split(i))) = rsa_patternConsistency(b,partition,tt,'removeMean',0);
                        else
                            So{r}.(sprintf('R2_Sess%d',split(i))) = rsa_patternConsistency(b,partition,tt); % better to remove mean
                        end
                    end
                    
                    % Get pattern consistencies across sessions
                    partition = runTrial;
                    if remove_mean==0,
                        So{r}.R2_overall = rsa_patternConsistency(b,partition,tt,'removeMean',0);
                    else
                        So{r}.R2_overall = rsa_patternConsistency(b,partition,tt);
                    end
                    
                    % Estimate crossval second moment matrix
                    [G,Sig] = crossval_estG(betas,indicatorMatrix('identity_p',tt),D.run); % all betas given here - D.tt indicates betas of interest
                    Ss{r}.IPM = rsa_vectorizeIPM(G); % vectorise second-moment matrix for later (multi-dimensional scaling)
                    Ss{r}.Sig = rsa_vectorizeIPM(Sig); % sigma is optional
                    
                    So{r}.SN         = sn(s); % subjNum
                    So{r}.region     = r; % regionNum
                    So{r}.regName    = {B{r}.regName}; % regionName
                    So{r}.GLM        = glm; % glmNum
                    So{r}.glm_type   = glm_type(glmType); % glmType (i.e. WLS or FAST)
                    So{r}.numvox     = size(betas,2); % number of voxels
                    So{r}.method     = PW(w); % noise normalisation approach (none or uni)
                    So{r}.method_num = w;
                    Ss{r}.SN         = sn(s);
                    Ss{r}.region     = r;
                    Ss{r}.regName    = {B{r}.regName};
                    Ss{r}.GLM        = glm;
                    Ss{r}.glm_type   = glm_type(glmType);
                    Ss{r}.method     = PW(w);
                    Ss{r}.method_num = w;
                    Ss{r}.numvox     = size(betas,2);
                    Ts               = addstruct(Ts,Ss{r});
                    To               = addstruct(To,So{r});
                end
            end
            % Save output
            save(fullfile(regDir,sprintf('glm%d',glm),subj_name{sn(s)},sprintf('Toverall_%s.mat',type)),'To'); % used for correlation statistics in 'ROI_RDM_stability'
            save(fullfile(regDir,sprintf('glm%d',glm),subj_name{sn(s)},sprintf('Ttasks_%s.mat',type)),'Ts'); % used to visualise RDMs and MDS
            fprintf('GLM %d stats are done for %s (%s). \n',glm,subj_name{sn(s)},type)
        end
    case 'ROI_RDM_stability'            % STEP 9.6: Pearson's corr for split-half reliability of LDC distances
        % example: sc1_imana('ROI_RDM_stability',1,1)
        sn=varargin{1}; % subjNum
        glm=varargin{2}; % glmNum
        type=varargin{3}; % 'cortical_lobes','whole_brain','yeo','desikan','cerebellum'
        
        split = [1;2]; % runs - odd and even
        
        T = [];
        subjs=length(sn);
        for s=1:subjs,
            T=[];
            
            switch glm
                case 4
                    glmType=1;
                case 13
                    glmType=2;
            end
            
            % load overall statistics
            load(fullfile(regDir,sprintf('glm%d',glm),subj_name{sn(s)},sprintf('Toverall_%s.mat',type))); % load in output from 'ROI_stats'
            
            numReg=length(unique(To.region));
            
            for r=1:numReg, % loop over regions
                for w=1:numel(PW), % loop over methods
                    P = getrow(To,To.method_num==w & To.region==r);
                    for i=1:numel(split), % loop over splits (odd and even runs)
                        X(i,:)  = P.(sprintf('RDMh_%d',i)); % distance estimates for splits
                    end
                    [Cs,~] = corr(X','type','pearson');
                    C.region    = r;
                    C.regName   = P.regName;
                    C.corrName  = 'pearson';
                    C.method    = PW(w);
                    C.method_num= w;
                    C.SN        = sn(s);
                    C.corr      = Cs(2);
                    C.GLM       = glm;
                    C.glm_type  = glm_type(glmType);
                    
                    T = addstruct(T,C);
                    C=[];
                end
            end
            
            % Save output
            save(fullfile(regDir,sprintf('glm%d',glm),subj_name{sn(s)},sprintf('correlations_%s.mat',type)),'T');
            fprintf('Correlation stats are done for %s (%s) for %s \n',subj_name{sn(s)}, sprintf('glm%d',glm),type)
        end
        
    case 'freesurfer_parcellations'     % (optional) make new freesurfer cortical parcellations
        type=varargin{1}; % cerebral cortex or 162 tessellation
        
        switch type,
            case 'cerebral_cortex_paint'
                for h=regSide,
                    C=caret_load(fullfile(caretDir,atlasname,hemName{h},[hem{h} '.lobes.paint'])); % freesurfer
                    F=caret_load(fullfile(caretDir,atlasname,hemName{h},[hem{h} '.desikan.paint']));
                    C.data(F.data==1)=6; % medial wall is now 6
                    C.data(C.data==0)=5; % everything else is limbic lobe (5)
                    C.paintnames=cerebralNames;
                    C.num_paintnames=length(C.paintnames);
                    C.column_name={'Column_01'};
                    caret_save(fullfile(caretDir,atlasname,hemName{h},sprintf('%s.%s.paint',hem{h},type)),C);
                    
                    % make area colour
                    cmap=load(fullfile(encodeDir,sprintf('winnerTakeAll_%s.colour.txt',type)));
                    M.encoding={'BINARY'};
                    M.column_name=C.paintnames;
                    M.num_rows=C.num_rows;
                    M.num_cols=length(C.paintnames);
                    M.column_color_mapping=repmat([-5 5],length(C.paintnames),1);
                    M.paintnames=C.paintnames;
                    M.data=cmap(1:length(C.paintnames),2:4);
                    caret_save(fullfile(caretDir,atlasname,hemName{h},sprintf('%s.areacolor',type)),M);
                end;
            case '162_tessellation_paint'
                % load in metric file
                F=caret_load(fullfile(caretDir,'fsaverage_sym','LeftHem','lh.tessel162.metric'));
                
                B=caret_load(fullfile(caretDir,'fsaverage_sym','LeftHem','lh.cerebral_cortex.paint'));
                
                % get medial wall
                %                 find(F.data(B.data==6))=0;
                F.data(B.data==6)=163;
                
                I=setdiff([1:158],unique(F.data));
                N=[159,160,162,163];
                
                % relabel data (medial wall is now index 149)
                for i=1:length(N),
                    F.data(F.data==N(i))=I(i);
                end
                
                % save out new metric file (medial wall removed)
                caret_save(fullfile(caretDir,'fsaverage_sym','LeftHem','lh.tessel162_new.metric'),F);
                
                % make and save new paintfile
                F=rmfield(F,'column_color_mapping');
                
                % loop over tessels
                for ii=1:length(unique(F.data)),
                    F.paintnames{ii}=sprintf('tessel%2.2d',ii);
                end
                %                 F.paintnames{I(end)}='medial_wall';
                F.num_paintnames=length(unique(F.data));
                
                %                 caret_save(fullfile(caretDir,'fsaverage_sym','LeftHem','lh.tessel162.paint'),F);
                
                % make new area colour file
                cmap=[1:1:255];
                for c=1:length(unique(F.data)),
                    M.data(c,:)=randsample(cmap,3);
                end
                M.data(I(end),:)=[0 0 0];
                M.encoding={'BINARY'};
                M.column_name={'Column_01'};
                M.num_rows=F.num_cols;
                M.num_cols=F.num_cols;
                M.column_color_mapping=repmat([-5 5],length(unique(F.data)),1);
                M.paintnames=F.paintnames;
                %                 caret_save(fullfile(caretDir,'fsaverage_sym','LeftHem','tessel162.areacolor'),M);
            case 'medialWall_paint'
                
                for h=1:2,
                    F=caret_load(fullfile(caretDir,'fsaverage_sym',hemName{h},sprintf('%s.cerebral_cortex.paint',hem{h})));
                    
                    F.data(F.data~=6)=0;
                    F.data(F.data==6)=1;
                    F.paintnames={'medialWall'};
                    F.num_paintnames=1;
                    
                    caret_save(fullfile(caretDir,'fsaverage_sym',hemName{h},sprintf('%s.medialWall.paint',hem{h})),F);
                    
                    M.data=[0 0 0];
                    M.encoding={'BINARY'};
                    M.column_name={'Column_01'};
                    M.num_rows=F.num_cols;
                    M.num_cols=F.num_cols;
                    M.column_color_mapping=repmat([-5 5],F.num_paintnames,1);
                    M.paintnames=F.paintnames;
                    caret_save(fullfile(caretDir,'fsaverage_sym',hemName{h},'medialWall.areacolor'),M);
                end
            case 'hand_knob_cerebellum'
                hands={'RH','LH'};thresh=[5.5;4.5];
                B=gifti(fullfile(caretDir,'suit_flat','Cerebellum-lobules.label.gii'));
                indices=zeros(size(B.cdata,1),1);
                for h=1:2,
                    inFile=fullfile(sprintf('/Users/mking/Documents/MATLAB/imaging/suit/functional_examples/HCP_MOTOR_%svsAVERAGE_SUIT.nii',hands{h}));
                    M=caret_suit_map2surf(inFile,'space','SUIT','stats','nanmean');
                    idx=find(M.data>thresh(h));
                    indices(idx)=h;
                end
                B=caret_load('cereb.winnerTakeAll_yeo.paint');
                B.num_cols=1;
                B.num_rows=size(indices,1);
                B.num_paintnames=2;
                B.column_name={'col1'};
                B.paintnames=hands;
                B.data=indices;
                B.index=[1:size(indices,1)]';
                caret_save(fullfile(caretDir,'suit_flat','motor_regions.paint'),B);
                % make new area colour file
                cmap=load('handKnob_cerebellum.txt');
                C.data=cmap(1:2,2:4);
                C.encoding={'BINARY'};
                C.column_name={'Column_01'};
                C.num_rows=B.num_cols;
                C.num_cols=B.num_cols;
                C.column_color_mapping=repmat([-5 5],length(unique(B.data)),1);
                C.paintnames=B.paintnames;
                caret_save(fullfile(caretDir,'suit_flat','motor_regions.areacolor'),C);
                % visualise
                suit_plotflatmap(indices,'type','label','cmap','handKnob_cerebellum.txt');
        end
        
    case 'prepare_encoding_data'        % STEP 15.1-2
        sn=varargin{1};
        glm=varargin{2};
        type=varargin{3}; % 'yeo','desikan','cortical_lobes','tasks','desikan_hem','yeo_hem','feature'
        
        %         sc1_imana('cerebellarGrey_mask_SUIT',[2:22])
        for s=sn,
            sc1_imana('get_voxels_cerebellum',s,glm,'grey')
            %             sc1_imana('get_voxels_cerebellum',s,glm,'grey_nan')
            %         sc1_imana('interSubjVar_firstLevel',sn,glm,'average','grey_nan)
            for t=1:numel(type)
                sc1_imana('get_model_cortical',s,glm,type{t})
            end
        end
    case 'cerebellarGrey_mask_SUIT'     % STEP 15.1: Create an average cerebellar grey mask in SUIT space (all subjects)
        sn=varargin{1};
        
        subjs=length(sn);
        % get average cerebellar grey matter
        for s=1:subjs,
            nam{s}=fullfile(suitDir,'anatomicals',subj_name{sn(s)},'wdc1anatomical.nii');
        end
        opt.dmtx = 1;
        cd(fullfile(suitDir,'anatomicals'));
        spm_imcalc(nam,'cerebellarGreySUIT.nii','mean(X)',opt);
        
        fprintf('averaged cerebellar grey mask in SUIT space has been computed \n')
    case 'reslice_cereb_betas'          % STEP 15.2: Reslice univar pre-whitened betas into suit space
        sn=varargin{1};
        
        subjs=length(sn);
        
        for s=1:subjs,
            
            % load betas (grey) from cerebellum
            load(fullfile(regDir,'glm4',subj_name{sn(s)},'betas_cerebellum_grey.mat'));
            
            % load cerebellar mask in individual func space
            Vi=spm_vol(fullfile(suitDir,'anatomicals',subj_name{sn(s)},'maskbrainSUITGrey.nii'));
            X=spm_read_vols(Vi);
            indx=find(X>0);
            
            % make volume
            for b=1:size(B{1}.betasUW,1),
                Yy=zeros(1,Vi.dim(1)*Vi.dim(2)*Vi.dim(3));
                Yy(1,indx)=B{1}.betasUW(b,:);
                Yy=reshape(Yy,[Vi.dim(1),Vi.dim(2),Vi.dim(3)]);
                %                             Yy(Yy==0)=NaN;
                Vi.fname=fullfile(baseDir,'GLM_firstlevel_4',subj_name{sn(s)},sprintf('temp_cereb_beta_%2.4d.nii',b));
                spm_write_vol(Vi,Yy);
                clear Yy
                filenames{b}=Vi.fname;
                fprintf('beta %d done \n',b)
            end
            % reslice univar prewhitened betas into suit space
            job.subj.affineTr = {fullfile(suitDir,'anatomicals',subj_name{sn(s)},'Affine_c_anatomical_seg1.mat')};
            job.subj.flowfield= {fullfile(suitDir,'anatomicals',subj_name{sn(s)},'u_a_c_anatomical_seg1.nii')};
            job.subj.resample = filenames';
            job.subj.mask     = {fullfile(suitDir,'anatomicals',subj_name{sn(s)},'cereb_prob_corr_grey.nii')};
            job.vox           = [2 2 2];
            job.outFile       = 'mat';
            D=suit_reslice_dartel(job);
            % delete temporary files
            for b=1:size(B{1}.betasUW,1),
                delete(char(filenames(b)));
            end
            save(fullfile(suitDir,'glm4',subj_name{sn(s)},'wdBetas_UW.mat'),'D');
            fprintf('UW betas resliced into suit space for %s \n',subj_name{sn(s)});
        end
    case 'get_voxels_cerebellum'        % STEP 15.3: Get cerebellar data
        sn=varargin{1};
        glm=varargin{2};
        data=varargin{3}; % 'grey_white' or 'grey' or 'grey_nan'
        
        subjs=length(sn);
        numRuns=numel(run);
        
        for s=1:subjs,
            
            VresMS=spm_vol(fullfile(suitDir,sprintf('glm%d',glm),subj_name{sn(s)},'wdResMS.nii'));
            ResMS= spm_read_vols(VresMS);
            ResMS(ResMS==0)=NaN;
            
            % Load over all grey matter mask
            if strcmp(data,'grey'),
                V=spm_vol(fullfile(suitDir,'anatomicals',subj_name{sn(s)},'wdc1anatomical.nii')); % was cerebellarGreySUIT.nii
            else
                V=spm_vol(fullfile(suitDir,'anatomicals','cerebellarGreySUIT.nii')); % was cerebellarGreySUIT.nii
            end
            
            X=spm_read_vols(V);
            % Check if V.mat is the the same as wdResMS!!!
            grey_threshold = 0.1; % gray matter threshold
            indx=find(X>grey_threshold);
            [i,j,k]= ind2sub(size(X),indx');
            
            encodeSubjDir = fullfile(encodeDir,sprintf('glm%d',glm),subj_name{sn(s)}); dircheck(encodeSubjDir);
            glmSubjDir =[baseDir sprintf('/GLM_firstlevel_%d/',glm) subj_name{sn(s)}];
            Y=load(fullfile(glmSubjDir,'SPM_info.mat'));
            
            switch glm,
                case 4
                    % modify existing 'spm_info' structure (include zero intercept)
                    % - clean up!!
                    r=zeros(numRuns,1);
                    T=struct('run',[1:numRuns]','sess',kron([1:2]',ones(numRuns/2,1)),'cond',r,'SN',ones(numRuns,1)*sn(s),'leftHand',r,'rightHand',r);
                    T.TN=repmat({'rest'},numRuns,1);
                    Y=addstruct(Y,T);
                    Y=rmfield(Y,'task');
                case 13
                    Y.cond=repmat([1:17]',numel(run),1);
                    r=zeros(numRuns,1);
                    T=struct('run',[1:numRuns]','sess',kron([1:2]',ones(numRuns/2,1)),'cond',r,'SN',ones(numRuns,1)*sn(s));
                    T.TN=repmat({'rest'},numRuns,1);
                    Y=addstruct(Y,T);
                    Y=rmfield(Y,{'task','type','TN'});
            end
            
            switch data,
                case 'grey'
                    % univariately pre-whiten cerebellar voxels
                    nam={};
                    for b=1:length(Y.SN),
                        nam{1}=fullfile(suitDir,sprintf('glm%d',glm),subj_name{sn(s)},sprintf('wdbeta_%2.4d.nii',b));
                        V=spm_vol(nam{1});
                        B1(b,:)=spm_sample_vol(V,i,j,k,0);
                        B1(b,:)=bsxfun(@rdivide,B1(b,:),sqrt(ResMS(indx)')); % univariate noise normalisation
                    end
                    for b=1:length(Y.SN),
                        Yy=zeros(1,V.dim(1)*V.dim(2)*V.dim(3));
                        Yy(1,indx)=B1(b,:);
                        Yy=reshape(Yy,[V.dim(1),V.dim(2),V.dim(3)]);
                        Yy(Yy==0)=NaN;
                        idx=find(~isnan(Yy));
                        Yy=Yy(:);
                        Bb(b,:)=Yy(idx,:);
                    end
                    clear B1 indx
                    B1=Bb;
                    indx=idx;
                case 'grey_nan'
                    load(fullfile(suitDir,'glm4',subj_name{sn(s)},'wdBetas_UW.mat'));
                    for b=1:size(D,1),
                        dat=D(b,:,:,:);
                        Vi.dat=reshape(dat,[V.dim(1),V.dim(2),V.dim(3)]);
                        B1(b,:)=spm_sample_vol(Vi,i,j,k,0);
                    end
            end
            
            % write out new structure ('Y_info')
            Y.data=B1;
            Y.data(end-numRuns+1:end,:)=0; % make intercept (last 16 regressors) equal zero
            Y.identity=indicatorMatrix('identity_p',Y.cond);
            Y.nonZeroInd=repmat(indx',size(B1,1),1);
            
            outName= fullfile(encodeSubjDir,sprintf('Y_info_glm%d_%s.mat',glm,data));
            save(outName,'Y','-v7.3');
            fprintf('cerebellar voxels (%s) computed for %s \n',data,subj_name{sn(s)});
            clear B1 idx Bb indx
        end
    case 'map_con_surf'                 % STEP 10.1: Map betas and ResMS (.nii) onto surface (.metric)
        % Run FREESURFER before this step!
        % map volume images to metric file and save them in individual
        % surface folder
        % example: sc1_imana('map_con_surf',2,4,'cortex','con')
        sn   = varargin{1}; % subjNum
        glm  = varargin{2}; % glmNum
        type = varargin{3}; % individual ('cortex' or 'cereb')
        contrast = varargin{4}; % 'con','R','R2','relMax'
        
        glmDir =[baseDir sprintf('/GLM_firstlevel_%d',glm)];dircheck(glmDir);
        
        subjs=length(sn);
        
        vararginoptions({varargin{5:end}},{'atlas','regSide'});
        
        for s=1:subjs,
            glmSubjDir=fullfile(glmDir, subj_name{sn(s)});
            switch type
                case 'cortex'
                    for h=regSide,
                        caretSDir = fullfile(caretDir,[atlasA,subj_name{sn(s)}],hemName{h});
                        white=fullfile(caretSDir,[hem{h} '.WHITE.coord']);
                        pial=fullfile(caretSDir,[hem{h} '.PIAL.coord']);
                        
                        C1=caret_load(white);
                        C2=caret_load(pial);
                        fileList = [];
                        outfile  = [];
                        
                        % rename contrast
                        if strcmp(contrast,'con'),
                            contrast='con_';
                        end
                        
                        filenames = dir(fullfile(glmSubjDir,sprintf('*%s*',contrast)));
                        outfile = sprintf('%s_glm%d_%s_cortex_%s.metric',subj_name{sn(s)},glm,contrast,hem{h});
                        
                        for t = 1:length(filenames),
                            fileList{t} = {filenames(t).name};
                        end
                        
                        for f=1:length(fileList),
                            images(f)=spm_vol(fullfile(glmSubjDir,fileList{f}));
                        end;
                        M=caret_vol2surf_own(C1.data,C2.data,images);
                        caret_save(fullfile(caretSDir,outfile),M);
                        
                        fprintf('%s map to surface for %s:%s \n',contrast,subj_name{sn(s)},hemName{h});
                    end;
                case 'cereb'
                    caretSDir = fullfile(caretDir,[atlasA,subj_name{sn(s)}],'cerebellum'); dircheck(caretSDir);
                    fileList = [];
                    outfile  = [];
                    
                    % rename contrast
                    if strcmp(contrast,'con'),
                        contrast='wdcon';
                    end
                    
                    filenames = dir(fullfile(suitDir,sprintf('glm%d',glm),subj_name{sn(s)},sprintf('*%s_*',contrast)));
                    contrast='con';
                    outfile = sprintf('%s_glm%d_%s_cereb.metric',subj_name{sn(s)},glm,contrast);
                    
                    for t = 1:length(filenames),
                        fileList{t} = {filenames(t).name};
                    end
                    
                    for f=1:length(fileList)
                        images(f)=spm_vol(fullfile(suitDir,sprintf('glm%d',glm),subj_name{sn(s)},fileList{f}));
                    end;
                    M=caret_suit_map2surf(images,'space','SUIT','stats','nanmean');
                    caret_save(fullfile(caretSDir,outfile),M);
                    
                    fprintf('%s map to surface for %s \n',contrast,subj_name{sn(s)});
                otherwise
                    disp('there is no such case')
            end
        end
    case 'get_vertices_cortex'
        sn=varargin{1};
        glm=varargin{2};
        
        subjs=length(sn);
        numRuns=numel(run);
        
        for s=1:subjs,
            for h=1:2,
                caretSDir = fullfile(caretDir,[atlasA,subj_name{sn(s)}],hemName{h});
                
                ResMS=caret_load(fullfile(caretSDir,sprintf('%s_glm%d_ResMS_cortex_%s.metric',subj_name{sn(s)},glm,hem{h})));
                ResMS.data(ResMS.data==0)=NaN;
                
                glmSubjDir =[baseDir sprintf('/GLM_firstlevel_%d/',glm) subj_name{sn(s)}];
                Y=load(fullfile(glmSubjDir,'SPM_info.mat'));
                
                % modify existing 'spm_info' structure (include zero intercept)
                % - clean up!!
                r=zeros(numRuns,1);
                T=struct('run',[1:numRuns]','sess',kron([1:2]',ones(numRuns/2,1)),'cond',r,'SN',ones(numRuns,1)*sn(s),'leftHand',r,'rightHand',r);
                T.TN=repmat({'rest'},numRuns,1);
                Y=addstruct(Y,T);
                Y=rmfield(Y,'task');
                
                % not doing univariate noise normalisation (matrix - too large)
                B1=caret_load(fullfile(caretSDir,sprintf('%s_glm%d_beta_cortex_%s.metric',subj_name{sn(s)},glm,hem{h})));
                
                % write out new structure
                Y.data=B1.data';
                Y.data(end-numRuns+1:end,:)=0; % make intercept (last 16 regressors) equal zero
                Y.identity=indicatorMatrix('identity_p',Y.cond);
                
                outName= fullfile(encodeDir,'glm4',subj_name{sn(s)},sprintf('%s_info_glm%d_grey.mat',hem{h},glm));
                save(outName,'Y','-v7.3');
                fprintf('Y structure for the cortex (%s) has been computed for %s \n',hem{h},subj_name{sn(s)});
                clear B1
            end
        end
    case 'get_model_cortical'
        % STEP 15.5: Get cortical model (intended for use in 'run_encoding' step)
        sn=varargin{1};
        glm=varargin{2};
        type=varargin{3}; % 'cortical_lobes','yeo','desikan','cerebellum','tasks','feature','tasks_saccades_hands','desikan_hem','yeo_hem','yeo_reduced'
        
        subjs=length(sn);
        for s=1:subjs,
            X=[];
            encodeSubjDir = fullfile(encodeDir,sprintf('glm%d',glm),subj_name{sn(s)}); dircheck(encodeSubjDir);
            glmSubjDir =[baseDir sprintf('/GLM_firstlevel_%d/',glm) subj_name{sn(s)}];
            D=load(fullfile(glmSubjDir,'SPM_info.mat'));
            switch type
                case 'cortical_lobes'
                    load(fullfile(regDir,sprintf('glm%d',glm),subj_name{sn(s)},sprintf('betas_%s.mat',type)));
                    for r=1:length(B),
                        X.Xx(r,:)=mean(B{r}.betasUW,2);
                        X.idx(r,:)=r;
                    end
                    X.Xx(:,size(X.Xx,2)-numel(run)+1:size(X.Xx,2))=0; % zero out last 'intercept' run
                case 'yeo'
                    load(fullfile(regDir,sprintf('glm%d',glm),subj_name{sn(s)},sprintf('betas_%s.mat',type)));
                    networks=[2:18];
                    for r=1:17, % we don't want 'FreeSurfer_Defined_Medial_Wall'
                        X.Xx(r,:)=mean(B{networks(r)}.betasUW,2);
                        X.idx(r,1)=networks(r);
                    end
                    X.Xx(:,size(X.Xx,2)-numel(run)+1:size(X.Xx,2))=0; % zero out last 'intercept' run
                case 'yeo_hem'
                    load(fullfile(regDir,sprintf('glm%d',glm),subj_name{sn(s)},sprintf('betas_%s.mat',type)));
                    networks=[2:18,20:36]; % not interested in freesurfer defined medial wall
                    paintFileNums=repmat([2:18],1,2);
                    for r=1:34,
                        X.Xx(r,:)=mean(B{networks(r)}.betasUW,2);
                        X.idx(r,1)=paintFileNums(r);
                    end
                    X.Xx(:,size(X.Xx,2)-numel(run)+1:size(X.Xx,2))=0; % zero out last 'intercept' run
                case 'desikan'
                    load(fullfile(regDir,sprintf('glm%d',glm),subj_name{sn(s)},sprintf('betas_%s.mat',type)));
                    networks=[2:36]; % remove 'medial wall'
                    for r=1:35,
                        X.Xx(r,:)=mean(B{networks(r)}.betasUW,2);
                        X.idx(r,1)=networks(r);
                    end
                    X.Xx(:,size(X.Xx,2)-numel(run)+1:size(X.Xx,2))=0; % zero out last 'intercept' run
                case 'desikan_hem'
                    load(fullfile(regDir,sprintf('glm%d',glm),subj_name{sn(s)},sprintf('betas_%s.mat',type)));
                    networks=[2:36,38:72];
                    paintFileNums=repmat([2:36],1,2);
                    for r=1:70,
                        X.Xx(r,:)=mean(B{networks(r)}.betasUW,2);
                        X.idx(r,1)=paintFileNums(r);
                    end
                    X.Xx(:,size(X.Xx,2)-numel(run)+1:size(X.Xx,2))=0; % zero out last 'intercept' run
                case '162_tessellation'
                    load(fullfile(regDir,sprintf('glm%d',glm),subj_name{sn(s)},sprintf('betas_%s.mat',type)));
                    tessels=[1:148,150:158];
                    for r=1:157, % we don't want 'FreeSurfer_Defined_Medial_Wall' - tessel number 149
                        X.Xx(r,:)=mean(B{tessels(r)}.betasUW,2);
                        X.idx(r,1)=tessels(r);
                    end
                    X.Xx(:,size(X.Xx,2)-numel(run)+1:size(X.Xx,2))=0; % zero out last 'intercept' run
                case '162_tessellation_hem'
                    load(fullfile(regDir,sprintf('glm%d',glm),subj_name{sn(s)},sprintf('betas_%s.mat',type)));
                    I=load(fullfile(regDir,'data','162_reorder.mat'));
                    for r=1:length(B),
                        % determine good and bad tessels
                        if I.good(r)==1,
                            X.Xx(r,:)=mean(B{r}.betasUW,2);
                        end
                        X.idx(r,1)=r;
                        goodIdx(r,1)=I.good(r);
                    end
                    X.Xx(:,size(X.Xx,2)-numel(run)+1:size(X.Xx,2))=0; % zero out last 'intercept' run
                    X=getrow(X,goodIdx==1);
                case 'tasks'
                    load(fullfile(encodeDir,subj_name{sn(s)},sprintf('Y_info_glm%d_grey.mat',glm)));
                    X.idx=[1:29]';
                    X.Xx=indicatorMatrix('identity_p',D.cond)';
                    X.Xx(:,size(X.Xx,2)-numel(run)+1:size(X.Xx,2))=0; % zero out last 'intercept' run
                case 'feature'
                    F=sc1_imana('make_feature_model');
                    F=getrow(F,[1:30]'); % remove instructions
                    T   = [F.lHand./F.duration F.rHand./F.duration F.saccades./F.duration F.responseAlt./F.duration F.visualStim./F.duration ...
                        F.verbalSem./F.duration F.workMem./F.duration F.episMem./F.duration F.VisAtt./F.duration F.action./F.duration];
                    %                     T   = [T eye(size(F.duration,1))];
                    T   = bsxfun(@minus,T,mean(T));
                    T   = bsxfun(@rdivide,T,sqrt(sum(T.^2)));  % Normalize to unit length vectors
                    % make cond x run x features
                    for f=1:size(T,2),
                        X.Xx(:,f)=repmat(T(:,f),numel(run),1);
                    end
                    X.Xx=X.Xx';
                    X.Xx(:,size(X.Xx,2)-numel(run)+1:size(X.Xx,2))=0; % zero out last 'intercept' run
                    X.idx=[1:size(X.Xx,1)]';
                case 'crossSubj_162'
                    others=sn(sn~=sn(s)); % leave out one subject
                    I=load(fullfile(regDir,'data','162_reorder.mat'));
                    for ss=1:length(others), % loop over all other subjects
                        load(fullfile(regDir,sprintf('glm%d',glm),subj_name{others(ss)},'betas_162_tessellation_hem.mat'));
                        for r=1:length(B),
                            % determine good and bad tessels
                            if I.good(r)==1,
                                Xx(ss,r,:)=mean(B{r}.betasUW,2);
                            end
                            X.idx(r,1)=r;
                            goodIdx(r,1)=I.good(r);
                        end
                        fprintf('subj%d done \n',others(ss))
                    end
                    Xx=nanmean(Xx,1); % get average across all other subjects
                    X.Xx=reshape(Xx,[size(Xx,2),size(Xx,3)]);
                    X.Xx(:,size(X.Xx,2)-numel(run)+1:size(X.Xx,2))=0; % zero out last 'intercept' run
                    X=getrow(X,goodIdx==1);
                    clear Xx
            end
            outFile=sprintf('%s_glm%d_model.mat',type,glm);
            save(fullfile(encodeSubjDir,outFile),'X');
            fprintf('%s-weighted betas (glm%d) (X) have been computed for %s \n',type,glm,subj_name{sn(s)});
        end
    case 'model_simulation'             % STEP 14.5: Make simulated data for generative models
        sn=varargin{1};
        glm=varargin{2};
        type=varargin{3}; % 'yeo', 'desikan'
        modelType=varargin{4}; % 'normal','uni','sparseP'
        numConn=varargin{5}; % constrain to # of networks
        
        encodeSubjDir = fullfile(encodeDir,subj_name{sn}); dircheck(encodeSubjDir);
        glmSubjDir =[baseDir sprintf('/GLM_firstlevel_%d/',glm) subj_name{sn}];
        D=load(fullfile(glmSubjDir,'SPM_info.mat'));
        
        % Set variables
        methods = {'cplexqp','cplexqp','cplexqp','cplexqp','cplexqp'};
        Lambda  = [0;50;100;500;1000];
        threshold = {[1e-4],[1e-4],[1e-4],[1e-4],[1e-4]};
        numCond=29;
        numRuns = numel(run);
        P = 30; % Number of voxels
        N = (numCond+1)*numRuns;
        sigma_signal=0.08; % pattern consistency for cerebellum is %10
        sigma_noise=1;
        
        % Utility vectors and matrices
        D.cond = [kron(ones(numRuns,1),[1:numCond]');ones(numRuns,1)*(numCond+1)];
        Z =    indicatorMatrix('identity',D.cond);
        D.part = [kron([1:numRuns]',ones(numCond,1));[1:numRuns]'];
        B = indicatorMatrix('identity',D.part);
        R  = eye(N)-B*pinv(B);
        
        % design matrix
        load(fullfile(encodeSubjDir,sprintf('%s_glm%d_model.mat',type,glm)));
        Q  = size(X,2);                   % Number of networks / regressors
        X = R*X;            % Subtract block mean
        X=bsxfun(@rdivide,X,sqrt(sum(X.*X)/(size(X,1)-numRuns)));
        
        for n=1:4
            switch(modelType)
                case 'normal'
                    U = normrnd(0,sigma_signal,Q,P);
                case 'uni'
                    U = unifrnd(0,1,Q,P);
                    U = U./std(U(:))*sigma_signal;
                case 'sparseP'
                    U = zeros(Q,P);
                    for p=1:P
                        q=randperm(Q);
                        U(q(1:numConn),p)=1;
                    end;
                    U = U./std(U(:))*sigma_signal;
            end;
            Y = X*U+ normrnd(0,sigma_noise,N,P);
            Y = R*Y;
            Y=bsxfun(@rdivide,Y,sqrt(sum(Y.*Y)/(size(Y,1)-numRuns)));
            numT = cellfun(@numel,threshold);
            numT = [0 cumsum(numT)];
            for m=1:length(methods)
                indx = [(numT(m)+1):numT(m+1)];
                [Uhat{m},T.fR2(n,indx),T.fR(n,indx)]=sc1_encode_fit(Y,X,methods{m},'lambda',Lambda(m),'threshold',threshold{m});
                for i = 1:length(threshold{m})
                    T.numReg(n,numT(m)+i) = mean(sum(abs(Uhat{m})>threshold{m}(i)));
                end;
                maxReg = max(abs(Uhat{m}))./sum(abs(Uhat{m}));
                T.maxReg(n,indx) = mean(max(abs(Uhat{m})));
                T.sumReg(n,indx) = mean(sum(abs(Uhat{m})));
                T.relMaxReg(n,indx)=mean(maxReg);
                
                [T.cR2(n,indx),T.cR(n,indx)]=sc1_encode_crossval(Y,X,D.part,methods{m},'lambda',Lambda(m),'threshold',threshold{m});
            end;
        end;
        varargout={T,Uhat};
        subplot(4,1,1);
        traceplot(Lambda,T.fR,'errorfcn','stderr');
        xlabel('lambda')
        ylabel('R value (fit)')
        subplot(4,1,2);
        traceplot(Lambda,T.cR,'errorfcn','stderr');
        xlabel('lambda')
        ylabel('R value (crossval)')
        subplot(4,1,3);
        traceplot(Lambda,T.relMaxReg,'errorfcn','stderr');
        xlabel('lambda')
        ylabel('portion of total regressors')
        subplot(4,1,4)
        traceplot(Lambda,T.numReg,'errorfcn','stderr');
        xlabel('lambda')
        ylabel('# of regressors > 0')
    case 'interSubjVar_firstLevel'      % STEP 15.4: Calculate within and between-subj variability for first-level betas using cerebellar grey voxels in SUIT space
        sn=varargin{1};
        glm=varargin{2};
        step=varargin{3}; % 'average', 'tasks'
        data=varargin{4}; % 'grey_white','grey'
        
        subjs=length(sn);
        switch step,
            case 'average'
                for sub=1:subjs,
                    glmSubjDir =[baseDir sprintf('/GLM_firstlevel_%d/',glm) subj_name{sn(sub)}];
                    D=load(fullfile(glmSubjDir,'SPM_info.mat'));
                    
                    % load Y
                    load(fullfile(encodeDir,subj_name{sn(sub)},sprintf('Y_info_glm%d_%s.mat',glm,data)));
                    
                    % set up identity matrix (session)
                    X = indicatorMatrix('identity_p',1:length(D.sess)/2);
                    
                    for sess=1:2,
                        
                        W=(X'*X)\(X'*Y.data(D.sess==sess,:));
                        
                        for s=1:subjs,
                            
                            % load Y
                            load(fullfile(encodeDir,subj_name{sn(s)},sprintf('Y_info_glm%d_%s.mat',glm,data)));
                            
                            for ss=1:2,
                                
                                B=(X'*X)\(X'*Y.data(D.sess==ss,:));
                                
                                % calculate correlation
                                tmp=nancorr(vertcat(mean(W),mean(B))');
                                R(sub*2-2+sess,s*2-2+ss)=tmp(2);
                                L{sub*2-2+sess,s*2-2+ss}= sprintf('subj%d-sess%d-subj%d-sess%d',sub,sess,s,ss);
                                fprintf('corr calculated for subj%d-sess%d and subj%d-sess%d \n',sub,sess,s,ss)
                            end
                        end
                    end
                end
                I{1}.R=R;
                I{1}.SN=L;
            case 'tasks'
                for c=1:29,
                    for sub=1:subjs,
                        glmSubjDir =[baseDir sprintf('/GLM_firstlevel_%d/',glm) subj_name{sn(sub)}];
                        D=load(fullfile(glmSubjDir,'SPM_info.mat'));
                        
                        % load Y
                        load(fullfile(encodeDir,subj_name{sn(sub)},'Y_info_grey.mat'));
                        
                        % set up identity matrix (session)
                        X = indicatorMatrix('identity_p',1:length(D.sess)/2);
                        
                        for sess=1:2,
                            
                            W=(X'*X)\(X'*Y.data(D.sess==sess,:));
                            A=getrow(D,D.sess==sess);
                            W1=nanmean(W(A.cond==c,:));
                            
                            for s=1:subjs,
                                
                                % load Y
                                load(fullfile(encodeDir,subj_name{sn(s)},'Y_info_grey.mat'));
                                
                                for ss=1:2,
                                    
                                    B=(X'*X)\(X'*Y.data(D.sess==ss,:));
                                    C=getrow(D,D.sess==sess);
                                    B1=nanmean(B(C.cond==c,:));
                                    
                                    % calculate correlation
                                    tmp=nancorr(vertcat(W1,B1)');
                                    R(sub*2-2+sess,s*2-2+ss)=tmp(2);
                                    L{sub*2-2+sess,s*2-2+ss}=sprintf('subj%d-sess%d-subj%d-sess%d',sub,sess,s,ss);
                                    T(sub*2-2+sess,s*2-2+ss)=unique(A.TN(A.cond==c));
                                    fprintf('corr calculated for subj%d-sess%d and subj%d-sess%d for %s \n',sub,sess,s,ss,char(unique(A.TN(A.cond==c))))
                                end
                            end
                        end
                    end
                    I{c}.R=R;
                    I{c}.SN=L;
                    I{c}.TN=T;
                end
        end
        outName= fullfile(encodeDir,sprintf('interSubjVar_firstLevel_%s.mat',step));
        save(outName,'I','-v7.3');
        
    case 'map_cortex_cerebellum'        % Map cortex to cerebellum (encoding models)
        sn=varargin{1};
        type=varargin{2};
        method=varargin{3};
        data=varargin{4};
        threshold=varargin{5};
        lambda=varargin{6};
        
        for s=sn,
            sc1_imana('run_encoding',s,4,'yes',type,method,data,threshold,lambda)
        end
    case 'run_encoding'                 % STEP 16.1: run all encoding models
        sn=varargin{1}; % [2:22]
        glm=varargin{2}; % usually 4
        normalise=varargin{3}; % yes or no (yes - remove mean from each voxel (X and Y) for each run across conditions)
        type=varargin{4}; % 'yeo','yeo_hem','whole_brain','desikan','desikan_hem','cortical_lobes','ica','tasks','feature','crossSubj_162'
        method=varargin{5}; % linRegress, ridgeFixed, nonNegExp, cplexqp, lasso, winnerTakeAll
        data=varargin{6}; % 'grey' or 'grey_white' or 'grey_nan'
        threshold=varargin{7}; % 1e-4 for 'cplexqp_L2' or 'cplexqp' and -inf for all others
        lambda=varargin{8}; % {0,5,10,25,50,100} - cplexqp; {0,25,50,150,300,500,700,1000} - cplexqp_L2
        encodeType=varargin{9}; % 1,2,3 etc depending on which betas are included in X (model) and Y (data)
        
        subjs=length(sn);
        
        for s=1:subjs,
            Yp=[];
            
            % determine encoding directory
            encodeSubjDir = fullfile(encodeDir,sprintf('glm%d',glm),subj_name{sn(s)}); dircheck(encodeSubjDir);
            
            % load Y
            load(fullfile(encodeSubjDir,sprintf('Y_info_glm%d_%s.mat',glm,data)));
            
            % load X
            load(fullfile(encodeSubjDir,sprintf('%s_glm%d_model.mat',type,glm)));
            cortIdx=X.idx;
            X=X.Xx;
            X=X';
            
            switch encodeType,
                case 'original'
                    % do nothing
                case 'noInstruct'
                    % remove instruct
                    glmSubjDir =[baseDir sprintf('/GLM_firstlevel_%d/',glm) subj_name{sn(s)}];
                    D=load(fullfile(glmSubjDir,'SPM_info.mat'));
                    D.cond(size(D.SN,1)+1:size(D.SN,1)+numel(run))=0;
                    Y=getrow(Y,D.cond~=1); % no instruct!!
                    Y.identity=indicatorMatrix('identity_p',Y.cond); % remove instruct from identity matrix
                    X(D.cond==1,:)=[];
                case 'crossSubj_162'
                    % do nothing
            end
            
            switch normalise
                case 'yes'
                    numCond=size(Y.identity,2);
                    N = (numCond+1)*numel(run);
                    B = indicatorMatrix('identity',Y.run);
                    R  = eye(N)-B*pinv(B);
                    X = R*X;            % Subtract block mean
                    X=bsxfun(@rdivide,X,sqrt(sum(X.*X)/(size(X,1)-numel(run))));
                    Yact = R*Y.data;
                    Yact=bsxfun(@rdivide,Yact,sqrt(sum(Yact.*Yact)/(size(Yact,1)-numel(run))));
                case 'no'
                    Yact=Y.data;
            end
            
            for l=1:length(lambda),
                [Uhat,T.fR2m,T.fRm,~,~,C]=sc1_encode_fit(Yact,X,method,'threshold',threshold,'lambda',lambda{l});
                
                % results
                T.numRegm=mean(sum(abs(Uhat)>threshold));
                maxReg=max(abs(Uhat))./sum(abs(Uhat));
                T.maxRegm=mean(max(abs(Uhat)));
                T.sumRegm=mean(sum(abs(Uhat)));
                T.relMaxRegm=mean(maxReg);
                T.numRegv=sum(abs(Uhat)>threshold);
                T.maxRegv=max(abs(Uhat));
                T.sumRegv=sum(abs(Uhat));
                T.relMaxRegv=maxReg;
                T.nonZeroInd=Y.nonZeroInd(1,:);
                T.lambda=lambda{l};
                T.betas=Uhat;
                T.cortIdx=cortIdx;
                T.idxLambda=repmat(lambda{l},size(Uhat,1),1);
                T.compIdx=C;
                T.catName={sprintf('%s-%s-%d',type,method,T.lambda)};
                T.encodeType=encodeType;
                
                %                 [T.cR2m,T.cRm,T.cR2v,T.cRv]=sc1_encode_crossval(Yact,X,Y.run,method,'threshold',threshold,'lambda',lambda{l});
                %                 Yp=addstruct(Yp,T);
                Yp=T;
            end
            
            outName=fullfile(encodeDir,sprintf('glm%d',glm),sprintf('encode_%s',encodeType),subj_name{sn(s)},sprintf('encode_%s_%s_%s.mat',type,method,data));
            dircheck(fullfile(encodeDir,sprintf('glm%d',glm),sprintf('encode_%s',encodeType),subj_name{sn(s)}));
            save(outName,'Yp','-v7.3');
            fprintf('encode model (%s + %s): cerebellar voxels predicted for %s \n',type,method,subj_name{sn(s)});
        end
    case 'map_to_surface_all'           % STEP 16.2: map any stats from the encoding models to the cerebellar surface
        sn=varargin{1};   % single subject (2) or all subjecs (2:17)
        type=varargin{2}; % yeo, yeo_hem, desikan, desikan_hem, 162_tessellation, 162_tessellation_hem
        method=varargin{3}; % cplexqp or cplexqp_L2 (we don't do winnerTakeAll in this case)
        lambda=varargin{4}; % optimal lambda for that model
        ana=varargin{5}; % betas, relMax, R, R2, numReg
        metric=varargin{6}; % make metric file: 'yes' or 'no'
        encodeType=varargin{7}; % 1 or 2
        stat=varargin{8}; % 'yes' or 'no'
        
        subjs=length(sn);
        threshold=.05;
        
        for s=1:subjs,
            V=[];
            encodeSubjDir = fullfile(encodeDir,'glm4',sprintf('encode_%d',encodeType),subj_name{sn(s)});
            
            load(fullfile(encodeSubjDir,sprintf('encode_%s_%s_grey.mat',type,method)));
            
            % make cerebellar volume
            B=spm_vol(fullfile(suitDir,'glm4',subj_name{sn(s)},'wdResMS.nii'));
            Yy=zeros(1,B.dim(1)*B.dim(2)*B.dim(3));
            switch ana
                case 'betas_mean'
                    A=Yp.betas(Yp.idxLambda==lambda,:);
                    A(A<threshold)=nan;
                    A=nanmean(A,1);
                    Yy(1,Yp.nonZeroInd(Yp.lambda==lambda,:))=A;
                    stats='nanmean';
                case 'relMax'
                    A=Yp.relMaxRegv(Yp.lambda==lambda,:);
                    Yy(1,Yp.nonZeroInd(Yp.lambda==lambda,:))=A;
                    stats='nanmean';
                case 'R'
                    A=Yp.cRv(Yp.lambda==lambda,:);
                    Yy(1,Yp.nonZeroInd(Yp.lambda==lambda,:))=A;
                    stats='nanmean';
                case 'R2'
                    A=Yp.cR2v(Yp.lambda==lambda,:);
                    Yy(1,Yp.nonZeroInd(Yp.lambda==lambda,:))=A;
                    stats='nanmean';
                case 'numBetas>threshold'
                    A=Yp.betas(Yp.idxLambda==lambda,:);
                    A(A<threshold)=nan;
                    for p=1:size(A,2),
                        c(:,p)=length(find(~isnan(A(:,p))));
                    end
                    Yy(1,Yp.nonZeroInd(Yp.lambda==lambda,:))=c;
                    stats='nanmean';
                    clear c
            end
            Yy=reshape(Yy,[B.dim(1),B.dim(2),B.dim(3)]);
            Yy(Yy==0)=NaN;
            V{1}.dat=Yy;
            V{1}.dim=B.dim;
            V{1}.mat=B.mat;
            M=caret_suit_map2surf(V,'space','SUIT','stats',stats);  % MK created caret_suit_map2surf to allow for output to be used as input to caret_save
            M.column_name={sprintf('%s_%s_%s',type,method,ana)};
            vertices(:,s)=M.data;
        end
        
        switch stat,
            case 'yes'
                D=caret_load('motor_regions.paint');
                vertices(D.data==0)=nan;
                vertices=nanmean(vertices,1);
                %                 nmIdx=find(vertices(D.data==0));
                %                 mIdx=find(vertices(D.data~=0));
                
                [t,p]=ttest(vertices,.3,1,'independent');
                
                cStats=caret_getcSPM('onesample_t','data',vertices(:,1:subjs));
                P=spm_P_FDR(cStats.con.Z,cStats.con.df,'Z',1,sort(cStats.con.Z_P,'ascend'));
                %                 P=spm_P_Bonf(cStats.con.Z,cStats.con.df,'Z',size(cStats.data,1),1);
                c=cStats.con.Z;
                c(P>threshold)=nan;
                indices=c;
            case 'no'
                % average across subjects
                indices=nanmean(vertices,2);
        end
        
        figure()
        suit_plotflatmap(indices,'type','func','cscale',[min(indices),max(indices)]);
        colorbar
        
        switch metric,
            case 'yes'
                caret_save(fullfile(caretDir,'suit_flat','glm4'),M);
            case 'no'
                disp('not making metric file')
        end
    case 'interSubjVar_encoding'        % STEP 16.3: calculate within and between-subj variability for betas from encoding model
        sn=varargin{1};   % single subject (2) or all subjecs (2:17)
        type=varargin{2}; % yeo, yeo_hem, desikan, desikan_hem, 162_tessellation, 162_tessellation_hem crossSubj_162
        method=varargin{3}; % cplexqp or cplexqp_L2 (we don't do winnerTakeAll in this case)
        lambda=varargin{4}; % optimal lambda for that model
        encodeType=varargin{5};
        step=varargin{6}; % 'group_betas' or 'interSubj_corr'
        
        subjs=length(sn);
        threshold=.001;
        
        switch step
            case 'group_betas'
                % loop over subjs & get betas
                for s=1:subjs,
                    V=[];
                    encodeSubjDir = fullfile(encodeDir,'glm4',sprintf('%s',encodeType),subj_name{sn(s)});
                    
                    load(fullfile(encodeSubjDir,sprintf('encode_%s_%s_grey.mat',type,method)));
                    
                    % make cerebellar volume
                    Q=size(Yp.betas,1)/size(Yp.lambda,1);
                    B=spm_vol(fullfile(suitDir,'glm4',subj_name{sn(s)},'wdResMS.nii'));
                    Yy=zeros(Q,B.dim(1)*B.dim(2)*B.dim(3));
                    
                    % get optimal betas
                    A=Yp.betas(Yp.idxLambda==lambda,:);
                    A(A<threshold)=nan;
                    Yy(:,Yp.nonZeroInd(Yp.lambda==lambda,:))=A;
                    
                    for q=1:Q,
                        a=reshape(Yy(q,:),[B.dim(1),B.dim(2),B.dim(3)]);
                        a(a==0)=nan;
                        V{1}.vol=a;
                        V{1}.dim=B.dim;
                        V{1}.mat=B.mat;
                        vertices(:,q,s)=suit_map2surf(V,'space','SUIT','stats','nanmean');  % MK changed suit_map2surf function to accept structures!!
                    end
                end
                outName=fullfile(encodeDir,sprintf('allSubjs_betas_%s.mat',type));
                save(outName,'vertices')
            case 'interSubj_corr'
                load(fullfile(encodeDir,sprintf('allSubjs_betas_%s.mat',type)));
                P=size(vertices,1);
                % loop over voxels
                for p=1:P,
                    for sub=1:subjs,
                        W=vertices(p,:,sub);
                        for s=1:subjs,
                            B=vertices(p,:,s);
                            % calculate correlation
                            tmp=nancorr(horzcat([W',B'])); % MK changed the mycorr function
                            R(sub,s)=tmp(2);
                            %                             L{sub,s}= sprintf('subj%d-subj%d',sub,s);
                        end
                    end
                    % extract lower triangular of square matrix R
                    [~,n]=size(R);
                    Z = R(tril(true(n),-1));
                    Z = Z(:)';
                    %             I(p,1)=mean(Z>0); % only take positive correlations?
                    I(p,1)=nanmean(Z);
                    fprintf('voxel %d \n',p)
                end
                outName=fullfile(encodeDir,sprintf('interSubjVar_%s.mat',type));
                save(outName,'I')
        end
    case 'map_winner_to_surface'        % STEP 16.5: do winnerTakeAll on group level - create paint and area colour files
        sn=varargin{1};
        type=varargin{2}; % 'yeo','yeo_hem','desikan','desikan_hem','cortical_lobes'
        method=varargin{3}; % 'winnerTakeAll' or 'winnerTakeAll_nonNeg'
        data=varargin{4}; % 'grey_nan'
        winner=varargin{5}; % which winner do we want? - 1,2,3,etc
        encodeType=varargin{6};
        
        % get correlations across subjs
        subjs=length(sn);
        for s=1:subjs,
            encodeSubjDir = fullfile(encodeDir,'glm4',sprintf('encode_%d',encodeType),subj_name{sn(s)});
            load(fullfile(encodeSubjDir,sprintf('encode_%s_%s_%s.mat',type,method,data)));
            W(s,:,:)=Yp.compIdx;
        end
        
        % get component indices (on group level)
        V=zeros(size(W,3),1);
        for p=1:size(W,3),
            C=nanmean(W(:,:,p));
            A=sort(C,'descend');
            R=A(winner);
            I=find(C==R);
            if isempty(I),
                I=0;
            end
            V(p,:)=I;
        end
        
        switch type,
            case 'yeo'
                paintNames=yeoNames;
            case 'yeo_rest'
                paintNames=yeoNames;
            case 'yeo_ToM'
                paintNames=yeoNames;
            case 'yeo_special'
                paintNames=yeoNames;
            case 'yeo_specialControl'
                paintNames=yeoNames;
            case 'yeo_random1'
                paintNames=yeoNames;
            case 'yeo_hem'
                paintNames=yeoHemNames;
            case 'desikan'
                paintNames=desikanNames;
            case 'desikan_hem'
            case 'cortical_lobes'
                paintNames=corticalNames;
            case 'desikan_special'
                paintNames=desikanSpecialNames;
        end
        
        % make paintfile
        caretGroupDir = fullfile(caretDir,'suit_flat','glm4');
        B=spm_vol(fullfile(suitDir,'glm4',subj_name{sn(s)},'wdResMS.nii'));
        Yy=zeros(1,B.dim(1)*B.dim(2)*B.dim(3));
        Yy(1,Yp.nonZeroInd)=V;
        Yy=reshape(Yy,[B.dim(1),B.dim(2),B.dim(3)]);
        Yy(Yy==0)=NaN;
        S{1}.dat=Yy;
        S{1}.dim=B.dim;
        S{1}.mat=B.mat;
        S{1}.fname=fullfile(encodeDir,sprintf('%s_%s_%d.nii',method,type,winner));
        M=caret_suit_map2surf(S,'space','SUIT','stats','mode','type','paint');
        M.paintnames=paintNames;
        caret_save(fullfile(caretGroupDir,sprintf('cereb.%s_%s_%d.paint',method,type,encodeType)),M);
        
        % make area colour
        numConds=size(W,2);
        cmap=load(fullfile(encodeDir,sprintf('winnerTakeAll_%s.colour.txt',type)));
        M.encoding={'BINARY'};
        M.column_name=M.paintnames;
        M.column_color_mapping=repmat([-5 5],numConds,1);
        M.paintnames=paintNames;
        M.data=cmap(1:numConds,2:4);
        caret_save(fullfile(caretGroupDir,sprintf('cereb.%s_%s.areacolor',method,type)),M);
    case 'calculate_DICE_coefficient'   % STEP 16.6: calculate DICE coefficient for 'labeled' maps
        glm=varargin{1};
        img1=varargin{2};
        img2=varargin{3};
        
        switch img1,
            case 'desikan_special'
                C=caret_load(fullfile(caretDir,'suit_flat',sprintf('glm%d',glm),sprintf('cereb.winnerTakeAll_%s.paint',img1)));
                I1Labels=C.data;
                I1Idx=C.index;
            case 'Buckner'
                C=caret_load(fullfile(caretDir,'suit_flat','Buckner_17Networks.paint'));
                I1Labels=C.data(:,1);
                I1Idx=C.index(:,1);
            case 'yeo'
                C=caret_load(fullfile(caretDir,'suit_flat',sprintf('glm%d',glm),sprintf('cereb.winnerTakeAll_%s.paint',img1)));
                I1Labels=C.data;
                I1Idx=C.index;
        end
        
        switch img2,
            case 'desikan_special'
                D=caret_load(fullfile(caretDir,'suit_flat',sprintf('glm%d',glm),sprintf('cereb.winnerTakeAll_%s.paint',img2)));
                I2Labels=D.data;
                I2Idx=D.index;
            case 'Buckner'
                D=caret_load(fullfile(caretDir,'suit_flat','Buckner_17Networks.paint'));
                I2Labels=D.data(:,1);
                I2Idx=D.index(:,1);
            case 'yeo'
                D=caret_load(fullfile(caretDir,'suit_flat',sprintf('glm%d',glm),sprintf('cereb.winnerTakeAll_%s.paint',img2)));
                I2Labels=D.data;
                I2Idx=D.index;
        end
        
        S=[];
        % loop over features (networks)
        for q=1:C.num_paintnames,
            F1=I1Idx(I1Labels==q);
            F2=I2Idx(I2Labels==q);
            T.overlap=length(intersect(F1,F2));
            T.sumImg1=length(F1);
            T.sumImg2=length(F2);
            T.DiceCoef=abs(2*T.overlap)/(T.sumImg1+T.sumImg2);
            T.sumTotal=T.sumImg1+T.sumImg2;
            T.relTotalImg1=(T.sumImg1/T.sumTotal)*100;
            T.relTotalImg2=(T.sumImg2/T.sumTotal)*100;
            T.feature=q;
            S=addstruct(S,T);
        end
        overallDICE=sum(abs(2*S.overlap))/sum(S.sumImg1+S.sumImg2);
        
        % plot results
        figure
        subplot(4,1,1)
        title(sprintf('Similarity between %s and %s maps',img1,img2))
        hold on
        barplot(S.feature,S.relTotalImg1)
        ylabel(sprintf('percentage explained by %s',img1))
        xlabel(sprintf('%s areas',img1))
        subplot(4,1,2)
        barplot(S.feature,S.relTotalImg2)
        ylabel(sprintf('percentage explained by %s',img2))
        xlabel(sprintf('%s areas',img2))
        subplot(4,1,3)
        barplot(S.feature,S.DiceCoef)
        ylabel('Dice Coeff')
        subplot(4,1,4)
        barplot(1,overallDICE);
        xlabel('Dice Coeff overall')
    case 'find_neighbouring_tessels'    % STEP 16.7: for each tessel - find neighbouring tessels
        for h=1:2,
            D=caret_load(fullfile(caretDir,'fsaverage_sym',hemName{1},'lh.SPHERE.REG.coord'));
            P=caret_load(fullfile(caretDir,'fsaverage_sym',hemName{1},'lh.tessel162.paint'));
            
            % index for centroid of each hex
            centroid=[1:P.num_paintnames];
            
            % define surface
            coord=fullfile(caretDir,'fsaverage_sym',hemName{h},[hem{h} '.FLAT.coord']);
            topo=fullfile(caretDir,'fsaverage_sym',hemName{h},[hem{h} '.CUT.topo']);
            xlims=[-140 140];
            ylims=[-140 140];
            
            % find neighbouring hexes
            for t=1:P.num_paintnames,
                ds=surfing_eucldist(D.data(centroid(t),:)',D.data(centroid,:)');
                [~,S]=sort(ds);
                clusters=S(1:7); % 1 is distance with itself
                
                data=zeros(P.num_rows,1);
                for c=1:length(clusters),
                    data([P.data==clusters(c)])=c;
                end
                
                figure
                caret_plotflatmap('coord',coord,'topo',topo,'data',data,'xlims',xlims,'ylims',ylims)
                drawnow
                pause()
            end
        end
    case 'cortical_spatial_dispersion'  % STEP 16.8: cortical spatial dispersion projected to the cerebellum
        sn=varargin{1};
        type=varargin{2}; % '162_tessellation_hem'
        method=varargin{3}; % 'cplexqp'
        data=varargin{4}; % 'grey'
        lambda=varargin{5}; % optimal lambda (25)
        encodeType=varargin{6};
        stats=varargin{7}; % 'yes' or 'no'
        
        subjs=length(sn);
        threshold=.05;
        
        % create Z:Qx3 (coordinates of centroid per tessel)
        Z=[];
        for h=1:2,
            D=caret_load(fullfile(caretDir,'fsaverage_sym',hemName{h},sprintf('%s.SPHERE.REG.coord',hem{h})));
            switch type,
                case '162_tessellation_hem'
                    P=caret_load(fullfile(caretDir,'fsaverage_sym',hemName{h},sprintf('%s.tessel162.paint',hem{h} )));
                    medialWall=149;
                case 'desikan_hem'
                    P=caret_load(fullfile(caretDir,'fsaverage_sym',hemName{h},sprintf('%s.desikan.paint',hem{h})));
                    medialWall=1;
            end
            % index for centroid of each hex
            centroid=[1:P.num_paintnames];
            centroid(centroid==medialWall)=[]; % remove medial wall
            Z=[Z;D.data(centroid,:)];
        end
        
        % get unit vectors (magnitude=1)
        for q=1:length(Z), % loop over Q
            Z_length=sqrt(Z(q,1)^2+Z(q,2)^2+Z(q,3)^2);
            Z_norm(q,:)=(1/Z_length)*Z(q,:);
        end
        
        % loop over subjects
        for s=1:subjs,
            Yy=[];
            encodeSubjDir = fullfile(encodeDir,'glm4',sprintf('encode_%d',encodeType),subj_name{sn(s)});
            load(fullfile(encodeSubjDir,sprintf('encode_%s_%s_%s',type,method,data)));
            
            % get optimal betas
            B=Yp.betas(Yp.idxLambda==lambda,:);
            
            % create W:QxP (cortical weights per cerebellar voxel)
            P=size(B,2); % numVoxels
            Q=size(B,1); % numFeatures
            W=zeros(Q,P); % preallocate array
            for p=1:P,
                cI=find(B(:,p)>threshold); % find important cortical connections
                W(cI,p)=B(cI,p);
                % figure out spatial dispersion
                N=size(W(cI,p),1); % number of relevant regions
                m(p,:)=1/N*(W(cI,p)'*Z_norm(cI,:)); % sample moment of circular distribution: 1/N*(Wi*Zi)
                R(p,:)=sqrt(m(p,1)^2+m(p,2)^2+m(p,3)^2); % get length |m|
            end
            % visualise R on cerebellar surface
            % make cerebellar volume
            B=spm_vol(fullfile(suitDir,'glm4',subj_name{sn(s)},'wdResMS.nii'));
            Yy=zeros(1,B.dim(1)*B.dim(2)*B.dim(3));
            Yy(1,Yp.nonZeroInd(Yp.lambda==lambda,:))=R;
            Yy=reshape(Yy,[B.dim(1),B.dim(2),B.dim(3)]);
            Yy(Yy==0)=NaN;
            V{1}.dat=Yy;
            V{1}.dim=B.dim;
            V{1}.mat=B.mat;
            V{1}.fname=B.fname;
            M=caret_suit_map2surf(V,'space','SUIT','stats','nanmean');
            vertices(:,s)=M.data;
            clear Yy R m W
        end
        switch stats,
            case 'yes'
                C=gifti(fullfile(caretDir,'suit_flat','Cerebellum-lobules.label.gii'));
                cStats= caret_getcSPM('onesample_t','data',vertices(:,1:subjs));
                P=spm_P_FDR(cStats.con.Z,cStats.con.df,'Z',1,sort(cStats.con.Z_P,'ascend'));
                %                     P=spm_P_Bonf(cStats{ii}.con.Z,cStats{ii}.con.df,'Z',size(cStats{ii}.data,1),1);
                indices=cStats.con.Z;
                indices(P>threshold)=nan;
            case 'no'
                % average across subjects
                indices=nanmean(vertices,2);
        end
        figure()
        suit_plotflatmap(indices,'type','func','cscale',[min(indices),max(indices)]);
    case 'cortex_to_cerebellum'
        sn=varargin{1};
        type=varargin{2}; % '162_tessellation_hem' or 'crossSubj_162'
        method=varargin{3}; % 'cplexqp','ridgeFixed'
        lambda=varargin{4}; % 25 or .1
        encodeType=varargin{5}; % 'crossSubj','original'
        tessel=varargin{6};
        
        subjs=length(sn);
        
        % make cerebellar volume
        X=spm_vol(fullfile(suitDir,'anatomicals','cerebellarGreySUIT.nii'));
        
        for s=1:subjs,
            Yy=zeros(1,X.dim(1)*X.dim(2)*X.dim(3));
            encodeSubjDir = fullfile(encodeDir,'glm4',sprintf('encode_%s',encodeType),subj_name{sn(s)});
            load(fullfile(encodeSubjDir,sprintf('encode_%s_%s_grey.mat',type,method)));
            % get optimal lambda
            B=Yp.betas(Yp.idxLambda==lambda,:);
            B=B(tessel,:);
            Yy(1,Yp.nonZeroInd(Yp.lambda==lambda,:))=B;
            Yy=reshape(Yy,[X.dim(1),X.dim(2),X.dim(3)]);
            Yy(Yy==0)=NaN;
            Y(:,:,:,s)=Yy;
            fprintf('subj%d done \n',sn(s))
            X.fname=fullfile(encodeDir,'glm4',sprintf('encode_%s',encodeType),subj_name{sn(s)},'occipital_cereb.nii');
            X = spm_write_vol(X,Y(:,:,:,s));
        end
        
        % get groupAvg & write to vol
        Y=nanmean(Y,4);
        X.fname=fullfile(encodeDir,'glm4',sprintf('encode_%s',encodeType),'avg_occipital_cereb.nii');
        X = spm_write_vol(X,Y);
        
        % map vol to surface
        V{1}.dat=Y;
        V{1}.dim=X.dim;
        V{1}.mat=X.mat;
        M=caret_suit_map2surf(V,'space','SUIT','stats','nanmean');
        
        % plot to cerebellar surface
        figure()
        suit_plotflatmap(M.data,'type','func','cscale',[min(M.data),max(M.data)]);
        title(sprintf('tessel%d',tessel))
        
    case 'map_cerebellum_cortex'        % Map cerebellum to cortex (results from encoding model)
    case 'cortical_combination'         % STEP 16.6: cerebellar voxel - cortical combination
        % example: sc1_imana('cortical_combination',[2:17],'162_tessellation_hem','cplexqp','grey',25)
        sn=varargin{1};
        type=varargin{2}; % '162_tessellation_hem'
        method=varargin{3}; % 'cplexqp','cplexqp_L2'
        data=varargin{4}; % 'grey'
        lambda=varargin{5}; % optimal lambda
        encodeType=varargin{6}; % original
        
        % determine threshold and voxel coordinates
        threshold=.001;
        
        % determine xyz coordinates of cerebellar voxels (of interest)
        xyz={[25,26,27],[13,19,21];[47,26,27],[60,25,19]};
        xyzLob={'lh-V-VI','lh-CrusII';'rh-V-VI','rh-CrusII'};
        
        % load encoding results
        %         encodeSubjDir = fullfile(encodeDir,'glm4',sprintf('encode_%d',encodeType),subj_name{sn});
        encodeSubjDir = fullfile(encodeDir,'glm4',encodeType,subj_name{sn});
        load(fullfile(encodeSubjDir,sprintf('encode_%s_%s_%s.mat',type,method,data)));
        
        % get optimal lambda
        B=Yp.betas(Yp.idxLambda==lambda,:);
        cI=Yp.nonZeroInd(Yp.lambda==lambda,:); % cerebellar index
        pI=Yp.cortIdx(Yp.idxLambda==lambda,:); % parcellation index
        
        % get indices for both hemispheres
        parcelIdx(:,1)=[1:size(B,1)/2];
        parcelIdx(:,2)=[(size(B,1)/2)+1:size(B,1)];
        
        % loop over hemispheres
        for h=1:2,
            
            % loop over cerebellar lobules
            for l=1:size(xyz,2),
                % find cerebellar index from volume
                C=spm_vol(fullfile(suitDir,'glm4',subj_name{sn},'wdResMS.nii'));
                Yy=zeros(1,C.dim(1)*C.dim(2)*C.dim(3));
                Yy=reshape(Yy,[C.dim(1),C.dim(2),C.dim(3)]);
                vIndx=sub2ind(size(Yy),xyz{h,l}(1),xyz{h,l}(2),xyz{h,l}(3));
                
                pIndx=pI(find(B(parcelIdx(:,h),find(cI==vIndx))>threshold)); % cortical indices of importance
                pOther=pI(find(B(parcelIdx(:,h),find(cI==vIndx))<threshold)); % cortical indices of NO importance
                
                % determine cortical vertices
                switch type
                    case '162_tessellation_hem'
                        C=caret_load(fullfile(caretDir,'fsaverage_sym',hemName{h},sprintf('%s.tessel162_new.metric',hem{h})));
                        
                        % assign [0] to non-important betas
                        for i=1:158,
                            if sum(ismember(pOther,i)),
                                C.data(C.data==i,1)=0;
                            elseif sum(ismember(pIndx,i))
                                C.data(C.data==i,1)=B(i,cI==vIndx); % important betas
                            end
                        end
                        % assign [0] to medial wall
                        C.data(C.data==149,1)=0;
                    case 'yeo_hem'
                        C=caret_load(fullfile(caretDir,'fsaverage_sym',hemName{h},sprintf('%s.Yeo17.paint',hem{h})));
                        
                        % assign [0] to non-important betas
                        for i=1:18,
                            if sum(ismember(pOther,i)),
                                C.data(C.data==i,1)=0;
                            elseif sum(ismember(pIndx,i))
                                C.data(C.data==i,1)=B(i,cI==vIndx); % important betas
                            end
                        end
                        % assign [0] to medial wall
                        C.data(C.data==1,1)=0;
                    case 'desikan_hem'
                        C=caret_load(fullfile(caretDir,'fsaverage_sym',hemName{h},sprintf('%s.desikan.paint',hem{h})));
                        
                        % assign [0] to non-important betas
                        for i=1:36,
                            if sum(ismember(pOther,i)),
                                C.data(C.data==i,1)=0;
                            elseif sum(ismember(pIndx,i))
                                C.data(C.data==i,1)=B(i,cI==vIndx); % important betas
                            end
                        end
                        % assign [0] to medial wall
                        C.data(C.data==1,1)=0;
                end
                
                % save out metric file
                outName=fullfile(caretDir,'fsaverage_sym',hemName{h},sprintf('%s.voxel_%s.metric',hem{h},xyzLob{h}));
                caret_save(outName,C);
                
                % plot winning combination on cortical flatmap
                %                 coord=fullfile(caretDir,'fsaverage_sym',hemName{h},[hem{h} '.FLAT.coord']);
                %                 topo=fullfile(caretDir,'fsaverage_sym',hemName{h},[hem{h} '.CUT.topo']);
                %                 xlims=[-140 140];
                %                 ylims=[-140 140];
                %
                %                 figure
                %                 caret_plotflatmap('coord',coord,'topo',topo,'data',C.data,'xlims',xlims,'ylims',ylims)
                %                 title(xyzLob{h,l})
                %                 colorbar
                %                 drawnow
                %                 pause()
            end
        end
    case 'cortical_matrix'              % STEP 16.7: QxQ matrix of model and betas
        sn=varargin{1};
        type=varargin{2}; % '162_tessellation_hem'
        
        subjs=length(sn);
        
        % loop over subjects
        for s=1:subjs,
            encodeSubjDir = fullfile(encodeDir,'glm4',subj_name{sn(s)});
            load(fullfile(encodeSubjDir,sprintf('%s_glm4_model.mat',type)));
            C.pI=X.idx;
            F=X.Xx; % feature matrix
            F(:,465:480)=[]; % remove intercept
            A(:,:,s)=F*F';
            B(:,s)=sum(F,2);
        end
        % number of features
        Q=size(A,2); % both hemis
        
        % get average across subjs
        A=nanmean(A,3);
        B=nanmean(B,2);
        
        % get indices for hemispheres
        C.hemi=kron([1:2]',ones(Q/2,1));
        
        % group the matrix according to lobes
        idx=1;
        for h=regSide,
            if h==2,
                idx=(Q/2)+1;
            end
            
            P=caret_load(fullfile(caretDir,'fsaverage_sym',hemName{h},sprintf('%s.cerebral_cortex.paint',hem{h})));
            switch type,
                case '162_tessellation_hem'
                    D=caret_load(fullfile(caretDir,'fsaverage_sym',hemName{h},sprintf('%s.tessel162.paint',hem{h})));
                case 'yeo_hem'
                    D=caret_load(fullfile(caretDir,'fsaverage_sym',hemName{h},sprintf('%s.yeo17.paint',hem{h})));
                case 'desikan_hem'
                    D=caret_load(fullfile(caretDir,'fsaverage_sym',hemName{h},sprintf('%s.desikan.paint',hem{h})));
                otherwise
                    disp('this case does not exist')
            end
            for q=[C.pI(1:Q/2)'],
                I(idx)=mode(P.data(D.data==q));
                idx=idx+1;
            end
            [Y(:,h),Z(:,h)]=sort(I(C.hemi==h));
        end
        
        % make 'lobes' field
        lobe=horzcat(Y(:,1),Y(:,2));
        idx=1;
        for h=1:2,
            for l=1:P.num_paintnames-1 % not interested in medial wall
                TickIdx(idx)=length(lobe(lobe(:,h)==l));
                lobeNames{idx}=sprintf('%s(%s)',P.paintnames{l},hem{h});
                idx=idx+1;
            end
        end
        C.lobeNum=vertcat(Y(:,1),Y(:,2));
        C.sortIndx=vertcat(Z(:,1),Z(:,2)+Q/2);
        C.lobeIdx=TickIdx';
        C.lobeName=lobeNames';
        
        % sort covar matrix (according to lobes)
        figure()
        imagesc(A(C.sortIndx,C.sortIndx));
        t=set(gca,'Ytick',cumsum([1,C.lobeIdx(1:end-1)']),'YTickLabel',C.lobeName','Xtick',cumsum([1,C.lobeIdx(1:end-1)']),'XTickLabel',C.lobeName','FontSize',12,'FontWeight','bold');
        t.Color='white';
        title(sprintf('%s',type));
        
        % get indices for both hemispheres
        parcelIdx(:,1)=[1:size(C.hemi,1)/2];
        parcelIdx(:,2)=[(size(C.hemi,1)/2)+1:size(C.hemi,1)];
        
        for h=regSide,
            switch type,
                case '162_tessellation_hem'
                    D=caret_load(fullfile(caretDir,'fsaverage_sym',hemName{h},sprintf('%s.tessel162_new.metric',hem{h})));
                    FData=nan(size(D.data));
                    if h==1,
                        paintNum=C.pI(C.hemi==h);
                    else
                        paintNum=C.pI(C.hemi==h)-length(unique(D.data));
                    end
                    idx=1;
                    for i=1:length(paintNum),% length(data)
                        FData(D.data==paintNum(i),1)=A(parcelIdx(idx,h));
                        idx=idx+1;
                    end
                case 'yeo_hem'
                    D=caret_load(fullfile(caretDir,'fsaverage_sym',hemName{h},sprintf('%s.Yeo17.paint',hem{h})));
                    idx=1;
                    for ii=[2:18],
                        D.data(D.data==ii,1)=B(parcelIdx(idx,h),:);
                        idx=idx+1;
                    end
                case 'desikan_hem'
                    D=caret_load(fullfile(caretDir,'fsaverage_sym',hemName{h},sprintf('%s.desikan.paint',hem{h})));
                    idx=1;
                    for ii=[2:36],
                        D.data(D.data==ii,1)=B(parcelIdx(idx,h),:);
                        idx=idx+1;
                    end
            end
            coord=fullfile(caretDir,'fsaverage_sym',hemName{h},[hem{h} '.FLAT.coord']);
            topo=fullfile(caretDir,'fsaverage_sym',hemName{h},[hem{h} '.CUT.topo']);
            figure;caret_plotflatmap('coord',coord,'topo',topo,'data',FData,'xlims',[-200 200],'ylims',[-200 200]);
            colorbar
            D=[];
        end
    case 'cerebellar_matrix'
        sn=varargin{1};
        
        subjs=length(sn);
        for s=1:subjs,
            X=[];
            load(fullfile(regDir,'glm4',subj_name{sn(s)},'betas_cerebellum_hem.mat'));
            for r=1:28
                X.Xx(r,:)=mean(B{r}.betasUW,2);
                X.idx(r,1)=r;
            end
            X.Xx(:,465:480)=[]; % remove intercept
            pI=X.idx;
            B=X.Xx; % feature matrix
            B=bsxfun(@rdivide,B,nansum(B,1));
            C(:,s)=nanmean(B,2);
            fprintf('subj%d done \n',sn(s));
        end
        
        % get avg across subjs
        C=nanmean(C,2);
        
        % project to flatmap
        D=gifti(fullfile(caretDir,'suit_flat','Cerebellum-lobules.label.gii'));
        data=double(D.cdata(:,1));
        for ii=1:28,
            data(data==ii,1)=C(ii);
        end
        suit_plotflatmap(data,'type','func')
    case 'encoding_betas'
        sn=varargin{1};
        type=varargin{2}; % '162_tessellation_hem' or 'crossSubj_162'
        method=varargin{3}; % 'cplexqp','ridgeFixed'
        lambda=varargin{4}; % 25 or .1
        encodeType=varargin{5};
        
        subjs=length(sn);
        
        for s=1:subjs,
            encodeSubjDir = fullfile(encodeDir,'glm4',sprintf('encode_%s',encodeType),subj_name{sn(s)});
            load(fullfile(encodeSubjDir,sprintf('encode_%s_%s_grey.mat',type,method)));
            
            % get optimal lambda
            B=Yp.betas(Yp.idxLambda==lambda,:);
            C.pI=Yp.cortIdx(Yp.idxLambda==lambda,:); % parcellation index
            B=bsxfun(@rdivide,B,nansum(B,1));
            C.A(:,s)=nanmean(B,2);
            fprintf('subj%d done \n',sn(s))
        end
        
        % number of features
        Q=size(C.A,1); % both hemis
        
        % get indices for hemispheres
        C.hemi=kron([1:2]',ones(Q/2,1));
        
        % get group average
        A=nanmean(C.A,2);
        
        % get indices for both hemispheres
        parcelIdx(:,1)=[1:size(C.hemi,1)/2];
        parcelIdx(:,2)=[(size(C.hemi,1)/2)+1:size(C.hemi,1)];
        for h=regSide,
            switch type,
                case '162_tessellation_hem'
                    D=caret_load(fullfile(caretDir,'fsaverage_sym',hemName{h},sprintf('%s.tessel162_new.metric',hem{h})));
                    FData=nan(size(D.data));
                    if h==1,
                        paintNum=C.pI(C.hemi==h);
                    else
                        paintNum=C.pI(C.hemi==h)-length(unique(D.data));
                    end
                    idx=1;
                    for i=1:length(paintNum),% length(data)
                        FData(D.data==paintNum(i),1)=A(parcelIdx(idx,h));
                        idx=idx+1;
                    end
                case 'yeo_hem'
                    D=caret_load(fullfile(caretDir,'fsaverage_sym',hemName{h},sprintf('%s.Yeo17.paint',hem{h})));
                    FData=nan(size(D.data));
                    idx=1;
                    for ii=[2:18],
                        FData(D.data==ii,1)=C.A(parcelIdx(idx,h));
                        idx=idx+1;
                    end
                case 'crossSubj_162'
                    D=caret_load(fullfile(caretDir,'fsaverage_sym',hemName{h},sprintf('%s.tessel162_new.metric',hem{h})));
                    FData=nan(size(D.data));
                    if h==1,
                        paintNum=C.pI(C.hemi==h);
                    else
                        paintNum=C.pI(C.hemi==h)-length(unique(D.data));
                    end
                    idx=1;
                    for i=1:length(paintNum),% length(data)
                        FData(D.data==paintNum(i),1)=A(parcelIdx(idx,h));
                        idx=idx+1;
                    end
            end
            coord=fullfile(caretDir,'fsaverage_sym',hemName{h},[hem{h} '.FLAT.coord']);
            topo=fullfile(caretDir,'fsaverage_sym',hemName{h},[hem{h} '.CUT.topo']);
            figure;caret_plotflatmap('coord',coord,'topo',topo,'data',FData,'xlims',[-200 200],'ylims',[-200 200]);
            colorbar
            D.data=FData;
            caret_save(fullfile(caretDir,'fsaverage_sym',hemName{h},sprintf('%s.encodeBetas_162.metric',hem{h})),D)
        end
        
    case 'make_allSubj_struct'          % STEP 11.2: Make allSubj struct from 'lh/rh_info_glm_grey_nan'
        sn=varargin{1};
        type=varargin{2}; % 'cortex' or 'cereb'
        hemN=varargin{3}; % [1:2] and [1]
        
        subjs=length(sn);
        for h=hemN,
            T=[];
            for s=1:subjs,
                switch type,
                    case 'cortex'
                        inFile=sprintf('%s_info_glm4_grey.mat',hem{h});
                        outName=sprintf('%s_%s_avrgDataStruct.mat',type,hem{h});
                    case 'cereb'
                        inFile=sprintf('Y_info_glm4_grey_nan.mat');
                        outName=sprintf('%s_avrgDataStruct.mat',type);
                        V=spm_vol(fullfile(suitDir,'anatomicals','cerebellarGreySUIT.nii'));
                end
                load(fullfile(encodeDir,'glm4',subj_name{sn(s)},inFile));
                numTasks=size(Y.identity,2);
                Y.cond = Y.cond-1;
                Y.cond(Y.cond==-1)=numTasks;
                for sess=1:2,
                    if sess==1,r=1;else r=9;end;
                    v=ones(numTasks,1);
                    S.SN = v*sn(s);
                    S.sess = v*sess;
                    S.cond = [1:numTasks]';
                    indx = (Y.sess==sess & Y.cond~=0);
                    S.TN   = Y.TN(indx & Y.run==r); % get taskNames (same for every run)
                    X=indicatorMatrix('identity',Y.cond(indx,:));
                    S.data = pinv(X)*Y.data(indx,:);
                    S.data = bsxfun(@minus,S.data,nanmean(S.data)); % remove mean within each session
                    T=addstruct(T,S);
                end;
                if strcmp(type,'cereb'),
                    volIndx=Y.nonZeroInd(1,:);
                end
                clear Y;
                fprintf('subj%d done...\n',sn(s))
            end;
            % save out struct
            if strcmp(type,'cereb'),
                save(fullfile(encodeDir,'glm4',outName),'T','volIndx','V');
            else
                save(fullfile(encodeDir,'glm4',outName),'T');
            end
        end
    case 'map_tasks_cortex'          % STEP 11.3: Map tasks and features to cerebellar or cortical surface for one or all subjs and do stats
        sn=varargin{1};
        feature=varargin{2}; % 'lHand','rHand','saccades','complexity','responseAlt','visualStim','workMem','action'
        map=varargin{3}; % map 'features' or 'tasks'
        stats=varargin{4}; % 'yes' or 'no'
        
        subjs=length(sn);
        pThresh=.05;
        
        for h=1:2,
            load(fullfile(encodeDir,'glm4',sprintf('cortex_%s_avrgDataStruct.mat',hem{h})));
            
            switch map,
                case 'features'
                    numTasks=0;
                case 'tasks'
                    numTasks=length(unique(T.cond));
            end
            
            % get feature model
            D=sc1_imana('make_feature_model');
            D=getrow(D,[2:size(D.duration,1)]);
            
            % which features are we mapping?
            switch feature,
                case 'lHand'
                    if strcmp(map,'tasks'),
                        X=[eye(numTasks) D.lHand./D.duration];
                        condNamesNoInstruct{numTasks+1}='30.left hand';
                    else
                        clear condNamesNoInstruct
                        X=[D.lHand./D.duration];
                        condNamesNoInstruct{1}='1.left hand';
                    end
                case 'rHand'
                    if strcmp(map,'tasks'),
                        X=[eye(numTasks) D.rHand./D.duration];
                        condNamesNoInstruct{numTasks+1}='30.right hand';
                    else
                        clear condNamesNoInstruct
                        X=[D.rHand./D.duration];
                        condNamesNoInstruct{1}='1.right hand';
                    end
                case 'saccades'
                    if strcmp(map,'tasks'),
                        X=[eye(numTasks) D.saccades./D.duration];
                        condNamesNoInstruct{numTasks+1}='30.saccades';
                    else
                        clear condNamesNoInstruct
                        X=[D.saccades./D.duration];
                        condNamesNoInstruct{1}='1.saccades';
                    end
                case 'bothHands'
                    if strcmp(map,'tasks'),
                        X=[eye(numTasks) D.lHand./D.duration D.rHand./D.duration];
                        condNamesNoInstruct{numTasks+1}='30.left hand';
                        condNamesNoInstruct{numTasks+2}='31.right hand';
                    else
                        clear condNamesNoInstruct
                        X=[D.lHand./D.duration D.rHand./D.duration];
                        condNamesNoInstruct{1}='1.left hand';
                        condNamesNoInstruct{2}='2.right hand';
                    end
                case 'allMotor'
                    if strcmp(map,'tasks'),
                        X=[eye(numTasks) D.lHand./D.duration D.rHand./D.duration D.saccades./D.duration];
                        condNamesNoInstruct{numTasks+1}='30.left hand';
                        condNamesNoInstruct{numTasks+2}='31.right hand';
                        condNamesNoInstruct{numTasks+3}='32.saccades';
                    else
                        clear condNamesNoInstruct
                        X=[D.lHand./D.duration D.rHand./D.duration D.saccades./D.duration];
                        condNamesNoInstruct{1}='1.left hand';
                        condNamesNoInstruct{2}='2.right hand';
                        condNamesNoInstruct{3}='3.saccades';
                    end
                case 'none'
                    X=[eye(numTasks)];
            end
            
            % Num Feat
            numFeat=size(X,2)-numTasks;
            
            % do ridge regression
            for s=1:subjs,
                indx = (T.SN==(sn(s)));
                X1=bsxfun(@minus,X,mean(X));
                X1=bsxfun(@rdivide,X1,sum(X1.^2));
                X1=[X1;X1];
                B=(X1'*X1+eye(numTasks+numFeat)*0.1)\(X1'*T.data(indx,:));
                B=permute(B,[2 1 3]);
                vertices(:,:,s)=B;
                clear X1 B
                fprintf('subj%d done \n',s+1)
            end;
            
            switch stats,
                case 'yes'
                    indices=zeros(size(vertices,1),size(vertices,2));
                    for ii=1:numTasks+numFeat,
                        data=ssqrt(vertices(:,ii,:));
                        data=permute(data,[2 1 3]);
                        data=reshape(data,[size(data,2),size(data,3)]);
                        cStats{ii}= caret_getcSPM('onesample_t','data',data(:,1:subjs));
                        P=spm_P_FDR(cStats{ii}.con.Z,cStats{ii}.con.df,'Z',1,sort(cStats{ii}.con.Z_P,'ascend'));
                        %                     P=spm_P_Bonf(cStats{ii}.con.Z,cStats{ii}.con.df,'Z',size(cStats{ii}.data,1),1);
                        c=cStats{ii}.con.Z;
                        c(P>pThresh)=nan;
                        indices(:,ii)=c;
                        clear c
                    end
                    S.indices=indices';
                    S.name=condNamesNoInstruct';
                    save(fullfile(caretDir,'fsaverage_sym',hemName{h},'glm4',sprintf('FDRCorr_%s_%s.mat',map,feature)),'S');
                case 'no'
                    % if numSubjs > 1 get avg
                    indices=nanmean(vertices,3);
                    S.indices=indices';
                    S.name=condNamesNoInstruct';
                    save(fullfile(caretDir,'fsaverage_sym',hemName{h},'glm4',sprintf('unCorr_%s_%s.mat',map,feature)),'S');
            end
        end
    case 'map_tasks_cerebellum'
        sn=varargin{1};
        feature=varargin{2}; % 'lHand','rHand','saccades'
        map=varargin{3}; % map 'features' or 'tasks'
        stats=varargin{4}; % 'yes' or 'no'
        
        subjs=length(sn);
        pThresh=.05;
        
        % load in allSubjs data struct
        load(fullfile(encodeDir,'glm4','cereb_avrgDataStruct.mat'));
        numConds=length(unique(T.cond));
        all=[1:numConds];
        
        % get session average
        for s=1:subjs,
            for c=1:numConds, % get average across sessions
                indx = (T.cond==c & T.SN==(sn(s)));
                avrgData(c,:)=nanmean(T.data(indx,:),1);
            end
            % subtract condition avrg baseline
            for c=1:numConds,
                X=nanmean(avrgData(all(all~=c),:),1);
                data(c,:,s)=avrgData(c,:)-X;
            end
        end
        
        switch map,
            case 'features'
                numTasks=0;
            case 'tasks'
                numTasks=length(unique(T.cond));
        end
        
        % get feature model
        D=sc1_imana('make_feature_model');
        D=getrow(D,[2:size(D.duration,1)]); % remove instruct
        
        %which features are we mapping?
        switch feature,
            case 'lHand'
                if strcmp(map,'tasks'),
                    X=[eye(numTasks) D.lHand./D.duration];
                    condNamesNoInstruct{numTasks+1}='30.left hand';
                else
                    clear condNamesNoInstruct
                    X=[D.lHand./D.duration];
                    condNamesNoInstruct{1}='1.left hand';
                end
            case 'rHand'
                if strcmp(map,'tasks'),
                    X=[eye(numTasks) D.rHand./D.duration];
                    condNamesNoInstruct{numTasks+1}='30.right hand';
                else
                    clear condNamesNoInstruct
                    X=[D.rHand./D.duration];
                    condNamesNoInstruct{1}='1.right hand';
                end
            case 'saccades'
                if strcmp(map,'tasks'),
                    X=[eye(numTasks) D.saccades./D.duration];
                    condNamesNoInstruct{numTasks+1}='30.saccades';
                else
                    clear condNamesNoInstruct
                    X=[D.saccades./D.duration];
                    condNamesNoInstruct{1}='1.saccades';
                end
            case 'bothHands'
                if strcmp(map,'tasks'),
                    X=[eye(numTasks) D.lHand./D.duration D.rHand./D.duration];
                    condNamesNoInstruct{numTasks+1}='30.left hand';
                    condNamesNoInstruct{numTasks+2}='31.right hand';
                else
                    clear condNamesNoInstruct
                    X=[D.lHand./D.duration D.rHand./D.duration];
                    condNamesNoInstruct{1}='1.left hand';
                    condNamesNoInstruct{2}='2.right hand';
                end
            case 'allMotor'
                if strcmp(map,'tasks'),
                    X=[eye(numTasks) D.lHand./D.duration D.rHand./D.duration D.saccades./D.duration];
                    condNamesNoInstruct{numTasks+1}='30.left hand';
                    condNamesNoInstruct{numTasks+2}='31.right hand';
                    condNamesNoInstruct{numTasks+3}='32.saccades';
                else
                    clear condNamesNoInstruct
                    X=[D.lHand./D.duration D.rHand./D.duration D.saccades./D.duration];
                    condNamesNoInstruct{1}='1.left hand';
                    condNamesNoInstruct{2}='2.right hand';
                    condNamesNoInstruct{3}='3.saccades';
                end
            case 'none'
                X=[eye(numTasks)];
        end
        
        % set up volume info
        numFeat=size(X,2)-numTasks;
        Yy=zeros(numTasks+numFeat,subjs,V.dim(1)*V.dim(2)*V.dim(3));
        C{1}.dim=V.dim;
        C{1}.mat=V.mat;
        
        % do ridge regression
        for s=1:subjs,
            X1=bsxfun(@minus,X,mean(X));
            X1=bsxfun(@rdivide,X1,sum(X1.^2));
            B=(X1'*X1+eye(numTasks+numFeat)*.5)\(X1'*data(:,:,s));
            % make volume
            Yy(:,s,volIndx)=B;
            clear X1 B
            fprintf('subj%d done \n',sn(s))
        end;
        
        switch stats,
            case 'yes'
                Yy(Yy==0)=nan;
                for ii=1:numTasks+numFeat,
                    data=ssqrt(Yy(ii,:,:));
                    data=reshape(data,[size(data,2),size(data,3)]);
                    cStats{ii}= caret_getcSPM('onesample_t','data',data(1:subjs,:)');
                    P=spm_P_FDR(cStats{ii}.con.Z,cStats{ii}.con.df,'Z',1,sort(cStats{ii}.con.Z_P,'ascend'));
                    %                     P=spm_P_Bonf(cStats{ii}.con.Z,cStats{ii}.con.df,'Z',size(cStats{ii}.data,1),1);
                    c=cStats{ii}.con.Z;
                    c(P>pThresh)=nan;
                    indices(ii,:)=c;
                    clear c
                end
            case 'no'
                % if numSubjs > 1 get avg
                Yy=permute(Yy,[2 1 3]);
                indices=nanmean(Yy,1);
                indices=reshape(indices,[size(indices,2),size(indices,3)]);
        end
        clear data
        
        % map vol2surf
        indices=reshape(indices,[size(indices,1) V.dim(1),V.dim(2),V.dim(3)]);
        for i=1:size(indices,1),
            data=reshape(indices(i,:,:,:),[C{1}.dim]);
            C{i}.dat=data;
        end
        M=caret_suit_map2surf(C,'space','SUIT','stats','nanmean','column_names',condNamesNoInstruct);  % MK created caret_suit_map2surf to allow for output to be used as input to caret_save
        
        % save out as struct
        S.indices=M.data';
        S.name=condNamesNoInstruct';
        if strcmp(stats,'yes'),
            save(fullfile(caretDir,'suit_flat','glm4',sprintf('FDRCorr_%s_%s.mat',map,feature)),'S');
        else
            save(fullfile(caretDir,'suit_flat','glm4',sprintf('unCorr_%s_%s.mat',map,feature)),'S');
        end
    case 'visualise_features'
        reg=varargin{1}; % 'cortex' or 'cereb'
        thresh=varargin{2}; % 'FDRCorr' or 'unCorr'
        map=varargin{3}; % 'tasks' or 'features'
        feature=varargin{4}; % see 'map_features_cortex'
        metric=varargin{5}; % 'yes' or 'no'
        
        switch reg,
            case 'cortex'
                for h=1:2,
                    outDir=fullfile(caretDir,'fsaverage_sym',hemName{h},'glm4');
                    load(fullfile(outDir,sprintf('%s_%s_%s.mat',thresh,map,feature)))
                    switch metric,
                        case 'yes'
                            % save output as metric or paint
                            M=caret_struct('metric','data',S.indices','column_name',S.name');
                            caret_save(fullfile(outDir,sprintf('%s_%s_%s.metric',thresh,map,feature)),M);
                        case 'no'
                            % Visualise features/tasks on surface
                            coord=fullfile(caretDir,'fsaverage_sym',hemName{h},[hem{h} '.FLAT.coord']);
                            topo=fullfile(caretDir,'fsaverage_sym',hemName{h},[hem{h} '.CUT.topo']);
                            xlims=[-140 140];
                            ylims=[-140 140];
                            for ii=1:size(S.name,1),
                                figure(ii);
                                caret_plotflatmap('coord',coord,'topo',topo,'data',S.indices(ii,:)','xlims',xlims,'ylims',ylims,'cscale',[min(S.indices(ii,:)),max(S.indices(ii,:))]);
                                title(char(S.name{ii}))
                            end
                    end
                end
            case 'cereb'
                outDir=fullfile(caretDir,'suit_flat','glm4');
                load(fullfile(outDir,sprintf('%s_%s_%s.mat',thresh,map,feature)))
                switch metric,
                    case 'yes'
                        % save output as metric or paint
                        M=caret_struct('metric','data',S.indices','column_name',S.name');
                        caret_save(fullfile(outDir,sprintf('%s_%s_%s.metric',thresh,map,feature)),M);
                    case 'no'
                        for ii=1:size(S.name,1),
                            figure(ii);
                            suit_plotflatmap(S.indices(ii,:)','cscale',[min(S.indices(ii,:)),max(S.indices(ii,:))]);
                            text(90,90,sprintf('min Z = %2.2f',min(S.indices(ii,:))));
                            text(90,85,sprintf('max Z = %2.2f',max(S.indices(ii,:))));
                            title(char(S.name{ii}))
                        end
                end
        end
        
    case 'process_reliability'
    case 'all162act'
        sn=varargin{1};
        numTasks=29;
        
        removeInstr = 0;
        condNum = [kron(ones(numel(run),1),[1:numTasks]');ones(numel(run),1)*numTasks+1];
        partNum = [kron([1:numel(run)]',ones(numTasks,1));[1:numel(run)]'];
        if (removeInstr)
            idx=condNum>1;
            partNum=partNum(idx,:);
            condNum=condNum(idx,:)-1;
        else
            idx=condNum>0;
        end;
        N=sum(idx);
        
        for s=1:length(sn)
            load(fullfile(encodeDir,'glm4',subj_name{sn(s)},'162_tessellation_hem_glm4_model.mat'));
            Y(:,:,s)=X.Xx(:,idx)';
        end;
        ROI = X.idx';
        
        save(fullfile(encodeDir,'162_tesselation_hem_all.mat'),'Y','partNum','condNum','ROI');
    case 'allCereb'
        sn=varargin{1};
        
        numTasks=29;
        subjs=length(sn);
        
        condNum = [kron(ones(numel(run),1),[1:numTasks]');ones(numel(run),1)*numTasks+1];
        partNum = [kron([1:numel(run)]',ones(numTasks,1));[1:numel(run)]'];
        for s=1:subjs,
            encodeSubjDir=fullfile(encodeDir,'glm4',subj_name{sn(s)});
            load(fullfile(encodeSubjDir,'Y_info_glm4_grey_nan.mat'))
            %             [U,S,V]=svd(Y.data);
            Yy{s}=Y.data;
            fprintf('subj%d done \n',sn(s))
        end
        save(fullfile(encodeDir,'glm4','cerebellum_allVoxels.mat'),'Yy','condNum','partNum');
    case 'allCortex'
        sn=varargin{1};
        
        numTasks=29;
        subjs=length(sn);
        
        condNum = [kron(ones(numel(run),1),[1:numTasks]');ones(numel(run),1)*numTasks+1];
        partNum = [kron([1:numel(run)]',ones(numTasks,1));[1:numel(run)]'];
        for s=1:subjs,
            regSubjDir=fullfile(regDir,'glm4',subj_name{sn(s)});
            load(fullfile(regSubjDir,'betas_cortex_grey.mat'))
            Yy{s}=[B{1}.betasUW,B{2}.betasUW];
            fprintf('subj%d done \n',sn(s))
        end
        save(fullfile(encodeDir,'glm4','cortex_allVoxels.mat'),'Yy','condNum','partNum','-v7.3');
    case 'pattern_consistency_unique' % Between sessions / subjects
        sn=varargin{1};
        type=varargin{2}; % 'cortex' or 'cerebellum'
        
        switch type,
            case 'cortex'
                load(fullfile(encodeDir,'glm4','162_tesselation_hem_all.mat'));
            case 'cerebellum'
                load(fullfile(encodeDir,'glm4','cerebellum_allVoxels.mat'));
                Y=Yy;
        end
        
        D=dload(fullfile(baseDir,'sc1_sc2_taskConds_revised.txt'));
        
        % which tasks?
        a=D.studyNum==1 & D.overlap==0; % unique to sc1
        taskIdx=[repmat(a(D.studyNum==1),numel(run),1);zeros(numel(run),1)];
        condNum=condNum.*taskIdx;
        sessNum=[kron([1:2],ones(1,(length(condNum)-numel(run))/2))';kron([1:2],ones(1,numel(run)/2))'];
        
        numSubj=length(sn);
        for se=1:2
            indx = find(sessNum==se);
            X=indicatorMatrix('identity',condNum(indx,:));
            for subj = 1:numSubj,
                subjOverlap=sn(subj)-1; % subjs common to sc1 & sc2
                Yp(:,:,subj+(se-1)*numSubj)=X*pinv(X)*Y{subjOverlap}(indx,:);
                Yf(:,:,subj+(se-1)*numSubj)=Y{subjOverlap}(indx,:);
                fprintf('subj%d done \n',sn(subj));
            end;
        end;
        Cp=intersubj_corr(Yp);    % means
        Cf=intersubj_corr(Yf);    % betas
        Cr=intersubj_corr(Yf-Yp); % resiudals
        
        save(fullfile(regDir,'glm4',sprintf('pattern_reliability_%s_unique.mat',type)),'Cp','Cf','Cr');
    case 'visualise_reliability'
        type=varargin{1}; % 'cortex' or 'cerebellum'
        step=varargin{2}; % 'unique' or 'overlap'
        
        load(fullfile(regDir,'glm4',sprintf('pattern_reliability_%s_%s.mat',type,step)))
        
        T=[];
        % means
        [Y.a1,Y.a2,Y.a3]=bwse_corr(Cp); % between-subject, within-subject, diffSubjdiffSess
        Y.type={'means'};
        Y.typeNum=1;
        T=addstruct(T,Y);
        % betas
        [S.a1,S.a2,S.a3]=bwse_corr(Cf);
        S.type={'betas'};
        S.typeNum=2;
        T=addstruct(T,S);
        % residuals
        [V.a1,V.a2,V.a3]=bwse_corr(Cr);
        V.type={'residuals'};
        V.typeNum=3;
        T=addstruct(T,V);
        
        figure(); barplot([T.typeNum],[T.a2 T.a1],'leg',{'Within-Subject Reliability','Between-Subject Reliability'},'style_rainbow') % [T.a2 T.a1]
        
    case 'process_distance'
    case 'ROI_dist'
        sn=varargin{1};
        types=varargin{2}; % {'cortex_grey','cerebellum_grey'}
        removeMotor=varargin{3}; % 'yes' or 'no'
        reg=varargin{4}; % which region of the cortex (lh or rh) or cortical_lobes (1,2,3,4) or cerebellar lobules (1-10)?
        step=varargin{5}; % RDM, corr, inter-subj, linRegress, sum, split_half
        
        subjs=length(sn);
        numDist=length(condNamesNoInstruct)-1;
        
        for s=1:subjs,
            idx=1;
            for i=1:numel(types),
                for r=1:numel(reg{i}),
                    load(fullfile(regDir,'glm4',subj_name{sn(s)},sprintf('Ttasks_%s.mat',types{i})));
                    A=getrow(Ts,Ts.method_num==2 & Ts.region==reg{i}(r));
                    con = indicatorMatrix('allpairs',[1:numDist]);
                    N = rsa_squareIPM(A.IPM);
                    D = rsa.rdm.squareRDM(diag(con*N*con'));
                    d = diag(N);  % Distances from zero
                    fullRDM(:,:,idx,s) = [D d;[d' 0]];
                    vecRDM(idx,:,s) = rsa.rdm.vectorizeRDM(fullRDM(:,:,idx,s));
                    regName{idx}=sprintf('%d.%s',idx,char(A.regName));
                    idx=idx+1;
                end
            end
        end
        
        % subjTitle
        if sn>1,
            subjTitle='allSubjs';
        else
            subjTitle=sprintf('s%2.2d ',sn);
        end
        
        switch step,
            case 'RDM'
                for r=1:numel(regName),
                    figure()
                    X=ssqrt(nanmean(fullRDM(:,:,r),4));
                    numDist=size(X,1);
                    imagesc_rectangle(X,'YDir','reverse');
                    caxis([0 1]);
                    t=set(gca,'Ytick', 1:numDist,'YTickLabel',condNamesNoInstruct,'FontSize',12,'FontWeight','bold');
                    t.Color='white';
                    colorbar
                    %                     title(sprintf('%s-%s',subjTitle,char(regName{r})));
                end
            case 'RDM_thresh'
                for r=1:numel(regName),
                    vecRDM=reshape(vecRDM,[size(vecRDM,2),size(vecRDM,3)]);
                    for dd=1:size(vecRDM,1),
                        [t(dd),p(dd)]=ttest(vecRDM(dd,:),[],1,'onesample');
                    end
                    t(p>.001)=0;
                    % sort according to dendrogram
                    vecRDM=nanmean(vecRDM,2);
                    [Y,~] = rsa_classicalMDS(vecRDM','mode','RDM');
                    clustTree = linkage(Y,'average');
                    indx = cluster(clustTree,'cutoff',1);
                    condNums=[1:29]';
                    reOrder=[];
                    for i=1:11,
                        s=condNums(indx==i);
                        reOrder=[reOrder;s];
                    end
                    reOrder=[6,7,11,12,26,27,28,22,23,17,18,14,21,19,20,1,2,8,9,10,13,15,25,3,4,16,24,5,29]';
                    squareT=squareform(t);
                    imagesc_rectangle(squareT(reOrder,reOrder),'YDir','reverse')
                    caxis([0 1])
                    t=set(gca,'Ytick', '','YTickLabel',condNamesNoInstruct(reOrder),'FontSize',12,'FontWeight','bold');
                    t.Color='white';
                end
            case 'RDM_thresh_unthresh'
                for r=1:numel(regName),
                    vecRDM=reshape(vecRDM,[size(vecRDM,2),size(vecRDM,3)]);
                    for dd=1:size(vecRDM,1),
                        [t(dd),p(dd)]=ttest(vecRDM(dd,:),[],1,'onesample');
                    end
                    ut=t; % unthresholded distances
                    t(p>.01)=0; % thresholded distances
                    % sort according to dendrogram
                    vecRDM=nanmean(vecRDM,2);
                    [Y,~] = rsa_classicalMDS(vecRDM','mode','RDM');
                    clustTree = linkage(Y,'average');
                    indx = cluster(clustTree,'cutoff',1);
                    condNums=[1:29]';
                    reOrder=[];
                    for i=1:11,
                        s=condNums(indx==i);
                        reOrder=[reOrder;s];
                    end
                    reOrder=[6,7,11,12,26,27,28,22,23,17,18,14,21,19,20,1,2,8,9,10,13,15,25,3,4,16,24,5,29]';
                    % visualise thresh/unthresh
                    squareT=tril(squareform(t));
                    squareUT=squareform(ut);
                    idxUT=find(triu(squareUT));
                    squareT(idxUT)=squareUT(idxUT);
                    figure();imagesc_rectangle(squareT(reOrder,reOrder),'YDir','reverse')
                    caxis([0 1])
                    ylabel('');
                    t=set(gca,'Ytick', '','YTickLabel',condNamesNoInstruct(reOrder),'FontSize',12,'FontWeight','bold');
                    t.Color='white';
                end
            case 'ROI_corr'
                X=nanmean(vecRDM,3);
                [C,P]=corr(ssqrt(X'));
                imagesc_rectangle(C,'YDir','reverse');
                caxis([0 1]);
                t=set(gca,'Ytick', '','YTickLabel',regName,'FontSize',24,'FontWeight','bold');
                t.Color='white';
            case 'subj_corr'
                X=nanmean(vecRDM,1);
                X=reshape(X,size(X,2),size(X,3));
                [C,P]=corr(ssqrt(X));
                imagesc_rectangle(C,'YDir','reverse');
                caxis([0 1]);
                t=set(gca,'Ytick', '','YTickLabel',subj_name(sn),'FontSize',12,'FontWeight','bold');
                t.Color='white';
                %                 title(regName)
                % disp average corr
                fprintf('average cross-subj corr is %2.2f \n',nanmean(rsa.rdm.vectorizeRDM(C)))
                varargout={C};
            case 'linRegress'
                % average across subjects (if num subj >1)
                vecRDMMean=mean(vecRDM,3);
                
                % option to remove motoric components
                switch removeMotor,
                    case 'hands'
                        % load feature matrix
                        F= sc1_imana('make_feature_model');
                        F=getrow(F,[2:30]'); % remove instructions
                        numTasks = 29;
                        X   = [F.lHand./F.duration F.rHand./F.duration];
                        X   = [X eye(numTasks)];
                        X   = bsxfun(@minus,X,nanmean(X));
                        X   = bsxfun(@rdivide,X,sqrt(sum(X.^2)));  % Normalize to unit length vectors
                        
                        for ii=1:2,
                            [Y,~] = rsa_classicalMDS(vecRDMMean(ii,:),'mode','RDM'); % predictor var
                            B = (X'*X+eye(size(X,2))*0.0001)\(X'*Y);
                            Yr    = Y  - X(:,1:3)*B(1:3,:); % remove motor features
                            [V,L]   = eig(Yr*Yr');
                            [l,i]   = sort(diag(L),1,'descend');           % Sort the eigenvalues
                            V       = V(:,i);
                            X1       = bsxfun(@times,V,sqrt(l'));
                            X2(:,:,ii) = real(X1);
                            clear Y Yr X1 V L i B l
                        end
                    case 'saccades'
                        % load feature matrix
                        F= sc1_imana('make_feature_model');
                        F=getrow(F,[2:30]'); % remove instructions
                        numTasks = 29;
                        X   = [F.saccades./F.duration];
                        X   = [X eye(numTasks)];
                        X   = bsxfun(@minus,X,nanmean(X));
                        X   = bsxfun(@rdivide,X,sqrt(sum(X.^2)));  % Normalize to unit length vectors
                        
                        for ii=1:2,
                            [Y,~] = rsa_classicalMDS(vecRDMMean(ii,:),'mode','RDM'); % predictor var
                            B = (X'*X+eye(size(X,2))*0.0001)\(X'*Y);
                            Yr    = Y  - X(:,1:3)*B(1:3,:); % remove motor features
                            [V,L]   = eig(Yr*Yr');
                            [l,i]   = sort(diag(L),1,'descend');           % Sort the eigenvalues
                            V       = V(:,i);
                            X1       = bsxfun(@times,V,sqrt(l'));
                            X2(:,:,ii) = real(X1);
                            clear Y Yr X1 V L i B l
                        end
                    case 'all_motor'
                        % load feature matrix
                        F= sc1_imana('make_feature_model');
                        F=getrow(F,[2:30]'); % remove instructions
                        numTasks = 29;
                        X   = [F.lHand./F.duration F.rHand./F.duration F.saccades./F.duration];
                        X   = [X eye(numTasks)];
                        X   = bsxfun(@minus,X,nanmean(X));
                        X   = bsxfun(@rdivide,X,sqrt(sum(X.^2)));  % Normalize to unit length vectors
                        
                        for ii=1:2,
                            [Y,~] = rsa_classicalMDS(vecRDMMean(ii,:),'mode','RDM'); % predictor var
                            B = (X'*X+eye(size(X,2))*0.0001)\(X'*Y);
                            Yr    = Y  - X(:,1:3)*B(1:3,:); % remove motor features
                            [V,L]   = eig(Yr*Yr');
                            [l,i]   = sort(diag(L),1,'descend');           % Sort the eigenvalues
                            V       = V(:,i);
                            X1       = bsxfun(@times,V,sqrt(l'));
                            X2(:,:,ii) = real(X1);
                            clear Y Yr X1 V L i B l
                        end
                    case 'no'
                        for ii=1:2,
                            [Y,~] = rsa_classicalMDS(vecRDMMean(ii,:),'mode','RDM');
                            [V,L]   = eig(Y*Y');
                            [l,i]   = sort(diag(L),1,'descend');           % Sort the eigenvalues
                            V       = V(:,i);
                            X1       = bsxfun(@times,V,sqrt(l'));
                            X2(:,:,ii) = real(X1);
                        end
                end
                
                % linear regression on reduced distances
                %
                % choose first dimension
                x=X2(:,1,1); % predictor
                y=X2(:,1,2); % dependent
                
                % do regression
                b=x\y;
                
                % do regression (with intercept)
                x_intercept=[ones(length(x),1) x];
                b_intercept=x_intercept\y;
                
                % plot regression line
                figure()
                scatterplot(x,y,'label',[1:numDist+1],'markerfill',[0 0 0],'regression','linear','intercept',0,'printcorr');
                hold on
                plot(x,b*x);
                hold on
                plot(x,x_intercept(:,2)*b_intercept(2,1),'--');
                axis equal
                %                 legend('data','slope','slope & intercept','Location','best');
                %                 xlabel(sprintf('tasks:%s',regName{1}))
                %                 ylabel(sprintf('tasks:%s',regName{2}))
                %                 title(subjTitle);
                grid on
                
                % print out taskNames
                disp(condNamesNoInstruct')
                
                % which is the better fit?
                R2 = 1 - sum((y - b*x).^2)/sum((y - mean(y)).^2);
                R2_intercept = 1 - sum((y - b_intercept(2,1)*x_intercept(:,2)).^2)/sum((y - mean(y)).^2);
                
                if R2_intercept>R2,
                    disp('fit including y-intercept is a better estimator')
                else
                    disp('fit not including y-intercept is a better estimator')
                end
            case 'sum'
                X=nanmean(fullRDM,4);
                figure()
                %                 scatterplot(sum(X(:,:,1))',sum(X(:,:,2))','markerfill',[0 0 0])
                scatterplot(sum(X(:,:,1))',sum(X(:,:,2))','markerfill',[0 0 0],'label',condNamesNoInstruct)
                title(regName{1})
                grid on
            case 'split_half'
                idx=1;
                for s=1:subjs,
                    idx2=1;
                    for i=1:numel(types),
                        for r=1:numel(reg{i}),
                            load(fullfile(regDir,'glm4',subj_name{sn(s)},sprintf('correlations_%s.mat',types{i})),'T');
                            A=getrow(T,T.method_num==2 & T.region==reg{i}(r));
                            C(idx)=A.corr;
                            R(idx)=idx2;
                            S(idx)=s;
                            regName{idx}=sprintf('%d.%s',idx,char(A.regName));
                            idx=idx+1;
                            idx2=idx2+1;
                        end
                    end
                end
                barplot(R',C','split',R','leg',regName')
                %                 barplot(R',C','split',R')
                ylabel('correlation')
        end
    case 'clusterMDS' % Does MDS modelling
        % example: sc1_imana('clusterMDS','cerebellum_grey',1)
        sn=varargin{1};
        type=varargin{2}; % dentate, cerebellum
        reg=varargin{3}; % 1,2,3 etc or 'all'
        removeMotor=varargin{4}; % 'hands', 'saccades','all','none'
        
        CAT.markertype='o';
        CAT.markersize=10;
        numTasks=28;
        
        subjs=length(sn);
        A=[];
        for s=1:subjs,
            % load statistics for subject(s) and GLM(s)
            load(fullfile(regDir,'glm4',subj_name{sn(s)},sprintf('Ttasks_%s.mat',type)));
            A = addstruct(A,Ts);
        end
        
        if strcmp(reg,'all'),
            T=getrow(A,A.method_num==2 & ismember(A.SN,sn));
            plotTitle=sprintf('concatenate-%s',type);
        else
            T=getrow(A,A.region==reg & A.method_num==2 & ismember(A.SN,sn));
            plotTitle=unique(T.regName);
        end
        
        % load feature matrix
        F= sc1_imana('make_feature_model');
        F=getrow(F,[2:numTasks+2]'); % remove instructions
        
        % Make RDM including rest from the IPM
        IPM = nanmean(T.IPM);
        con = indicatorMatrix('allpairs',[1:numTasks]);
        A = rsa_squareIPM(IPM);
        D = rsa.rdm.squareRDM(diag(con*A*con'));
        d = diag(A);  % Distances from zero
        fullRDM = [D d;[d' 0]];
        vecRDM = rsa.rdm.vectorizeRDM(fullRDM);
        tasks = [1:numTasks+1]';
        numTasks = numTasks+1;
        
        switch removeMotor,
            case 'hands'
                X   = [F.lHand./F.duration F.rHand./F.duration];
                X   = [X eye(numTasks)];
            case 'saccades'
                X   = [F.saccades./F.duration];
                X   = [X eye(numTasks)];
            case 'all'
                X   = [F.lHand./F.duration F.rHand./F.duration F.saccades./F.duration];
                X   = [X eye(numTasks)];
            case 'none'
                X   = [eye(numTasks)];
        end
        
        X   = bsxfun(@minus,X,nanmean(X));
        X   = bsxfun(@rdivide,X,sqrt(sum(X.^2)));  % Normalize to unit length vectors
        
        % Reduced Y
        [Y,~] = rsa_classicalMDS(vecRDM,'mode','RDM');
        B = (X'*X+eye(size(X,2))*0.0001)\(X'*Y); % ridge regression
        Yr    = Y  - X(:,1:3)*B(1:3,:); % remove motor features
        clustTree = linkage(Yr,'average');
        indx = cluster(clustTree,'cutoff',1);
        numClusters=length(unique(indx));
        
        color={[1 0 0],[0 1 0],[0 0 1],[0.2 0.7 0.3],[1 0 1],[1 1 0],[0 1 1],[0.5 0 0.4],[0.8 0.8 0.8],[.07 .48 .84],[.99 .76 .21],[.11 .7 .68],[.39 .74 .52],[.21 .21 .62],[0.2 0.2 0.2],[.6 .6 .6]};
        CAT.markercolor= {color{indx}};
        CAT.markerfill = {color{indx}};
        CAT.labelcolor  = {color{indx}};
        CAT.labelfont=12;
        [V,L]   = eig(Yr*Yr');
        [l,i]   = sort(diag(L),1,'descend');           % Sort the eigenvalues
        V       = V(:,i);
        X       = bsxfun(@times,V,sqrt(l'));
        X = real(X);
        figure
        scatterplot3(X(:,1),X(:,2),X(:,3),'split',tasks,'CAT',CAT,'label',condNamesNoInstruct);
        %                 scatterplot3(X(:,1),X(:,2),X(:,3),'split',tasks,'CAT',CAT)
        hold on;
        plot3(0,0,0,'+');
        
        % Draw connecting lines
        for i=1:numClusters,
            ind=clustTree(i,1:2);
            X(end+1,:)=(X(ind(1),:)+X(ind(2),:))/2;
            line(X(ind,1),X(ind,2),X(ind,3));
        end;
        hold off;
        set(gcf,'PaperPosition',[2 2 8 8]);
        set(gca,'XTickLabel',[],'YTickLabel',[],'ZTickLabel',[],'Box','on');
        axis equal;
        wysiwyg;
        view([81 9]);
        
    case 'process_pcm'
        type={'cerebellum','cortex'}; % add cerebellum
        for t=1:2,
            sc1_imana('pcm_prepData',type{t})
            sc1_imana('pcm_makeModel',type{t})
            sc1_imana('pcm_group',type{t})
            sc1_imana('pcm_individ',type{t})
        end
    case 'pcm_prepData'
        type=varargin{1}; % 'cortex' or 'cerebellum'
        
        T = load(fullfile(encodeDir,'glm4',sprintf('%s_allVoxels.mat',type))); % region stats (T)
        subjs=length(returnSubjs);
        
        % prep inputs for PCM modelling functions
        for s=1:subjs,
            subjOverlap=returnSubjs(s)-1; % subjs common to sc1 & sc2
            betaW           = T.Yy{subjOverlap};
            % get subject's partitions and second moment matrix
            D               = load(fullfile(baseDir,'GLM_firstlevel_4', subj_name{returnSubjs(s)}, 'SPM_info.mat'));   % load subject's trial structure
            N               = length(D.run);
            numConds        = length(D.cond(D.cond~=1))/numel(run); % remove instruct
            betaW           = betaW(1:N,:);
            betaW           = betaW(D.cond~=1,:); % remove instruct
            partVec{s}      = D.run(D.cond~=1);    % remove instruct
            condVec{s}      = repmat([1:numConds],1,numel(run))';  % remove instruct
            Y{s}            = betaW;
            G_hat(:,:,s)    = pcm_estGCrossval(Y{s},partVec{s},condVec{s});
        end
        fprintf('Y data prepared for %s',type)
        
        save(fullfile(regDir,'glm4',sprintf('pcm_data_%s.mat',type)),'Y','condVec','partVec','G_hat','-v7.3');
    case 'pcm_makeModel'
        type=varargin{1}; % 'cortex' or 'cerebellum'
        
        numConds=28; % exclude rest and instruct
        
        % Model 1: null model for baseline: all task conditions are
        % equally far away from each other
        M{1}.type       = 'component';
        M{1}.numGparams = 1;
        M{1}.Gc         = eye(numConds);
        M{1}.name       = 'null';
        
        % Model 2: free model as noise ceiling
        M{2}.type       = 'freechol';
        M{2}.numCond    = numConds;
        M{2}.name       = 'noiseceiling';
        M{2}            = pcm_prepFreeModel(M{2});
        
        % set up feature model
        F=importdata(fullfile(baseDir,'sc1_featureModel.xlsx'));
        F1.feat=F.data';F1.colheaders=F.colheaders';
        F1.feat=F1.feat(:,1:numConds);
        duration=F1.feat(5,:); % duration
        F1=getrow(F1,6:size(F1.feat,1)); % get all features except for the first five
        % normalise motor features by task duration
        for f=1:3,
            F1.feat(f,:)=F1.feat(f,:)./duration; % divide by duration
        end
        % z-score features
        allFeat=zscore(F1.feat');
        
        % Model 3: motor feature model (including baseline model)
        numFeat=numConds+3;
        motorFeat=zscore([allFeat(:,1:3),eye(numConds)]); % standarise motor features
        M{3}.type       = 'feature';
        M{3}.numGparams = numFeat;
        M{3}.Ac         = zeros(numConds,numFeat,numFeat);
        for f=1:numFeat,
            M{3}.Ac(:,f,f)=motorFeat(:,f);
        end
        M{3}.theta0     = [ones(numFeat,1)/2]; % starting values
        M{3}.name       = 'motor feature model';
        M{3}.featNames  = F1.colheaders(1:3);
        
        % Model 4: full feature model
        numFeat=size(allFeat,2);
        M{4}.type       = 'feature';
        M{4}.numGparams = numFeat;
        M{4}.Ac=zeros(numConds,numFeat,numFeat);
        for f=1:numFeat,
            M{4}.Ac(:,f,f)  = allFeat(:,f);
        end
        M{4}.theta0     =  [ones(numFeat,1)/2]; % starting values
        M{4}.name       = 'full feature model';
        M{4}.featNames  = F1.colheaders;
        
        % Model 5: 10 eigenvectors
        numFeat=10;
        load(fullfile(regDir,'glm4',sprintf('pcm_data_%s.mat',type)))
        avrgG_hat=nanmean(G_hat,3);
        h=eye(numConds)-ones(numConds)/numConds;
        avrgG_hat=(h*avrgG_hat*h);  % center G matrix
        [V,L]   = eig(avrgG_hat);
        [l,i]   = sort(diag(L),1,'descend');
        V       = V(:,i);
        indx = find(l<eps);
        V(:,indx)=0;
        allFeat=real(V);
        M{5}.type       = 'feature';
        M{5}.numGparams = numFeat;
        M{5}.Ac=zeros(numConds,numFeat,numFeat);
        for f=1:numFeat,
            M{5}.Ac(:,f,f)  = allFeat(:,f);
        end
        M{5}.theta0     =  [ones(numFeat,1)/2]; % starting values
        M{5}.name       = '10:raw feature model';
        for f=1:numFeat,
            M{5}.featNames{f,1}  = sprintf('EigenVec%d',f);
        end
        
        fprintf('%d models have been computed for %s \n',length(M),type)
        
        save(fullfile(regDir,'glm4',sprintf('pcm_model_%s.mat',type)),'M');
    case 'pcm_group'
        type=varargin{1}; % 'cortex' or 'cerebellum'
        
        % load model
        load(fullfile(regDir,'glm4',sprintf('pcm_model_%s.mat',type)))
        
        % load data
        load(fullfile(regDir,'glm4',sprintf('pcm_data_%s.mat',type)))
        
        % Fit the models on the group level
        [Tgroup,theta,G_pred]     = pcm_fitModelGroup(Y,M,partVec,condVec,'runEffect','fixed','fitScale',1);
        
        % Fit the models through cross-subject crossvalidation
        [Tcross,thetaCr,G_predCr] = pcm_fitModelGroupCrossval(Y,M,partVec,condVec,'runEffect','fixed','groupFit',theta,'fitScale',1);
        
        save(fullfile(regDir,'glm4',sprintf('pcm_fitModels_%s.mat',type)),'Tgroup','theta','G_pred');
        save(fullfile(regDir,'glm4',sprintf('pcm_crossValModels_%s.mat',type)),'Tcross','thetaCr','G_predCr','G_hat');
    case 'pcm_individ'
        type=varargin{1};
        
        % load model
        load(fullfile(regDir,'glm4',sprintf('pcm_model_%s.mat',type)))
        
        % load data
        load(fullfile(regDir,'glm4',sprintf('pcm_data_%s.mat',type)))
        
        % Fit the models on the individual level
        [T_indiv,theta_indiv,G_pred_indiv] = pcm_fitModelIndivid(Y,M,partVec,condVec,'isCheckDeriv',0);
        
        save(fullfile(regDir,'glm4',sprintf('pcm_indivFitModels_%s.mat',type)),'T_indiv','theta_indiv','G_pred_indiv');
    case 'PLOTTING:likelihood'
        type=varargin{1};
        group=varargin{2}; % 'yes' or 'no'
        
        % load model
        load(fullfile(regDir,'glm4',sprintf('pcm_model_%s.mat',type)))
        
        if strcmp(group,'yes')
            load(fullfile(regDir,'glm4',sprintf('pcm_crossValModels_%s.mat',type)))
            load(fullfile(regDir,'glm4',sprintf('pcm_fitModels_%s',type)));
            figure();T=pcm_plotModelLikelihood(Tcross,M,'upperceil',Tgroup.likelihood(:,2),'normalize',1,'mindx',[3:5]); % provide noise ceiling
            title(sprintf('sc1:%s',type))
        else
            load(fullfile(regDir,'glm4',sprintf('pcm_indivFitModels_%s.mat',type)))
            figure();T=pcm_plotModelLikelihood(T_indiv,M,'subj',2,'normalize',0); % provide noise ceiling
            title(sprintf('sc1:%s',type))
        end
        varargout={T};
    case 'PLOTTING:features'
        model=varargin{1}; % 1,2,3,4,5,6
        
        type={'cortex','cerebellum'};
        threshold={.001,1e-4};
        
        T=[];
        
        % get feature names
        load(fullfile(regDir,'glm4','pcm_model_cortex.mat'))
        featNames=M{model}.featNames;
        
        for t=1:numel(type),
            load(fullfile(regDir,'glm4',sprintf('pcm_indivFitModels_%s.mat',type{t})))
            numFeat=size(theta_indiv{model},1)-2;
            S.theta=theta_indiv{model}(1:numFeat,:).^2;
            S.featNames=featNames';
            S.type=repmat({type{t}},numFeat,1);
            S.typeNum=repmat(t,numFeat,1);
            T=addstruct(T,S);
        end
        
        % cortex against cerebellum
        % get average across subjects
        whitebg('black');scatterplot(nanmean(T.theta(T.typeNum==1,:),2),nanmean(T.theta(T.typeNum==2,:),2),'label',[1:numFeat],'regression','linear','printcorr','intercept',0,'markercolor',[1 1 1],'markersize',10)
        %         xlabel(unique(T.type(T.typeNum==1)));ylabel(unique(T.type(T.typeNum==2)));
        disp(featNames')
    case 'PLOTTING:MDS'
        type=varargin{1};
        
        % load group fitted G
        load(fullfile(regDir,'glm4',sprintf('pcm_data_%s.mat',type)))
        numConds=size(G_hat,1);
        avrgG_hat=nanmean(G_hat,3);
        h=eye(numConds)-ones(numConds)/numConds;
        avrgG_hat=(h*avrgG_hat*h);  % center G matrix
        [COORD,EV]=pcm_classicalMDS(avrgG_hat);
        lineplot([1:numConds]',COORD(:,3));
        disp(condNames(2:end-1)');
        
        scatterplot3(COORD(:,1),COORD(:,2),COORD(:,3),'label',condNames(2:end-1),'leg','auto');
        
    case 'process_connectivity'
    case 'TS_get_meants'            % Get univariately pre-whitened mean times series for each region
        % sc1_connectivity('TS_get_meants',[2 3 6 8 9 10 12 17:22],'sc2',4,'162_tessellation_hem');
        % sc1_connectivity('TS_get_meants',[2:22],'sc1',4,'162_tessellation_hem');
        sn=varargin{1}; % subjNum
        glm=varargin{2}; % glmNum
        type=varargin{3}; % '162_tessellation_hem', and 'cerebellum_grey'
        
        B = [];
        glmDir =fullfile(baseDir,sprintf('/GLM_firstlevel_%d',glm));
        subjs=length(sn);
        
        for s=1:subjs,
            glmDirSubj=fullfile(glmDir, subj_name{sn(s)});
            load(fullfile(glmDirSubj,'SPM.mat'));
            T=load(fullfile(glmDirSubj,'SPM_info.mat'));
            
            % load data
            tic;
            load(fullfile(regDir,'data',subj_name{sn(s)},sprintf('regions_%s.mat',type))); % 'regions' are defined in 'ROI_define'
            SPM=spmj_move_rawdata(SPM,fullfile(imagingDir,subj_name{sn(s)}));
            % Get the raw data files
            V=SPM.xY.VY;
            VresMS = spm_vol(fullfile(glmDirSubj,'ResMS.nii'));
            fprintf('Moved %d\n',toc);
            % Get time series data
            tic;
            Y = region_getdata(V,R);  % Data is N x P
            resMS = region_getdata(VresMS,R);
            fprintf('Data %d\n',toc);
            
            % Spatially prewhiten and average
            Data=zeros(numel(V),numel(R));
            for r=1:numel(R), % R is the output 'regions' structure from 'ROI_define'
                Y{r}=bsxfun(@rdivide,Y{r},sqrt(resMS{r}));
                Data(:,r)=nanmean(Y{r},2);
            end;
            
            clear Y;
            
            % Redo regression
            reg_interest=[SPM.xX.iH SPM.xX.iC];
            Yfilt = SPM.xX.W*Data;
            B = SPM.xX.pKX*Yfilt;                             %-Parameter estimates
            Yres = spm_sp('r',SPM.xX.xKXs,Yfilt);             %-Residuals
            
            % Decompose betas into mean and residuals
            Z=indicatorMatrix('identity',T.cond);
            Bm = Z*pinv(Z)*B(reg_interest,:);   % Mean betas
            Br = B(reg_interest,:)-Bm;
            Yhatm = SPM.xX.xKXs.X(:,reg_interest)*Bm; %- predicted values
            Yhatr = SPM.xX.xKXs.X(:,reg_interest)*Br; %- predicted values
            filename=(fullfile(regDir,sprintf('glm%d',glm),subj_name{sn(s)},sprintf('ts_%s.mat',type)));
            save(filename,'Data','Yres','Yhatm','Yhatr','B');
            
            fprintf('ts saved for %s (%s) for %s \n',subj_name{sn(s)},sprintf('glm%d',glm),type);
        end
    case 'TS_get_ts'                % Get univariately pre-whitened time series for each voxel of a region
        % sc1_connectivity('TS_get_ts',[2:22],'sc2',4,'Cerebellum_grey');
        % sc1_connectivity('TS_get_ts',[2 3 6 8 9 10 12 17:22],'sc2',4,'Cerebellum_grey');
        sn=varargin{1}; % subjNum
        glm=varargin{2}; % glmNum
        type=varargin{3}; % 'Cerebellum_grey'
        
        B = [];
        glmDir =fullfile(baseDir,sprintf('GLM_firstlevel_%d',glm));
        subjs=length(sn);
        
        if glm==5,
            imagingDir=imagingDirNA;
        elseif glm==6,
            imagingDir=imagingDirA;
        end
        
        for s=1:subjs,
            glmDirSubj=fullfile(glmDir, subj_name{sn(s)});
            load(fullfile(glmDirSubj,'SPM.mat'));
            T=load(fullfile(glmDirSubj,'SPM_info.mat'));
            
            % load data
            tic;
            load(fullfile(regDir,'data',subj_name{sn(s)},sprintf('regions_%s.mat',type))); % 'regions' are defined in 'ROI_define'
            SPM=spmj_move_rawdata(SPM,fullfile(imagingDir,subj_name{sn(s)}));
            % Get the raw data files
            V=SPM.xY.VY;
            VresMS = spm_vol(fullfile(glmDirSubj,'ResMS.nii'));
            fprintf('Moved %d\n',toc);
            % Get time series data
            tic;
            Y = region_getdata(V,R{1});  % Data is N x P
            resMS = region_getdata(VresMS,R{1});
            fprintf('Data %d\n',toc);
            
            % Spatially prewhiten
            Y=bsxfun(@rdivide,Y,sqrt(resMS));
            
            % Redo regression
            reg_interest=[SPM.xX.iH SPM.xX.iC];
            Yfilt = SPM.xX.W*Y;
            B = SPM.xX.pKX*Yfilt;                             %-Parameter estimates
            Yres = spm_sp('r',SPM.xX.xKXs,Yfilt);             %-Residuals
            
            % Decompose betas into mean and residuals
            Z=indicatorMatrix('identity',T.cond);
            Bm = Z*pinv(Z)*B(reg_interest,:);   % Mean betas
            Br = B(reg_interest,:)-Bm;
            Yhatm = SPM.xX.xKXs.X(:,reg_interest)*Bm; %- predicted values
            Yhatr = SPM.xX.xKXs.X(:,reg_interest)*Br; %- predicted values
            filename=(fullfile(regDir,sprintf('glm%d',glm),subj_name{sn(s)},sprintf('ts_%s.mat',type)));
            dircheck(fullfile(regDir,sprintf('glm%d',glm),subj_name{sn(s)}));
            save(filename,'Yres','Yhatm','Yhatr','B');
            fprintf('ts saved for %s (%s) for %s \n',subj_name{sn(s)},sprintf('glm%d',glm),type);
        end
    case 'TS_allsubj'               % Make a structure of all cortical time series of all subject - also seperate out residual from
        sn=varargin{1};  % subjNum
        glm=varargin{2}; % glmNum
        type=varargin{3}; % '162_tessellation_hem' or 'cerebellum_grey'
        session_specific = 1;
        
        vararginoptions(varargin,{'sn','glm4','type','session_specific'});
        
        glmDir =fullfile(baseDir,sprintf('/GLM_firstlevel_%d',glm));
        numSubj=length(sn);
        
        for s=1:numSubj
            fprintf('%d\n',s);
            % load condition data
            glmDirSubj=fullfile(glmDir, subj_name{sn(s)});
            load(fullfile(glmDirSubj,'SPM_light.mat'));
            T=load(fullfile(glmDirSubj,'SPM_info.mat'));
            % load data
            filename=(fullfile(regDir,sprintf('glm%d',glm),subj_name{sn(s)},sprintf('ts_%s.mat',type)));
            S=load(filename);
            
            reg_interest=[SPM.xX.iH SPM.xX.iC];
            % Decompose betas into mean and residuals
            if (session_specific)
                Z=indicatorMatrix('hierarchicalI',[T.sess T.cond]);
            else
                Z=indicatorMatrix('identity',T.cond);
            end;
            B(:,:,s)=S.B;
            Yres(:,:,s)=S.Yres;
            Bm = Z*pinv(Z)*S.B(reg_interest,:);   % Mean betas
            Br = S.B(reg_interest,:)-Bm;
            Yhatm(:,:,s) = SPM.xX.xKXs.X(:,reg_interest)*Bm; %- predicted values
            Yhatr(:,:,s) = SPM.xX.xKXs.X(:,reg_interest)*Br; %- predicted values
        end;
        if (session_specific)
            save(fullfile(regDir,sprintf('glm%d',glm),sprintf('ts_%s_all_se.mat',type)),'Yres','Yhatm','Yhatr','B');
        else
            save(fullfile(regDir,sprintf('glm%d',glm),sprintf('ts_%s_all.mat',type)),'Yres','Yhatm','Yhatr','B');
        end;
        
    case 'check_times_runs'             % PLOTTING: Ensure that start-times (real and predicted) match
        % Check that the startimes match TR times
        % example: sc1_imana('check_start-times',1)
        sn=varargin{1}; % subjNum
        
        cd(fullfile(behavDir,subj_name{sn}));
        
        D = dload(sprintf('sc1_%s.dat',subj_name{sn}));
        D = getrow(D,D.runNum>=funcRunNum(1)); % gets behavioural data for functional runs
        %         lineplot(D.realStartTime(D.runNum>=funcRunNum(1)),D.startTime(D.runNum>=funcRunNum(1)));
        pivottable(D.runNum,D.startTime,D.realStartTime,'(x)'); % visually inspect that the start-times match
        taskNames=unique(D.taskName);
        for tt=1:length(taskNames),
            table(D.taskFile(strcmpi(D.taskName,taskNames(tt))),D.runNum(strcmpi(D.taskName,taskNames(tt))));
        end
        fprintf('Visually inspect that the startimes match across all runs \n')
    case 'check_behavioural'            % PLOTTING: Check behavioural performance
        % Get behavioural results
        % example: sc1_imana('check_behavioural',[1:4],'stroop',1)
        sn=varargin{1};  % subjNum
        type=varargin{2};% choose task from section 5 ('taskNames')
        
        switch type
            case 'stroop'
                A=[];
                for s=sn,
                    
                    D = dload(fullfile(behavDir,subj_name{s},sprintf('sc1_%s_stroop.dat',subj_name{s})));
                    A = addstruct(A,D);
                    A = getrow(A,A.runNum>=funcRunNum(1) & A.runNum<=funcRunNum(2));
                end
                
                if numel(sn)>1,
                    main='all subjects';
                    main=type;
                else
                    main=subj_name{s};
                    main=type;
                end
                
                figure(s)
                subplot(2,1,1)
                lineplot([A.runNum], A.rt, 'split',A.trialType,'leg',{'incongruent','congruent'},'subset',A.respMade==1);
                xlabel('Run')
                ylabel('Reaction Time')
                title(main)
                
                subplot(2,1,2)
                lineplot([A.runNum], A.numCorr, 'split',A.trialType,'leg',{'incongruent','congruent'},'subset', A.respMade==1);
                xlabel('Run')
                ylabel('Percent correct')
                title(main)
            case 'nBack'
                A=[];
                for s=sn,
                    
                    D = dload(fullfile(behavDir,subj_name{s},sprintf('sc1_%s_nBack.dat',subj_name{s})));
                    A = addstruct(A,D);
                    A = getrow(A,A.runNum>=funcRunNum(1) & A.runNum<=funcRunNum(2));
                end
                
                if numel(sn)>1,
                    main='all subjects';
                    main=type;
                else
                    main=subj_name{s};
                    main=type;
                end
                
                figure(s)
                subplot(2,1,1)
                lineplot(A.runNum, A.rt, 'split', A.possCorr,'leg', {'No Match','Match'}, 'subset',A.respMade==1);
                xlabel('Run')
                ylabel('Reaction Time')
                title(main)
                
                subplot(2,1,2)
                lineplot(A.runNum, A.numCorr, 'split', A.possCorr,'leg', {'No Match','Match'}, 'subset',A.respMade==1);
                xlabel('Run')
                ylabel('Percent Correct')
                title(main)
            case 'visualSearch'
                A=[];
                for s=sn,
                    
                    D = dload(fullfile(behavDir,subj_name{s},sprintf('sc1_%s_visualSearch.dat',subj_name{s})));
                    A = addstruct(A,D);
                    A = getrow(A,A.runNum>=funcRunNum(1) & A.runNum<=funcRunNum(2));
                end
                
                if numel(sn)>1,
                    main='all subjects';
                    main=type;
                else
                    main=subj_name{s};
                    main=type;
                end
                
                figure(s)
                subplot(4,1,1)
                lineplot(A.runNum, A.rt, 'split', A.trialType,'leg', {'absent','present'}, 'subset',A.respMade==1);
                xlabel('Run')
                ylabel('Reaction Time')
                title(main)
                
                subplot(4,1,2)
                lineplot(A.runNum, A.numCorr, 'split', A.trialType,'leg', {'absent','present'}, 'subset',A.respMade==1);
                xlabel('Run')
                ylabel('Percent Correct')
                title(main)
                
                subplot(4,1,3)
                lineplot(A.runNum, A.rt, 'split', A.setSize,'leg', {'4','8','12'}, 'subset',A.respMade==1);
                xlabel('Run')
                ylabel('Reaction Time')
                title(main)
                
                subplot(4,1,4)
                lineplot(A.runNum, A.numCorr, 'split', A.setSize,'leg', {'4','8','12'}, 'subset',A.respMade==1);
                xlabel('Run')
                ylabel('Percent Correct')
                title(main)
            case 'GoNoGo'
                A=[];
                for s=sn,
                    
                    D = dload(fullfile(behavDir,subj_name{s},sprintf('sc1_%s_GoNoGo.dat',subj_name{s})));
                    A = addstruct(A,D);
                    A = getrow(A,A.runNum>=funcRunNum(1) & A.runNum<=funcRunNum(2));
                end
                
                if numel(sn)>1,
                    main='all subjects';
                    main=type;
                else
                    main=subj_name{s};
                    main=type;
                end
                
                figure(s)
                subplot(2,1,1)
                lineplot(A.runNum, A.rt, 'split', A.trialType,'leg', {'negative','positive'}, 'subset',A.respMade==1);
                xlabel('Run')
                ylabel('Reaction Time')
                title(main)
                
                subplot(2,1,2)
                lineplot(A.runNum, A.numCorr, 'split', A.trialType,'leg', {'negative','positive'}, 'subset',A.respMade==1);
                xlabel('Run')
                ylabel('Percent Correct')
                title(main)
            case 'nBackPic'
                A=[];
                for s=sn,
                    
                    D = dload(fullfile(behavDir,subj_name{s},sprintf('sc1_%s_nBackPic.dat',subj_name{s})));
                    A = addstruct(A,D);
                    A = getrow(A,A.runNum>=funcRunNum(1) & A.runNum<=funcRunNum(2));
                end
                
                if numel(sn)>1,
                    main='all subjects';
                    main=type;
                else
                    main=subj_name{s};
                    main=type;
                end
                
                figure(s)
                subplot(2,1,1)
                lineplot(A.runNum, A.rt, 'split', A.possCorr,'leg', {'No Match','Match'}, 'subset',A.respMade==1);
                xlabel('Run')
                ylabel('Reaction Time')
                title(main)
                
                subplot(2,1,2)
                lineplot(A.runNum, A.numCorr, 'split', A.possCorr,'leg', {'No Match','Match'}, 'subset',A.respMade==1);
                xlabel('Run')
                ylabel('Percent Correct')
                title(main)
            case 'affective'
                A=[];
                for s=sn,
                    
                    D = dload(fullfile(behavDir,subj_name{s},sprintf('sc1_%s_affective.dat',subj_name{s})));
                    A = addstruct(A,D);
                    A = getrow(A,A.runNum>=funcRunNum(1) & A.runNum<=funcRunNum(2));
                end
                
                if numel(sn)>1,
                    main='all subjects';
                    main=type;
                else
                    main=subj_name{s};
                    main=type;
                end
                
                figure(s)
                subplot(2,1,1)
                lineplot(A.runNum, A.rt, 'split', A.trialType,'leg', {'unpleasant','pleasant'}, 'subset',A.respMade==1);
                xlabel('Run')
                ylabel('Reaction Time')
                title(main)
                
                subplot(2,1,2)
                lineplot(A.runNum, A.numCorr, 'split', A.trialType,'leg', {'unpleasant','pleasant'}, 'subset',A.respMade==1);
                xlabel('Run')
                ylabel('Percent Correct')
                title(main)
            case 'emotional'
                A=[];
                for s=sn,
                    
                    D = dload(fullfile(behavDir,subj_name{s},sprintf('sc1_%s_emotional.dat',subj_name{s})));
                    A = addstruct(A,D);
                    A = getrow(A,A.runNum>=funcRunNum(1) & A.runNum<=funcRunNum(2));
                end
                
                if numel(sn)>1,
                    main='all subjects';
                    main=type;
                else
                    main=subj_name{s};
                    main=type;
                end
                
                figure(s)
                subplot(2,1,1)
                lineplot(A.runNum, A.rt, 'split', A.trialType,'leg', {'sad','happy'}, 'subset',A.respMade==1);
                xlabel('Run')
                ylabel('Reaction Time')
                title(main)
                
                subplot(2,1,2)
                lineplot(A.runNum, A.numCorr, 'split', A.trialType,'leg', {'sad','happy'}, 'subset',A.respMade==1);
                xlabel('Run')
                ylabel('Percent Correct')
                title(main)
            case 'ToM'
                A=[];
                for s=sn,
                    
                    D = dload(fullfile(behavDir,subj_name{s},sprintf('sc1_%s_ToM.dat',subj_name{s})));
                    A = addstruct(A,D);
                    A = getrow(A,A.runNum>=funcRunNum(1) & A.runNum<=funcRunNum(2));
                end
                
                if numel(sn)>1,
                    main='all subjects';
                    main=type;
                else
                    main=subj_name{s};
                    main=type;
                end
                
                figure(s)
                subplot(2,1,1)
                lineplot(A.runNum, A.rt,'split',A.condition,'leg',{'false','true'},'subset',A.respMade==1);
                xlabel('Run')
                ylabel('Reaction Time')
                title(main)
                
                subplot(2,1,2)
                lineplot(A.runNum, A.numCorr,'split',A.condition,'leg',{'false','true'},'subset',A.respMade==1);
                xlabel('Run')
                ylabel('Percent Correct')
                title(main)
            case 'arithmetic'
                A=[];
                for s=sn,
                    
                    D = dload(fullfile(behavDir,subj_name{s},sprintf('sc1_%s_arithmetic.dat',subj_name{s})));
                    A = addstruct(A,D);
                    A = getrow(A,A.runNum>=funcRunNum(1) & A.runNum<=funcRunNum(2));
                end
                
                if numel(sn)>1,
                    main='all subjects';
                    main=type;
                else
                    main=subj_name{s};
                    main=type;
                end
                
                figure(s)
                subplot(2,1,1)
                lineplot(A.runNum, A.rt, 'split', A.trialType,'leg', {'equations','control'}, 'subset',A.respMade==1);
                xlabel('Run')
                ylabel('Reaction Time')
                title(main)
                
                subplot(2,1,2)
                lineplot(A.runNum, A.numCorr, 'split', A.trialType,'leg', {'equations','control'}, 'subset',A.respMade==1);
                xlabel('Run')
                ylabel('Percent Correct')
                title(main)
            case 'intervalTiming'
                A=[];
                for s=sn,
                    
                    D = dload(fullfile(behavDir,subj_name{s},sprintf('sc1_%s_intervalTiming.dat',subj_name{s})));
                    A = addstruct(A,D);
                    A = getrow(A,A.runNum>=funcRunNum(1) & A.runNum<=funcRunNum(2));
                end
                
                if numel(sn)>1,
                    main='all subjects';
                    main=type;
                else
                    main=subj_name{s};
                    main=type;
                end
                
                figure(s)
                subplot(2,1,1);
                lineplot(A.runNum,A.rt,'split',A.trialType,'leg', {'long', 'short'},'subset',A.respMade==1);
                xlabel('Run');
                ylabel('Reaction Time');
                title(main);
                
                subplot(2,1,2);
                lineplot(A.runNum,A.numCorr,'split',A.trialType,'leg',{'long','short'},'subset',A.respMade==1);
                xlabel('Run')
                ylabel('Percent Correct')
                title(main);
            case 'motorSequence'
                A=[];
                for s=sn,
                    
                    D = dload(fullfile(behavDir,subj_name{s},sprintf('sc1_%s_motorSequence.dat',subj_name{s})));
                    A = addstruct(A,D);
                    A = getrow(A,A.runNum>=funcRunNum(1) & A.runNum<=funcRunNum(2));
                end
                
                if numel(sn)>1,
                    main='all subjects';
                    main=type;
                else
                    main=subj_name{s};
                    main=type;
                end
                
                figure(s)
                subplot(2,1,1);
                lineplot(A.runNum,A.rt,'split',A.trialType,'leg',{'control','sequence'});
                xlabel('Run');
                ylabel('Reaction Time');
                title(main)
                
                subplot(2,1,2);
                lineplot(A.runNum,A.numCorr,'split', A.trialType,'leg', {'control','sequence'});
                xlabel('Run')
                ylabel('Percent Correct')
                title(main)
        end
    case 'heartRate'                    % PLOTTING: Plot average heart-rate across tasks
        sn=varargin{1};
        
        A=[];
        H=[];
        T=[];
        dur=30;
        announceTime=5;
        
        taskNames2 = {'1.GoNoGo','2.ToM','3.actionObs','4.affective','5.arith',...
            '6.checkerBoard','7.emotional','8.intTiming','9.motorImagery','10.motorSequence',...
            '11.nBack', '12.nBackPic','13.spatialNavigation','14.stroop', '15.verbGeneration',...
            '16.visualSearch','17.rest'};
        
        for s=sn,
            
            % load physio regressors
            load(fullfile(physioDir,subj_name{s},'physioReg.mat'));
            
            % load runFile
            D=dload(fullfile(baseDir, 'data', subj_name{s},['sc1_',subj_name{s},'.dat']));
            D = getrow(D,D.runNum>=funcRunNum(1) & D.runNum<=funcRunNum(2)); % Get imaging behavioural data
            
            A{s} = P;
            for r=1:numel(run),
                A{s}{r}.SN=s; % subjNum
                A{s}{r}.run=r; % runNum
                H=addstruct(H,A{s}{r});
            end
            for r=1:numel(run), % loop through runs
                R=getrow(D,D.runNum==runB(r));
                heartRate = H.rate(H.SN==s & H.run==r,:);
                for t=1:numel(taskNumbers), % loop through tasks
                    
                    idx=find(strcmp(R.taskName,taskNames{t}));
                    startTime=R.realStartTime(idx)+announceTime-(1*numDummys);
                    S.taskName= R.taskName(idx(1));
                    S.heartRate = mean(heartRate(:,floor(startTime:startTime+dur)),2); % mean heart-rate
                    S.run= r;
                    S.SN = s;
                    S.taskNum = t;
                    T=addstruct(T,S);
                end
            end
        end
        
        figure(sn(1));
        subplot(2,1,1)
        lineplot(H.run,mean(H.rate,2),'split',H.SN,'leg',subj_name(unique(H.SN))); % average heartRate across runs per subject
        xlabel('Runs')
        ylabel('Heart-rate')
        
        subplot(2,1,2)
        lineplot(T.taskNum,T.heartRate,'split',T.taskName,'leg',taskNames2);
        ylabel('Heart-rate')
        xlabel('Tasks')
        
        pivottable(T.SN,T.taskNum,T.heartRate,'(x)');
    case 'saccades'                     % PLOTTING: Pivottable (average saccades across tasks)
        sn=varargin{1};
        glm=varargin{2};
        Rr=[];
        
        switch glm,
            case 13
                taskNames = taskNames;
            case 4
                taskNames=condNames;
        end
        
        for s=sn,
            eyeSubjDir=fullfile(eyeDir,subj_name{s});
            load(fullfile(eyeSubjDir,sprintf('glm%d_saccades.mat',glm)));  % load saccade info
            Rr=addstruct(Rr,R);
        end
        
        lineplot(Rr.condNum,Rr.avgSacc,'split',Rr.taskName,'leg',taskNames,'markersize',10);
        xlabel('Tasks')
        ylabel('Number of Saccades')
        varargout={Rr};
    case 'plotSaccades'                 % PLOTTING: Plot x,y coordinates of eye-movements (per task & per subject)
        % plot eyeTracking data for individual tasks
        sn=varargin{1};
        tn=varargin{2}; % taskName
        
        if strcmp(tn,'motorImagery') || strcmp(tn,'motorSequence') || strcmp(tn,'nBack')|| strcmp(tn,'nBackPic'),
            taskN = tn(end-1:end);
        else
            taskN = tn(1:2);
        end
        
        filename=dir(fullfile(eyeDirRaw,subj_name{sn},sprintf('*%s*',taskN)));
        E=Edf2Mat(fullfile(eyeDirRaw,subj_name{sn},filename(saccRun{sn}(1)).name)); % first example of a run
        
        plotEye(E,tn);
    case 'residuals'                    % PLOTTING: Plot residuals (movement) across tasks
        sn=varargin{1};
        glm=varargin{2}; % glm 4
        
        SS=[];
        for s=sn,
            T=[];
            % load SPM
            glmSubjDir =[baseDir sprintf('/GLM_firstlevel_%d/',glm)  subj_name{s}];dircheck(glmSubjDir);
            load(fullfile(glmSubjDir,'SPM_light.mat'));
            
            MOV=spm_rwls_resstats(SPM); % get movement parameters
            
            numTasks=length(SPM.Sess(1).U);
            
            % Get start times (over entire timeseries) per task
            for t=1:numTasks, % loop over tasks
                for r=1:numel(run), % loop over runs
                    S.taskOns = floor(SPM.Sess(r).U(t).ons); % only interested in execution (not instructions)
                    S.runNum = r;
                    S.taskName = SPM.Sess(r).U(t).name(t);
                    S.taskNum = t;
                    S.SN=s;
                    T=addstruct(T,S);
                end
            end
            
            % Get average movement, ResMS per task
            for tt=1:numel(taskNames)-1, % loop over tasks
                taskStart=[T.taskOns(T.taskNum==tt & T.runNum==1);(cumsum(SPM.nscan(2:end))'+T.taskOns(T.taskNum==tt & T.runNum~=1))]; % start-time of each task across entire timeseries
                taskEnd=taskStart+30; % end time of tasks across entire timeseries
                
                R=[];
                subset=[];
                
                % Get timepoints (per task)
                for ii=1:length(taskStart),
                    Rr.runs=(taskStart(ii):taskEnd(ii)-1);
                    R=addstruct(R,Rr');
                    subset=horzcat(subset,R.runs(ii,:));
                end
                
                ResMS = sqrt(SPM.ResStats.ss./SPM.ResStats.n);
                meanResMS = mean(ResMS(subset));
                meanTrans = mean(MOV(subset,1:3));
                meanRot   = mean(MOV(subset,4:6));
                
                Ss.SN    = s;
                Ss.TN    = tt;
                Ss.taskName = taskNames(tt);
                Ss.trans = meanTrans;
                Ss.rot   = meanRot;
                Ss.resMS = meanResMS;
                SS=addstruct(SS,Ss);
                
                if numel(sn)==1,
                    % Plot res mean-square error (per task)
                    FigHandle = figure(str2double(SPM.swd(end-1:end)));
                    set(FigHandle, 'Position', [100, 100, 1049, 895]);
                    max_sd=[];
                    subplot(4,4,tt)
                    sd_post=sqrt(SPM.ResStats.ss./SPM.ResStats.n);
                    if (isempty(max_sd))
                        max_sd=max(sd_post(subset));
                    end;
                    %             max_sdTask(tt,1)=max(sd_post(subset));
                    plot(subset,sd_post(subset),'k.');
                    set(gca,'Box','off','YLim',[0 max_sd*1.1]);
                    xlabel(char(taskNames(tt)));
                    ylabel('Res Mean-Square Error (SD)');
                    subtitle(char(SPM.swd(end-2:end)));
                    
                    % Plot average movement (per task)
                    FigHandle = figure(str2double(SPM.swd(end-1:end))+1);
                    set(FigHandle, 'Position', [100, 100, 1049, 895]);
                    subplot(4,4,tt)
                    plot(subset,MOV(subset,1:3));
                    legend({'x','y','z'});
                    legend(gca,'boxoff');
                    set(gca,'Box','off');
                    ylabel('Translation [mm]');
                    xlabel(char(taskNames(tt)));
                    subtitle(char(SPM.swd(end-2:end)));
                end
            end
        end
        varargout={SS};
        pivottable(SS.SN,SS.TN,SS.resMS,'mean(x)');
    case 'check_designMatrix'           % PLOTTING: Visually inspect design matrix
        % example: sc1_imana('check_designMatrix',1,1)
        % run 'make_glm#','estimate_glm' and 'contrast' before this step
        sn=varargin{1};
        glm=varargin{2};
        
        glmDir =[baseDir sprintf('/GLM_firstlevel_%d/',glm) subj_name{sn}];
        
        A=load(fullfile(glmDir,'SPM.mat'));
        
        X=A.SPM.xX.X(A.SPM.Sess(1).row,A.SPM.Sess(1).col);
        
        figure(sn);
        imagesc(X);
        title('Design Matrix for run 1')
        
        figure(sn+1);
        indx=A.SPM.Sess(1).col;
        imagesc(A.SPM.xX.Bcov(indx,indx))
        title('variance of predicted betas')
        
        if length(varargin)==3,
            reg=varargin{3}; % specify [10,11] for example
            figure(3);
            plot([1:size(X,1)],X(:,reg),'b'); % which regressors are we plotting?
        end
    case 'check_movement'               % PLOTTING: Check residual SD
        % example: sc1_imana('check_movement2',1,'both')
        s=varargin{1}; % subjNum
        glm=varargin{2}; % glmNum
        
        glmSubjDir =[baseDir sprintf('/GLM_firstlevel_%d/',glm)  subj_name{s}];dircheck(glmSubjDir);
        load(fullfile(glmSubjDir,'SPM_light.mat'));
        spm_rwls_resstats(SPM);
        
        % 'spm_rwls_resstats' was edited to include check for FAST GLM
        % ('spm_light') - no 'xVi' field
    case 'ROI_plot_PC'                  % PLOTTING: Test pattern consistencies (across subs,across sessions,across regions)
        % example: sc1_imana('ROI_plot_PC',[1,2,3],[1,3])
        % default noise normalisation is univariate. For NW or MW add 1 or
        % 3 respectively. For example: sc1_imana('ROI_plot_PC',[1:3],[3],1)
        sn=varargin{1};
        types=varargin{2}; % {'cortex_grey','cerebellum_grey'}
        reg=varargin{3}; % which region of the cortex (lh or rh) or cortical_lobes (1,2,3,4) or cerebellar lobules (1-10)?
        step=varargin{4};
        
        subjs=length(sn);
        
        A=[];
        idx=1;
        for s=1:subjs,
            idx2=1;
            for i=1:numel(types),
                for r=1:numel(reg{i}),
                    % load statistics for all subjects and all GLMs
                    load(fullfile(regDir,'glm4',subj_name{sn(s)},sprintf('Toverall_%s.mat',types{i})));
                    A=getrow(To,To.method_num==2 & To.region==reg{i}(r));
                    sess1(idx)=A.R2_Sess1;
                    sess2(idx)=A.R2_Sess2;
                    overall(idx)=A.R2_overall;
                    S(idx)=s+1;
                    R(idx)=idx2;
                    regName{idx}=sprintf('%d.%s',idx,char(A.regName));
                    idx=idx+1;
                    idx2=idx2+1;
                end
            end
        end
        
        switch step,
            case 'subjs'
                figure()
                barplot(S',overall','split',R','leg',regName')
                ylabel('R2')
            case 'regions'
                figure()
                barplot(R',overall','split',R','leg',regName')
                ylabel('R2')
            case 'sess1'
                figure()
                barplot(R',sess1','split',R','leg',regName')
                ylabel('R2')
            case 'sess2'
                figure()
                barplot(R',sess2','split',R','leg',regName')
                ylabel('R2')
        end
    case 'summary_PC'                   % PLOTTING: Display pattern consistency values for all GLMS
        sn=varargin{1};
        glm=varargin{2};
        
        if length(varargin)==3, % if we specify no or multivariate noise normalise
            w=varargin{3};
        else
            w=2; % default is univariate noise normalise for PC (more effective than multivar in our case)
        end
        
        A=[];
        for g=glm,
            % load statistics for all subjects and all GLMs
            load(fullfile(regDir,sprintf('glm%d',g),subj_name{sn},'Toverall.mat'));
            To=rmfield(To,{'RDMh_1','RDMh_2'});
            A = addstruct(A,To);
        end
        
        P = getrow(A,A.method_num==w);
        
        pivottable(P.GLM,P.SN,P.R2_overall,'mean(x)');
        
        pivottable(P.GLM,P.regName,P.R2_overall,'mean(x)');
        
        figure(sn)
        barplot(P.GLM,P.R2_overall)
    case 'make_feature_model'
        D.saccades=[15 28 28 98 31 31 37 37 29 29 46 38 38 36 41 38 38 20 20 25 25 50 22 22 26 26 32 32 32 45]';
        D.duration = [5;15;15;30;15;15;15;15;15;15;30;15;15;30;30;15;15;15;15;15;15;30;15;15;15;15;10;10;10;30];
        D.lHand = [0;0;15;2;0;0;8;7;0;0;0;0;0;0;0;12;12;0;7;0;0;0;3.5;4;0;0;5;5;5;0];
        D.rHand = [0;0;0;0;0;0;0;0;5;5;0;8;7;15;0;12;12;0;0;0;7;0;3.5;4;0;0;0;0;0;0];
        varargout={D};
    case 'ROI_MDS_overall'              % PLOTTING: Visualise Multidimensional Scaling
        % example: sc1_imana('ROI_MDS_overall',[1:4],1,1,1)
        sn  = varargin{1}; % subjNum
        type = varargin{2}; % dentate
        reg = varargin{3}; % 1
        contrast = varargin{4}; % 'motor_features'
        
        color={[1 1 0] [1 0 1] [0 1 1] [1 0 0] [0 1 0] [0 0 1] [1 1 1] [0 0 0] [1 0.5 0] [0.5 0 1] [0.9 0 0] [1 0.6 0] [0 0.7 0] [0.8 0.5 0] [0.3 0 1] [1 0.4 0.7] [1 1 0] [1 0 1] [0 1 1] [1 0 0] [0 1 0] [0 0 1] [1 1 1] [0 0 0] [1 0.5 0] [0.5 0 1] [0.9 0 0] [1 0.6 0] [0 0.7 0] [0.8 0.5 0] [0.3 0 1] [1 0.4 0.7] };
        CAT.markercolor=color;
        CAT.markerfill=color;
        CAT.markertype='o';
        CAT.markersize=10;
        
        subjs=length(sn);
        A=[];
        for s=1:subjs,
            % load statistics for subject(s) and GLM(s)
            load(fullfile(regDir,'glm4',subj_name{sn(s)},sprintf('Ttasks_%s.mat',type)));
            A = addstruct(A,Ts);
        end
        
        T=getrow(A,A.region==reg & A.method_num==2 & ismember(A.SN,sn)); % Univariate PW only
        numTasks=28;
        
        if strcmp(reg,'all'),
            T=getrow(A,A.method_num==2 & ismember(A.SN,sn));
            plotTitle=sprintf('concatenate-%s',type);
        else
            T=getrow(A,A.region==reg & A.method_num==2 & ismember(A.SN,sn));
            plotTitle=unique(T.regName);
        end
        
        % load feature matrix
        F=sc1_imana('make_feature_model');
        F=getrow(F,[2:30]'); % remove instruction
        
        % Make a RDM including rest from the IPM
        IPM = mean(T.IPM);
        con = indicatorMatrix('allpairs',[1:numTasks]);
        A = rsa_squareIPM(IPM);
        D = rsa.rdm.squareRDM(diag(con*A*con'));
        d = diag(A);  % Distances from zero
        fullRDM = [D d;[d' 0]];
        vecRDM = rsa.rdm.vectorizeRDM(fullRDM);
        tasks = [1:29]';
        numTasks = 29;
        
        switch contrast
            case 'all'
                Call   = eye(numTasks)-ones(numTasks)/numTasks;
                Y = rsa_classicalMDS(vecRDM,'mode','RDM','contrast',Call);
                scatterplot3(Y(:,1),Y(:,2),Y(:,3),'split',tasks,'CAT',CAT,'label',condNamesNoInstruct);
                hold on;
                plot3(0,0,0,'+');
                hold off;
                axis equal;
            case 'motor_features'
                MF   = [F.lHand./F.duration F.rHand./F.duration F.saccades./F.duration];
                MF = bsxfun(@minus,MF,mean(MF));
                MF=bsxfun(@rdivide,MF,sqrt(sum(MF.^2)));  % Normalize to unit length vectors
                % Call   = eye(numTasks)-ones(numTasks)/numTasks;
                
                [Y,l] = rsa_classicalMDS(vecRDM,'mode','RDM','contrast',MF);
                scatterplot3(Y(:,1),Y(:,2),Y(:,3),'split',tasks,'CAT',CAT,'label',condNamesNoInstruct,'color',F.visualStim);
                hold on;
                plot3(0,0,0,'+');
                
                % project the motor features into this space and plot
                yp = Y(:,1:3);
                yp = bsxfun(@rdivide,yp,sqrt(sum(yp.^2)));  % Normalize to unit length vectors
                
                b=pinv(yp)*MF;
                linecolor={'r','b','g'};
                for j=1:3
                    quiver3(0,0,0,b(1,j),b(2,j),b(3,j),0.1,linecolor{j});
                end;
                hold off;
                axis equal;
            case 'cognitive_features_unknown'
                CF   = [F.lHand./F.duration F.rHand./F.duration F.saccades./F.duration];
                CF = bsxfun(@minus,CF,mean(CF));
                CF=bsxfun(@rdivide,CF,sqrt(sum(CF.^2)));  % Normalize to unit length vectors
                Call   = eye(numTasks)-ones(numTasks)/numTasks;
                
                [Y,~] = rsa_classicalMDS(vecRDM,'mode','RDM','contrast',Call);
                
                % Reduced Y
                Yr = Y-CF*pinv(CF)*Y;
                
                [V,L]=eig(Yr*Yr');
                [l,i]   = sort(diag(L),1,'descend');           % Sort the eigenvalues
                V       = V(:,i);
                X       = bsxfun(@times,V,sqrt(l'));
                X = real(X);
                scatterplot3(X(:,1),X(:,2),X(:,3),'split',tasks,'CAT',CAT,'label',condNamesNoInstruct,'color',F.visualStim);
                hold on;
                plot3(0,0,0,'+');
                
                hold off;
                axis equal;
            case 'saccades'
                scatterplot3(Y(:,1),Y(:,2),Y(:,3),'split',tasks,'CAT',CAT,'label',condNamesNoInstruct);
                hold on;
                plot3(0,0,0,'+');
                hold off;
                axis equal;
            case 'none'
                Y = rsa_classicalMDS(IPM,'mode','IPM');
        end
        
        sc1_imana('scatterplotMDS',Y(:,1:3),tasks,condNamesNoInstruct);
        title(plotTitle)
    case 'scatterplotMDS'               % PLOTTING: This step is needed for 'ROI_MDS_overall'
        Y= varargin{1};
        tasks = varargin{2};
        taskNames = varargin{3};
    case 'timeCourse_mean'              % PLOTTING: Plot raw timecourse (mean removed) per run
        sn=varargin{1};
        type=varargin{2}; %'mean' or 'raw'
        
        A=[];
        for s=sn,
            MNIMeanSubjDir = [baseDir,'/imaging_data_MNI_noMean/',subj_name{s}];
            
            load(fullfile(MNIMeanSubjDir, 'timecourse.mat'));
            
            A = addstruct(A,T);
        end
        
        switch type
            case 'mean'
                figure(s);
                for r=1:16,
                    subplot(8,2,r)
                    Aa=getrow(A,A.runN==r);
                    if length(sn)>1,
                        plot(mean(Aa.meanRemoved));
                    else
                        plot(Aa.meanRemoved);
                    end
                    hold on
                    xlabel(sprintf('run %d',r));
                    ylabel('y (meanRemoved)')
                    subtitle('all subjects');
                end
            case 'raw'
                figure(s);
                for r=1:16,
                    subplot(8,2,r)
                    Aa=getrow(A,A.runN==r);
                    if length(sn)>1,
                        plot(mean(Aa.orig));
                    else
                        plot(Aa.orig);
                    end
                    hold on
                    xlabel(sprintf('run %d',r));
                    ylabel('y (raw)')
                    subtitle(subj_name{s});
                end
        end
    case 'encoding_one'                 % PLOTTING: Plot encoding model fits per subject and per model
        sn=varargin{1}; % subj num(s)
        type=varargin{2}; % type of model 'desikan','cortical_lobes','ica','yeo'
        method=varargin{3}; % 'linRegress','nonNegExp','nonNegExp_L1','nonNegExp_L2','cplexqp','cplexqp_L2'
        data=varargin{4}; % 'grey_white','grey'
        encodeType=varargin{5};
        
        subjs=length(sn);
        R=[];
        N=[];
        
        for s=1:subjs,
            encodeSubjDir = fullfile(encodeDir,'glm4',sprintf('encode_%d',encodeType),subj_name{sn(s)});
            for t=1:numel(type),
                for m=1:numel(method),
                    for d=1:numel(data),
                        load(fullfile(encodeSubjDir,sprintf('encode_%s_%s_%s.mat',type{t},method{m},data{d})));
                        % cleaner way to extract this information
                        N.cR=Yp.cRm;
                        N.relMaxReg=Yp.relMaxRegm;
                        N.numReg=Yp.numRegm;
                        N.lambda=Yp.lambda;
                        N.fR=Yp.fRm;
                        N.SN=repmat(sn(s),size(N.cR,1),1);
                        N.method=repmat(method(m),size(N.cR,1),1);
                        N.type=repmat(type(t),size(N.cR,1),1);
                        %                         N.catName=Yp.catName;
                        R=addstruct(R,N);
                    end
                end
            end
        end
        
        % plot everything really (for one parcellation only)
        if numel(type)==1,
            %             figure
            %             whitebg('black')
            %             subplot(4,1,4);
            %             lineplot(R.lambda,R.fR,'split',[R.method,R.type],'leg','auto','linecolor',[1 1 1],'markercolor',[1 1 1]);
            %             xlabel('regularisation prior')
            %             ylabel('R value (fit)')
            %             subplot(4,1,3);
            %             lineplot(R.lambda,R.cR,'split',[R.method,R.type],'leg','auto','linecolor',[1 1 1],'markercolor',[1 1 1]);
            %             xlabel('regularisation prior')
            %             ylabel('R value (crossval)')
            %             subplot(4,1,2);
            %             lineplot(R.lambda,R.relMaxReg,'split',[R.method,R.type],'leg','auto','linecolor',[1 1 1],'markercolor',[1 1 1]);
            %             xlabel('regularisation prior')
            %             ylabel('relative max of total networks')
            %             subplot(4,1,1)
            %             lineplot(R.lambda,R.numReg,'split',[R.method,R.type],'leg','auto','linecolor',[1 1 1],'markercolor',[1 1 1]);
            %             xlabel('regularisation prior')
            %             ylabel('number of "winning" networks')
            
            % plot relMaxReg against crossval R-value (for one parcellation only)
            figure
            whitebg('black')
            xyplot(R.relMaxReg,R.cR,[R.lambda],'split',[R.method],'style_thickline','leg','auto','markersize',10);
            set(gca,'XTick',[0:0.2:1])
            set(gca,'YTick',[.1:.1:.5])
            ylabel('crossvalidated R')
            xlabel('relative max of total "winning combination"')
        end
    case 'encoding_all'                 % PLOTTING: Plot relMax/crossval for all parcellations together
        sn=varargin{1}; % subj num(s)
        type=varargin{2}; % type of model 'desikan','cortical_lobes','ica','yeo'
        method=varargin{3}; % 'linRegress','nonNegExp','nonNegExp_L1','nonNegExp_L2','cplexqp','cplexqp_L2'
        encodeType=varargin{4};
        
        subjs=length(sn);
        N=[];
        D=[];
        for t=1:numel(type),
            for s=1:subjs,
                T=[];
                R=[];
                encodeSubjDir = fullfile(encodeDir,'glm4',sprintf('encode_%d',encodeType),subj_name{sn(s)});
                for m=1:numel(method),
                    load(fullfile(encodeSubjDir,sprintf('encode_%s_%s_grey.mat',type{t},method{m}))); % always read in grey-matter voxels (not grey_white or grey_nan)
                    % cleaner way to extract this information
                    N.cR=Yp.cRm;
                    N.relMaxReg=Yp.relMaxRegm;
                    N.numReg=Yp.numRegm;
                    N.lambda=Yp.lambda;
                    N.fR=Yp.fRm;
                    N.SN=repmat(sn(s),size(N.cR,1),1);
                    N.method=repmat(method(m),size(N.cR,1),1);
                    N.type=repmat(type(t),size(N.cR,1),1);
                    R=addstruct(R,N);
                end
                I=find(R.cR==max(R.cR));
                T.cR=mean(R.cR(I)); % best crossval per subject, per parcellation
                T.relMaxReg=mean(R.relMaxReg(I)); % best relMaxReg per subject, per parcellation
                T.type=type(t);
                T.SN=sn(s);
                D=addstruct(D,T);
            end
        end
        %  plot winning model for each parcellation (relMaxReg against crossval R-value)
        % whitebg('black')
        figure
        xyplot(D.relMaxReg,D.cR,[D.type],'split',[D.type],'style_thickline','leg','auto','markersize',40);
        set(gca,'XTick',[0.1:0.1:2])
        set(gca,'YTick',[.3:.05:.5])
        ylabel('crossvalidated R')
        xlabel('relative max of total "winning combination"')
    case 'check_multicollinearity'      % PLOTTING: Check measures of multicollinearity for beta-weighted components
        sn=varargin{1};
        glm=varargin{2};
        type=varargin{3};
        
        subjs=length(sn);
        A=[];
        
        glmSubjDir =[baseDir sprintf('/GLM_firstlevel_%d/',glm) subj_name{sn(1)}];
        D=load(fullfile(glmSubjDir,'SPM_info.mat'));
        
        for s=1:subjs,
            encodeSubjDir=fullfile(encodeDir,subj_name{sn(s)}); dircheck(encodeSubjDir);
            
            % load betas
            load(fullfile(encodeSubjDir,sprintf('%s_glm%d_model.mat',type,glm)));
            Xx.X=X;
            Xx.X(465:480,:)=0;
            A=addstruct(A,Xx);
        end
        
        figure
        imagesc(corrcov(A.X'*A.X))
        title(sprintf('correlational matrix for %s',type))
        colorbar
    case 'plot_interSubjVar_firstlevel' % PLOTTING: Check inter-subject (and within-subject) variability
        sn=varargin{1};
        type=varargin{2};
        encodeType=varargin{3};
        
        load(fullfile(encodeDir,'glm4',sprintf('encode_%d',encodeType),sprintf('interSubjVar_firstLevel_%s.mat',type)));
        
        subjs=length(sn);
        within=(min(sn):2:subjs*2);
        between=1:subjs*2;
        W=[];
        B=[];
        
        switch type,
            case 'average'
                % plot within-subject variability (per subject)
                figure;
                subplot(3,1,1)
                for s=1:subjs,
                    w.values=I{1}.R(within(s)-1,within(s));
                    w.name=I{1}.SN(within(s)-1,within(s));
                    w.SN=sn(s);
                    W=addstruct(W,w);
                end
                barplot(W.SN,W.values)
                xlabel('subjects')
                ylabel('correlation')
                title('within-subject correlation')
                
                % plot within-subject variability (averaged)
                subplot(3,1,2)
                barplot(1,mean(W.values));
                xlabel('averaged')
                ylabel('correlation')
                title('within-subject correlation')
                
                % plot between-subject variability (averaged)
                subplot(3,1,3)
                
                for ss=1:2:subjs*2,
                    for s=1:subjs*2,
                        b(s)=mean(I{1}.R(s,between~=ss & between~=ss+1));
                    end
                end
                
                barplot(1,mean(unique(b)))
                xlabel('mean inter-subject variability')
                ylabel('correlation')
                title('between-subject correlation')
            case 'tasks'
                condNames={'1.instructions','2.GoNoGo-Neg','3.GoNoGo-Pos','4.ToM','5.actObs-act','6.actObs-con',...
                    '7.aff-unpleas','8.aff-pleas','9.arith-equat','10.arith-con',...
                    '11.checkerboard','12.emotion-sad','13.emotion-happy','14.intervalTiming',...
                    '15.motorImag','16.motorSeq-con','17.motorSeq-seq','18.nBack-noResp',...
                    '19.nBack-resp','20.nBackPic-noResp','21.nBack-resp','22.spatialNavigation',...
                    '23.stroop-incong','24.stroop-cong','25.verbGen-gen','26.verbGen-read',...
                    '27.visSearch-small','28.visSearch-med','29.visSearch-large'};
                figure;
                for c=1:length(I), % loop over task conditions
                    for s=1:subjs,
                        w(s)=I{c}.R(within(s)-1,within(s));
                        n(s)=I{c}.SN(within(s)-1,within(s));
                    end
                    W(c)=mean(w);
                    
                    for ss=1:2:32,
                        for s=1:32,
                            b(s)=mean(I{c}.R(s,between~=ss & between~=ss+1));
                        end
                    end
                    B(c)=mean(b);
                    cond(c)=c;
                end
                
                % plot within-subject variability (averaged across
                % subjects and per task)
                subplot(2,1,1)
                barplot(cond',W','split',cond','leg',condNames);
                xlabel('task conditions')
                ylabel('correlation')
                title('within-subject correlation')
                
                subplot(2,1,2)
                barplot(cond',B');
                xlabel('task conditions')
                ylabel('correlation')
                title('between-subject correlation')
        end
    case 'plot_interSubjVar_encode'     % PLOTTING: Check inter-subject variability from encoding model
        type=varargin{1}; % '162_tessellation_hem'
        encodeType=varargin{2};
        
        load(fullfile(encodeDir,'glm4',sprintf('encode_%d',encodeType),sprintf('interSubjVar_%s.mat',type)));
        suit_plotflatmap(I,'type','func','cscale',[min(I),max(I)]);
        colorbar
        
    otherwise
        disp('there is no such case.')
end;


% Local functions
function dircheck(dir)
if ~exist(dir,'dir');
    warning('%s doesn''t exist. Creating one now. You''re welcome! \n',dir);
    mkdir(dir);
end

% InterSubj Corr
function C=intersubj_corr(Y)
numSubj=size(Y,3);
for i=1:numSubj
    for j=1:numSubj
        C(i,j)=nansum(nansum(Y(:,:,i).*Y(:,:,j)))/...
            sqrt(nansum(nansum(Y(:,:,i).*Y(:,:,i)))*...
            nansum(nansum(Y(:,:,j).*Y(:,:,j))));
    end;
end

% Within/Between Subj/Sess Corr
function [DiffSubjSameSess,SameSubjDiffSess,DiffSubjDiffSess]=bwse_corr(C)
N=size(C,1);
n=N/2;
sess = [ones(1,n) ones(1,n)*2];
subj = [1:n 1:n];
SameSess = bsxfun(@eq,sess',sess);
SameSubj = bsxfun(@eq,subj',subj);
DiffSubjSameSess=nanmean(C(~SameSubj & SameSess));
SameSubjDiffSess=nanmean(C(SameSubj & ~SameSess));
DiffSubjDiffSess=nanmean(C(~SameSubj & ~SameSess));