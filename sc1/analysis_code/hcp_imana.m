function varargout=hcp_imana(what,varargin)
% Ewa Zotow 2015

% script to analyse HCP dataset
% (2st level GLM, flatmaps for specific constrasts, aggregate cerebellar
% coverage + flatmaps)

% varargin:
%           contrasts:  simpleCon, mainCon, motorCon, mathStory
%           stats:      nanmean, minmax, min, max

vararginoptions(varargin,{'contrasts', 'stats'});

cd('/Volumes/External_Hard_Drive_EZ/connectome2/analysis');

% set flat_dir for suit_plotflatmap
global flat_dir
% flat_dir='/Users/ewazotow/Desktop/MotorControlEZ/imaging/suit/suit_flat';
flat_dir='/Applications/spm12/toolbox/suit/suit_flat';

baseDir= '/Users/mking/Dropbox (Personal)/Diedrichsen Lab/Cerebellum_Cognition/data/HCP_tfMRI/contrasts_from_1st_lvl';
outDir = '/Volumes/External_Hard_Drive_EZ/connectome2/analysis/lvl2';
imgDir = '/Volumes/External_Hard_Drive_EZ/connectome2/analysis/flatmaps';
mkdir(outDir);
% SN = {'100307',	'103414',	'105115',	'110411',	'111312',	'113619',	'115320',	'117122',	'118730',	'118932',	...
%     '123117',	'124422',	'125525',	'128632',	'129028',	'130013',	'133928',	'135932',	'136833',	'139637',	...
%     '149337',	'149539',	'151223',	'151627',	'156637',	'161731',	'192540',	'201111',	'212318',	'214423',	...
%     '221319',	'298051',	'397760',	'414229',	'499566',	'654754', '672756',	'792564'}; % old 38 subject sample
SN = {'100307',	'100408',	'101107',	'101309',	'101915',	'103111',	'103414',	'103818',	'105014',	'105115',	...
    '106016',	'108828',	'110411',	'111312',	'111716',	'113619',	'113922',	'114419',	'115320',	'116524',	...
    '117122',	'118528',	'118730',	'118932',	'120111',	'122317',	'122620',	'123117',	'123925',	'124422',	...
    '125525',	'126325',	'127630',	'127933',	'128127',	'128632',	'129028',	'130013',	'130316',	'131217',	...
    '131722',	'133019',	'133928',	'135225',	'135932',	'136833',	'138534',	'139637',	'140925',	'144832',	...
    '146432',	'147737',	'148335',	'148840',	'149337',	'149539',	'149741',	'151223',	'151526',	'151627',	...
    '153025',	'154734',	'156637',	'159340',	'160123',	'161731',	'162733',	'163129',	'176542',	'178950',	...
    '188347',	'189450',	'190031',	'192540',	'196750',	'198451',	'199655',	'201111',	'208226',	'211417',	...
    '211720',	'212318',	'214423',	'221319',	'239944',	'245333',	'280739',	'298051',	'366446',	'397760',	...
    '414229',	'499566',	'654754',	'672756',	'751348',	'756055',	'792564',	'856766',	'857263',	'899885'};
[d,e]=xlsread('contrasts'); % only use if need all contrasts. .xls must be in analysis folder
conNames = e(:,4); % all contrasts

if strcmp(contrasts, 'simpleCon')
    Cont = {'WM_0BK','WM_2BK', 'WM_BODY','WM_FACE','WM_PLACE','WM_TOOL',  ...
        'EM_FACES','EM_SHAPES',   'MO_LF','MO_LH','MO_RF','MO_RH','MO_T',   ...
        'RE_MATCH','RE_REL',   'GA_PUNISH','GA_REWARD',   'LA_MATH','LA_STORY',  ...
        'SO_RANDOM','SO_TOM'}; % all simple contrasts
elseif strcmp(contrasts, 'mainCon')
    Cont = {'WM_2BKvs0BK', 'GA_REWARDvsPUNISH', 'MO_LFvsAVG', 'MO_LHvsAVG', 'MO_RFvsAVG', 'MO_RHvsAVG', 'MO_TvsAVG', ...
        'LA_STORYvsMATH', 'SO_TOMvsRANDOM', 'EM_FACESvsSHAPES', 'RE_RELvsMATCH'}; % main contrasts
elseif strcmp(contrasts, 'motorCon')
    Cont = {'MO_LFvsAVG', 'MO_LHvsAVG', 'MO_RFvsAVG', 'MO_RHvsAVG', 'MO_TvsAVG'};
elseif strcmp(contrasts, 'mathStory')
    Cont = {'LA_MATHvsSTORY'};
end

switch(what)
    
    case '2nd_lvl_GLM' % specify 2nd level GLM and estimate. Takes specified contrasts from 'contrasts_from_1st_level' (done with getCopes.m)
        % and creates folders with results of level 2 GLM for each contrast
        
        % create separate directories for all specified contrasts
        for con = 1:numel(Cont)
            currDir = fullfile(outDir, ['lvl2_' Cont{con}]); % create directory for given contrast
            mkdir(currDir);
            
            % specify:
            matlabbatch{1}.spm.stats.factorial_design.dir = {currDir};
            for s = 1:numel(SN)
                matlabbatch{1}.spm.stats.factorial_design.des.t1.scans{s,1} = fullfile(baseDir, [Cont{con} '_' SN{s} '.nii']); % select all scans for given contrast
            end
            matlabbatch{1}.spm.stats.factorial_design.cov = struct('c', {}, 'cname', {}, 'iCFI', {}, 'iCC', {});
            matlabbatch{1}.spm.stats.factorial_design.multi_cov = struct('files', {}, 'iCFI', {}, 'iCC', {});
            matlabbatch{1}.spm.stats.factorial_design.masking.tm.tm_none = 1;
            matlabbatch{1}.spm.stats.factorial_design.masking.im = 1;
            matlabbatch{1}.spm.stats.factorial_design.masking.em = {''};
            matlabbatch{1}.spm.stats.factorial_design.globalc.g_omit = 1;
            matlabbatch{1}.spm.stats.factorial_design.globalm.gmsca.gmsca_no = 1;
            matlabbatch{1}.spm.stats.factorial_design.globalm.glonorm = 1;
            
            %estimate
            matlabbatch{1}.spm.stats.fmri_est.spmmat = fullfile(currDir, 'SPM.mat');
            matlabbatch{1}.spm.stats.fmri_est.write_residuals = 0;
            matlabbatch{1}.spm.stats.fmri_est.method.Classical = 1;
            spm_jobman('run',matlabbatch)
            
            % run SPM
            cd(currDir);
            load SPM;
            SPM=spm_spm(SPM); % this returns beta, mask, ResMS and RPV - but not contrast
            spmj_rfx_contrast(SPM); % returns all possible contrasts?
            
            clear currDir
        end
        
        
    case ('suit_makeflatmap') % show contrast on suit flatmap. Select stats: nanmean, max, min
        
        mkdir(imgDir);
        
        for con = 1:numel(Cont)
            currDir = fullfile(outDir,['lvl2_' Cont{con}]);
            cd(currDir);
            Data(:,con) = suit_map2surf('con_0001.nii', 'space', 'FSL', 'stats', stats);
            %             figure
            %             title(Cont{con}, 'interpreter', 'none'); % otherwise underscore = subscripts
            %             suit_plotflatmap(Data(:,con), 'cscale', [5.47, 15]); % for stats = 'min', get rid of cscale
            %             cd(imgDir);
            %             figname = [Cont{con}, sprintf('_flatmap_%s', stats)]
            %             savefig(fullfile(figname));
        end
        
        % create average maps
        %         Data(:,con+1) = mean(Data');
        %         figure
        %         title('average_map')
        %         suit_plotflatmap(Data(:,con+1));
        
        % for motor only: each motor task as a separate colour (.paint)
        if strcmp(contrasts, 'motorCon')
            [m, ind] = max(Data,[],2); % only the one with highest value will get assigned. m= value, ind = index (which vertex)
            thres = [5.47,7.5,10,12.5,15,20,25,30];
            thres_n= {'547','75','10','125','15','20','25','30'};
            for th = 1:numel(thres)
                ind(m<thres(th))=0; % m<threshold
                C = caret_struct('paint', 'data', ind);
                C.paintnames = {'LF', 'LH', 'RF', 'RH', 'T','none'};
                C.column_name = thres_n(th);
                cd(imgDir);
                caret_save(['motor_contrasts_con_th' num2str(thres(th)) '.paint'],C);
            end
        end
        
        %         save all as caret metric file. Each column = one contrast.
        M = caret_struct('metric','data', Data);
        colname = [];
        for n=1:numel(Cont)
            colname{n} = [stats,'_',Cont{n}];
        end
        M.column_name = colname;
        cd(imgDir);
        caretfilename = sprintf('connectome_flatmaps_%s_%s.metric', stats, contrasts);
        caret_save(caretfilename,M);
        
        
    case('aggregate_coverage') % number of contrasts with 50% or 70% of subjects with z-values above(P)/below(N) z=|1.96|
        % need to get zstat instead of con images;
        % as in Barch et al. - Fig 13 - aggregate brain coverage - unlike
        % in Barch, here we use number of contrasts and not tasks
        
        baseDir = '/Users/ewazotow/Desktop/connectome_project/analysis/zstat_from_1st_lvl';
        
        for con = 1:numel(Cont)
            for sn = 1:numel(SN)
                Data(:,sn,con) = suit_map2surf(fullfile(baseDir, ['zstat_' Cont{con} '_' SN{sn} '.nii']), 'space', 'FSL');
            end
            
            % is each value bigger than 1.96?
            P = Data(:,:,con) > 1.96;
            N = Data(:,:,con) < (-1.96);
            % how many subjects with values > 1.96 in a given voxel
            numP = sum(P,2);
            numN = sum(N,2);
            
            perc50 = 0.5 * numel(SN);
            perc70 = 0.7 * numel(SN);
            % number of z-scores > 1.96 for a given percentage of subjects in this task
            P50(:,con) = numP > perc50; % 1 if this voxel is >1.96
            P70(:,con) = numP > perc70;
            N50(:,con) = numN > perc50;
            N70(:,con) = numN > perc70;
            
            clear P N numP numN
        end
        
        numConP50 = sum(P50,2);
        numConP70 = sum(P70,2);
        numConN50 = sum(N50,2);
        numConN70 = sum(N70,2);
        AveData = [numConP50, numConP70, numConN50, numConN70];
        AveDataHead = {'numConP50', 'numConP70', 'numConN50', 'numConN70'};
        
        for n = 1:size(AveData,2)
            figure
            title(AveDataHead{n})
            suit_plotflatmap(AveData(:,n));
        end
        imgDir = fullfile(baseDir, 'flatmaps');
        mkdir(imgDir);
        M = caret_struct('metric','data', AveData);
        M.column_name = AveDataHead;
        cd(imgDir);
        caret_save('aggregate_coverage_flatmaps.metric',M);
        
        
end

