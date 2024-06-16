function varargout=sc1_featureModel(what,varargin)
% Matlab script to do Feature mode analyses for sc1 and sc2 experiments

%==========================================================================
type=[];
% % (1) Directories
rootDir           = '/Users/maedbhking/Documents/Cerebellum_Cognition';
studyDir{1}     =fullfile(rootDir,'sc1');
studyDir{2}     =fullfile(rootDir,'sc2');
groupDir        =['group_GLM_MNI_run'];
behavDir        =['data'];
imagingDir      =['imaging_data'];
imagingDirRaw   =['imaging_data_raw'];
dicomDir        =['imaging_data_dicom'];
anatomicalDir   =['anatomicals'];
suitDir         =['suit'];
caretDir        =['surfaceCaret'];
regDir          =['RegionOfInterest/'];
connDir         =['connectivity_cerebellum'];


%==========================================================================

% % (2) Hemisphere and Region Names
hem        = {'lh','rh'};
regSide    = [1 2] ;
regType    = [1 2 3 4 5 1 2 3 4 5];
regName    = {'frontal','parietal','occipital','temporal','cerebellum'};
numReg     = length(regName);
subj_name = {'s01','s02','s03','s04','s05','s06','s07','s08','s09','s10','s11','s12','s13','s14','s15','s16','s17','s18','s19','s20','s21','s22'};
allsubj = [2:22];
goodsubj  = [2,3,4,6,7,8,9,10,12,14,15,17,18,19,20,21,22];
atlasname = 'fsaverage_sym';
hemName   = {'LeftHem','RightHem'};

switch(what)
    case 'ICAtoFeatures'            % Investigates tuning
        
        D=dload(fullfile(rootDir,'featureTable_mk.txt'));        % Read feature table
        S=dload(fullfile(rootDir,'sc1_sc2_taskConds.txt'));   % List of task conditions
        % load(fullfile(sc2Dir,regDir,'glm4','ICA_taskLoadings.mat'));
        load(fullfile(rootDir,'ICA_taskLoadings.mat'));
        W=pivottablerow(S.condNumUni,T.taskWeights,'mean(x,1)');
        
        figure(1);
        subplot(2,2,1);
        imagesc_rectangle(W);
        
        set(gca,'YTick',[1:47],'YTickLabel',D.conditionName,'XTickLabel',T.featNames,'FontSize',6);
        
        % Make the feature matrix
        D.LeftHand    = D.leftHandPresses ./D.duration;
        D.RightHand   = D.rightHandPresses ./D.duration;
        D.Saccade    = D.saccades./D.duration;
        f=fieldnames(D);
        FeatureNames = f(5:end);
        F=[];
        for d=1:length(FeatureNames)
            F = [F D.(FeatureNames{d})];
        end;
        F= bsxfun(@rdivide,F,sum(F.^2,1));
        numCond = length(D.conditionName);
        numFeat = length(FeatureNames);
        numICAs = length(T.featNames);
        
        subplot(2,2,2);
        C=corr(F,W);
        imagesc_rectangle(C);
        set(gca,'YTick',[1:numFeat],'YTickLabel',FeatureNames,'XTickLabel',T.featNames,'FontSize',6);
        
        subplot(2,2,[3:4]);
        imagesc_rectangle(F);
        set(gca,'YTick',[1:numCond],'YTickLabel',D.conditionName,'XTick',[1:numFeat],'XTickLabel',FeatureNames,'FontSize',6);
        set(gca,'XTickLabelRotation',60);
        
        % Run a multiple regression analysis on ICAComp onto Features
        lambda = [0.001 0.001];
        X=bsxfun(@minus,F,mean(F,1));
        Y=bsxfun(@minus,W,mean(W,1));
        X=bsxfun(@rdivide,X,sqrt(mean(X.^2)));
        Y=bsxfun(@rdivide,Y,sqrt(mean(Y.^2)));
        XX=X'*X;
        XY=X'*Y;
        A = -eye(numFeat);
        b = zeros(numFeat,1);
        for p=1:numICAs
            U(:,p) = cplexqp(XX+lambda(2)*eye(numFeat),ones(numFeat,1)*lambda(1)-XY(:,p),A,b);
        end;
        
        
        % Present the list of the highest three correlation for each ICA
        for i=1:numICAs
            [a,b]=sort(C(:,i),'descend');
            fprintf('%s: %s(%2.2f) %s(%2.2f) %s(%2.2f)\n',T.featNames{i},...
                FeatureNames{b(1)},a(1),...
                FeatureNames{b(2)},a(2),...
                FeatureNames{b(3)},a(3));
        end;
        
        % Make word lists for word map
        figure(2);
        DD = U;WORD=FeatureNames;
        DD(DD<0)=0;
        DD=DD./max(DD(:));
        for j=1:size(DD,2)
            subplot(3,4,j);
            set(gca,'XLim',[0 2.5],'YLim',[-0.2 1.2]);
            title(T.featNames{j})
            for i=1:size(DD,1)
                if (DD(i,j)>0)
                    siz=ceil(DD(i,j)*20);
                    text(unifrnd(0,1,1),unifrnd(0,1,1),WORD{i},'FontSize',siz);
                end;
            end;
        end;
        set(gcf,'PaperPosition',[1 1 60 30]);wysiwyg;
    otherwise
        disp('there is no such case.')
end;
