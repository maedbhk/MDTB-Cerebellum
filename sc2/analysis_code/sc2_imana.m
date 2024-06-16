function varargout=sc2_imana(what,varargin)
% super_cerebellum project - study 2 (3T scanner at Robarts, UWO, 03/2017 to ?)
% same subjects from sc1 so we are not running freesurfer or anatomical
% segmentation (including suit) in this script. We import new anatomical
% just to check that anatomy has not changed from sc1!
% anatomical files are called from sc1

% UPDATE INFO IN SECTION 2 WITH EVERY NEW SUBJECT
%
numDummys = 3;                                                              % per run
numTRs    = 601;                                                            % per run (includes dummies)

%========================================================================================================================
% % (1) Directories
baseDir         = '/Users/mking/Documents/Cerebellum_Cognition/sc2';
baseDirSc1      = '/Users/mking/Documents/Cerebellum_Cognition/sc1'; % sc1 dataset
% baseDir         = '/Volumes/MotorControl/data/super_cerebellum/';
behavDir        =[baseDir '/data'];
imagingDir      =[baseDir '/imaging_data'];
imagingDirNA    =[baseDir '/imaging_data_nonaggr'];
imagingDirA     =[baseDir '/imaging_data_aggr'];
imagingDirRaw   =[baseDir '/imaging_data_raw'];
dicomDir        =[baseDir '/imaging_data_dicom'];
anatomicalDir   =[baseDir '/anatomicals'];
suitDir         =[baseDir '/suit'];
caretDir        =[baseDir '/surfaceCaret'];
regDir          =[baseDir '/RegionOfInterest/'];
eyeDirRaw       =[baseDir '/eyeTracking_raw'];
eyeDir          =[baseDir '/eyeTracking'];
physioDir       =[baseDir '/physio'];
encodeDir       =[baseDir '/encoding'];

%========================================================================================================================
% % (2) PRE-PROCESSING: Subject AND Session specific info. EDIT W/ EVERY NEW SUBJECT AND W/ EVERY NEW
% SESSION

subj_name = {'s','s02','s03','s04','s','s06','s07','s08','s09','s10','s','s12','s','s14','s15','s','s17','s18','s19','s20','s21','s22'};

returnSubjs=[2,3,4,6,7,8,9,10,12,14,15,17,18,19,20,21,22];

DicomName = {'',...% s01
    '',...         % s01
    '2017_05_25_IO11.MR.DIEDRICHSEN_MCC',...%s02
    '2017_05_26_IO11.MR.DIEDRICHSEN_MCC',...%s02
    '2017_03_27_UH11.MR.DIEDRICHSEN_MCC',...%s03
    '2017_03_28_UH11.MR.DIEDRICHSEN_MCC',...%s03
    '2017_06_12_CC23.MR.DIEDRICHSEN_MCC',...%s04
    '2017_06_13_CC23.MR.DIEDRICHSEN_MCC',...%s04
    '',...%s05
    '',...%s05
    '2017_04_12_MO28.MR.DIEDRICHSEN_MCC',...%s06
    '2017_04_20_MO28.MR.DIEDRICHSEN_MCC',...%s06
    '2017_05_16_HI15.MR.DIEDRICHSEN_MCC',...%s07
    '2017_05_17_HI15.MR.DIEDRICHSEN_MCC',...%s07
    '2017_04_24_NL20.MR.DIEDRICHSEN_MCC',...%s08
    '2017_05_01_NL20.MR.DIEDRICHSEN_MCC',...%s08
    '2017_04_19_OH14.MR.DIEDRICHSEN_MCC',...%s09
    '2017_04_20_OH14.MR.DIEDRICHSEN_MCC',...%s09
    '2017_04_27_RV14.MR.DIEDRICHSEN_MCC',...%s10
    '2017_04_28_RV14.MR.DIEDRICHSEN_MCC',...%s10
    '',...%s11
    '',...%s11
    '2017_04_24_RM20.MR.DIEDRICHSEN_MCC',...%s12
    '2017_04_25_RM20.MR.DIEDRICHSEN_MCC',...%s12
    '',...%s13
    '',...%s13
    '2017_06_12_SR12.MR.DIEDRICHSEN_MCC',...%s14
    '2017_06_15_SR12.MR.DIEDRICHSEN_MCC',...%s14
    '2017_06_14_RT25.MR.DIEDRICHSEN_MCC',...%s15
    '2017_06_15_RT25.MR.DIEDRICHSEN_MCC',...%s15
    '',...%s16
    '',...%s16
    '2017_03_24_AR14.MR.DIEDRICHSEN_MCC',...%s17
    '2017_03_28_AR14.MR.DIEDRICHSEN_MCC',...%s17
    '2017_05_09_AO21.MR.DIEDRICHSEN_MCC',...%s18
    '2017_05_10_AO21.MR.DIEDRICHSEN_MCC',...%s18
    '2017_05_25_HA31.MR.DIEDRICHSEN_MCC',...%s19
    '2017_05_26_HA31.MR.DIEDRICHSEN_MCC',...%s19
    '2017_04_12_ML24.MR.DIEDRICHSEN_MCC',...%s20
    '2017_04_23_ML24.MR.DIEDRICHSEN_MCC',...%s20
    '2017_04_25_AZ18.MR.DIEDRICHSEN_MCC',...%s21
    '2017_04_28_AZ18.MR.DIEDRICHSEN_MCC',...%s21
    '2017_04_26_VE14.MR.DIEDRICHSEN_MCC',...%s22
    '2017_04_28_VE14.MR.DIEDRICHSEN_MCC',...%s22
    };

NiiRawName =  {'',...%s01
    '',...%s01
    '170525100719DST131221107524367007',...%s02
    '170525100719DST131221107524367007',...%s02
    '170327151145DST131221107524367007',...%s03
    '170328124001DST131221107524367007',...%s03
    '170612140815DST131221107524367007',...%s04
    '170612140815DST131221107524367007',...%s04
    '',...%s05
    '',...%s05
    '170412101047DST131221107524367007',...%s06
    '170420150758DST131221107524367007',...%s06
    '2017_05_16_HI15',...%s07
    '2017_05_16_HI15',...%s07
    '170424100628DST131221107524367007',...%s08
    '170501083431DST131221107524367007',...%s08
    '170419115131DST131221107524367007',...%s09
    '170420120648DST131221107524367007',...%s09
    '170427131043DST131221107524367007',...%s10
    '170427131043DST131221107524367007',...%s10
    '',...%s11
    '',...%s11
    '170424140431DST131221107524367007',...%s12
    '170424140431DST131221107524367007',...%s12
    '',...%s13
    '',...%s13
    '170612120235DST131221107524367007',...%s14
    '170615145716DST131221107524367007',...%s14
    '170614140812DST131221107524367007',...%s15
    '170614140812DST131221107524367007',...%s15
    '',...%s16
    '',...%s16
    '170324151234DST131221107524367007',...%s17
    '170328100924DST131221107524367007',...%s17
    '170509140556DST131221107524367007',...%s18
    '170509140556DST131221107524367007',...%s18
    '170525151250DST131221107524367007',...%s19
    '170525151250DST131221107524367007',...%s19
    '170412121416DST131221107524367007',...%s20
    '170417125335DST131221107524367007',...%s20
    '170425155510DST131221107524367007',...%s21
    '170425155510DST131221107524367007',...%s21
    '170427102053DST131221107524367007',...%s22
    '170427102053DST131221107524367007',...%s22
    };

fscanNum   = {[],...%s01 functional scans (series number)
    [],...%s01
    [3,5,7,9,11,13,15,17],...%s02
    [2,4,6,8,10,12,14,16],...%s02
    [3,5,7,9,11,13,15,17],...% s03_1
    [2,4,6,8,10,12,14,16],...% s03_2
    [3,5,7,9,11,13,15,17],...%s04
    [2,4,6,8,10,12,14,16],...%s04
    [],...%s05
    [],...%s05
    [4,6,8,10,12,14,16,18],...%s06_1
    [2,4,6,8,10,12,14,16],...%s06_2
    [4,6,8,10,12,14,16,18],...% s07_1
    [2,4,6,8,10,12,14,16],...% s07_2
    [3,5,7,9,11,13,15,17],...% s08_1
    [2,4,6,8,10,12,14,16],...% s08_2
    [3,5,7,9,11,13,15,17],...% s09_1
    [2,4,6,8,10,12,14,16],...% s09_2
    [3,5,7,9,11,13,15,17],...% s10_1
    [3,5,7,9,11,13,15,17],...% s10_2
    [],...%s11
    [],...%s11
    [3,5,7,9,11,13,15,17],...% s12_1
    [2,4,6,8,10,12,14,16],...% s12_2
    [],...%s13
    [],...%s13
    [3,5,7,9,11,13,15,17],...%s14
    [2,4,6,8,10,12,14,16],...%s14
    [3,5,7,9,11,13,15,17],...%s15
    [2,4,6,8,10,12,14,16],...%s15
    [],...%s16
    [],...%s16
    [3,5,7,9,11,13,15,17],...% s17_1
    [2,4,6,8,10,12,14,16],...% s17_2
    [3,5,7,9,11,13,15,17],...% s18_1
    [2,4,6,8,10,12,14,16],...% s18_2
    [3,5,7,9,11,13,15,17],...% s19_1
    [2,4,6,8,10,12,14,16],...% s19_2
    [3,5,7,9,11,13,15,17],...% s20_1
    [2,4,6,8,10,12,14,16],...% s20_2
    [3,5,7,9,11,13,15,17],...% s21_1
    [2,4,6,8,10,12,14,16],...% s21_2
    [3,5,7,9,11,13,15,17],...% s22_1
    [2,4,6,8,10,12,14,16],...% s22_2
    };


anatNum =    {[],...% s01 % anatomical scans (series number)
    [2],... % s02
    [2],... % s03
    [2],...  % s04
    [],...  % s05
    [3],... % s06
    [2],... % s07
    [2],... % s08
    [2],... % s09
    [2],... % s10
    [],...  % s11
    [2],... % s12
    [],...  % s13
    [2],...  % s14
    [2],...  % s15
    [],...  % s16
    [2],... % s17
    [2],... % s18
    [2],...  % s19
    [2],... % s20
    [2],... % s21
    [2],... % s22
    };

physioNum = {[],...%s01
    [],...%s01
    [4,6,8,10,12,14,16,18],...% s02
    [3,5,7,9,11,13,15,17],... % s02
    [4,6,8,10,12,14,16,18],...% s03_1
    [3,5,7,9,11,13,15,17],... % s03_2
    [4,6,8,10,12,14,16,18],...%s04
    [3,5,7,9,11,13,15,17],...%s04
    [],...%s05
    [],...%s05
    [5,7,9,11,13,15,17,19],...% s06_1
    [3,5,7,9,11,13,15,17],...% s06_2
    [4,6,8,10,12,14,16,18],...% s07_1
    [3,5,7,9,11,13,15,17],...% s07_2
    [4,6,8,10,12,14,16,18],...% s08_1
    [3,5,7,9,11,13,15,17],...% s08_2
    [4,6,8,10,12,14,16,18],...% s09_1
    [3,5,7,9,11,13,15,17],...% s09_2
    [4,6,8,10,12,14,16,18],...% s10_1
    [4,6,8,10,12,14,16,18],...% s10_2
    [],...%s11
    [],...%s11
    [4,6,8,10,12,14,16,18],...% s12_1
    [3,5,7,9,11,13,15,17],...% s12_2
    [],...%s13
    [],...%s13
    [4,6,8,10,12,14,16,18],...%s14
    [3,5,7,9,11,13,15,17],...%s14
    [4,6,8,10,12,14,16,18],...%s15
    [3,5,7,9,11,13,15,17],...%s15
    [],...%s16
    [],...%s16
    [4,6,8,10,12,14,16,18],...% s17_1
    [3,5,7,9,11,13,15,17],...% s17_2
    [4,6,8,10,12,14,16,18],...% s18_1
    [3,5,7,9,11,13,15,17],...% s18_2
    [4,6,8,10,12,14,16,18],...%s19
    [3,5,7,9,11,13,15,17],...%s19
    [4,6,8,10,12,14,16,18],...% s20_1
    [3,5,7,9,11,13,15,17],...% s20_2
    [4,6,8,10,12,14,16,18],...% s21_1
    [3,5,7,9,11,13,15,17],...% s21_2
    [4,6,8,10,12,14,16,18],...% s22_1
    [3,5,7,9,11,13,15,17],...% s22_2
    };

saccRun =   {[],... % s01 % runs to be included for saccade analysis
    [],...% s02 [1,2]
    [],... % s03
    [],... % s04
    [],... % s05
    [1,2],... % s06
    [1,2],... % s07
    [],... % s08
    [2],... % s09
    [1,2],... % s10
    [],... % s11
    [],... % s12
    [],... % s13
    [1,2],... % s14
    [],... % s15
    [],... % s16
    [],... % s17
    [1,2],... % s18
    [1,2],... % s19
    [1,2],... % s20
    [1,2],... % s21
    [1,2],... % s22
    };

T2Num = {[20],...% s01      % T2 scans (series number)
    [20],...% s02
    [20],...% s03
    [20],...% s04
    [20],... % s05
    [21],... % s06
    [20],... % s07
    [19],... % s08
    [20],... % s09
    [20],... % s10
    [20],... % s11
    [21],... % s12
    [20],... % s13
    [20],... % s14
    [20],... % s15
    [20],... % s16
    [20],... % s17
    [20],... % s18
    [20],... % s19
    [20],... % s20
    [20],... % s21
    [20],... % s22
    };

%========================================================================================================================
% % (3) GLM.

% GLM Directories-change glmNum when appropriate
glm_type = {'complex-fast'};

funcRunNum = [51,66];  % first and last behavioural run numbers (16 runs per subject)

run        = {'01','02','03','04','05','06','07','08','09','10','11','12','13','14','15','16'};

runB       =  [51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66];  % Behavioural labelling of scanning runs

sess       = [1,1,1,1,1,1,1,1,2,2,2,2,2,2,2,2]; % session number

taskNames  = {'CPRO','prediction','verbGeneration2','spatialNavigation2',...
    'spatialMap','natureMovie','romanceMovie','landscapeMovie','motorSequence2',...
    'mentalRotation', 'nBackPic2','emotionProcess','respAlt','visualSearch2','ToM2',...
    'actionObservation2','rest2'};

condNames  = {'1.instruct','2.CPRO', '3.pred-true','4.pred-viol','5.pred-scram',...
    '6.verbGen2-gen', '7.verbGen2-read','8.spatialNav2','9.spatMap-easy',...
    '10.spatMap-med', '11.spatMap-diff','12.natureMov','13.romanceMov','14.landscapeMov',...
    '15.motorSeq2-con', '16.motorSeq2-seq','17.menRot-easy','18.menRot-med',...
    '19.menRot-diff','20.nBackPic2-resp','21.nBackPic2-noResp','22.emotProc-intact',...
    '23.emotProc-scram','24.respAlt-easy', '25.respAlt-med', '26.respAlt-diff','27.visSearch2-small',...
    '28.visSearch2-med','29.visSearch2-large','30.ToM2','31.actObs2-act', '32.actObs2-con','33.rest2'};

condNamesNoInstruct = {'1.Rules','2.True Prediction','3.Violated Prediction','4.Scrambled Sentence',...
    '5.Verb Generation', '6.Reading','7.Spatial Navigation','8.Spatial Map Easy','9.Spatial Map Medium',...
    '10.Spatial Map Difficult', '11.Nature Movie','12.Pixar Movie','13.Landscape Movie', '14.Finger Simple',...
    '15.Finger Sequence','16.Mental Rotation Easy','17.Mental Rotation Medium', '18.Mental Rotation Difficult',...
    '19.Object 2-Back','20.Object 0-Back', '21.Emotion Processing Intact','22.Emotion Processing Scrambled','23.Resp Alt Easy',...
    '24.Resp Alt Medium', '25.Resp Alt Difficult', '26.Visual Search Small', '27.Visual Search Medium', '28.Visual Search Large',...
    '29.Theory of Mind', '30.Video Actions', '31.Video Knots', '32.Rest'};

condNamesSc1Sc2 = {'1.NoGo','2.Go','3.Theory of Mind','4.Video Actions','5.Video Knots',...
    '6.Unpleasant Scenes','7.Pleasant Scenes','8.Math','9.Digit Judgment','10.Checkerboard',...
    '11.Sad Faces','12.Happy Faces','13.Interval Timing','14.Motor Imagery','15.Finger Simple',...
    '16.Finger Sequence','17.Verbal 0-Back','18.Verbal 2-Back','19.Object 0-Back','20.Object 2-Back',...
    '21.Spatial Navigation','22.Stroop Incongruent','23.Stroop Congruent','24.Verb Generation','25.Word Reading',...
    '26.Visual Search - small','27.Visual Search - medium','28.Visual Search - large','29.rest','30.Rules','31.True Prediction','32.Violated Prediction',...
    '33.Scrambled Sentence','34.Verb Generation 2', '35.Reading 2','36.Spatial Navigation 2','37.Spatial Map Easy','38.Spatial Map Medium',...
    '39.Spatial Map Difficult', '40.Nature Movie','41.Pixar Movie','42.Landscape Movie', '43.Finger Simple 2',...
    '44.Finger Sequence 2','45.Mental Rotation Easy','46.Mental Rotation Medium', '47.Mental Rotation Difficult',...
    '48.Object 2-Back 2','49.Object 0-Back 2', '50.Emotion Processing Intact','51.Emotion Processing Scrambled','52.Resp Alt Easy',...
    '53.Resp Alt Medium', '54.Resp Alt Difficult', '55.Visual Search Small 2', '56.Visual Search Medium 2', '57.Visual Search Large 2',...
    '58.Theory of Mind 2', '59.Video Actions 2', '60.Video Knots 2', '61.Rest 2'};

contrasts{1} = {'CPRO','rest'};             % CPRO (new)
contrasts{2} = {'true','viol','scram'};     % prediction (new)
contrasts{3} = {'gen','read'};              % verbGeneration2
contrasts{4} = {'spatialNav2','rest'};      % spatialNavigation2
contrasts{5} = {'easy','med','diff'};       % spatialMap (new)
contrasts{6} = {'natureMov','rest'};        % natureMovie (new)
contrasts{7} = {'romanceMov','rest'};       % romanceMovie (new)
contrasts{8} = {'landscapeMov','rest'};     % landscapeMovie (new)
contrasts{9} = {'con','seq'};               % motorSequence2
contrasts{10}= {'easy','med','diff'};       % mentalRotation (new)
contrasts{11}= {'no-response','response'};  % nBackPic2
contrasts{12}= {'intact','scram'};          % emotionProcess (new)
contrasts{13}= {'easy','med','diff'};       % respAlt (new)
contrasts{14}= {'small','medium','large'};  % visualSearch2
contrasts{15}= {'ToM2','rest'};             % ToM2
contrasts{16}= {'act','con'};               % actionObservation2
contrasts{17}= {'rest2'};                   % rest2

numRegress ={[1;3;2;1;3;1;1;1;2;3;2;2;3;3;1;2],... % glm4
    };

taskNumbers = [1;2;3;4;5;6;7;8;9;10;11;12;13;14;15;16;17];

PW = {'betasNW','betasUW'}; % methods of noise normalisation (none and univariate noise normalisation)

% RightHand = {'nBackPic2','emotionProcess','mentalRotation'};
% LeftHand = {'visualSearch2','prediction','ToM2'};
% BothHands = {'CPRO','motorSequence2','respAlt','spatialMap'};
%
% ========================================================================================================================
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

desikanNames = {'bankssts','caudalACC','caudalmiddlefrontal','corpuscallosum','cuneus','entorhinal','fusiform',...
    'infparietal','inftemporal','isthmuscingulate','lateraloccipital','lateralorbitofrontal','lingual','medialorbitofrontal',...
    'middletemporal','parahippocampal','paracentral','parsopercularis','parsorbitalis','parstriangularis','pericalcarine',...
    'postcentral','posteriorcingulate','precentral','precuneus','rostralACC','rostralmiddlefrontal','superiorfrontal','superiorparietal',...
    'superiortemporal','supramarginal','frontalpole','temporalpole','transversetemporal','insula'};

% cerebellarNames = {'I_IV','V','VI','CrusI','CrusII','VIIb','VIIIa','VIIIb','IX','X'};

%========================================================================================================================

switch(what)
    
    case 'temp'
        sn=varargin{1};
        type=varargin{2}; % 'aggr' or 'nonaggr'
        
        subjs=length(sn);
        for s=1:subjs,
            for r=1:16,
                sourceDir=fullfile('/Volumes/MotorControl/data/super_cerebellum/','Aroma/sc2',subj_name{sn(s)},sprintf('A_%2.2d',r));
                destDir=fullfile(baseDir,sprintf('imaging_data_%s',type),subj_name{sn(s)});
                dircheck(destDir);
                
                % imagingFiles
                imagingFiles=fullfile(sourceDir,sprintf('denoised_func_data_%s.nii.gz',type));
                
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
            fprintf('subj%d done for %s data \n',sn(s),type)
        end
        
    case 'process_session1'
        sn=varargin{1};
        
        for s=sn,
            sc2_imana('import_from_dropbox',s,'behavioural')
            if ~isempty(saccRun{s}),
                sc2_imana('import_from_dropbox',s,'eyeTracking')
                sc2_imana('process_eyeTracking',s,'events_samples')
                sc2_imana('process_eyeTracking',s,'regressors_glm4')
            end
            sc2_imana('func_dicom_import',s,1)
            sc2_imana('anat_dicom_import',s,1)
            sc2_imana('physio_dicom_import',s,1)
            sc2_imana('T2_dicom_import',s,1)
        end
    case 'func_dicom_import'            % STEP 1.2: enter subjNum and sessNum
        % converts dicom to nifti files w/ spm_dicom_convert
        % example: sc2_imana('func_dicom_import',1,1)
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
    case 'anat_dicom_import'            % STEP 1.3: enter subjNum and sessNum
        % converts dicom to nifti files w/ spm_dicom_convert
        % example: sc2_imana('func_dicom_import',1,1)
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
        % copy and rename file from dicom to anatomical folder
        fileName=dir(fullfile(dicomDir,[subj_name{s},sprintf('_%d',sessN)],dirname{r}));
        source=fullfile(fullfile(dicomDir,[subj_name{s},sprintf('_%d',sessN)],dirname{r},fileName(3).name));
        dircheck(fullfile(anatomicalDir,subj_name{s}));
        dest=fullfile(anatomicalDir,subj_name{s},'anatomical_raw.nii');
        copyfile(source,dest);
    case 'physio_dicom_import'          % STEP 1.4: enter subjNum and sessN
        sn=varargin{1};
        sessN=varargin{2};
        
        dircheck(fullfile(dicomDir,[subj_name{sn},sprintf('_%d',sessN)]));
        cd(fullfile(dicomDir,[subj_name{sn},sprintf('_%d',sessN)]));
        if sessN==1,
            ss=(sn*2)-1;
        else
            ss=(sn*2);
        end
        for i=1:length(physioNum{ss})
            r=physioNum{ss}(i);
            DIR=dir(sprintf('%s.%4.4d.*.IMA',DicomName{ss},r));              % Get DICOM FILE NAMES
            Names=vertcat(DIR.name);
            if (~isempty(Names))
                HDR=spm_dicom_headers(Names,1);                             % Load dicom headers
                dirname{r}=sprintf('series%2.2d',r);
                if (~exist(dirname{r}))
                    mkdir(dirname{r});                                      % make dir for series{r} for .nii file output
                end;
                dircheck(fullfile(dicomDir,[subj_name{sn},sprintf('_%d',sessN)],dirname{r}));
                extractCMRRPhysio(HDR{1}.Filename,fullfile(dicomDir,[subj_name{sn},sprintf('_%d',sessN)],dirname{r}));
                %                   physio=readCMRRPhysio(HDR{i}.Filename,1);
            end;
            display(sprintf('Series %d done \n',physioNum{ss}(i)))
        end;
    case 'T2_dicom_import'              % STEP 1.5: enter subjNum and sessNum
        % converts dicom to nifti files w/ spm_dicom_convert
        % example: sc2_imana('func_dicom_import',1,1)
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
        % copy and rename file from dicom to anatomical folder
        fileName=dir(fullfile(dicomDir,[subj_name{s},sprintf('_%d',sessN)],dirname{r}));
        source=fullfile(fullfile(dicomDir,[subj_name{s},sprintf('_%d',sessN)],dirname{r},fileName(3).name));
        dircheck(fullfile(anatomicalDir,subj_name{s}));
        dest=fullfile(anatomicalDir,subj_name{s},'T2.nii');
        copyfile(source,dest);
    case 'import_from_dropbox'          % STEP 2.5: enter subjNum and step (behavioural or eyeTracking)
        sn=varargin{1};
        step=varargin{2};
        
        switch step,
            case 'behavioural'
                root='/Users/mking/Dropbox (Diedrichsenlab)/Cerebellum_Cognition/data/sc2';
                source = fullfile(sprintf('%s/behavioural/%s',root,subj_name{sn}));
                dest = fullfile(behavDir,subj_name{sn}); dircheck(fullfile(behavDir,subj_name{sn}));
                copyfile(source,dest);
            case 'eyeTracking'
                root='/Users/mking/Dropbox (Diedrichsenlab)/Cerebellum_Cognition/data/sc2';
                source = fullfile(sprintf('%s/eyeTracking/%s',root,subj_name{sn}));
                dest = fullfile(eyeDirRaw,subj_name{sn}); dircheck(dest);
                copyfile(source,dest);
        end
    case 'process_eyeTracking'          % STEP 2.6: enter subjNum and step (events_samples or regressors_glm4)
        % converts all edf files and saves 'events','samples' &
        % 'regressors'
        sn=varargin{1};
        step=varargin{2}; % 'events_samples','regressors_glm4'
        
        taskNames_Eye={'vi','CP','sp','la','ve','nB','pr',...
            'lt','me','To','ro','re','na','em','mo','sp','ac'
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
                    A = dload(fullfile(baseDir, 'data', subj_name{sn(s)},['sc2_',subj_name{sn(s)},'.dat']));
                    A = getrow(A,A.runNum>=runs(1) & A.runNum<=runs(end));
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
                            D=dload(fullfile(baseDir, 'data', subj_name{sn(s)},['sc2_',subj_name{sn(s)},'_',taskNames{tt},'.dat']));
                            numRegress{1}(17)=1; % add rest
                            trialType=1:numRegress{1}(tt);
                            idx=find(strcmp(Tr.taskName,taskNames_Eye{tt}));
                            for regs=trialType,
                                taskDur=Tr.Ssacc(idx).time-I.endInstruct(tt);
                                S.numSacc=length(find(taskDur>0))/trialType(end); % count number of saccades (per task)
                                S.num=indx;
                                Rr=addstruct(Rr,S);
                                indx=indx+1;
                            end
                        end
                    end
                    % get average saccades per task across runs
                    for c=1:size(Rr.num,1)/2, % loop over task conditions
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
        
    case 'process_session2'
        sn=varargin{1};
        sc2_imana('func_dicom_import',sn,2)
        sc2_imana('physio_dicom_import',sn,2)
        sc2_imana('make_4dNifti',sn,1);
        sc2_imana('make_4dNifti',sn,2);
        sc2_imana('realign',sn,'both');
        sc2_imana('move_data',sn,'both');
        sc2_imana('import_from_dropbox',sn,'behavioural')
        %         sc2_imana('process_physio',sn)
        sc2_imana('coreg',sn,'yes')
    case 'make_4dNifti'                 % STEP 2.1: Make 4dNifti
        % merges nifti files for each image into a 4-d nifti (time is 4th
        % dimension) w/ spm_file_merge
        % example: sc2_imana('make_4dNifti',1,1)
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
    case 'realign'                      % STEP 2.2: Realign functional images (both sessions)
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
        % example: sc2_imana('realign',1,'both')
        
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
    case 'move_data'                    % STEP 2.3: Move realigned data
        % Moves image data from imaging_dicom_raw into a "working dir":
        % imaging_dicom.
        % example: sc2_imana('move_data',1,'both')
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
    case 'process_physio'               % STEP 2.4: Make physio regressors
        sn=varargin{1};
        
        % Read raw physio and make regressors for both sessions
        T=[];P=[];
        idx=1;
        for sessN=1:2, % number of sessions
            if sessN==1,
                ss=(sn*2)-1;
            else
                ss=(sn*2);
            end
            for r=1:length(physioNum{ss}),
                physioRawDir=[dicomDir,'/',sprintf('%s_%d',subj_name{sn},sessN),sprintf('/series%2.2d',physioNum{ss}(r))];
                fnameInfo(idx) = dir(fullfile(physioRawDir,'*info*'));
                idx=idx+1;
            end
        end
        fnameInfo = {fnameInfo(:).name};
        pS=physio_readPrisma(fnameInfo,numDummys);
        T=horzcat(T,pS);
        t=physio_getCardiacPrisma(pS); % fig,'1'
        P=horzcat(P,t);
        dircheck(fullfile(physioDir,subj_name{sn}));
        save(fullfile(physioDir,subj_name{sn},'physioReg.mat'),'P');
        save(fullfile(physioDir,subj_name{sn},'physioData.mat'),'T');
    case 'coreg'                        % STEP 4: REQUIRES USER INPUT: Adjust meanepi to anatomical image
        % (1) Manually seed the functional/anatomical registration
        % - Do "coregtool" on the matlab command window
        % - Select anatomical image and meanepi image to overlay
        % - Manually adjust meanepi image and save result as rmeanepi
        %   image
        % example: sc2_imana('coreg',1)
        s = varargin{1};% subjNum
        manual = varargin{2}; % 'yes' or 'no'
        
        cd(fullfile(baseDirSc1,'anatomicals',subj_name{s}));
        
        switch manual,
            case 'yes'
                coregtool;
                keyboard();
            case 'no'
                % do nothing
        end
        
        % (2) Automatically co-register functional and anatomical images
        J.ref = {fullfile(baseDirSc1,'anatomicals',subj_name{s},['anatomical.nii'])}; % call from sc1
        J.source = {fullfile(imagingDir,subj_name{s},['rmeanepi.nii'])};
        J.other = {''};
        J.eoptions.cost_fun = 'nmi';
        J.eoptions.sep = [4 2];
        J.eoptions.tol = [0.02 0.02 0.02 0.001 0.001 0.001 0.01 0.01 0.01 0.001 0.001 0.001];
        J.eoptions.fwhm = [7 7];
        matlabbatch{1}.spm.spatial.coreg.estimate=J;
        spm_jobman('run',matlabbatch);
        
        % (3) Manually check again
        %         coregtool;
        %         keyboard();
        
        % NOTE:
        % Overwrites meanepi, unless you update in step one, which saves it
        % as rmeanepi.
        % Each time you click "update" in coregtool, it saves current
        % alignment by appending the prefix 'r' to the current file
        % So if you continually update rmeanepi, you'll end up with a file
        % called r...rrrmeanepi.
        
    case 'run_postProcessing'           % STEP 5.1
        sn=varargin{1};
        types={'162_tessellation_hem','cerebellum_grey','cortex_grey','cortical_lobes','yeo',...
            'yeo_hem','desikan_hem','162_tessellation'};
        for s=sn,
            sc2_imana('coreg',s,'no') % run automatic coreg (manual coreg MUST be run before this step)
            sc2_imana('make_samealign',s,'both');
            sc2_imana('make_maskImage',s);
            sc2_imana('process_glm',s,4,'conditions_vs_rest')
            sc2_imana('process_suit',s,4)
            sc2_imana('process_ROI',s,4,types)
            sc2_imana('prepare_encoding_data',s,4,types(1:end-4)) % don't want dentate,cerebellum,cortex etc
            %             sc2_imana('process_surface',s,4,'cortex','con')
            %             sc2_imana('process_surface',s,4,'cereb','con')
        end
        %         sc2_imana('process_feature_models',sn)
        %                     display('Run spmj_checksamealign to check alignment of run_epi to rmean_epi')
    case 'make_samealign'               % STEP 5.1-5.2: Align functional images to rmeanepi
        % Aligns all functional images to rmeanepi
        % example: sc2_imana('make_samealign',1,'both')
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
    case 'make_maskImage'               % STEP 5.2: Make mask images (noskull and grey_only)
        % Make maskImage meanepi
        % example: sc2_imana('make_maskImage',1)
        s  = varargin{1}; % subjNum
        
        for s=s
            cd(fullfile(imagingDir,subj_name{s}));
            
            nam{1}  = fullfile(imagingDir,subj_name{s}, 'rmeanepi.nii');
            nam{2}  = fullfile(baseDirSc1,'anatomicals',subj_name{s}, 'c1anatomical.nii'); % move from sc1
            nam{3}  = fullfile(baseDirSc1,'anatomicals',subj_name{s}, 'c2anatomical.nii'); % move from sc1
            nam{4}  = fullfile(baseDirSc1,'anatomicals',subj_name{s}, 'c3anatomical.nii'); % move from sc1
            spm_imcalc(nam, 'rmask_noskull.nii', 'i1>1 & (i2+i3+i4)>0.2')
            
            nam={};
            nam{1}  = fullfile(imagingDir,subj_name{s}, 'rmeanepi.nii');
            nam{2}  = fullfile(baseDirSc1,'anatomicals',subj_name{s}, 'c1anatomical.nii'); % move from sc1
            spm_imcalc(nam, 'rmask_gray.nii', 'i1>2 & i2>0.4')
            
            nam={};
            nam{1}  = fullfile(imagingDir,subj_name{s}, 'rmeanepi.nii');
            nam{2}  = fullfile(baseDirSc1,'anatomicals',subj_name{s}, 'c1anatomical.nii'); % move from sc1
            nam{3}  = fullfile(baseDirSc1,'anatomicals',subj_name{s}, 'c5anatomical.nii'); % move from sc1
            spm_imcalc(nam, 'rmask_grayEyes.nii', 'i1>2400 & i2+i3>0.4')
            
            nam={};
            nam{1}  = fullfile(imagingDir,subj_name{s}, 'rmeanepi.nii');
            nam{2}  = fullfile(baseDirSc1,'anatomicals', subj_name{s}, 'c5anatomical.nii'); % move from sc1
            nam{3}  = fullfile(baseDirSc1,'anatomicals', subj_name{s}, 'c1anatomical.nii'); % move from sc1
            nam{4}  = fullfile(baseDirSc1,'anatomicals', subj_name{s}, 'c2anatomical.nii'); % move from sc1
            nam{5}  = fullfile(baseDirSc1,'anatomicals', subj_name{s}, 'c3anatomical.nii'); % move from sc1
            spm_imcalc(nam, 'rmask_noskullEyes.nii', 'i1>2000 & (i2+i3+i4+i5)>0.2')
        end
        
    case 'process_glm'                  % STEP 6.1-6.5: Makes and runs glms. ~ 70 min per glm
        % 'make_glm' - 'spm_rwls_run_fmri_spec' function - sets up GLM
        % 'estimate_glm' - 'spm_rwls_spm' function - estimates GLM
        sn=varargin{1};
        glm=varargin{2};
        type=varargin{3};
        
        for s=sn,
            for g=glm,
                %                 if g==4,
                %                     sc2_imana('make_glm4',s)
                %                 elseif g==13,
                %                     sc2_imana('make_glm13',s)
                %                 elseif g==5,
                %                     sc2_imana('make_glm5',s)
                %                 elseif g==6,
                %                     sc2_imana('make_glm6',s)
                %
                %                 end
                %                 sc2_imana('estimate_glm',s,g)
                sc2_imana('contrast',s,g,type)
            end
        end
    case 'make_glm4'                    % STEP 6.2: FAST glm w/out hpf (complex:rest as baseline) - model one instruct period
        % GLM with FAST and no high pass filtering
        % 'spm_get_defaults' code modified to allow for -v7.3 switch (to save
        % >2MB FAST GLM struct)
        % Be aware: this switch (from -v6 to -v7.3) slows down the code!
        sn=varargin{1};
        
        prefix='r';
        announceTime=5;
        glm=4;
        
        for s=sn,
            T=[];
            A = dload(fullfile(baseDir, 'data', subj_name{s},['sc2_',subj_name{s},'.dat']));
            A = getrow(A,A.runNum>=funcRunNum(1) & A.runNum<=funcRunNum(2));
            
            glmSubjDir =[baseDir sprintf('/GLM_firstlevel_%d/',glm),subj_name{s}];dircheck(glmSubjDir);
            
            J.dir = {glmSubjDir};
            J.timing.units = 'secs';
            J.timing.RT = 1.0;
            J.timing.fmri_t = 16;
            J.timing.fmri_t0 = 1;
            
            for r=1:numel(run) % loop through runs
                P=getrow(A,A.runNum==runB(r));
                for i=1:(numTRs-numDummys)
                    N{i} = [fullfile(baseDir, 'imaging_data',subj_name{s},[prefix 'run_',run{r},'.nii,',num2str(i)])];
                end;
                J.sess(r).scans= N; % number of scans in run
                
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
                    D=dload(fullfile(baseDir, 'data', subj_name{s},['sc2_',subj_name{s},'_',taskNames{task},'.dat']));
                    R=getrow(D,D.runNum==runB(r)); % functional runs
                    trialType=1:numRegress{1}(task);
                    for regs=trialType, % loop through trial-types (ex. easy, medium, difficult)
                        
                        cond=contrasts{task}{regs};
                        ST = find(strcmp(P.taskName,taskNames{task}));
                        condName = sprintf('%s-%s',char(R.taskName(1)),cond);
                        % loop through trial-types (ex. congruent or incongruent)
                        J.sess(r).cond(indx).name = condName;
                        J.sess(r).cond(indx).onset = [P.realStartTime(ST)+R.startTimeReal(R.condition==regs)+announceTime-(J.timing.RT*numDummys)]; % correct start time for numDummys and announcetime included
                        J.sess(r).cond(indx).duration = unique(R.trialDur);  % duration of trials we are modeling
                        J.sess(r).cond(indx).tmod = 0;
                        J.sess(r).cond(indx).orth = 0;
                        J.sess(r).cond(indx).pmod = struct('name', {}, 'param', {}, 'poly', {});
                        S.SN    = s;
                        S.run   = r;
                        S.task  = task;
                        S.cond  = indx;
                        S.TN    = {condName};
                        S.sess  = sess(r);
                        S.hand  = unique(R.hand);
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
    case 'make_glm5'                    % STEP 6.2: FAST glm w/out hpf (complex:rest as baseline) - model one instruct period - nonAggr
        % GLM with FAST and no high pass filtering
        % 'spm_get_defaults' code modified to allow for -v7.3 switch (to save
        % >2MB FAST GLM struct)
        % Be aware: this switch (from -v6 to -v7.3) slows down the code!
        sn=varargin{1};
        
        prefix='r';
        announceTime=5;
        glm=5;
        
        for s=sn,
            T=[];
            A = dload(fullfile(baseDir, 'data', subj_name{s},['sc2_',subj_name{s},'.dat']));
            A = getrow(A,A.runNum>=funcRunNum(1) & A.runNum<=funcRunNum(2));
            
            glmSubjDir =[baseDir sprintf('/GLM_firstlevel_%d/',glm),subj_name{s}];dircheck(glmSubjDir);
            
            J.dir = {glmSubjDir};
            J.timing.units = 'secs';
            J.timing.RT = 1.0;
            J.timing.fmri_t = 16;
            J.timing.fmri_t0 = 1;
            
            for r=1:numel(run) % loop through runs
                P=getrow(A,A.runNum==runB(r));
                for i=1:(numTRs-numDummys)
                    N{i} = [fullfile(baseDir, 'imaging_data_nonaggr',subj_name{s},[prefix 'run_',run{r},'.nii,',num2str(i)])];
                end;
                J.sess(r).scans= N; % number of scans in run
                
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
                    D=dload(fullfile(baseDir, 'data', subj_name{s},['sc2_',subj_name{s},'_',taskNames{task},'.dat']));
                    R=getrow(D,D.runNum==runB(r)); % functional runs
                    trialType=1:numRegress{1}(task);
                    for regs=trialType, % loop through trial-types (ex. easy, medium, difficult)
                        
                        cond=contrasts{task}{regs};
                        ST = find(strcmp(P.taskName,taskNames{task}));
                        condName = sprintf('%s-%s',char(R.taskName(1)),cond);
                        % loop through trial-types (ex. congruent or incongruent)
                        J.sess(r).cond(indx).name = condName;
                        J.sess(r).cond(indx).onset = [P.realStartTime(ST)+R.startTimeReal(R.condition==regs)+announceTime-(J.timing.RT*numDummys)]; % correct start time for numDummys and announcetime included
                        J.sess(r).cond(indx).duration = unique(R.trialDur);  % duration of trials we are modeling
                        J.sess(r).cond(indx).tmod = 0;
                        J.sess(r).cond(indx).orth = 0;
                        J.sess(r).cond(indx).pmod = struct('name', {}, 'param', {}, 'poly', {});
                        S.SN    = s;
                        S.run   = r;
                        S.task  = task;
                        S.cond  = indx;
                        S.TN    = {condName};
                        S.sess  = sess(r);
                        S.hand  = unique(R.hand);
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
    case 'make_glm6'                    % STEP 6.3: FAST glm w/out hpf (complex:rest as baseline) - model one instruct period - Aggr
        % GLM with FAST and no high pass filtering
        % 'spm_get_defaults' code modified to allow for -v7.3 switch (to save
        % >2MB FAST GLM struct)
        % Be aware: this switch (from -v6 to -v7.3) slows down the code!
        sn=varargin{1};
        
        prefix='r';
        announceTime=5;
        glm=6;
        
        for s=sn,
            T=[];
            A = dload(fullfile(baseDir, 'data', subj_name{s},['sc2_',subj_name{s},'.dat']));
            A = getrow(A,A.runNum>=funcRunNum(1) & A.runNum<=funcRunNum(2));
            
            glmSubjDir =[baseDir sprintf('/GLM_firstlevel_%d/',glm),subj_name{s}];dircheck(glmSubjDir);
            
            J.dir = {glmSubjDir};
            J.timing.units = 'secs';
            J.timing.RT = 1.0;
            J.timing.fmri_t = 16;
            J.timing.fmri_t0 = 1;
            
            for r=1:numel(run) % loop through runs
                P=getrow(A,A.runNum==runB(r));
                for i=1:(numTRs-numDummys)
                    N{i} = [fullfile(baseDir, 'imaging_data_aggr',subj_name{s},[prefix 'run_',run{r},'.nii,',num2str(i)])];
                end;
                J.sess(r).scans= N; % number of scans in run
                
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
                    D=dload(fullfile(baseDir, 'data', subj_name{s},['sc2_',subj_name{s},'_',taskNames{task},'.dat']));
                    R=getrow(D,D.runNum==runB(r)); % functional runs
                    trialType=1:numRegress{1}(task);
                    for regs=trialType, % loop through trial-types (ex. easy, medium, difficult)
                        
                        cond=contrasts{task}{regs};
                        ST = find(strcmp(P.taskName,taskNames{task}));
                        condName = sprintf('%s-%s',char(R.taskName(1)),cond);
                        % loop through trial-types (ex. congruent or incongruent)
                        J.sess(r).cond(indx).name = condName;
                        J.sess(r).cond(indx).onset = [P.realStartTime(ST)+R.startTimeReal(R.condition==regs)+announceTime-(J.timing.RT*numDummys)]; % correct start time for numDummys and announcetime included
                        J.sess(r).cond(indx).duration = unique(R.trialDur);  % duration of trials we are modeling
                        J.sess(r).cond(indx).tmod = 0;
                        J.sess(r).cond(indx).orth = 0;
                        J.sess(r).cond(indx).pmod = struct('name', {}, 'param', {}, 'poly', {});
                        S.SN    = s;
                        S.run   = r;
                        S.task  = task;
                        S.cond  = indx;
                        S.TN    = {condName};
                        S.sess  = sess(r);
                        S.hand  = unique(R.hand);
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
    case 'make_glm13'                   % STEP 6.3: FAST glm w/out hpf (simple:rest as baseline) - model one instruction regressor
        s=varargin{1};
        
        prefix='r';
        dur=30;                                                              % secs (length of task dur, not trial dur)
        announcetime=5;                                                     % length of task announce time                                                    % length of task announce time
        for s=s,
            T=[];
            glmSubjDir =[baseDir '/GLM_firstlevel_13/' subj_name{s}];dircheck(glmSubjDir);
            
            D=dload(fullfile(baseDir, 'data', subj_name{s},['sc2_',subj_name{s},'.dat']));
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
    case 'estimate_glm'                 % STEP 6.4: Enter subjNum & glmNum Takes approx 70 minutes!!
        % example: sc2_imana('estimate_glm',1,1)
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
    case 'contrast'                     % STEP 6.5: Define linear contrasts
        % 'SPM_light' is created in this step (xVi is removed as it slows
        % down code for FAST GLM)
        % example: sc2_imana('contrast',1,1,'task_variability')
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
                
                %                 % F contrast for instructions
                %                 if glm==3,
                %                     con=[];
                %                     for ii=1:16,
                %                         con=horzcat(con,T.task==ii & T.type==1); % instructions
                %                     end
                %                     con = [con;zeros(ncolX-size(T.task,1),size(con,2))];
                %                     SPM.xCon(length(SPM.xCon)+1)=spm_FcUtil('Set','Instructions_FCon', 'F', 'c',con,SPM.xX.xKXs);
                %                 end
                
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
        
    case 'process_suit'                 % STEP 8.1-8.5
        % example: sc1_imana('process_suit',2,4,'contrast')
        sn = varargin{1}; % subjNum
        glm = varargin{2}; % glmNum
        %         spm fmri
        
        for s=sn,
            sc2_imana('make_mask_cortex',s)
            sc2_imana('corr_cereb_cortex_mask',s)
            sc2_imana('suit_normalise_dartel',s,'grey');
            %             sc2_imana('suit_normalise_dentate',s,'grey');
            sc2_imana('suit_make_mask',s,glm,'grey');
            sc2_imana('suit_reslice',s,glm,'betas','cereb_prob_corr_grey');
            sc2_imana('suit_reslice',s,glm,'contrast','cereb_prob_corr_grey');
            sc2_imana('suit_reslice',s,glm,'ResMS','cereb_prob_corr_grey');
            fprintf('suit data processed for %s',subj_name{s})
        end
    case 'make_mask_cortex'
        sn=varargin{1};
        
        subjs=length(sn);
        for s=1:subjs,
            glmSubjDir =[baseDir '/GLM_firstlevel_4/' subj_name{sn(s)}];
            
            for h=regSide,
                C=caret_load(fullfile(baseDirSc1,'surfaceCaret',atlasname,hemName{h},[hem{h} '.cerebral_cortex.paint'])); % freesurfer
                caretSubjDir=fullfile(baseDirSc1,'surfaceCaret',[atlasA subj_name{sn(s)}]);
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
            dircheck(fullfile(regDir,'data',subj_name{sn(s)}));
            cd(fullfile(regDir,'data',subj_name{sn(s)}))
            region_saveasimg(R{1},R{1}.file);
        end
    case 'corr_cereb_cortex_mask'
        sn=varargin{1};
        mask=varargin{2}; % 'whole' or 'grey'
        
        subjs=length(sn);
        
        
        for s=1:subjs,
            switch mask,
                case 'grey'
                    probName='cereb_prob_corr_grey';
                    cereb = fullfile(baseDirSc1,'suit','anatomicals',subj_name{sn(s)},'c1anatomical.nii'); % call from sc1
                case 'whole'
                    probName='cereb_prob_corr';
                    cerebDir=fullfile(baseDirSc1,'suit','anatomicals',subj_name{sn(s)});
                    cd(cerebDir);
                    spm_imcalc('c1anatomical.nii','c2anatomical.nii','c5anatomical.nii','i1.*2')
                    cereb = fullfile(cerebDir,'c5anatomical.nii'); % call from sc1
            end
            
            cortexGrey= fullfile(regDir,'data',subj_name{sn(s)},'cortical_mask_grey.nii'); % cerebellar mask grey (corrected)
            dircheck(fullfile(suitDir,'anatomicals',subj_name{sn(s)}));
            bufferVox = fullfile(suitDir,'anatomicals',subj_name{sn(s)},'buffer_voxels.nii');
            
            % isolate overlapping voxels
            spm_imcalc({cortexGrey,cereb},bufferVox,'(i1.*i2)')
            
            % mask buffer
            spm_imcalc({bufferVox},bufferVox,'i1>0')
            
            cereb2 = fullfile(suitDir,'anatomicals',subj_name{sn(s)},sprintf('%s.nii',probName));
            cortex2= fullfile(regDir,'data',subj_name{sn(s)},'cortical_mask_grey_corr.nii');
            
            % remove buffer from cerebellum
            spm_imcalc({cereb,bufferVox},cereb2,'i1-i2')
            
            % remove buffer from cortex
            spm_imcalc({cortexGrey,bufferVox},cortex2,'i1-i2')
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
        
        job.subjND.gray      = {fullfile(baseDirSc1,'suit','anatomicals',subj_name{sn},'c_anatomical_seg1.nii')}; % call from sc1
        job.subjND.white     = {fullfile(baseDirSc1,'suit','anatomicals',subj_name{sn},'c_anatomical_seg2.nii')}; % call from sc1
        switch type,
            case 'grey'
                job.subjND.isolation= {fullfile(suitDir,'anatomicals',subj_name{sn},'cereb_prob_corr_grey.nii')};
            case 'whole'
                job.subjND.isolation= {fullfile(suitDir,'anatomicals',subj_name{sn},'cereb_prob_corr.nii')};
        end
        outputDir=fullfile(suitDir,'anatomicals',subj_name{sn}); % MK added this option
        suit_normalize_dartel(job,'outputDir',outputDir);
        
        % 'suit_normalize_dartel' was changed to include a varargin
        %  argument 'outputDir' so that files can be saved in another dir
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
    case 'suit_make_mask'               % STEP 8.4: Make cerebellar mask in individual space using SUIT
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
                    omask = fullfile(suitDir,'anatomicals',subj_name{sn(s)},'maskbrainSUIT.nii'); % output mask image
            end
            dircheck(fullfile(suitDir,'anatomicals',subj_name{sn(s)}));
            cd(fullfile(suitDir,'anatomicals',subj_name{sn(s)}));
            spm_imcalc({mask,suit},omask,'i1>0 & i2>0.7',{});
        end
    case 'suit_mask_dentate'            % STEP 8.4: Mask task contrast using SUIT dentate ROIs
        sn=varargin{1}; % subjNum
        
        subjs=length(sn);
        
        % mask dentate
        spm_imcalc({which('Cerebellum-SUIT.nii'),which('Cerebellum-SUIT.nii')},fullfile(suitDir,'anatomicals','dentate-mask.nii'),'(i1==29) + (i1==30)')
        
        for s=1:subjs,
            
            mask  = fullfile(suitDir,'anatomicals','dentate-mask.nii'); % dentate mask
            cd(fullfile(suitDir,'glm4',subj_name{sn(s)}));
            files=dir('fwd*');
            
            for i=1:length(files)
                outname=fullfile(suitDir,'glm4',subj_name{sn(s)},['dmask-' files(i).name]);
                spm_imcalc({mask,files(i).name},outname,'i1.*i2');
            end
        end
    case 'suit_reslice'
        % Reslices the functional data (betas, contrast images or ResMS)
        % from the first-level GLM using deformation from
        % 'suit_normalise_dartel'.
        % example: sc1_imana('suit_reslice_dartel',1,1,'contrast')
        % make sure that you reslice into 2mm^3 resolution
        sn=varargin{1}; % subjNum
        glm=varargin{2}; % glmNum
        type=varargin{3}; % 'betas' or 'contrast' or 'ResMS'
        mask=varargin{4}; % 'cereb_prob_corr_grey' or 'cereb_prob_corr' or 'dentate_mask'
        
        subjs=length(sn);
        
        % determine prefix for resliced images
        switch mask,
            case 'cereb_prob_corr'
                prefix='fwd';
            case 'cereb_prob_corr_grey'
                prefix='wd';
            case 'dentate_mask'
                prefix='dwd';
        end
        
        % reslice betas/contrast/ResMS
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
            end
            job.subj.affineTr = {fullfile(suitDir,'anatomicals',subj_name{sn(s)},'Affine_c_anatomical_seg1.mat')};
            job.subj.flowfield= {fullfile(suitDir,'anatomicals',subj_name{sn(s)},'u_a_c_anatomical_seg1.nii')};
            job.subj.resample = {source.name};
            job.subj.mask     = {fullfile(suitDir,'anatomicals',subj_name{sn(s)},sprintf('%s.nii',mask))};
            job.vox           = [2 2 2];
            job.prefix        = prefix;
            suit_reslice_dartel(job);
            source=fullfile(glmSubjDir,sprintf('*%s*',prefix));
            dircheck(fullfile(outDir));
            destination=fullfile(suitDir,sprintf('glm%d',glm),subj_name{sn(s)});
            movefile(source,destination);
            % delete 'temp' files
            tempFiles=dir(fullfile(suitDir,sprintf('glm%d',glm),subj_name{sn(s)},'*temp*'));
            if ~isempty(tempFiles),
                for i=1:length(tempFiles),
                    delete(char(fullfile(suitDir,sprintf('glm%d',glm),subj_name{sn(s)},tempFiles(i).name)));
                end
            end
            
            fprintf('%s have been resliced into suit space for %s \n\n',type,glm,subj_name{sn(s)})
        end
        
    case 'process_ROI'                  % STEP 8.1-9.6
        sn=varargin{1}; % subjNum
        glm=varargin{2}; % glmNum
        type=varargin{3}; %'cortical_lobes','whole_brain','yeo','desikan','cerebellum'
        for s=sn,
            for t=1:numel(type),
                sc2_imana('ROI_define',s,type{t})
                sc2_imana('ROI_get_betas',s,glm,type{t})
                sc2_imana('ROI_stats',s,glm,1,type{t}) % remove mean
                %                 sc2_imana('ROI_RDM_stability',s,glm,type{t})
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
                        C=caret_load(fullfile(baseDirSc1,'surfaceCaret',atlasname,hemName{h},[hem{h} '.cerebral_cortex.paint'])); % freesurfer
                        caretSubjDir=fullfile(baseDirSc1,'surfaceCaret',[atlasA subj_name{sn(s)}]);
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
                        C=caret_load(fullfile(baseDirSc1,'surfaceCaret',atlasname,hemName{h},[hem{h} '.Yeo17.paint'])); % freesurfer
                        caretSubjDir=fullfile(baseDirSc1,'surfaceCaret',[atlasA subj_name{sn(s)}]);
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
                        C=caret_load(fullfile(baseDirSc1,'surfaceCaret',atlasname,hemName{h},[hem{h} '.Yeo17.paint'])); % freesurfer
                        caretSubjDir=fullfile(baseDirSc1,'surfaceCaret',[atlasA subj_name{sn(s)}]);
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
                        C=caret_load(fullfile(baseDirSc1,'surfaceCaret',atlasname,hemName{h},[hem{h} '.desikan.paint'])); % freesurfer
                        caretSubjDir=fullfile(baseDirSc1,'surfaceCaret',[atlasA subj_name{sn(s)}]);
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
                        C=caret_load(fullfile(baseDirSc1,'surfaceCaret',atlasname,hemName{h},[hem{h} '.desikan.paint'])); % freesurfer
                        caretSubjDir=fullfile(baseDirSc1,'surfaceCaret',[atlasA subj_name{sn(s)}]);
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
                    caretSubjDir=fullfile(baseDirSc1,'surfaceCaret',[atlasA subj_name{sn(s)}]);
                    file=fullfile(regDir,'data',subj_name{sn(s)},'cortical_mask_grey_corr.nii');
                    for h=regSide,
                        C=caret_load(fullfile(baseDirSc1,'surfaceCaret',atlasname,hemName{h},sprintf('%s.tessel162.paint',hem{h}))); % freesurfer
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
                    caretSubjDir=fullfile(baseDirSc1,'surfaceCaret',[atlasA subj_name{sn(s)}]);
                    file=fullfile(regDir,'data',subj_name{sn(s)},'cortical_mask_grey_corr.nii'); % used to be 'mask'
                    for h=regSide,
                        C=caret_load(fullfile(baseDirSc1,'surfaceCaret',atlasname,hemName{h},sprintf('%s.tessel162.paint',hem{h}))); % freesurfer
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
                        C=caret_load(fullfile(baseDirSc1,'surfaceCaret',atlasname,hemName{h},[hem{h} '.cerebral_cortex.paint'])); % freesurfer
                        caretSubjDir=fullfile(baseDirSc1,'surfaceCaret',[atlasA subj_name{sn(s)}]);
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
                    file = fullfile(baseDirSc1,'suit','anatomicals',subj_name{sn(s)},'dentate_mask.nii');
                    R{1}.type = 'roi_image';
                    R{1}.file= file;
                    R{1}.name = ['dentate'];
                    R{1}.value = 1;
                    R=region_calcregions(R);
            end
            dircheck(fullfile(regDir,'data',subj_name{sn(s)}));
            save(fullfile(regDir,'data',subj_name{sn(s)},sprintf('regions_%s.mat',type)),'R');
            fprintf('ROIs have been defined for %s for %s \n',type,subj_name{sn(s)})
        end
    case 'ROI_get_betas'                % STEP 8.3: Extract betas and prewhiten (apply uni noise normalisation)
        % Betas are not multivariately noise-normalised in this version of
        % the code. See 'sc2_imana_backUp' code for this option
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
            load(fullfile(glmDirSubj,'SPM_light.mat'));
            
            % load data
            load(fullfile(regDir,'data',subj_name{sn(s)},sprintf('regions_%s.mat',type))); % 'regions' are defined in 'ROI_define'
            
            % Get the raw data files
            V=SPM.xY.VY;
            
            Y = region_getdata(V,R);  % Data is N x P
            
            for r=1:numel(R), % R is the output 'regions' structure from 'ROI_define'
                % Get betas (univariately prewhitened)
                %                 Y = region_getdata(V,R{r});  % Data is N x P
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
            dircheck(fullfile(regDir,sprintf('glm%d',glm),subj_name{sn(s)}));
            cd(fullfile(regDir,sprintf('glm%d',glm),subj_name{sn(s)}))
            
            % Save output for each subject
            outfile = sprintf('betas_%s.mat',type);
            dircheck(fullfile(regDir,sprintf('glm%d',glm),subj_name{sn(s)}));
            save(fullfile(regDir,sprintf('glm%d',glm),subj_name{sn(s)},outfile),'B');
            fprintf('betas computed and saved for %s (%s) for %s \n',subj_name{sn(s)},sprintf('glm%d',glm),type);
        end
    case 'ROI_stats'                    % STEP 8.4: Calculate G/second-moment matrix,distance estimates (Mahalanobis),pattern consistencies for all regions
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
                    
                    tt = D.cond.*(D.cond~=1); % we're not interested in the instructions
                    runTrial=D.run.*(D.cond~=1);
                    glmType=1;
                    
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
    case 'ROI_RDM_stability'            % STEP 8.5: Pearson's corr for split-half reliability of LDC distances
        % example: sc2_imana('ROI_RDM_stability',1,1)
        sn=varargin{1}; % subjNum
        glm=varargin{2}; % glmNum
        type=varargin{3}; % 'cortical_lobes','whole_brain','yeo','desikan','cerebellum'
        
        split = [1;2]; % runs - odd and even
        
        T = [];
        subjs=length(sn);
        for s=1:subjs,
            
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
        
    case 'prepare_encoding_data'        % STEP 9.1-3
        sn=varargin{1};
        glm=varargin{2};
        type=varargin{3}; % 'yeo','desikan','cortical_lobes','tasks','desikan_hem','yeo_hem','feature'
        
        sc2_imana('reslice_cereb_betas',sn)
        sc2_imana('get_voxels_cerebellum',sn,glm,'grey')
        sc2_imana('get_voxels_cerebellum',sn,glm,'grey_nan')
        %         sc2_imana('get_vertices_cortex',sn,glm)
        for i=1:numel(type)
            sc2_imana('get_model_cortical',sn,glm,type{i})
        end
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
            deleteFiles=dir(fullfile(baseDir,'GLM_firstlevel_4',subj_name{sn(s)},'*temp*'));
            for b=1:length(deleteFiles),
                delete(char(fullfile(baseDir,'GLM_firstlevel_4',subj_name{sn(s)},deleteFiles(b).name)));
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
                V=spm_vol(fullfile(baseDirSc1,'suit','anatomicals',subj_name{sn(s)},'wdc1anatomical.nii')); % call from sc1
            else
                V=spm_vol(fullfile(baseDirSc1,'suit','anatomicals','cerebellarGreySUIT.nii')); % call from sc1
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
    case 'map_con_surf'                 % STEP 12.1: Map betas and ResMS (.nii) onto surface (.metric)
        % Run FREESURFER before this step!
        % map volume images to metric file and save them in individual
        % surface folder
        % example: sc2_imana('surf_map_con',4,'cortex','con','')
        sn   = varargin{1}; % subjNum
        glm  = varargin{2}; % glmNum
        type = varargin{3}; % individual ('cortex' or 'cereb')
        contrast = varargin{4}; % 'con','resMS','betas'
        
        subjs=length(sn);
        
        for s=1:subjs,
            
            glmDir =[baseDir sprintf('/GLM_firstlevel_%d',glm)];dircheck(glmDir);
            glmSubjDir=fullfile(glmDir, subj_name{sn(s)});
            
            vararginoptions({varargin{5:end}},{'atlas','regSide'});
            
            switch type
                case 'cortex'
                    for h=regSide,
                        caretSDir = fullfile(baseDirSc1,'surfaceCaret',[atlasA,subj_name{sn(s)}],hemName{h});
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
                        
                        caretSDir=fullfile(baseDir,'surfaceCaret',[atlasA,subj_name{sn(s)}],hemName{h}); dircheck(caretSDir);
                        caret_save(fullfile(caretSDir,outfile),M); % save in sc2
                        
                        fprintf('%s map to surface for %s:%s \n',contrast,subj_name{sn(s)},hemName{h});
                    end;
                case 'cereb'
                    caretSDir = fullfile(baseDirSc1,'surfaceCaret',[atlasA,subj_name{sn(s)}],'cerebellum'); dircheck(caretSDir);
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
                    
                    caretSDir=fullfile(baseDir,'surfaceCaret',[atlasA,subj_name{sn(s)}],'cerebellum'); dircheck(caretSDir);
                    caret_save(fullfile(caretSDir,outfile),M); % save in sc2
                    
                    fprintf('%s map to surface for %s \n',contrast,subj_name{sn(s)});
                    %                         cd(fullfile(groupDir));
                    %                         suit_lobuli_summarize(images,'outfilename',outfile_stats,'atlas','Cerebellum_SUIT.nii')
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
    case 'get_model_cortical'           % STEP 9.4: Get cortical model (intended for use in 'run_encoding' step)
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
                    X.Xx(:,length(D.SN)+1:length(D.SN)+numel(run))=0; % zero out last 'intercept' run
                case 'yeo'
                    load(fullfile(regDir,sprintf('glm%d',glm),subj_name{sn(s)},sprintf('betas_%s.mat',type)));
                    networks=[2:18];
                    for r=1:17, % we don't want 'FreeSurfer_Defined_Medial_Wall'
                        X.Xx(r,:)=mean(B{networks(r)}.betasUW,2);
                        X.idx(r,1)=networks(r);
                    end
                    X.Xx(:,length(D.SN)+1:length(D.SN)+numel(run))=0; % zero out last 'intercept' run
                case 'yeo_hem'
                    load(fullfile(regDir,sprintf('glm%d',glm),subj_name{sn(s)},sprintf('betas_%s.mat',type)));
                    networks=[2:18,20:36]; % not interested in freesurfer defined medial wall
                    paintFileNums=repmat([2:18],1,2);
                    for r=1:34,
                        X.Xx(r,:)=mean(B{networks(r)}.betasUW,2);
                        X.idx(r,1)=paintFileNums(r);
                    end
                    X.Xx(:,length(D.SN)+1:length(D.SN)+numel(run))=0; % zero out last 'intercept' run
                case 'desikan'
                    load(fullfile(regDir,sprintf('glm%d',glm),subj_name{sn(s)},sprintf('betas_%s.mat',type)));
                    networks=[2:36]; % remove 'medial wall'
                    for r=1:35,
                        X.Xx(r,:)=mean(B{networks(r)}.betasUW,2);
                        X.idx(r,1)=networks(r);
                    end
                    X.Xx(:,length(D.SN)+1:length(D.SN)+numel(run))=0; % zero out last 'intercept' run
                case 'desikan_hem'
                    load(fullfile(regDir,sprintf('glm%d',glm),subj_name{sn(s)},sprintf('betas_%s.mat',type)));
                    networks=[2:36,38:72];
                    paintFileNums=repmat([2:36],1,2);
                    for r=1:70,
                        X.Xx(r,:)=mean(B{networks(r)}.betasUW,2);
                        X.idx(r,1)=paintFileNums(r);
                    end
                    X.Xx(:,length(D.SN)+1:length(D.SN)+numel(run))=0; % zero out last 'intercept' run
                case '162_tessellation'
                    load(fullfile(regDir,sprintf('glm%d',glm),subj_name{sn(s)},sprintf('betas_%s.mat',type)));
                    tessels=[1:148,150:158];
                    for r=1:157, % we don't want 'FreeSurfer_Defined_Medial_Wall' - tessel number 149
                        X.Xx(r,:)=mean(B{tessels(r)}.betasUW,2);
                        X.idx(r,1)=tessels(r);
                    end
                    X.Xx(:,length(D.SN)+1:length(D.SN)+numel(run))=0; % zero out last 'intercept' run
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
                    X.Xx(:,length(D.SN)+1:length(D.SN)+numel(run))=0; % zero out last 'intercept' run
                case 'feature'
                    F=sc2_imana('make_feature_model');
                    F=getrow(F,[2:30]'); % remove instructions
                    T   = [F.lHand./F.duration F.rHand./F.duration F.saccades./F.duration];
                    T   = [T eye(29)];
                    T   = bsxfun(@minus,T,mean(T));
                    T   = bsxfun(@rdivide,T,sqrt(sum(T.^2)));  % Normalize to unit length vectors
                    % make cond x run x features
                    for f=1:size(T,2),
                        X.Xx(:,f)=repmat(T(:,f),numel(run),1);
                    end
                    X.Xx=X.Xx';
                    X.Xx(:,length(D.SN)+1:length(D.SN)+numel(run))=0; % zero out last 'intercept' run
                    X.idx=[1:32]';
            end
            outFile=sprintf('%s_glm%d_model.mat',type,glm);
            save(fullfile(encodeSubjDir,outFile),'X');
            fprintf('%s-weighted betas (glm%d) (X) have been computed for %s \n',type,glm,subj_name{sn(s)});
        end
    case 'model_simulation'             % STEP 9.5: Make simulated data for generative models
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
                [Uhat{m},T.fR2(n,indx),T.fR(n,indx)]=sc2_encode_fit(Y,X,methods{m},'lambda',Lambda(m),'threshold',threshold{m});
                for i = 1:length(threshold{m})
                    T.numReg(n,numT(m)+i) = mean(sum(abs(Uhat{m})>threshold{m}(i)));
                end;
                maxReg = max(abs(Uhat{m}))./sum(abs(Uhat{m}));
                T.maxReg(n,indx) = mean(max(abs(Uhat{m})));
                T.sumReg(n,indx) = mean(sum(abs(Uhat{m})));
                T.relMaxReg(n,indx)=mean(maxReg);
                
                [T.cR2(n,indx),T.cR(n,indx)]=sc2_encode_crossval(Y,X,D.part,methods{m},'lambda',Lambda(m),'threshold',threshold{m});
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
        
    case 'map_cortex_cerebellum'        % Map cortex to cerebellum (encoding models)
        sn=varargin{1};
        type=varargin{2};
        method=varargin{3};
        data=varargin{4};
        threshold=varargin{5};
        lambda=varargin{6};
        
        sc2_imana('run_encoding',sn,4,'yes',type,method,data,threshold,lambda)
        sc2_imana('map_winner_to_surface',sn,type,method,data,1)
    case 'run_encoding'                 % STEP 10.1: run all encoding models
        sn=varargin{1}; % [2:17]
        glm=varargin{2}; % usually 4
        normalise=varargin{3}; % yes or no (yes - remove mean from each voxel (X and Y) for each run across conditions)
        type=varargin{4}; % 'yeo','yeo_hem','whole_brain','desikan','desikan_hem','cortical_lobes','ica','tasks','feature'
        method=varargin{5}; % linRegress, ridgeFixed, nonNegExp, cplexqp, lasso, winnerTakeAll
        data=varargin{6}; % 'grey' or 'grey_white' or 'grey_nan'
        threshold=varargin{7}; % 1e-4 for 'cplexqp_L2' or 'cplexqp' and -inf for all others
        lambda=varargin{8}; % {0,5,10,25,50,100} - cplexqp; {0,25,50,150,300,500,700,1000} - cplexqp_L2
        encodeType=varargin{9}; % 1,2,3 etc depending on which betas are included in X (model) and Y (data)
        
        subjs=length(sn);
        
        for s=1:subjs,
            Yp=[];
            
            encodeSubjDir = fullfile(encodeDir,sprintf('glm%d',glm),subj_name{sn(s)}); dircheck(encodeSubjDir);
            
            % load Y
            load(fullfile(encodeSubjDir,sprintf('Y_info_glm%d_%s.mat',glm,data)));
            
            % load X
            load(fullfile(encodeSubjDir,sprintf('%s_glm%d_model.mat',type,glm)));
            cortIdx=X.idx;
            X=X.Xx;
            X=X';
            
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
                [Uhat,T.fR2m,T.fRm,~,~,C]=sc2_encode_fit(Yact,X,method,'threshold',threshold,'lambda',lambda{l});
                
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
                T.cortIdx=cortIdx; % indices for cortical parcellation
                T.idxLambda=repmat(lambda{l},size(Uhat,1),1);
                T.compIdx=C;
                T.catName={sprintf('%s-%s-%d',type,method,T.lambda)};
                
                [T.cR2m,T.cRm,T.cR2v,T.cRv]=sc2_encode_crossval(Yact,X,Y.run,method,'threshold',threshold,'lambda',lambda{l});
                Yp=addstruct(Yp,T);
            end
            
            outName=fullfile(encodeDir,sprintf('glm%d',glm),sprintf('encode_%d',encodeType),subj_name{sn(s)},sprintf('encode_%s_%s_%s.mat',type,method,data));
            save(outName,'Yp','-v7.3');
            fprintf('encode model (%s + %s): cerebellar voxels predicted for %s \n',type,method,subj_name{sn(s)});
        end
    case 'map_to_surface_all'           % STEP 10.2: map any stats from the encoding models to the cerebellar surface
        sn=varargin{1};   % single subject (2) or all subjecs (2:17)
        type=varargin{2}; % yeo, yeo_hem, desikan, desikan_hem, 162_tessellation, 162_tessellation_hem
        method=varargin{3}; % cplexqp or cplexqp_L2 (we don't do winnerTakeAll in this case)
        lambda=varargin{4}; % optimal lambda for that model
        stat=varargin{5}; % betas, relMax, R, R2
        metric=varargin{6}; % make metric file: 'yes' or 'no'
        encodeType=varargin{7};
        
        subjs=length(sn);
        threshold=.001;
        
        for s=1:subjs,
            V=[];
            encodeSubjDir = fullfile(encodeDir,'glm4',sprintf('encode_%d',encodeType));
            
            load(fullfile(encodeSubjDir,sprintf('encode_%s_%s_grey.mat',type,method)));
            
            % make cerebellar volume
            B=spm_vol(fullfile(suitDir,'glm4',subj_name{sn(s)},'wdResMS.nii'));
            Yy=zeros(1,B.dim(1)*B.dim(2)*B.dim(3));
            switch stat
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
            end
            Yy=reshape(Yy,[B.dim(1),B.dim(2),B.dim(3)]);
            Yy(Yy==0)=NaN;
            V{1}.dat=Yy;
            V{1}.dim=B.dim;
            V{1}.mat=B.mat;
            V{1}.fname=B.fname;
            M=caret_suit_map2surf(V,'space','SUIT','stats',stats);  % MK created caret_suit_map2surf to allow for output to be used as input to caret_save
            M.column_name={sprintf('%s_%s_%s',type,method,stat)};
            vertices(:,s)=M.data;
        end
        
        % average across subjects
        indices=nanmean(vertices,2);
        suit_plotflatmap(indices,'type','func','cscale',[min(indices),max(indices)]);
        colorbar
        
        switch metric,
            case 'yes'
                caret_save(fullfile(caretDir,'suit_flat','glm4'),M);
            case 'no'
                disp('not making metric file')
        end
    case 'interSubjVar_encoding'        % STEP 10.3: calculate within and between-subj variability for betas from encoding model
        sn=varargin{1};   % single subject (2) or all subjecs (2:17)
        type=varargin{2}; % yeo, yeo_hem, desikan, desikan_hem, 162_tessellation, 162_tessellation_hem
        method=varargin{3}; % cplexqp or cplexqp_L2 (we don't do winnerTakeAll in this case)
        lambda=varargin{4}; % optimal lambda for that model
        step=varargin{5}; % 'group_betas' or 'interSubj_corr'
        encodeType=varargin{6};
        
        subjs=length(sn);
        threshold=.001;
        
        switch step
            case 'group_betas'
                % loop over subjs & get betas
                for s=1:subjs,
                    V=[];
                    encodeSubjDir = fullfile(encodeDir,'glm4',sprintf('encode_%d',encodeType),subj_name{sn(s)});
                    
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
    case 'map_winner_to_surface'        % STEP 10.5: do winnerTakeAll on group level - create paint and area colour files
        sn=varargin{1};
        type=varargin{2}; % 'yeo','yeo_hem','desikan','desikan_hem','cortical_lobes'
        method=varargin{3}; % 'winnerTakeAll' or 'winnerTakeAll_nonNeg'
        data=varargin{4}; % 'grey_nan'
        winner=varargin{5}; % which winner do we want? - 1,2,3,etc
        
        % get correlations across subjs
        subjs=length(sn);
        for s=1:subjs,
            encodeSubjDir = fullfile(encodeDir,subj_name{sn(s)});
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
        caret_save(fullfile(caretGroupDir,sprintf('cereb.%s_%s.paint',method,type)),M);
        
        % make area colour
        numConds=size(W,2);
        cmap=load(fullfile(encodeDir,sprintf('winnerTakeAll_%s.colour.txt',type)));
        M.encoding={'BINARY'};
        M.column_name=M.paintnames;
        M.column_color_mapping=repmat([-5 5],numConds,1);
        M.paintnames=paintNames;
        M.data=cmap(1:numConds,2:4);
        caret_save(fullfile(caretGroupDir,sprintf('cereb.%s_%s.areacolor',method,type)),M);
    case 'calculate_DICE_coefficient'   % STEP 10.6: calculate DICE coefficient for 'labeled' maps
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
        
    case 'map_cerebellum_cortex'        % Map cerebellum to cortex (results from encoding model)
    case 'cortical_combination'         % STEP 11.1: cerebellar voxel - cortical combination
        % example: sc2_imana('cortical_combination',[2:17],'162_tessellation_hem','cplexqp','grey',25)
        sn=varargin{1};
        type=varargin{2}; % '162_tessellation_hem'
        method=varargin{3}; % 'cplexqp','cplexqp_L2'
        data=varargin{4}; % 'grey'
        lambda=varargin{5}; % optimal lambda
        lateral=varargin{6}; % 'left' or 'right'
        lobule=varargin{7}; % 'V_VI' or 'CrusII'
        
        % determine threshold and voxel coordinates
        threshold=.001;
        switch lateral,
            case 'right'
                if strcmp(lobule,'V_VI'),
                    i=47;j=26;k=27; % voxel in right V/VI
                else
                    i=60;j=25;k=19; % voxel in right Crus II;
                end
            case 'left'
                if strcmp(lobule,'V_VI')
                    i=25;j=26;k=27; % voxel in left V/VI
                else
                    i=13;j=19;k=21; % voxel in left Crus II;
                end
        end
        
        % find cerebellar index from volume
        C=spm_vol(fullfile(suitDir,'glm4',subj_name{sn},'wdResMS.nii'));
        Yy=zeros(1,C.dim(1)*C.dim(2)*C.dim(3));
        Yy=reshape(Yy,[C.dim(1),C.dim(2),C.dim(3)]);
        vIndx=sub2ind(size(Yy),i,j,k);
        
        % load encoding results
        encodeSubjDir = fullfile(encodeDir,subj_name{sn});
        load(fullfile(encodeSubjDir,sprintf('encode_%s_%s_%s.mat',type,method,data)));
        
        % get optimal lambda
        B=Yp.betas(Yp.idxLambda==lambda,:);
        cI=Yp.nonZeroInd(Yp.lambda==lambda,:); % cerebellar index
        pI=Yp.cortIdx(Yp.idxLambda==lambda,:); % parcellation index
        
        % get indices for both hemispheres
        parcelIdx(:,1)=[1:size(B,1)/2];
        parcelIdx(:,2)=[(size(B,1)/2)+1:size(B,1)];
        
        % loop over hemispheres
        for h=1:2, % left hemisphere
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
            %             outName=fullfile(caretDir,'fsaverage_sym',hemName{h},sprintf('%s.voxel_%s_%s.metric',hem{h},lateral,lobule));
            %             caret_save(outName,C);
            
            % plot winning combination on cortical flatmap
            coord=fullfile(caretDir,'fsaverage_sym',hemName{h},[hem{h} '.FLAT.coord']);
            topo=fullfile(caretDir,'fsaverage_sym',hemName{h},[hem{h} '.CUT.topo']);
            xlims=[-140 140];
            ylims=[-140 140];
            
            figure
            caret_plotflatmap('coord',coord,'topo',topo,'data',C.data,'xlims',xlims,'ylims',ylims)
            colorbar
        end
        disp(X);
    case 'feature_corr_matrix'          % STEP 11.2: QxQ correlational matrix
        sn=varargin{1};
        type=varargin{2}; % '162_tessellation_hem'
        
        subjs=length(sn);
        
        % loop over subjects
        for s=1:subjs,
            encodeSubjDir = fullfile(encodeDir,subj_name{sn(s)});
            load(fullfile(encodeSubjDir,sprintf('%s_glm4_model.mat',type)));
            pI=X.idx;
            B=X.Xx; % feature matrix
            B(:,465:480)=[]; % remove intercept
            A(s,:,:)=B*B';
        end
        
        % number of features
        Q=size(A,2); % both hemis
        
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
            for q=[pI(1:Q/2)'],
                I(idx)=mode(P.data(D.data==q));
                idx=idx+1;
            end
            [Y(:,h),Z(:,h)]=sort(I(C.hemi==h));
        end
        
        % get group average QxQ matrix
        A=reshape(mean(A,1),[Q,Q]);
        
        % make correlational matrix
        C.corr=nancorr(A);
        
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
        
        % save out structure
        outName=fullfile(encodeDir,sprintf('corr_%s_tasks.mat',type));
        save(outName,'C');
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
                    for i=1:length(paintNum),% length(data)
                        FData(D.data==paintNum(i),1)=A(parcelIdx(i,h));
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
        
    case 'process_feature_models'
        sn=varargin{1};
        
        %         sc2_imana('make_allSubj_struct',sn,'cortex',[1:2])
        sc2_imana('make_allSubj_struct',sn,'cereb',[1])
        %         sc2_imana('map_features_cortex',sn,'allMotor','tasks','yes')
        sc2_imana('map_tasks_cereb',sn,'allMotor','tasks','no')
    case 'make_allSubj_struct'          % STEP 11.2: Make allSubj struct from 'Y_info_glm_grey_nan' struct and 'lh/rh_info_glm_grey_nan'
        sn=varargin{1};
        type=varargin{2}; % 'cortex' or 'cereb'
        hemN=varargin{3}; % [1:2] and [1]
        
        % instructions are removed in this case!! (but rest remains)
        
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
                        V=spm_vol(fullfile(baseDirSc1,'suit','anatomicals','cerebellarGreySUIT.nii'));
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
    case 'map_tasks_cortex'             % STEP 11.3: Map tasks and features to cerebellar or cortical surface for one or all subjs and do stats
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
            D=sc2_imana('make_feature_model');
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
    case 'map_tasks_cereb'
        sn=varargin{1};
        feature=varargin{2}; % 'lHand','rHand','saccades'
        map=varargin{3}; % map 'features' or 'tasks'
        stats=varargin{4}; % 'yes' or 'no'
        
        subjs=length(sn);
        pThresh=.05;
        
        % load in allSubjs data struct
        load(fullfile(encodeDir,'glm4','cereb_avrgDataStruct.mat')); % instruct already removed
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
        D=sc2_imana('make_feature_model','sc2');
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
            save(fullfile(caretDir,'suit_flat','glm4',sprintf('FDRCorr_%s_%s_sc2.mat',map,feature)),'S');
        else
            save(fullfile(caretDir,'suit_flat','glm4',sprintf('unCorr_%s_%s_sc2.mat',map,feature)),'S');
        end
    case 'map_tasks_sc1_sc2'
        sn=varargin{1};
        feature=varargin{2}; % 'lHand','rHand','saccades'
        map=varargin{3}; % map 'features' or 'tasks'
        
        subjs=length(sn);
        pThresh=.05;
        
        % load in allSubjs data struct from sc1 & sc2
        H=[];
        for study=1:2,
            if study==1,
                encodeDir=fullfile(baseDirSc1,'encoding');
            else
                encodeDir=fullfile(baseDir,'encoding');
            end
            load(fullfile(encodeDir,'glm4','cereb_avrgDataStruct.mat'));
            T.studyNum=repmat(study,size(T.SN,1),1);
            H=addstruct(H,T);
            clear T
        end
        
        % get session average for each study separately
        for s=1:subjs,
            idx=1;
            for study=1:2,
                numConds=length(unique(H.cond(H.studyNum==study)));
                for c=1:numConds, % get average across sessions
                    indx = H.cond==c & H.studyNum==study & H.SN==(sn(s));
                    avrgData(idx,:)=nanmean(H.data(indx,:),1);
                    idx=idx+1;
                    clear indx
                end
                fprintf('subj%d averaged sessions for study%d \n',sn(s),study)
            end
            % subtract condition avrg baseline (across 61-1 conditions)
            all=[1:size(avrgData,1)];
            for c=1:size(avrgData,1),
                X=nanmean(avrgData(all(all~=c),:),1);
                data(c,:,s)=avrgData(c,:)-X;
            end
            clear avrgData
            fprintf('subj%d new baseline \n',sn(s))
        end
        
        % get feature model
        D=sc2_imana('make_feature_model','both');
        
        switch map,
            case 'features'
                numTasks=0;
            case 'tasks'
                numTasks=size(D.duration,1);
        end
        
        %which features are we mapping?
        switch feature,
            case 'lHand'
                if strcmp(map,'tasks'),
                    X=[eye(numTasks) D.lHand./D.duration];
                    condNamesSc1Sc2{numTasks+1}='30.left hand';
                else
                    clear condNamesSc1Sc2
                    X=[D.lHand./D.duration];
                    condNamesSc1Sc2{1}='1.left hand';
                end
            case 'rHand'
                if strcmp(map,'tasks'),
                    X=[eye(numTasks) D.rHand./D.duration];
                    condNamesSc1Sc2{numTasks+1}='30.right hand';
                else
                    clear condNamesSc1Sc2
                    X=[D.rHand./D.duration];
                    condNamesSc1Sc2{1}='1.right hand';
                end
            case 'saccades'
                if strcmp(map,'tasks'),
                    X=[eye(numTasks) D.saccades./D.duration];
                    condNamesSc1Sc2{numTasks+1}='30.saccades';
                else
                    clear condNamesSc1Sc2
                    X=[D.saccades./D.duration];
                    condNamesSc1Sc2{1}='1.saccades';
                end
            case 'bothHands'
                if strcmp(map,'tasks'),
                    X=[eye(numTasks) D.lHand./D.duration D.rHand./D.duration];
                    condNamesSc1Sc2{numTasks+1}='30.left hand';
                    condNamesSc1Sc2{numTasks+2}='31.right hand';
                else
                    clear condNamesSc1Sc2
                    X=[D.lHand./D.duration D.rHand./D.duration];
                    condNamesSc1Sc2{1}='1.left hand';
                    condNamesSc1Sc2{2}='2.right hand';
                end
            case 'allMotor'
                if strcmp(map,'tasks'),
                    X=[eye(numTasks) D.lHand./D.duration D.rHand./D.duration D.saccades./D.duration];
                    condNamesSc1Sc2{numTasks+1}='30.left hand';
                    condNamesSc1Sc2{numTasks+2}='31.right hand';
                    condNamesSc1Sc2{numTasks+3}='32.saccades';
                else
                    clear condNamesSc1Sc2
                    X=[D.lHand./D.duration D.rHand./D.duration D.saccades./D.duration];
                    condNamesSc1Sc2{1}='1.left hand';
                    condNamesSc1Sc2{2}='2.right hand';
                    condNamesSc1Sc2{3}='3.saccades';
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
            fprintf('ridge regress done for subj%d done \n',sn(s))
        end;
        clear data
        
        % if numSubjs > 1 get avg
        Yy=permute(Yy,[2 1 3]);
        indices=nanmean(Yy,1);
        indices=reshape(indices,[size(indices,2),size(indices,3)]);
        
        % map vol2surf
        indices=reshape(indices,[size(indices,1) V.dim(1),V.dim(2),V.dim(3)]);
        for i=1:size(indices,1),
            data=reshape(indices(i,:,:,:),[C{1}.dim]);
            C{i}.dat=data;
        end
        M=caret_suit_map2surf(C,'space','SUIT','stats','nanmean','column_names',condNamesSc1Sc2);  % MK created caret_suit_map2surf to allow for output to be used as input to caret_save
        
        % save out as struct
        S.indices=M.data';
        S.name=condNamesSc1Sc2';
        save(fullfile(caretDir,'suit_flat','glm4',sprintf('unCorr_%s_%s_sc1_sc2.mat',map,feature)),'S');
    case 'map_motor_cereb'
        sn=varargin{1};
        feature=varargin{2}; % 'lHand','rHand','saccades'
        map=varargin{3}; % map 'features' or 'tasks'
        
        subjs=length(sn);
        pThresh=.05;
        
        % load in allSubjs data struct from sc1 & sc2
        H=[];
        for study=1:2,
            if study==1,
                encodeDir=fullfile(baseDirSc1,'encoding');
            else
                encodeDir=fullfile(baseDir,'encoding');
            end
            load(fullfile(encodeDir,'glm4','cereb_avrgDataStruct.mat'));
            T.studyNum=repmat(study,size(T.SN,1),1);
            H=addstruct(H,T);
            clear T
        end
        
        % get session average for each study separately
        for s=1:subjs,
            idx=1;
            for study=1:2,
                numConds=length(unique(H.cond(H.studyNum==study)));
                for c=1:numConds, % get average across sessions
                    indx = H.cond==c & H.studyNum==study & H.SN==(sn(s));
                    avrgData(idx,:)=nanmean(H.data(indx,:),1);
                    idx=idx+1;
                    clear indx
                end
                fprintf('subj%d averaged sessions for study%d \n',sn(s),study)
            end
            % subtract condition avrg baseline (across 61-1 conditions)
            all=[1:size(avrgData,1)];
            for c=1:size(avrgData,1),
                X=nanmean(avrgData(all(all~=c),:),1);
                data(c,:,s)=avrgData(c,:)-X;
            end
            clear avrgData
            fprintf('subj%d new baseline \n',sn(s))
        end
        
        % get feature model
        D=sc2_imana('make_feature_model','both');
        
        switch map,
            case 'features'
                numTasks=0;
            case 'tasks'
                numTasks=size(D.duration,1);
        end
        
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
            fprintf('ridge regress done for subj%d done \n',sn(s))
        end;
        clear data
        
        % do stats on motor features
        Yy(Yy==0)=nan;
        totalFeat=size(Yy,1);
        motorFeat=numTasks+1:totalFeat;
        for ii=1:length(motorFeat),
            data=ssqrt(Yy(motorFeat(ii),:,:));
            data=reshape(data,[size(data,2),size(data,3)]);
            cStats{ii}= caret_getcSPM('onesample_t','data',data(1:subjs,:)');
            P=spm_P_FDR(cStats{ii}.con.Z,cStats{ii}.con.df,'Z',1,sort(cStats{ii}.con.Z_P,'ascend'));
            %                     P=spm_P_Bonf(cStats{ii}.con.Z,cStats{ii}.con.df,'Z',size(cStats{ii}.data,1),1);
            c=cStats{ii}.con.Z;
            c(P>pThresh)=nan;
            indices(ii,:)=c;
            clear c
            fprintf('motorFeat%d done \n',ii)
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
        save(fullfile(caretDir,'suit_flat','glm4',sprintf('FDRCorr_%s_%s_sc1_sc2.mat',map,feature)),'S');
    case 'visualise_tasks'
        reg=varargin{1}; % 'cortex' or 'cereb'
        thresh=varargin{2}; % 'FDRCorr' or 'unCorr'
        map=varargin{3}; % 'tasks' or 'features'
        feature=varargin{4}; % see 'map_features_cortex'
        metric=varargin{5}; % 'yes' or 'no'
        study=varargin{6}; % 'sc2' or 'sc1_sc2'
        
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
                load(fullfile(outDir,sprintf('%s_%s_%s_%s.mat',thresh,map,feature,study)))
                switch metric,
                    case 'yes'
                        % save output as metric or paint
                        M=caret_struct('metric','data',S.indices','column_name',S.name');
                        caret_save(fullfile(outDir,sprintf('%s_%s_%s_%s.metric',thresh,map,feature,study)),M);
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
    case 'visualise_motor'
        reg=varargin{1}; % 'cortex' or 'cereb'
        
        switch reg,
            case 'cortex'
                for h=1:2,
                    outDir=fullfile(caretDir,'fsaverage_sym',hemName{h},'glm4');
                    load(fullfile(outDir,sprintf('%s_tasks_allMotor_sc1_sc2.mat',thresh)))
                end
            case 'cereb'
                outDir=fullfile(caretDir,'suit_flat','glm4');
                load(fullfile(outDir,'FDRCorr_tasks_allMotor_sc1_sc2.mat'))
        end
        
        M=caret_struct('metric','data',S.indices');
        M.column_name={'lHand','rHand','saccades'};
        
        caret_save(fullfile(caretDir,'suit_flat','glm4','FDRCorr_motor_features_sc1_sc2.metric'),M);
        %         switch motor
        %             case 'hands'
        %                 taskN=[1,2];
        %             case 'saccades'
        %                 taskN=[3];
        %             case 'all'
        %                 taskN=[1:3];
        %         end
        
        %
        %         % threshold activation maps
        %         for f=1:numel(taskN),
        %             motorF=S.indices(taskN(f),:);
        %             motorF(motorF<=6)=nan; % threshold
        %             motorFeat(f,:)=motorF;
        %         end
        %         % make composite map
        %         for p=1:size(motorFeat,2),
        %             A=sort(motorFeat(:,p),'ascend');
        %             R=A(1);
        %             I=find(motorFeat(:,p)==R);
        %             if isempty(I) || length(I)>1,
        %                 I=0;
        %             end
        %             groupFeat(p,:)=I;
        %         end
        %         % save output as metric or paint
        %         groupFeat(groupFeat==0)=nan;
        %         cmap=load(fullfile(encodeDir,'handKnob_cerebellum.txt'));
        %         suit_plotflatmap(groupFeat,'type','label','cmap',cmap(taskN,2:end)/255)
        
    case 'process_pattern'
    case 'all162act'
        sn=varargin{1};
        numTasks=32;
        
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
        
        numTasks=32;
        subjs=length(sn);
        
        condNum = [kron(ones(numel(run),1),[1:numTasks]');ones(numel(run),1)*numTasks+1];
        partNum = [kron([1:numel(run)]',ones(numTasks,1));[1:numel(run)]'];
        for s=1:subjs,
            encodeSubjDir=fullfile(encodeDir,'glm4',subj_name{sn(s)});
            load(fullfile(encodeSubjDir,'Y_info_glm4_grey_nan.mat'))
            Yy{s}=Y.data;
            fprintf('subj%d done \n',sn(s))
        end
        save(fullfile(encodeDir,'glm4','cerebellum_allVoxels.mat'),'Yy','condNum','partNum');
    case 'allCortex'
        sn=varargin{1};
        
        numTasks=32;
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
        a=D.studyNum==2 & D.overlap==0; % unique to sc2
        taskIdx=[repmat(a(D.studyNum==2),numel(run),1);zeros(numel(run),1)];
        condNum=condNum.*taskIdx;
        sessNum=[kron([1:2],ones(1,(length(condNum)-numel(run))/2))';kron([1:2],ones(1,numel(run)/2))'];
        
        numSubj=length(sn);
        for se=1:2
            indx = find(sessNum==se);
            X=indicatorMatrix('identity',condNum(indx,:));
            for subj = 1:numSubj
                Yp(:,:,subj+(se-1)*numSubj)=X*pinv(X)*Y{subj}(indx,:);
                Yf(:,:,subj+(se-1)*numSubj)=Y{subj}(indx,:);
            end;
        end;
        Cp=intersubj_corr(Yp);    % means
        Cf=intersubj_corr(Yf);    % betas
        Cr=intersubj_corr(Yf-Yp); % resiudals
        
        save(fullfile(regDir,'glm4',sprintf('pattern_reliability_%s_unique.mat',type)),'Cp','Cf','Cr');
    case 'pattern_consistency_overlap'
        sn=varargin{1};
        type=varargin{2}; % 'cortex' or 'cerebellum'
        
        switch type,
            case 'cortex'
                for sess=1:2,
                    load(fullfile(encodeDir,'glm4','162_tesselation_hem_all.mat'));
                    if sess==1,
                        tmp=Yy;
                    else
                        tmp1=Yy;
                    end
                end
                for s=1:length(returnSubjs),
                    Y(:,:,s)=[tmp{returnSubjs(s)-1};tmp1{s}];
                end
            case 'cerebellum'
                for sess=1:2,
                    if sess==1,
                        encodeDir=fullfile(baseDirSc1,'encoding');
                    else
                        encodeDir=fullfile(baseDir,'encoding');
                    end
                    load(fullfile(encodeDir,'glm4','cerebellum_allVoxels.mat'));
                    if sess==1,
                        condNum1=condNum;
                        tmp=Yy;
                    else
                        tmp1=Yy;
                    end
                end
                for s=1:length(returnSubjs),
                    Y(:,:,s)=[tmp{returnSubjs(s)-1};tmp1{s}];
                end
                condNum=[condNum1;condNum];
        end
        
        D=dload(fullfile(baseDir,'sc1_sc2_taskConds_revised.txt'));
        
        % overlapping tasks
        a=D.overlap==1 & D.condNum~=1;
        taskIdx=[];
        sessNum=[];
        for d=1:2,
            idx=[repmat(a(D.studyNum==d),numel(run),1);zeros(numel(run),1)];
            sessN=kron(d,ones(1,length(idx))');
            taskIdx=[taskIdx;idx];
            sessNum=[sessNum;sessN];
        end
        condNum=condNum.*taskIdx;
        taskNum=unique(condNum(condNum~=0));
        
        numSubj=length(sn);
        for t=1:length(taskNum),
            for se=1:2
                indx = find(sessNum==se & condNum==taskNum(t));
                X=indicatorMatrix('identity',condNum(indx,:));
                for subj = 1:numSubj
                    Yp(:,:,subj+(se-1)*numSubj,t)=X*pinv(X)*Y(indx,:,subj);
                    Yf(:,:,subj+(se-1)*numSubj,t)=Y(indx,:,subj);
                end;
            end;
        end
        % get average across tasks
        Yp=nanmean(Yp,4);
        Yf=nanmean(Yf,4);
        
        % get correlations
        Cp=intersubj_corr(Yp);
        Cf=intersubj_corr(Yf);
        Cr=intersubj_corr(Yf-Yp);
        
        save(fullfile(regDir,'glm4',sprintf('pattern_reliability_%s_overlap.mat',type)),'Cp','Cf','Cr');
    case 'pattern_consistency_tasks'
        sn=varargin{1};
        type=varargin{2}; % 'cortex' or 'cerebellum'
        step=varargin{3}; % 'sc1', 'sc2' ,'overlap'
        
        for st=1:numel(step), % loop over 'sc1', 'sc2' and 'overlap'
            stepType=step{st};
            
            switch type,
                case 'cortex'
                    for sess=1:2,
                        load(fullfile(encodeDir,'glm4','162_tesselation_hem_all.mat'));
                        if sess==1,
                            tmp=Yy;
                        else
                            tmp1=Yy;
                        end
                    end
                    for s=1:length(returnSubjs),
                        Y(:,:,s)=[tmp{returnSubjs(s)-1};tmp1{s}];
                    end
                case 'cerebellum'
                    for sess=1:2,
                        if sess==1,
                            encodeDir=fullfile(baseDirSc1,'encoding');
                        else
                            encodeDir=fullfile(baseDir,'encoding');
                        end
                        load(fullfile(encodeDir,'glm4','cerebellum_allVoxels.mat'));
                        if sess==1,
                            condNum1=condNum;
                            tmp=Yy;
                        else
                            condNum2=condNum;
                            tmp1=Yy;
                        end
                    end
                    for s=1:length(returnSubjs),
                        Y(:,:,s)=[tmp{returnSubjs(s)-1};tmp1{s}];
                    end
                    condNum=[condNum1;condNum2];
            end
            
            D=dload(fullfile(baseDir,'sc1_sc2_taskConds_revised.txt'));
            
            switch stepType,
                case 'sc1'
                    a=D.studyNum==1 & D.overlap==0; % unique to sc1
                    taskIdx=[repmat(a(D.studyNum==1),numel(run),1);zeros(numel(run),1)];
                    condNum=condNum1;
                    taskConds{st}=D.condNames(D.studyNum==1 & D.condNum~=1 & D.overlap==0);
                    sessNum=[kron([1:2],ones(1,(length(condNum)-numel(run))/2))';kron([1:2],ones(1,numel(run)/2))'];
                case 'sc2'
                    a=D.studyNum==2 & D.overlap==0; % unique to sc2
                    taskIdx=[repmat(a(D.studyNum==2),numel(run),1);zeros(numel(run),1)];
                    condNum=condNum2;
                    taskConds{st}=D.condNames(D.studyNum==2 & D.condNum~=1 & D.overlap==0);
                    sessNum=[kron([1:2],ones(1,(length(condNum)-numel(run))/2))';kron([1:2],ones(1,numel(run)/2))'];
                case 'overlap'
                    a=D.overlap==1 & D.condNum~=1;  % shared across sc1 & sc2
                    taskIdx=[];
                    sessNum=[];
                    for d=1:2,
                        idx=[repmat(a(D.studyNum==d),numel(run),1);zeros(numel(run),1)];
                        sessN=kron(d,ones(1,length(idx))');
                        taskIdx=[taskIdx;idx];
                        sessNum=[sessNum;sessN];
                    end
                    taskConds{st}=D.condNames(D.label~=0 & D.studyNum==1);
            end
            
            condNum=condNum.*taskIdx;
            taskNum=unique(condNum(condNum~=0));
            
            numSubj=length(sn);
            for t=1:length(taskNum), % loop over tasks
                for se=1:2
                    indx = find(sessNum==se & condNum==taskNum(t));
                    X=indicatorMatrix('identity',condNum(indx,:));
                    for subj = 1:numSubj
                        Yp(:,:,subj+(se-1)*numSubj,t)=X*pinv(X)*Y(indx,:,subj);
                    end;
                end;
            end
            fprintf('task reliability computed for %s \n',stepType);
            
            % get reliability for each task
            for tt=1:size(Yp,4),
                Cp{st}(:,:,tt)=intersubj_corr(Yp(:,:,:,tt));
            end
            clear Yp
        end
        
        save(fullfile(regDir,'glm4',sprintf('pattern_reliability_%s_tasks.mat',type)),'Cp','taskConds');
    case 'visualise_reliability'
        type=varargin{1}; % 'cortex' or 'cerebellum'
        step=varargin{2}; % 'unique' or 'overlap' or 'tasks' or 'all'
        
        load(fullfile(regDir,'glm4',sprintf('pattern_reliability_%s_%s.mat',type,step)))
        
        % means
        [T.a1,T.a2,T.a3]=bwse_corr(Cp);
        T.type={'means'};
        T.typeNum=1;
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
        
        figure(); barplot([T.typeNum],[T.a2 T.a1],'leg',{'Between-Subject Reliability','Within-Subject Reliability'},'style_rainbow') % [T.a2 T.a1]
    case 'visualise_reliability_all'
        type=varargin{1}; % 'cortex' or 'cerebellum'
        
        % load sc1
        regDir=fullfile(baseDirSc1,'RegionOfInterest');
        load(fullfile(regDir,'glm4',sprintf('pattern_reliability_%s_%s.mat',type,'unique')))
        [T.a1,T.a2,T.a3]=bwse_corr(Cp);
        T.type={'means'};
        T.typeNum=1;
        T.studyNum=1;
        
        % load sc2
        regDir=fullfile(baseDir,'RegionOfInterest');
        load(fullfile(regDir,'glm4',sprintf('pattern_reliability_%s_%s.mat',type,'unique')))
        [V.a1,V.a2,V.a3]=bwse_corr(Cp);
        V.type={'means'};
        V.typeNum=1;
        V.studyNum=2;
        T=addstruct(T,V);
        
        % load overlap
        regDir=fullfile(baseDir,'RegionOfInterest');
        load(fullfile(regDir,'glm4',sprintf('pattern_reliability_%s_%s.mat',type,'overlap')))
        [S.a1,S.a2,S.a3]=bwse_corr(Cp);
        S.type={'means'};
        S.typeNum=1;
        S.studyNum=3; % overlap
        T=addstruct(T,S);
        
        figure(); barplot([T.studyNum],[T.a2 T.a1],'leg',{'Within-Subject Reliability','Between-Subject Reliability'},'style_rainbow') % [T.a2 T.a1]
    case 'table_task_reliability'
        type=varargin{1}; % 'cortex' or 'cerebellum'
        
        load(fullfile(regDir,'glm4',sprintf('pattern_reliability_%s_tasks.mat',type)))
        numTables=length(Cp);
        
        % get inter-sess and inter-subj reliability
        for n=1:numTables,
            for t=1:size(Cp{n},3),
                [a1(t),a2(t),~]=bwse_corr(Cp{n}(:,:,t));
            end
            R.data=[a2;a1]';
            R.taskNames=taskConds{n};
            table(R.taskNames,R.data)
            clear a1 a2
        end
        
    case 'process_distance'
    case 'PLOTTING:ROI_dist' % Computes RDM for sc1 or sc2
        sn=varargin{1};
        study=varargin{2}; % 'sc1' or 'sc2'
        types=varargin{3}; % {'cortex_grey','cerebellum_grey'}
        reg=varargin{4}; % which region of the cortex (lh or rh) or cortical_lobes (1,2,3,4) or cerebellar lobules (1-10)?
        step=varargin{5}; % RDM, corr, inter-subj, sum
        
        subjs=length(sn);
        F=dload('sc1_sc2_taskConds.txt');
        
        switch study
            case 'sc1'
                regionDir=fullfile(baseDirSc1,'RegionOfInterest');
                condNamesNoInstruct=F.condNames(F.StudyNum==1);
            case 'sc2'
                regionDir=regDir;
                condNamesNoInstruct=F.condNames(F.StudyNum==2);
        end
        
        numDist=length(condNamesNoInstruct)-1;
        
        for s=1:subjs,
            idx=1;
            for i=1:numel(types),
                for r=1:numel(reg{i}),
                    load(fullfile(regionDir,'glm4',subj_name{sn(s)},sprintf('Ttasks_%s.mat',types{i})));
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
        if subjs>1,
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
                    title(sprintf('%s-%s',subjTitle,char(regName{r})));
                end
            case 'RDM_thresh'
                for r=1:numel(regName),
                    vecRDM=reshape(vecRDM,[size(vecRDM,2),size(vecRDM,3)]);
                    for dd=1:size(vecRDM,1),
                        [t(dd),p(dd)]=ttest(vecRDM(dd,:),[],1,'onesample');
                    end
                    t(p>.01)=0;
                    % sort according to dendrogram
                    vecRDM=nanmean(vecRDM,2);
                    [Y,~] = rsa_classicalMDS(vecRDM','mode','RDM');
                    clustTree = linkage(Y,'average');
                    indx = cluster(clustTree,'cutoff',1);
                    condNums=[1:32]';
                    reOrder=[];
                    for i=1:11,
                        s=condNums(indx==i);
                        reOrder=[reOrder;s];
                    end
                    reOrder=[2,3,4,21,22,23,24,25,26,27,28,16,9,18,17,10,19,20,12,29,5,15,1,6,7,8,11,13,14,30,31,32]';
                    squareT=squareform(t);
                    figure();imagesc_rectangle(squareT(reOrder,reOrder),'YDir','reverse')
                    caxis([0 1])
                    ylabel('');
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
                    condNums=[1:32]';
                    reOrder=[];
                    for i=1:11,
                        s=condNums(indx==i);
                        reOrder=[reOrder;s];
                    end
                    reOrder=[2,3,4,21,22,23,24,25,26,27,28,16,9,18,17,10,19,20,12,29,5,15,1,6,7,8,11,13,14,30,31,32]';
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
                t=set(gca,'Ytick','','YTickLabel',regName,'FontSize',24,'FontWeight','bold');
                t.Color='white';
            case 'subj_corr'
                X=nanmean(vecRDM,1);
                X=reshape(X,size(X,2),size(X,3));
                [C,P]=corr(ssqrt(X));
                imagesc_rectangle(C,'YDir','reverse');
                caxis([0 1]);
                t=set(gca,'Ytick', 1:subjs,'YTickLabel',subj_name(sn),'FontSize',12,'FontWeight','bold');
                t.Color='white';
                %                 title(regName)
                colorbar;
                % disp average corr
                fprintf('average cross-subj corr is %2.2f \n',nanmean(rsa.rdm.vectorizeRDM(C)))
                varargout={C};
            case 'sum'
                X=nanmean(fullRDM,4);
                scatterplot(sum(X(:,:,1))',sum(X(:,:,2))','markerfill',[0 0 0],'label',condNamesNoInstruct)
                %                 scatterplot(sum(X(:,:,1))',sum(X(:,:,2))','markerfill',[0 0 0],'label',[1:numDist+1])
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
    case 'PLOTTING:clusterMDS' % Does MDS modelling for sc1 or sc2
        % example: sc2_imana('clusterMDS',[2],'sc1','cerebellum_grey',1,'none')
        sn=varargin{1};
        study=varargin{2}; % 'sc1' or 'sc2'
        type=varargin{3}; % dentate, cerebellum
        reg=varargin{4}; % 1,2,3 etc or 'all'
        removeMotor=varargin{5}; % 'saccades', 'hands','all','none'
        
        D=dload('sc1_sc2_taskConds.txt');
        
        switch study
            case 'sc1'
                regionDir=fullfile(baseDirSc1,'RegionOfInterest');
                condNamesNoInstruct=D.condNames(D.StudyNum==1);
            case 'sc2'
                regionDir=regDir;
                condNamesNoInstruct=D.condNames(D.StudyNum==2);
        end
        
        numTasks=length(condNamesNoInstruct)-1;
        
        subjs=length(sn);
        A=[];
        for s=1:subjs,
            % load statistics for subject(s) and GLM(s)
            load(fullfile(regionDir,'glm4',subj_name{sn(s)},sprintf('Ttasks_%s.mat',type)));
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
        F=sc2_imana('make_feature_model',study);
        F=getrow(F,[2:numTasks+2]'); % remove instructions
        
        % Make RDM including rest from the IPM
        IPM = mean(T.IPM);
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
        
        X   = bsxfun(@minus,X,mean(X));
        X   = bsxfun(@rdivide,X,sqrt(sum(X.^2)));  % Normalize to unit length vectors
        
        % Reduced Y
        [Y,~] = rsa_classicalMDS(vecRDM,'mode','RDM');
        B = (X'*X+eye(size(X,2))*0.0001)\(X'*Y); % ridge regression
        Yr    = Y  - X(:,1:3)*B(1:3,:); % remove motor features
        clustTree = linkage(Yr,'average');
        indx = cluster(clustTree,'cutoff',1);
        numClusters=length(unique(indx));
        
        colour={[1 0 0],[0 1 0],[0 0 1],[0.3 0.3 0.3],[1 0 1],[1 1 0],[0 1 1],[0.5 0 0.5],[0.8 0.8 0.8],[.07 .48 .84],[.99 .76 .21],[.11 .7 .68],[.39 .74 .52],[.21 .21 .62],[0.2 0.2 0.2],[.6 .6 .6]};
        CAT.markercolor= {colour{indx}};
        CAT.markerfill = {colour{indx}};
        CAT.labelcolor  = {colour{indx}};
        CAT.markertype='o';
        CAT.markersize=10;
        CAT.labelfont=12;
        [V,L]   = eig(Yr*Yr');
        [l,i]   = sort(diag(L),1,'descend');           % Sort the eigenvalues
        V       = V(:,i);
        X       = bsxfun(@times,V,sqrt(l'));
        X = real(X);
        
        figure
        scatterplot3(X(:,1),X(:,2),X(:,3),'split',tasks,'CAT',CAT,'label',condNamesNoInstruct');
        %         scatterplot3(X(:,1),X(:,2),X(:,3),'split',tasks,'CAT',CAT);
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
        %         wysiwyg;
        view([81 9]);
    case 'ROI_stats_sc1_sc2'
        sn=varargin{1};
        type=varargin{2}; % 'cortex' or 'cerebellum'
        step=varargin{3}; % 1- 1 IPM (sc1+sc2); 2 - 4 sIPM's (sc1+sc2)
        
        subjs=length(sn);
        
        % prep inputs for PCM modelling functions
        for s=1:subjs,
            V=[];
            for study=1:2,
                if study==1,
                    baseDir=baseDirSc1;
                else
                    baseDir='/Users/mking/Documents/Cerebellum_Cognition/sc2';
                end
                T = load(fullfile(baseDir,'encoding','glm4',sprintf('%s_allVoxels.mat',type))); % region stats (T)
                D = load(fullfile(baseDir,'GLM_firstlevel_4', subj_name{sn(s)}, 'SPM_info.mat'));   % load subject's trial structure
                betaW              = T.Yy{s};
                % get subject's partitions and second moment matrix
                N                  = length(D.run);
                numConds(study)     = length(D.cond(D.cond~=1))/numel(run); % remove instruct
                betaW              = betaW(1:N,:);
                betaW              = [betaW(D.cond~=1,:);zeros(numel(run),size(betaW,2))]; % remove instruct & add rest
                B.partVec          = [D.run(D.cond~=1);[1:numel(run)]'];   % remove instruct & add rest
                B.sessNum          = [D.sess(D.cond~=1);kron([1:2],ones(1,numel(run)/2))'];   % remove instruct & add rest
                % subtract block mean from run
                I = indicatorMatrix('identity',B.partVec);
                R  = eye(N)-I*pinv(I);
                B.Y = R*betaW;            % Subtract block mean
                if study==1,
                    B.condVec      = [repmat([1:numConds(study)],1,numel(run))';repmat(numConds(study)+1,numel(run),1)];  % remove instruct % add rest
                else
                    B.condVec      = [repmat([numConds(2)-1:numConds(1)+numConds(2)+1],1,numel(run))';repmat(numConds(1)+numConds(2)+2,numel(run),1)];
                end
                B.studyNum         = repmat(study,size(betaW,1),1);
                V=addstruct(V,B);
                clear B
            end
            
            % Overall IPM or 4-session IPM's
            if step==1,
                G_hat(:,:,s)    = pcm_estGCrossval(V.Y,V.partVec,V.condVec);  % get IPM
            else
                for study=1:2,
                    for sess=1:2,
                        sessStudyIdx=V.studyNum==study & V.sessNum==sess;
                        if study==1,
                            G_hat_sc1(:,:,sess,s)=pcm_estGCrossval(V.Y(sessStudyIdx,:),V.partVec(sessStudyIdx),V.condVec(sessStudyIdx));
                        else
                            G_hat_sc2(:,:,sess,s)=pcm_estGCrossval(V.Y(sessStudyIdx,:),V.partVec(sessStudyIdx),V.condVec(sessStudyIdx));
                        end
                    end
                end
            end
            
            fprintf('IPM calculated for subj%d \n',sn(s));
            clear Y partVec condVec
        end
        % Save overall IPM or 4-session IPM's
        if step==1,
            save(fullfile(regDir,'glm4',sprintf('G_hat_sc1_sc2_%s.mat',type)),'G_hat');
        else
            save(fullfile(regDir,'glm4',sprintf('G_hat_sc1_sc2_sess_%s.mat',type)),'G_hat_sc1','G_hat_sc2');
        end
    case 'RDM_MDS_sc1_sc2'
        type=varargin{1}; % 'cortex' or 'cerebellum'
        removeMotor=varargin{2}; % 'saccades', 'hands','all','none'
        
        load(fullfile(regDir,'glm4',sprintf('G_hat_sc1_sc2_%s.mat',type)))
        subjs=size(G_hat,3);
        numDist=size(G_hat,1);
        
        reOrderAll={[1:29],...
            [30:61]};
        
        % Get RDM
        for s=1:subjs,
            H=eye(numDist)-ones(numDist)/numDist; % centering matrix
            G_hat(:,:,s)=H*G_hat(:,:,s)*H'; % subtract out mean pattern
            IPM=rsa_vectorizeIPM(G_hat(:,:,s));
            con = indicatorMatrix('allpairs',[1:numDist]);
            N = rsa_squareIPM(IPM);
            D = rsa.rdm.squareRDM(diag(con*N*con'));
            fullRDM(:,:,s) = D;
        end
        
        % load feature matrix
        F=sc2_imana('make_feature_model','both');
        
        switch removeMotor,
            case 'hands'
                X   = [F.lHand./F.duration F.rHand./F.duration];
                X   = [X eye(numDist)];
            case 'saccades'
                X   = [F.saccades./F.duration];
                X   = [X eye(numDist)];
            case 'all'
                X   = [F.lHand./F.duration F.rHand./F.duration F.saccades./F.duration];
                X   = [X eye(numDist)];
            case 'none'
                X   = [eye(numDist)];
        end
        
        X   = bsxfun(@minus,X,mean(X));
        X   = bsxfun(@rdivide,X,sqrt(sum(X.^2)));  % Normalize to unit length vectors
        
        % Plot RDMr
        reOrder=[1,2,6,7,8,9,10,11,12,13,14,17,18,22,23,3,4,5,15,16,19,20,21,24,25,26,...
            27,28,29,58,59,60,43,44,49,48,36,34,35,55,56,57,61,30,31,32,33,37,38,39,40,41,42,45,46,47,50,51,52,53,54]'; % reorder
        figure()
        avrgFullRDM=ssqrt(nanmean(fullRDM,3));
        numDist=size(avrgFullRDM,1);
        imagesc_rectangle(avrgFullRDM(reOrder,reOrder),'YDir','reverse');
        caxis([0 1]);
        t=set(gca,'Ytick',[1:numDist]','YTickLabel',condNamesSc1Sc2(reOrder)','FontSize',12,'FontWeight','bold');
        t.Color='white';
        colorbar
        
        % MDS
        %         vecRDM = rsa.rdm.vectorizeRDM(avrgFullRDM);
        %         [Y,~] = rsa_classicalMDS(vecRDM,'mode','RDM');
        %         B = (X'*X+eye(size(X,2))*0.0001)\(X'*Y); % ridge regression
        %         Yr    = Y  - X(:,1:3)*B(1:3,:); % remove motor features
        %
        %         clustTree = linkage(Yr,'average');
        %         indx = cluster(clustTree,'cutoff',1);
        %
        %         % define cluster colour
        %         numClusters=length(unique(indx));
        %         colour={[1 0 0],[0 1 0],[0 0 1],[0.3 0.3 0.3],[1 0 1],[1 1 0],[0 1 1],[0.5 0 0.5],[0.8 0.8 0.8],[.07 .48 .84],[.99 .76 .21],[.11 .7 .68],[.39 .74 .52],[.21 .21 .62],[0.2 0.2 0.2],[.6 .6 .6],[.3 0 .8],[.8 0 .4],[0 .9 .2],[.1 .3 0],[.2 .4 0],[.63 0 .25],[0 .43 .21],[.4 0 .8]};
        %         CAT.markercolor= {colour{indx}};
        %         CAT.markerfill = {colour{indx}};
        %         CAT.markersize = 10;
        %         [V,L]   = eig(Yr*Yr');
        %         [l,i]   = sort(diag(L),1,'descend');           % Sort the eigenvalues
        %         V       = V(:,i);
        %         X       = bsxfun(@times,V,sqrt(l'));
        %         X = real(X);
        %
        %         for study=1:2,
        %
        %             X1=X(reOrderAll{study},reOrderAll{study});
        %
        %             figure()
        %             scatterplot3(X1(:,1),X1(:,2),X1(:,3),'split',reOrderAll{study}','CAT',CAT,'label',condNamesSc1Sc2(reOrderAll{study})','markertype','o');
        %             set(gca,'XTickLabel',[],'YTickLabel',[],'ZTickLabel',[],'Box','on');
        %             hold on;
        %             plot3(0,0,0,'+');
        %             % Draw connecting lines
        %             %             for i=1:15,
        %             %                 ind=clustTree(i,1:2);
        %             %                 X(end+1,:)=(X(ind(1),:)+X(ind(2),:))/2;
        %             %                 line(X(ind,1),X(ind,2),X(ind,3));
        %             %             end;
        %             hold off;
        %             set(gcf,'PaperPosition',[2 2 8 8]);
        %             axis equal;
        %             set(gca,'XTickLabel',[],'YTickLabel',[],'ZTickLabel',[],'Box','on');
        %             wysiwyg;
        %             view([81 9]);
        %             clear X1
        %
        %         end
    case 'reliability_sc1_sc2'
        load(fullfile(regDir,'glm4','G_hat_sc1_sc2_sess_cerebellum.mat'));
        D=dload('sc1_sc2_taskConds.txt');
        D1=getrow(D,D.StudyNum==1);
        D2=getrow(D,D.StudyNum==2);
        
        % Look at the shared conditions only
        i1 = find(D1.overlap==1);
        i2 = find(D2.overlap==1);
        [~,b] = sort(D2.condNumUni(i2));     % Bring the indices for sc2 into the right order.
        i2=i2(b);
        numCond = length(i1);
        numSubj = size(G_hat_sc1,4);
        numSess = 2;
        
        C=indicatorMatrix('allpairs',[1:numCond]);
        for i=1:numSubj
            for j=1:numSess
                dist(:,j  ,i)  = ssqrt(diag(C*G_hat_sc1(i1,i1,j,i)*C'));
                dist(:,j+2,i)  = ssqrt(diag(C*G_hat_sc2(i2,i2,j,i)*C'));
            end;
            CORR(:,:,i)    = corr(dist(:,:,i));
            T.SN(i,1)      = i;
            T.within1(i,1) = CORR(1,2,i);
            T.within2(i,1) = CORR(3,4,i);
            T.across(i,1)  = mean(mean(CORR(1:2,3:4,i)));
        end;
        
        % within & between-subj reliability
        myboxplot([],[T.within1 T.within2 T.across],'style_tukey');
        set(gca,'XTickLabel',{'SC1','SC2','across'});
        set(gcf,'PaperPosition',[2 2 4 3]);
        wysiwyg;
        ttest(sqrt(T.within1.*T.within2),T.across,2,'paired');
        
        % group reliability
        X=nanmean(dist,3);
        groupCorr=corr(X);
        fprintf('group reliability for study1 is %2.2f \n',groupCorr(1,2));
        fprintf('group reliability for study2 is %2.2f \n',groupCorr(3,4));
        fprintf('group reliability for shared tasks is %2.2f \n',mean(mean(groupCorr(1:2,3:4))));
        varargout={T};
        
    case 'process_pcm'
        type={'cortex'}; % 'cerebellum'
        for t=1:2,
            sc2_imana('pcm_prepData',type{t})
            sc2_imana('pcm_makeModel',type{t})
            sc2_imana('pcm_group',type{t})
            sc2_imana('pcm_individ',type{t})
        end
    case 'pcm_prepData'
        type=varargin{1}; % 'cortex' or 'cerebellum'
        
        T = load(fullfile(encodeDir,'glm4',sprintf('%s_allVoxels.mat',type))); % region stats (T)
        subjs=length(returnSubjs);
        
        % prep inputs for PCM modelling functions
        for s=1:subjs,
            betaW           = T.Yy{s};
            % get subject's partitions and second moment matrix
            D               = load(fullfile(baseDir,'GLM_firstlevel_4', subj_name{returnSubjs(s)}, 'SPM_info.mat'));   % load subject's trial structure
            N               = length(D.run);
            numConds        = length(D.cond(D.cond~=1))/numel(run); % remove instruct
            betaW           = betaW(1:N,:);
            betaW           = betaW(D.cond~=1,:); % remove instruct
            partVec{s}      = D.run(D.cond~=1);   % remove instruct
            condVec{s}      = repmat([1:numConds],1,numel(run))';  % remove instruct
            Y{s}            = betaW;
            G_hat(:,:,s)    = pcm_estGCrossval(Y{s},partVec{s},condVec{s});
        end
        fprintf('Y data prepared for %s \n',type)
        
        save(fullfile(regDir,'glm4',sprintf('pcm_data_%s.mat',type)),'Y','condVec','partVec','G_hat','-v7.3');
    case 'pcm_makeModel'
        type=varargin{1}; % 'cortex' or 'cerebellum'
        
        numConds=31; % exclude rest and instructions
        
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
        %
        % set up feature model
        F=importdata(fullfile(baseDir,'sc2_featureModel.xlsx'));
        F1.feat=F.data';F1.colheaders=F.colheaders';
        F1.feat=F1.feat(:,1:numConds); % remove rest as condition
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
        motorFeat=zscore([allFeat(:,1:3),eye(numConds)]); % normalise
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
            title(sprintf('sc2:%s',type))
        else
            load(fullfile(regDir,'glm4',sprintf('pcm_indivFitModels_%s.mat',type)))
            figure();T=pcm_plotModelLikelihood(T_indiv,M,'subj',2,'normalize',0); % provide noise ceiling
            title(sprintf('sc2:%s',type))
        end
        varargout={T};
    case 'PLOTTING:features'
        model=varargin{1}; % 1,2,3,4,5,6
        
        type={'cortex','cerebellum'};
        
        T=[];
        
        % get feature names
        load(fullfile(regDir,'glm4','pcm_model_cortex.mat'))
        featNames=M{model}.featNames;
        
        for s=1:2,
            if s==1,
                regDir=fullfile(baseDirSc1,'RegionOfInterest');
            else
                regDir=[baseDir '/RegionOfInterest/'];
            end
            for t=1:numel(type),
                load(fullfile(regDir,'glm4',sprintf('pcm_indivFitModels_%s.mat',type{t})))
                numFeat=size(theta_indiv{model},1)-2;
                S.theta=theta_indiv{model}(1:numFeat,:).^2;
                S.type=repmat({type{t}},numFeat,1);
                S.typeNum=repmat(t,numFeat,1);
                S.studyNum=repmat(s,numFeat,1);
                T=addstruct(T,S);
            end
        end
        
        % cortex against cerebellum
        for s=1:2,
            figure()
            scatterplot(nanmean(T.theta(T.typeNum==1 & T.studyNum==s,:),2),nanmean(T.theta(T.typeNum==2 & T.studyNum==s,:),2),'label',[1:numFeat],'regression','linear','intercept',0,'markersize',10,'markerfill',[0 0 0])
            xlabel(unique(T.type(T.typeNum==1)));ylabel(unique(T.type(T.typeNum==2)));
            title(sprintf('study%d',s))
        end
        
        % plot sc1 against sc2 (for cortex and cerebellum)
        for t=1:2,
            figure()
            scatterplot(nanmean(T.theta(T.typeNum==t & T.studyNum==1,:),2),nanmean(T.theta(T.typeNum==t & T.studyNum==2,:),2),'label',[1:numFeat],'regression','linear','intercept',0,'markersize',10,'markerfill',[0 0 0])
            xlabel('study1');ylabel('study2');
            title(unique(T.type(T.typeNum==t)));
        end
        disp(featNames')
    case 'PLOTTING:MDS'
        type=varargin{1};
        model=varargin{2}; % 1,2,3,4,5,6
        
        % load predicted G (under different models)
        load(fullfile(regDir,'glm4',sprintf('pcm_crossValModels_%s.mat',type)))
        
        % load model
        load(fullfile(regDir,'glm4',sprintf('pcm_model_%s.mat',type)))
        numConds=size(M{model}.Ac,1);
        numFeat=M{model}.numGparams;
        
        % define contrast based on feature
        %         C=M{model}.Ac(:,1,1); % first feature
        %         [COORD,EV]=pcm_classicalMDS(nanmean(G_predCr{model},3),'contrast',C);
        [COORD,EV]=pcm_classicalMDS(nanmean(G_predCr{model},3));
        lineplot([1:numConds]',COORD(:,1));
        disp(condNames(1:end-1)');
        
        scatterplot3(COORD(:,1),COORD(:,2),COORD(:,3),'label',condNames(1:end-1),'leg','auto');
        
    case 'process_ICA'
    case 'get_avrgDataStruct_sc1_sc2'
        sn=varargin{1};
        type=varargin{2}; % 'cortex' or 'cereb'
        hemN=varargin{3}; % [1:2] or [1]
        
        subjs=length(sn);
        
        for h=hemN,
            switch type,
                case 'cortex'
                    inFile=sprintf('%s_%s_avrgDataStruct.mat',type,hem{h});
                    outName=sprintf('%s_%s_avrgDataStruct_sc1_sc2.mat',type,hem{h});
                case 'cereb'
                    inFile=sprintf('%s_avrgDataStruct.mat',type);
                    outName=sprintf('%s_avrgDataStruct_sc1_sc2.mat',type);
            end
            for sess=1:2,
                if sess==1,
                    encodeDir=fullfile(baseDirSc1,'encoding');
                else
                    encodeDir=fullfile(baseDir,'encoding');
                end
                load(fullfile(encodeDir,'glm4',inFile));
                for s=1:subjs,
                    indx=T.SN==sn(s);
                    UFull=T.data(indx,:);
                    [numConds,numVox]=size(UFull);
                    numConds=numConds/2;
                    % get average across sessions
                    for c=1:numConds,
                        tmp(c,:,s)=nanmean(UFull([c,c+numConds],:),1);
                    end
                end
                if sess==1,
                    tmp1=tmp;
                    condNames1=T.TN(1:numConds);
                end
            end
            allCondNames=vertcat(condNames1,T.TN(1:numConds));
            Y=[tmp1;tmp];
            % save out struct
            if strcmp(type,'cereb'),
                save(fullfile(encodeDir,'glm4',outName),'Y','volIndx','V','allCondNames');
            else
                save(fullfile(encodeDir,'glm4',outName),'Y','allCondNames');
            end
            clear UFull tmp tmp1 Y
        end
    case 'func_parcellation_ICA'
        % load data (both sc1 & sc2)
        load(fullfile(encodeDir,'glm4','cereb_avrgDataStruct_sc1_sc2.mat'));
        
        % get group
        U=nanmean(Y,3);
        
        % center the data
        [X_C, ~]=remmean(U);
        
        % calculate the pca for data
        [E,D] = pcamat(U,1,2,'on','on');
        
        % prewhiten the data
        whiteningMatrix = inv(sqrt (D)) * E';
        dewhiteningMatrix = E * sqrt (D);
        X_PW =  whiteningMatrix * X_C;
        
        % run ICA faster on centered data
        [S_PW,A_PW,W_PW] = fastica(X_C,'pcaE',E,'pcaD',D,'whiteSig',X_PW,'whiteMat',whiteningMatrix,'dewhiteMat',dewhiteningMatrix);
        
        save(fullfile(regDir,'glm4','ICA_comps_cerebellum.mat'),'S_PW','A_PW','W_PW','X_PW','whiteningMatrix','dewhiteningMatrix','volIndx','V');
    case 'project_ICA_cereb'
        load(fullfile(regDir,'glm4','ICA_comps_cerebellum.mat'));
        
        numFeat=size(S_PW,1);
        removeFeats=[1,2,6,12,8];
        
        % get pos and neg comps
        for p=1:size(S_PW,2),
            signIdx=find(S_PW(:,p)>0);
            pwS=abs(S_PW(:,p));
            [~,i]=sort(pwS,'descend');
            % sort 'winner' into pos or neg group
            if find(signIdx==i(1)),
                groupFeat(p,:)=i(1);
            else
                groupFeat(p,:)=i(1)+numFeat;
            end
            % reassign some ICs
            if find(removeFeats==groupFeat(p,:)),
                if groupFeat(p,:)>numFeat,
                    groupFeat(p,:)=groupFeat(p,:)-numFeat;
                else
                    groupFeat(p,:)=groupFeat(p,:)+numFeat;
                end
            end
        end
        
        % rename data points
        featNum=unique(groupFeat);
        newFeat=[1:length(featNum)];
        for ff=1:length(featNum),
            groupFeat(groupFeat==featNum(ff))=newFeat(ff);
        end
        
        for f=1:length(featNum),
            if featNum(f)>numFeat,
                featNames(f)={sprintf('ICA%d:neg',featNum(f)-numFeat)};
            else
                featNames(f)={sprintf('ICA%d:pos',featNum(f))};
            end
        end
        
        % map features on group
        Yy=zeros(1,V.dim(1)*V.dim(2)*V.dim(3));
        Yy(1,volIndx)=groupFeat;
        Yy=reshape(Yy,[V.dim(1),V.dim(2),V.dim(3)]);
        Yy(Yy==0)=NaN;
        Vv{1}.dat=Yy;
        Vv{1}.dim=V.dim;
        Vv{1}.mat=V.mat;
        
        % save out vol of ICA feats
        exampleVol=fullfile(suitDir,'glm4','s02','wdbeta_0001.nii'); % must be better way ??
        X=spm_vol(exampleVol);
        X.fname=fullfile(regDir,'glm4','ICA_features.nii');
        X.private.dat.fname=V.fname;
        spm_write_vol(X,Vv{1}.dat);
        
        % map vol 2 surf
        M=caret_suit_map2surf(Vv,'space','SUIT','stats','mode','type','paint');
        M.paintnames=featNames;
        M.num_paintnames=length(featNum);
        M.column_name={'ICA'};
        
        caret_save(fullfile(caretDir,'suit_flat','glm4','ICA_features.paint'),M);
        
        % make areacolour
        cmap=load(fullfile(encodeDir,'features.txt'));
        M.column_name=M.paintnames;
        M.column_color_mapping=repmat([-5 5],length(featNum),1);
        M.data=cmap(1:length(featNum),2:4);
        caret_save(fullfile(caretDir,'suit_flat','glm4','ICA_features.areacolor'),M);
    case 'project_ICA_cortex'
        sn=varargin{1};
        
        subjs=length(sn);
        removeFeats=[1,2,6,12,8];
        
        % load raw Y (cereb)
        load(fullfile(encodeDir,'glm4','cereb_avrgDataStruct_sc1_sc2.mat'));
        
        % load ICs for cereb
        load(fullfile(regDir,'glm4','ICA_comps_cerebellum.mat'));
        
        % get pos + neg IC's
        S_PW=[S_PW;S_PW*-1];
        
        % make model
        Y=nanmean(Y,3); % get group
        [Y_C, ~]=remmean(Y); % center data
        
        % project back to task-space
        Uica=Y_C*S_PW'; % get U * S
        L=Uica'*Uica;
        S=diag(diag(sqrt(L)));
        X=Uica/S;
        Q=setdiff([1:size(S_PW,1)],removeFeats);
        
        for h=1:2,
            
            % load data (cortex)
            load(fullfile(encodeDir,'glm4',sprintf('cortex_%s_avrgDataStruct_sc1_sc2.mat',hem{h})));
            
            % do winner-take-all on cortex
            for s=1:subjs,
                [~,~,~,~,~,C(:,:,s)]=sc1_encode_fit(X(:,Q),Y(:,:,s),'winnerTakeAll');
            end
            
            % get composite map (group)
            for p=1:size(C,1),
                groupC=nanmean(C(p,:,:),3);
                [~,i]=sort(groupC,'descend');
                R=i(1);
                groupFeat(p,:)=R;
            end
            
            % make paint file
            P=caret_load(fullfile(caretDir,'suit_flat','glm4','ICA_features.paint'));
            M=caret_struct('paint','data',groupFeat);
            M.paintnames=P.paintnames;
            M.column_name={'ICA'};
            M.num_paintnames=length(M.paintnames);
            
            caret_save(fullfile(caretDir,'fsaverage_sym',hemName{h},'glm4',sprintf('%s.winnerTakeAll_ICA.paint',hem{h})),M);
            
            % make areacolour
            cmap=load(fullfile(encodeDir,'features.txt'));
            M.column_name=M.paintnames;
            M.column_color_mapping=repmat([-5 5],length(Q),1);
            M.data=cmap(1:length(Q),2:4);
            caret_save(fullfile(caretDir,'fsaverage_sym',hemName{h},'glm4','ICA_features.areacolor'),M);
        end
    case 'project_ICA_taskSpace'
        removeFeats=[1,2,6,12,8];
        
        % load raw Y (cereb)
        load(fullfile(encodeDir,'glm4','cereb_avrgDataStruct_sc1_sc2.mat'));
        
        % load ICs for cereb
        load(fullfile(regDir,'glm4','ICA_comps_cerebellum.mat'));
        
        % get pos + neg IC's
        S_PW=[S_PW;S_PW*-1];
        
        % make model
        Y=nanmean(Y,3); % get group
        [Y_C, ~]=remmean(Y); % center data
        
        % project back to task-space
        Uica=Y_C*S_PW'; % get U * S
        L=Uica'*Uica;
        S=diag(diag(sqrt(L)));
        X=Uica/S;
        Q=setdiff([1:size(S_PW,1)],removeFeats);
        
        % visualise ICc in task-space
        P=caret_load(fullfile(caretDir,'suit_flat','glm4','ICA_features.paint'));
        figure();imagesc_rectangle(X(:,Q),'YDir','reverse');
        caxis([0 1]);
        t=set(gca,'Ytick', 1:length(allCondNames),'YTickLabel',allCondNames,'FontSize',12,'FontWeight','bold',...
            'Xtick',1:length(Q),'XTickLabel',P.paintnames);
        t.Color='white';
        
        T.taskWeights=X(:,Q);
        T.taskNames=allCondNames;
        T.featNames=P.paintnames;
        
        save(fullfile(regDir,'glm4','ICA_taskLoadings.mat'),'T')
        
        % Plot left/right hands
        
        %         % scatterplots
        %         CAT.markertype='o';
        %         CAT.markersize=8;
        %
        %         % plot left/right hands
        %         scatterplot(X(:,14),X(:,10),'label',allCondNames,'CAT',CAT,'regression','linear','intercept',0,'printcorr','draworig')
        %         xlabel('right hand tasks');ylabel('left hand tasks');
    case 'func_parcellation_varimax'
        sn=varargin{1};
        model=varargin{2}; % 'bottomUp' or 'topDown'
        rotate=varargin{3}; % 'tasks' or 'voxels'
        
        subjs=length(sn);
        
        % load data (both sc1 & sc2)
        load(fullfile(encodeDir,'glm4','cereb_avrgDataStruct_sc1_sc2.mat'));
        U=Y;
        
        % get M
        switch model,
            case 'bottomUp'
                numFeat=9;
                % group
                U=nanmean(U,3);
                % get bottom-up model
                [M,~,W]=svds(U,numFeat);
                feats=[1,2,3,5,6,9];
                numFeat=length(feats);
                for f=1:numFeat,
                    featNames(f)={sprintf('Eig%d',feats(f))};
                end
            case 'topDown'
                for sess=1:2,
                    if sess==1,
                        F=importdata(fullfile(baseDirSc1,'sc1_featureModel.xlsx'));
                    else
                        F=importdata(fullfile(baseDir,'sc2_featureModel.xlsx'));
                    end
                    F1.feat=F.data';F1.colheaders=F.colheaders';
                    F1.feat=F1.feat(:,1:size(F1.feat,2));
                    duration=F1.feat(5,:); % duration
                    F1=getrow(F1,6:size(F1.feat,1)); % get all features except for the first five
                    % normalise motor features by task duration
                    for f=1:3,
                        F1.feat(f,:)=F1.feat(f,:)./duration; % divide by duration
                    end
                    idx=[1,2,7,30,33,43]; % important cerebellar features (1,2,7,24,30,42)
                    allFeat=F1.feat(idx,1:end);
                    % z-score features
                    tmp=zscore(allFeat');
                    featNames=F1.colheaders(idx)';
                    numFeat=size(tmp,2);
                    if sess==1,
                        tmp1=tmp;
                    end
                end
                M=[tmp1;tmp];
                % get W
                for s=1:subjs,
                    W(:,:,s)=(M'*M)\M'*U(:,:,s);
                    fprintf('subj%d done \n',sn(s))
                end;
                % group W
                W=nanmean(W,3);
                W=W';
        end
        
        % varimax rotation in feature or voxel space
        switch rotate,
            case 'tasks'
                [~,T1] = rotatefactors(M);
                B=W*T1;
                % which tasks are weighted by features?
                figure();imagesc(M*T1')
                t=set(gca,'Ytick', [1:size(M,1)],'YTickLabel',allCondNames','FontSize',12,'FontWeight','bold');
                t=set(gca,'Xtick', [1:size(M,2)],'XTickLabel',featNames,'FontSize',12,'FontWeight','bold');
            case 'voxels'
                [~,T2]= rotatefactors(W);
                B=W*T2;
                figure();imagesc(M*T2')
                t=set(gca,'Ytick', [1:size(M,1)],'YTickLabel',allCondNames','FontSize',12,'FontWeight','bold');
                t=set(gca,'Xtick', [1:size(M,2)],'XTickLabel',featNames,'FontSize',12,'FontWeight','bold');
        end
        
        % get group-level map
        for p=1:size(B,1),
            [~,i]=sort(B(p,:),'descend');
            groupFeat(p,:)=i(1); % choose best feature
        end
        
        % map features on group
        Yy=zeros(1,V.dim(1)*V.dim(2)*V.dim(3));
        Yy(1,volIndx)=groupFeat;
        Yy=reshape(Yy,[V.dim(1),V.dim(2),V.dim(3)]);
        Yy(Yy==0)=NaN;
        Vv{1}.dat=Yy;
        Vv{1}.dim=V.dim;
        Vv{1}.mat=V.mat;
        M=caret_suit_map2surf(Vv,'space','SUIT','stats','mode','type','paint');
        M.paintnames=featNames;
        M.num_paintnames=numFeat;
        M.column_name={sprintf('%s_%s',model,rotate)};
        
        caret_save(fullfile(caretDir,'suit_flat','glm4',sprintf('%s_features_%s.paint',model,rotate)),M);
        
        % make areacolour
        cmap=load(fullfile(encodeDir,'features_topDown.txt'));
        M.column_name=M.paintnames;
        M.column_color_mapping=repmat([-5 5],numFeat,1);
        M.data=cmap(1:numFeat,2:4);
        caret_save(fullfile(caretDir,'suit_flat','glm4',sprintf('%s_features.areacolor',model)),M);
        
    case 'process_connectivity'
    case 'TS_get_meants'                % Get univariately pre-whitened mean times series for each region
        % sc1_connectivity('TS_get_meants',[2 3 6 8 9 10 12 17:22],'sc2',4,'162_tessellation_hem');
        % sc1_connectivity('TS_get_meants',[2:22],'sc1',4,'162_tessellation_hem');
        sn=varargin{1}; % subjNum
        glm=varargin{3}; % glmNum
        type=varargin{4}; % '162_tessellation_hem', and 'cerebellum_grey'
        
        B = [];
        glmDir =fullfile(baseDir,sprintf('/GLM_firstlevel_%d',glm));
        subjs=length(sn);
        
        for s=1:subjs,
            glmDirSubj=fullfile(glmDir, subj_name{sn(s)});
            load(fullfile(glmDirSubj,'SPM_light.mat'));
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
            filename=(fullfile(rootDir,exper,regDir,sprintf('glm%d',glm),subj_name{sn(s)},sprintf('ts_%s.mat',type)));
            save(filename,'Data','Yres','Yhatm','Yhatr','B');
            
            fprintf('ts saved for %s (%s) for %s \n',subj_name{sn(s)},sprintf('glm%d',glm),type);
        end
    case 'TS_get_ts'                    % Get univariately pre-whitened time series for each voxel of a region
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
    case 'TS_allsubj'                   % Make a structure of all cortical time series of all subject - also seperate out residual from
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
    case 'crossval_evaluate'            % Evaluate the connectivity model across sessions based on mean betas
        name = 'glm4_162_ridge';
        crossval = 'session';
        glm      = 4;
        xname     = '162_tessellation_hem';
        yname     = 'cerebellum_grey';
        model     = 'sc1';
        data      = 'sc1';
        rmMean    = 1; % Remove mean?
        Ysplit=[];
        sn=goodsubj;        % Restrict to 17 good subjects
        vararginoptions(varargin,{'name','xname','model','data','Ysplit','name','sn','rmMean'});
        RRR=[];
        for s=sn
            fprintf('%d\n',s);
            RR=[];
            
            % Load the connectivity weights
            T = load(fullfile(rootDir,model,'connectivity_cerebellum',name,sprintf('%s_%s.mat',name,subj_name{s})));
            % Load SPM info
            S = load(fullfile(rootDir,data,sprintf('GLM_firstlevel_%d',glm),subj_name{s},'SPM_info.mat'));
            S.run=[S.run;[1:16]'];
            S.cond=[S.cond;zeros(16,1)];
            S.sess=[S.sess;ones(8,1);ones(8,1)*2];
            
            % Get the X-data
            X = load(fullfile(rootDir,data,regDir,sprintf('glm%d',glm),subj_name{s},sprintf('ts_%s.mat',xname)));
            switch(xname)
                case '162_tessellation_hem'
                    Tcort=load(fullfile(sc1Dir,regDir,'data','162_reorder.mat'));
                    Tcort=getrow(Tcort,Tcort.good==1);
                    X.B= X.B(:,Tcort.regIndx);
                case 'yeo'
                    X.B= X.B(:,2:18);
                case 'other'
            end;
            X.B(S.cond==0,:)=0; % set all intercepts (rest) to zero.
            
            % Get Y-data
            Y=load(fullfile(rootDir,data,regDir,sprintf('glm%d',glm),subj_name{s},sprintf('ts_%s.mat',yname)));
            switch (crossval)
                case 'session'
                    part = S.sess;
                case 'oddeven'
                    part = mod(S.run,2)+1;
            end;
            Y.B(S.cond==0,:)=0; % set all intercepts (rest) to zero.
            S.cond(S.cond==0)=max(S.cond(:))+1; % Relabel as rest
            
            % Figure out the voxels to evaluate
            goodindx = sum(abs(Y.B))>0 & ~isnan(sum(Y.B));
            X.B(isnan(X.B))=0;
            
            % Check if and how to split up the data (ignoring 0)
            if isempty(Ysplit);
                Ysplit = ones(size(CN,2),1);
            end;
            numSplit = max(Ysplit);
            CN = indicatorMatrix('identity',S.cond);
            
            for m=1:length(T.SN)  % Now loop over different instances of models
                for n=1:numSplit  % Loop over different splits
                    condIndx = find(Ysplit==n);
                    
                    SSP=0;SSY=0;SSCp=0;SSCy=0;SSCn=0;SSCc=0;
                    for p=1:2
                        Aindx = find(part==p & ismember(S.cond,condIndx));
                        Bindx = find(part~=p & ismember(S.cond,condIndx));
                        xBa   = pinv(CN(Aindx,condIndx))*X.B(Aindx,:); % Average betas on cortical data - part A
                        xBb   = pinv(CN(Bindx,condIndx))*X.B(Bindx,:); % Average betas on cortical data - part B
                        yBa   = pinv(CN(Aindx,condIndx))*Y.B(Aindx,:); % Average betas on cerebellar data - part A
                        yBb   = pinv(CN(Bindx,condIndx))*Y.B(Bindx,:); % Average betas on cerebellar data - part B
                        if (rmMean)
                            xBa = bsxfun(@minus,xBa,mean(xBa));
                            xBb = bsxfun(@minus,xBb,mean(xBb));
                            yBa = bsxfun(@minus,yBa,mean(yBa));
                            yBb = bsxfun(@minus,yBb,mean(yBb));
                        end;
                        predYa = xBa*T.W{m};                    % Predicted Y based on part A
                        predYb = xBb*T.W{m};                    % Predicted Y based on part A
                        SSP     = SSP  + sum(sum(predYa(:,goodindx).^2));
                        SSY     = SSY  + sum(sum(yBa(:,goodindx).^2));
                        SSCp    = SSCp + sum(sum(predYa(:,goodindx).*predYb(:,goodindx))); % Covariance of PRedictions
                        SSCy    = SSCy + sum(sum(yBa(:,goodindx).*yBb(:,goodindx)));  % Covariance of Y's
                        SSCn    = SSCn + sum(sum(predYa(:,goodindx).*yBa(:,goodindx)));   % Covariance of non-cross prediction and data
                        SSCc    = SSCc + sum(sum(predYa(:,goodindx).*yBb(:,goodindx)));   % Covariance of cross prediction and data
                    end;
                    F=fieldnames(T);
                    for f=1:length(F)
                        if (~strcmp(F{f},'W') && ~strcmp(F{f},'fR2v') && ~strcmp(F{f},'fRv'))
                            R.(F{f})(n,:)=T.(F{f})(m,:);
                        end;
                    end;
                    
                    R.Rcv(n,1)   = SSCc ./ sqrt(SSY.*SSP); % Crossvalidated predictive correlation
                    R.Rnc(n,1)   = SSCn ./ sqrt(SSY.*SSP); % Non-crossvalidated predictive correlation
                    R.Ry(n,1)    = SSCy ./ SSY;            % Reliability of data
                    R.Rp(n,1)    = SSCp ./ SSP;            % Reliability of prediction
                    R.split(n,1) = n;
                    R.relMax(n,1)= mean(max(abs(T.W{m}))./sum(abs(T.W{m})));
                end;
                
                RR = addstruct(RR,R);
            end;
            RRR=addstruct(RRR,RR);
        end;
        varargout={RRR};
    case 'crossval_evaluate_all'        % Evaluates different Connnectivity models
        whatAna=varargin{1};
        
        D=dload(fullfile(rootDir,'sc1_sc2_taskConds.dat'));
        sn = goodsubj;
        switch(whatAna)
            case 'buckner_margin_sc2'
                
                % Cross exeriment a--
                %         outname = 'type_sc2';
                %         encode = [4 4 4 4 5 5];
                %         name   = {'162','162_bm','yeo','yeo_bm','162','yeo'};
                %         xnames = {'162_tessellation_hem','yeo'};
                %         xnIn   = [1 1 2 2 1 2];
                %         glm    = [4 4 4 4 4 4];
                %         correct = [0 1 0 1 0 0];
                %         xdata   = 'sc2_b';
                %         ydata   = 'sc2';
                %         sn      = [3 6 8 9 10 12 17 18 20 21 22];
                %         D=dload(fullfile(rootDir,'sc1_sc2_taskConds.dat'));
                %         D=getrow(D,D.StudyNum==2);
                %         ysplit = [1;D.overlap+2];
                % Cross exeriment b--
                %         outname = 'type_sc2_nosplit';
                %         encode = [4];
                %         name   = {'162'};
                %         xnames = {'162_tessellation_hem','yeo'};
                %         xnIn   = [1 ];
                %         glm    = [4 ];
                %         correct = [0];
                %         xdata   = 'sc2_b';
                %         ydata   = 'sc2';
                %         sn      = [3 6 8 9 10 12 17 18 20 21 22];
                %         D=dload(fullfile(rootDir,'sc1_sc2_taskConds.dat'));
                %         D=getrow(D,D.StudyNum==2);
                %         ysplit = [1;ones(size(D.overlap,1),1)*2];
                
                % Cross exeriment b--
                %         outname = 'type_sc1_nosplit';
                %         encode = [4 4 ];
                %         name   = {'162','162_bm'};
                %         xnames = {'162_tessellation_hem','yeo'};
                %         xnIn   = [1 1];
                %         glm    = [4 4];
                %         correct = [0 1];
                %         xdata   = 'sc1_b';
                %         ydata   = 'sc1';
                %         sn      = [3 6 8 9 10 12 17 18 20 21 22];
                %         D=dload(fullfile(rootDir,'sc1_sc2_taskConds.dat'));
                %         D=getrow(D,D.StudyNum==1);
                %         ysplit = [1;ones(size(D.overlap,1),1)*2];
                % Different regularisation L1L2/Winner take all,....
                %          outname = 'L1L2_sc1';
                %          encode = [4 4 4 4];
                %          name   = {'WTAn','162_L1L2','162_L1L2b','162_L1L2c'};
                %          xnames = {'162_tessellation_hem'};
                %          xnIn   = [1 1 1 1];
                %          glm    = [4 4 4 4];
                %          correct = [0 0 0 0];
                %          model   = [1 2 2 2];
                %          xdata   = 'sc1_b';
                %          ydata   = 'sc1';
                %          sn      = [2:22];
                %          D=dload(fullfile(rootDir,'sc1_sc2_taskConds.dat'));
                %          D=getrow(D,D.StudyNum==1);
                %          ysplit = [1;ones(size(D.overlap,1),1)*2];
                %
                
                %          %
            case 'glm4_162_L1L2_sc1'      % Negative_nonnegative
                outname = 'glm4_162_nnL1L2_sc1';
                name   = {'glm4_162_nnL1L2','glm4_162_nnL1L2b','glm4_162_nnL1L2c'};
                xnames = {'162_tessellation_hem'};
                xnIn   = [1  1 1 ];
                glm    = [4 4 4 ];
                correct = [0 0 0 ];
                glm    = [4 4 4 ];
                model   = 'sc1';
                data   = 'sc1';
                D=dload(fullfile(rootDir,'sc1_sc2_taskConds.dat'));
                D=getrow(D,D.StudyNum==1);
                ysplit = [0;ones(size(D.overlap,1),1)];
            case 'glm4_162_L1L2_sc2'      % Negative_nonnegative
                outname = 'glm4_162_nnL1L2_sc2';
                name   = {'glm4_162_nnL1L2','glm4_162_nnL1L2b','glm4_162_nnL1L2c'};
                xnames = {'162_tessellation_hem'};
                xnIn   = [1  1 1 ];
                glm    = [4 4 4 ];
                correct = [0 0 0 ];
                glm    = [4 4 4 ];
                model   = 'sc1';
                data   = 'sc2';
                D=dload(fullfile(rootDir,'sc1_sc2_taskConds.dat'));
                D=getrow(D,D.StudyNum==2);
                ysplit = [0;D.overlap+1];  % Add Instruction as zero
            case 'glm4_162_nn_sc1'
                outname = 'glm4_162_nn_sc1';
                name   = {'glm4_162_nn'};
                xnames = {'162_tessellation_hem'};
                xnIn   = [1 ];
                glm    = [4 ];
                correct = [0 ];
                model   = 'sc1';
                data   = 'sc1';
                D=dload(fullfile(rootDir,'sc1_sc2_taskConds.dat'));
                D=getrow(D,D.StudyNum==1);
                ysplit = [0;ones(size(D.overlap,1),1)];  % Add Instruction as zero
            case 'glm4_162_nn_sc2'
                outname = 'glm4_162_nn_sc2';
                name   = {'glm4_162_nn'};
                xnames = {'162_tessellation_hem'};
                xnIn   = [1 ];
                glm    = [4 ];
                correct = [0 ];
                model   = 'sc1';
                data   = 'sc2';
                D=getrow(D,D.StudyNum==2);
                ysplit = [0;D.overlap+1];  % Add Instruction as zero
            case 'glm4_162_ridge_sc1'
                outname = 'glm4_162_ridge_sc1';
                name   = {'glm4_162_ridge'};
                xnames = {'162_tessellation_hem'};
                xnIn   = [1 ];
                glm    = [4 ];
                correct = [0 ];
                model   = 'sc1';
                data   = 'sc1';
                D=getrow(D,D.StudyNum==1);
                ysplit = [0;ones(size(D.overlap,1),1)];  % Add Instruction as zero
            case 'glm4_162_ridge_sc2'
                outname = 'glm4_162_ridge_sc2';
                name   = {'glm4_162_ridge'};
                xnames = {'162_tessellation_hem'};
                xnIn   = [1 ];
                glm    = [4 ];
                correct = [0 ];
                model   = 'sc1';
                data   = 'sc2';
                D=getrow(D,D.StudyNum==2);
                ysplit = [0;D.overlap+1];  % Add Instruction as zero
            case 'glm4_162_WTA_sc1'
                outname = 'glm4_162_WTA_sc1';
                name   = {'glm4_162_nnWTA','glm4_162_WTA'};
                xnames = {'162_tessellation_hem'};
                xnIn   = [1 1];
                glm    = [4 4];
                correct = [0 0];
                model   = 'sc1';
                data   = 'sc1';
                D=getrow(D,D.StudyNum==1);
                ysplit = [0;ones(size(D.overlap,1),1)];  % Add Instruction as zero
            case 'glm4_162_WTA_sc2'
                outname = 'glm4_162_WTA_sc2';
                name   = {'glm4_162_nnWTA','glm4_162_WTA'};
                xnames = {'162_tessellation_hem'};
                xnIn   = [1 1];
                glm    = [4 4];
                correct = [0 0];
                model   = 'sc1';
                data   = 'sc2';
                D=getrow(D,D.StudyNum==2);
                ysplit = [0;D.overlap+1];  % Add Instruction as zero
        end;
        RR=[];
        for i=1:length(name)
            fprintf('%d\n',i);
            R=sc1_connectivity('crossval_evaluate','name',name{i},'xname',xnames{xnIn(i)},...
                'model',model,'data',data,'Ysplit',ysplit,'sn',sn);
            v=ones(size(R.SN,1),1);
            R.name       = {name{v*i}}';
            R.tessel     = v*xnIn(i);
            R.glm        = v*glm(i);
            R.correction = v*correct(i);
            RR=addstruct(RR,R);
        end;
        save(fullfile(rootDir,'sc1','connectivity_cerebellum','evaluation',sprintf('crossval_%s.mat',outname)),'-struct','RR');
        varargout={RR};
        
    case 'map_HCP_flatmap'
        HCP={'HCP_LANGUAGE_MATHvsSTORY_SUIT.nii','HCP_SOCIAL_TOMvsRANDOM_SUIT.nii','HCP_WM_2BACKvs0BACK_SUIT.nii'};
        
        for i=1:length(HCP),
            HCPDir=which(HCP{i});
            V=spm_vol(HCPDir);
            VI=spm_read_vols(V);
            
            % set up struct for map2surf
            C{1}.dim=V.dim;
            C{1}.mat=V.mat;
            C{1}.dat=VI;
            
            M=caret_suit_map2surf(C,'space','SUIT','stats','nanmean','column_names',{HCP{i}(1:end-4)});
            
            % save output as metric or paint
            M=caret_struct('metric','data',M.data','column_name',M.column_name');
            metricData(i,:)=M.data;
            colNames(i)=M.column_name;
        end
        M.data=metricData';
        M.column_name=colNames;
        M.num_rows=size(M.data,1);
        caret_save(fullfile(baseDirSc1,'surfaceCaret','suit_flat','HCP_tasks.metric'),M);
        
        %
        
    case 'check_times_runs'             % PLOTTING: Ensure that start-times (real and predicted) match
        % Check that the startimes match TR times
        % example: sc2_imana('check_start-times',1)
        sn=varargin{1}; % subjNum
        
        cd(fullfile(behavDir,subj_name{sn}));
        
        D = dload(sprintf('sc2_%s.dat',subj_name{sn}));
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
        % example: sc2_imana('check_behavioural',[1:4],'CPRO','scanning')
        sn=varargin{1};  % subjNum
        sess=varargin{2}; % behavioural or scanning results?
        task=varargin{3};% choose task from section 5 ('taskNames')
        
        switch task
            case 'CPRO'
                A=[];
                for s=sn,
                    D = dload(fullfile(behavDir,subj_name{s},sprintf('sc2_%s_CPRO.dat',subj_name{s})));
                    A = addstruct(A,D);
                    switch sess,
                        case 'behavioural'
                            A = getrow(A,A.runNum>=1 & A.runNum<=51);
                        case 'scanning'
                            A = getrow(A,A.runNum>=funcRunNum(1) & A.runNum<=funcRunNum(2));
                    end
                end
                
                if numel(sn)>1,
                    main=sprintf('all subjects-%s',task);
                else
                    main=sprintf('%s-%s',subj_name{s},task);
                end
                
                figure(s)
                subplot(2,1,1)
                lineplot([A.runNum], A.rt,'subset',A.respMade==1);
                xlabel('Run')
                ylabel('Reaction Time')
                title(main)
                
                subplot(2,1,2)
                lineplot([A.runNum], A.numCorr,'subset', A.respMade==1);
                xlabel('Run')
                ylabel('Percent correct')
                title(main)
            case 'prediction'
                A=[];
                for s=sn,
                    
                    D = dload(fullfile(behavDir,subj_name{s},sprintf('sc2_%s_prediction.dat',subj_name{s})));
                    A = addstruct(A,D);
                    switch sess,
                        case 'behavioural'
                            A = getrow(A,A.runNum>=1 & A.runNum<=51);
                        case 'scanning'
                            A = getrow(A,A.runNum>=funcRunNum(1) & A.runNum<=funcRunNum(2));
                    end
                end
                
                if numel(sn)>1,
                    main=sprintf('all subjects-%s',task);
                else
                    main=sprintf('%s-%s',subj_name{s},task);
                end
                
                figure(s)
                subplot(2,1,1)
                lineplot(A.runNum, A.rt, 'split', A.trialType,'leg', {'meaningful','not meaningful'}, 'subset',A.respMade==1);
                xlabel('Run')
                ylabel('Reaction Time')
                title(main)
                
                subplot(2,1,2)
                lineplot(A.runNum, A.numCorr, 'split', A.trialType,'leg', {'meaningful','not meaningful'}, 'subset',A.respMade==1);
                xlabel('Run')
                ylabel('Percent Correct')
                title(main)
            case 'spatialMap'
                A=[];
                for s=sn,
                    
                    D = dload(fullfile(behavDir,subj_name{s},sprintf('sc2_%s_spatialMap.dat',subj_name{s})));
                    A = addstruct(A,D);
                    switch sess,
                        case 'behavioural'
                            A = getrow(A,A.runNum>=1 & A.runNum<=51);
                        case 'scanning'
                            A = getrow(A,A.runNum>=funcRunNum(1) & A.runNum<=funcRunNum(2));
                    end
                end
                
                if numel(sn)>1,
                    main=sprintf('all subjects-%s',task);
                else
                    main=sprintf('%s-%s',subj_name{s},task);
                end
                
                figure(s)
                subplot(2,1,1)
                lineplot(A.runNum, A.rt, 'split', A.condition,'leg', {'easy','med','diff'}, 'subset',A.respMade==1);
                xlabel('Run')
                ylabel('Reaction Time')
                title(main)
                
                subplot(2,1,2)
                lineplot(A.runNum, A.numCorr, 'split', A.condition,'leg', {'easy','med','diff'}, 'subset',A.respMade==1);
                xlabel('Run')
                ylabel('Percent Correct')
                title(main)
            case 'mentalRotation'
                A=[];
                for s=sn,
                    
                    D = dload(fullfile(behavDir,subj_name{s},sprintf('sc2_%s_mentalRotation.dat',subj_name{s})));
                    A = addstruct(A,D);
                    switch sess,
                        case 'behavioural'
                            A = getrow(A,A.runNum>=1 & A.runNum<=51);
                        case 'scanning'
                            A = getrow(A,A.runNum>=funcRunNum(1) & A.runNum<=funcRunNum(2));
                    end
                end
                
                if numel(sn)>1,
                    main=sprintf('all subjects-%s',task);
                else
                    main=sprintf('%s-%s',subj_name{s},task);
                end
                
                figure(s)
                subplot(2,1,1)
                lineplot(A.runNum, A.rt, 'split', A.condition,'leg', {'easy','med','diff'}, 'subset',A.respMade==1);
                xlabel('Run')
                ylabel('Reaction Time')
                title(main)
                
                subplot(2,1,2)
                lineplot(A.runNum, A.numCorr, 'split', A.condition,'leg', {'easy','med','diff'}, 'subset',A.respMade==1);
                xlabel('Run')
                ylabel('Percent Correct')
                title(main)
            case 'emotionProcess'
                A=[];
                for s=sn,
                    
                    D = dload(fullfile(behavDir,subj_name{s},sprintf('sc2_%s_emotionProcess.dat',subj_name{s})));
                    A = addstruct(A,D);
                    switch sess,
                        case 'behavioural'
                            A = getrow(A,A.runNum>=1 & A.runNum<=51);
                        case 'scanning'
                            A = getrow(A,A.runNum>=funcRunNum(1) & A.runNum<=funcRunNum(2));
                    end
                end
                
                if numel(sn)>1,
                    main=sprintf('all subjects-%s',task);
                else
                    main=sprintf('%s-%s',subj_name{s},task);
                end
                
                figure(s)
                subplot(2,1,1)
                lineplot(A.runNum, A.rt, 'split', A.condition,'leg', {'intact','scrambled'}, 'subset',A.respMade==1);
                xlabel('Run')
                ylabel('Reaction Time')
                title(main)
                
                subplot(2,1,2)
                lineplot(A.runNum, A.numCorr, 'split', A.condition,'leg', {'intact','scrambled'}, 'subset',A.respMade==1);
                xlabel('Run')
                ylabel('Percent Correct')
                title(main)
            case 'respAlt'
                A=[];
                for s=sn,
                    
                    D = dload(fullfile(behavDir,subj_name{s},sprintf('sc2_%s_respAlt.dat',subj_name{s})));
                    A = addstruct(A,D);
                    switch sess,
                        case 'behavioural'
                            A = getrow(A,A.runNum>=1 & A.runNum<=51);
                        case 'scanning'
                            A = getrow(A,A.runNum>=funcRunNum(1) & A.runNum<=funcRunNum(2));
                    end
                end
                
                if numel(sn)>1,
                    main=sprintf('all subjects-%s',task);
                else
                    main=sprintf('%s-%s',subj_name{s},task);
                end
                
                figure(s)
                subplot(2,1,1)
                lineplot(A.runNum, A.rt, 'split', A.condition,'leg', {'easy','med','diff'}, 'subset',A.respMade==1);
                xlabel('Run')
                ylabel('Reaction Time')
                title(main)
                
                subplot(2,1,2)
                lineplot(A.runNum, A.numCorr, 'split', A.condition,'leg', {'easy','med','diff'}, 'subset',A.respMade==1);
                xlabel('Run')
                ylabel('Percent Correct')
                title(main)
            case 'visualSearch2'
                A=[];
                for s=sn,
                    
                    D = dload(fullfile(behavDir,subj_name{s},sprintf('sc2_%s_visualSearch2.dat',subj_name{s})));
                    A = addstruct(A,D);
                    switch sess,
                        case 'behavioural'
                            A = getrow(A,A.runNum>=1 & A.runNum<=51);
                        case 'scanning'
                            A = getrow(A,A.runNum>=funcRunNum(1) & A.runNum<=funcRunNum(2));
                    end
                end
                
                if numel(sn)>1,
                    main=sprintf('all subjects-%s',task);
                else
                    main=sprintf('%s-%s',subj_name{s},task);
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
                lineplot(A.runNum, A.rt, 'split', A.condition,'leg', {'4','8','12'}, 'subset',A.respMade==1);
                xlabel('Run')
                ylabel('Reaction Time')
                title(main)
                
                subplot(4,1,4)
                lineplot(A.runNum, A.numCorr, 'split', A.condition,'leg', {'4','8','12'}, 'subset',A.respMade==1);
                xlabel('Run')
                ylabel('Percent Correct')
                title(main)
            case 'nBackPic2'
                A=[];
                for s=sn,
                    
                    D = dload(fullfile(behavDir,subj_name{s},sprintf('sc2_%s_nBackPic2.dat',subj_name{s})));
                    A = addstruct(A,D);
                    switch sess,
                        case 'behavioural'
                            A = getrow(A,A.runNum>=1 & A.runNum<=51);
                        case 'scanning'
                            A = getrow(A,A.runNum>=funcRunNum(1) & A.runNum<=funcRunNum(2));
                    end
                end
                
                if numel(sn)>1,
                    main=sprintf('all subjects-%s',task);
                else
                    main=sprintf('%s-%s',subj_name{s},task);
                end
                
                figure(s)
                subplot(2,1,1)
                lineplot(A.runNum, A.rt, 'split', A.condition,'leg', {'response','no response'}, 'subset',A.respMade==1);
                xlabel('Run')
                ylabel('Reaction Time')
                title(main)
                
                subplot(2,1,2)
                lineplot(A.runNum, A.numCorr, 'split', A.condition,'leg', {'response','no response'}, 'subset',A.respMade==1);
                xlabel('Run')
                ylabel('Percent Correct')
                title(main)
            case 'ToM2'
                A=[];
                for s=sn,
                    
                    D = dload(fullfile(behavDir,subj_name{s},sprintf('sc2_%s_ToM2.dat',subj_name{s})));
                    A = addstruct(A,D);
                    switch sess,
                        case 'behavioural'
                            A = getrow(A,A.runNum>=1 & A.runNum<=51);
                        case 'scanning'
                            A = getrow(A,A.runNum>=funcRunNum(1) & A.runNum<=funcRunNum(2));
                    end
                end
                
                if numel(sn)>1,
                    main=sprintf('all subjects-%s',task);
                else
                    main=sprintf('%s-%s',subj_name{s},task);
                end
                
                figure(s)
                subplot(2,1,1)
                lineplot(A.runNum, A.rt,'subset',A.respMade==1);
                xlabel('Run')
                ylabel('Reaction Time')
                title(main)
                
                subplot(2,1,2)
                lineplot(A.runNum, A.numCorr,'subset',A.respMade==1);
                xlabel('Run')
                ylabel('Percent Correct')
                title(main)
            case 'motorSequence2'
                A=[];
                for s=sn,
                    
                    D = dload(fullfile(behavDir,subj_name{s},sprintf('sc2_%s_motorSequence2.dat',subj_name{s})));
                    A = addstruct(A,D);
                    switch sess,
                        case 'behavioural'
                            A = getrow(A,A.runNum>=1 & A.runNum<=51);
                        case 'scanning'
                            A = getrow(A,A.runNum>=funcRunNum(1) & A.runNum<=funcRunNum(2));
                    end
                end
                
                if numel(sn)>1,
                    main=sprintf('all subjects-%s',task);
                else
                    main=sprintf('%s-%s',subj_name{s},task);
                end
                
                figure(s)
                subplot(2,1,1);
                lineplot(A.runNum,A.rt,'split',A.condition,'leg',{'control','sequence'});
                xlabel('Run');
                ylabel('Reaction Time');
                title(main)
                
                subplot(2,1,2);
                lineplot(A.runNum,A.numCorr,'split', A.condition,'leg', {'control','sequence'});
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
            D=dload(fullfile(baseDir, 'data', subj_name{s},['sc2_',subj_name{s},'.dat']));
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
        lineplot(T.taskNum,T.heartRate,'split',T.taskName,'leg',taskName2s);
        ylabel('Heart-rate')
        xlabel('Tasks')
        
        pivottable(T.SN,T.taskNum,T.heartRate,'(x)');
    case 'saccades'                     % PLOTTING: Pivottable (average saccades across tasks)
        sn=varargin{1};
        glm=varargin{2};
        Rr=[];
        
        switch glm,
            case 13
                taskNames = {'1.CPRO','2.prediction','3.verbGeneration2','4.spatialNavigation2',...
                    '5.spatialMap','6.natureMovie','7.romanceMovie','8.landscapeMovie','9.motorSequence2',...
                    '10.mentalRotation', '11.nBackPic2','12.emotionProcess','13.respAlt','14.visualSearch2','15.ToM2',...
                    '16.actionObservation2','17.rest2'};
            case 4
                taskNames = {'1.instruct','2.CPRO', '3.pred-true','4.pred-viol','5.pred-scram',...
                    '6.verbGen2-gen', '7.verbGen2-read','8.spatialNav2','9.spatMap-easy',...
                    '10.spatMap-med', '11.spatMap-diff','12.natureMov','13.romanceMov','14.landscapeMov',...
                    '15.motorSeq2-con', '16.motorSeq2-seq','17.menRot-easy','18.menRot-med',...
                    '19.menRot-diff','20.nBackPic2-resp','21.nBackPic2-noResp','22.emotProc-intact',...
                    '23.emotProc-scram','24.respAlt-easy', '25.respAlt-med', '26.respAlt-diff','27.visSearch2-small',...
                    '28.visSearch2-med','29.visSearch2-large','30.ToM2','31.actObs2-act', '32.actObs2-con','33.rest2'};
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
        glm=varargin{2}; % glm 3
        
        SS=[];
        for s=sn,
            T=[];
            % load SPM
            glmSubjDir =[baseDir sprintf('/GLM_firstlevel_%d/',glm)  subj_name{s}];dircheck(glmSubjDir);
            load(fullfile(glmSubjDir,'SPM_light.mat'));
            
            MOV=spm_rwls_resstats(SPM); % get movement parameters
            
            % Get start times (over entire timeseries) per task
            for t=1:numel(taskNumbers)-1, % loop over tasks
                for r=1:numel(run), % loop over runs
                    S.taskOns = floor(SPM.Sess(r).U(t+16).ons); % only interested in execution (not instructions)
                    S.runNum = r;
                    S.taskName = taskNames(t);
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
        % example: sc2_imana('check_designMatrix',1,1)
        % run 'make_glm#','estimate_glm' and 'contrast' before this step
        sn=varargin{1};
        glm=varargin{2};
        
        glmDir =[baseDir sprintf('/GLM_firstlevel_%d/',glm) subj_name{sn}];
        
        A=load(fullfile(glmDir,'SPM_light.mat'));
        
        X=A.SPM.xX.X(A.SPM.Sess(2).row,A.SPM.Sess(2).col);
        
        figure(sn);
        imagesc(X);
        title('Design Matrix for run 1')
        
        figure();
        indx=A.SPM.Sess(1).col;
        imagesc(A.SPM.xX.Bcov(indx,indx))
        title('variance of predicted betas')
        
        if length(varargin)==4,
            reg=varargin{3}; % specify [10,11] for example
            figure(3);
            plot([1:size(X,1)],X(:,reg),'b'); % which regressors are we plotting?
        end
    case 'check_movement'               % PLOTTING: Check residual SD
        % example: sc2_imana('check_movement2',1,'both')
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
                    S(idx)=sn(s);
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
        type=varargin{1}; % 'sc2' or 'both'
        
        % figure out saccades
        subjs=length(saccRun);
        idx=1;
        for s=1:subjs,
            if ~isempty(saccRun{s});
                load(fullfile(eyeDir,subj_name{s},'glm4_saccades.mat'));
                sacc_subjs(idx,:)=R.avgSacc;
                idx=idx+1;
            end
        end
        
        switch type,
            case 'sc1'
                D.saccades=[15 28 28 98 31 31 37 37 29 29 46 38 38 36 41 38 38 20 20 25 25 50 22 22 26 26 32 32 32 45]';
                D.duration = [5;15;15;30;15;15;15;15;15;15;30;15;15;30;30;15;15;15;15;15;15;30;15;15;15;15;10;10;10;30];
                D.lHand = [0;0;15;2;0;0;8;7;0;0;0;0;0;0;0;12;12;0;7;0;0;0;3.5;4;0;0;5;5;5;0];
                D.rHand = [0;0;0;0;0;0;0;0;5;5;0;8;7;15;0;12;12;0;0;0;7;0;3.5;4;0;0;0;0;0;0];
            case 'sc2'
                D.saccades = round(mean(sacc_subjs,1))';
                %                 D.saccades = [45;60;15;15;15;26;26;50;16;30;35;71;60;58;38;38;43;43;43;25;25;30;30;23;23;50;40;40;40;98;21;21;45];
                D.duration = [5;30;10;10;10;15;15;30;10;10;10;30;30;30;15;15;10;10;10;15;15;15;15;10;10;10;10;10;10;30;15;15;30];
                D.lHand    = [0;2;2;2;2;0;0;0;1;1;1;0;0;0;12;12;0;0;0;0;0;0;0;1;1;1;5;5;5;2;0;0;0];
                D.rHand    = [0;2;0;0;0;0;0;0;1;1;1;0;0;0;12;12;3;3;3;0;7;5;5;1;1;1;0;0;0;0;0;0;0];
            case 'both'
                D.saccades=[28;28;98;31;31;37;37;29;29;46;38;38;36;41;38;38;20;20;25;25;50;22;22;26;26;32;32;32;45;...
                    60;15;15;15;26;26;50;16;30;35;71;60;58;38;38;43;43;43;25;25;30;30;23;23;50;40;40;40;98;21;21;45];
                D.duration = [15;15;30;15;15;15;15;15;15;30;15;15;30;30;15;15;15;15;15;15;30;15;15;15;15;10;10;10;30;...
                    30;10;10;10;15;15;30;10;10;10;30;30;30;15;15;10;10;10;15;15;15;15;10;10;10;10;10;10;30;15;15;30];
                D.lHand = [0;15;2;0;0;8;7;0;0;0;0;0;0;0;12;12;0;7;0;0;0;3.5;4;0;0;5;5;5;0;...
                    2;2;2;2;0;0;0;1;1;1;0;0;0;12;12;0;0;0;0;0;0;0;1;1;1;5;5;5;2;0;0;0];
                D.rHand = [0;0;0;0;0;0;0;5;5;0;8;7;15;0;12;12;0;0;0;7;0;3.5;4;0;0;0;0;0;0;...
                    2;0;0;0;0;0;0;1;1;1;0;0;0;12;12;3;3;3;0;7;5;5;1;1;1;0;0;0;0;0;0;0];
        end
        
        varargout={D};
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
        
        subjs=length(sn);
        R=[];
        N=[];
        
        for s=1:subjs,
            encodeSubjDir = fullfile(encodeDir,subj_name{sn(s)}); dircheck(encodeSubjDir);
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
            figure
            whitebg('black')
            subplot(4,1,4);
            lineplot(R.lambda,R.fR,'split',[R.method,R.type],'leg','auto','linecolor',[1 1 1],'markercolor',[1 1 1]);
            xlabel('regularisation prior')
            ylabel('R value (fit)')
            subplot(4,1,3);
            lineplot(R.lambda,R.cR,'split',[R.method,R.type],'leg','auto','linecolor',[1 1 1],'markercolor',[1 1 1]);
            xlabel('regularisation prior')
            ylabel('R value (crossval)')
            subplot(4,1,2);
            lineplot(R.lambda,R.relMaxReg,'split',[R.method,R.type],'leg','auto','linecolor',[1 1 1],'markercolor',[1 1 1]);
            xlabel('regularisation prior')
            ylabel('relative max of total networks')
            subplot(4,1,1)
            lineplot(R.lambda,R.numReg,'split',[R.method,R.type],'leg','auto','linecolor',[1 1 1],'markercolor',[1 1 1]);
            xlabel('regularisation prior')
            ylabel('number of "winning" networks')
            
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
        
        subjs=length(sn);
        N=[];
        D=[];
        for t=1:numel(type),
            for s=1:subjs,
                T=[];
                R=[];
                encodeSubjDir = fullfile(encodeDir,subj_name{sn(s)}); dircheck(encodeSubjDir);
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
        
        load(fullfile(encodeDir,sprintf('interSubjVar_firstLevel_%s.mat',type)));
        
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
        
        load(fullfile(encodeDir,sprintf('interSubjVar_%s.mat',type)));
        suit_plotflatmap(I,'type','func','cscale',[min(I),max(I)]);
        colorbar
    case 'plot_corr_encoding_model'     % PLOTTING: Check correlational matrix for different cortical parcellations
        type=varargin{1}; % '162_tessellation_hem'
        step=varargin{2}; % 'corr_matrix' or 'corr_surface'
        
        load(fullfile(encodeDir,sprintf('corr_%s_tasks.mat',type)))
        
        switch step,
            case 'corr_matrix'
                % sort correlational matrix (according to lobes)
                figure
                imagesc(C.corr(C.sortIndx,C.sortIndx));
                t=set(gca,'Ytick',cumsum([1,C.lobeIdx(1:end-1)']),'YTickLabel',C.lobeName','Xtick',cumsum([1,C.lobeIdx(1:end-1)']),'XTickLabel',C.lobeName','FontSize',12,'FontWeight','bold');
                t.Color='white';
                title(sprintf('%s-correlational-matrix',type));
            case 'corr_surface'
                % get indices for both hemispheres
                parcelIdx(:,1)=[1:size(C.hemi,1)/2];
                parcelIdx(:,2)=[(size(C.hemi,1)/2)+1:size(C.hemi,1)];
                for h=regSide,
                    switch type,
                        case '162_tessellation_hem'
                            D=caret_load(fullfile(caretDir,'fsaverage_sym',hemName{h},sprintf('%s.tessel162_new.metric',hem{h})));
                            idx=1;
                            for ii=[1:148,150:158],
                                D.data(D.data==ii,1)=mean(C.corr(parcelIdx(idx,h),:));
                                idx=idx+1;
                            end
                            D.data(D.data==149,1)=0;
                        case 'yeo_hem'
                            D=caret_load(fullfile(caretDir,'fsaverage_sym',hemName{h},sprintf('%s.Yeo17.paint',hem{h})));
                            idx=1;
                            for ii=[2:18],
                                D.data(D.data==ii,1)=mean(C.corr(parcelIdx(idx,h),:));
                                idx=idx+1;
                            end
                        case 'desikan_hem'
                            D=caret_load(fullfile(caretDir,'fsaverage_sym',hemName{h},sprintf('%s.desikan.paint',hem{h})));
                            idx=1;
                            for ii=[2:36],
                                D.data(D.data==ii,1)=mean(C.corr(parcelIdx(idx,h),:));
                                idx=idx+1;
                            end
                    end
                    coord=fullfile(caretDir,'fsaverage_sym',hemName{h},[hem{h} '.FLAT.coord']);
                    topo=fullfile(caretDir,'fsaverage_sym',hemName{h},[hem{h} '.CUT.topo']);
                    figure;caret_plotflatmap('coord',coord,'topo',topo,'data',D.data,'xlims',[-140 140],'ylims',[-140 140])
                    colorbar
                    D=[];
                end
        end
        
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