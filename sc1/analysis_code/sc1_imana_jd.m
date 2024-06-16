function varargout=sc1_imana_jd(what,varargin)
%==========================================================================
type=[];
% % (1) Directories
baseDir         = '/Users/mking/Documents/Cerebellum_Cognition/sc1';
% baseDir         = sprintf('/Users/joern/projects/superCerebellum');
% baseDir           = '/Users/jdiedrichsen/Data/super_cerebellum';
% baseDir           = '/Users/jdiedrichsen/Projects/SuperCerebellum/sc1';
% baseDir         = '/Volumes/MotorControl/data/super_cerebellum/sc1';
groupDir        =[baseDir '/group_GLM_MNI_run'];
behavDir        =[baseDir '/data'];
imagingDir      =[baseDir '/imaging_data'];
imagingDirRaw   =[baseDir '/imaging_data_raw'];
dicomDir        =[baseDir '/imaging_data_dicom'];
anatomicalDir   =[baseDir '/anatomicals'];
fieldDir        =[baseDir '/fieldmaps'];
freesurferDir   =[baseDir '/surfaceFreesurfer'];
suitDir         =[baseDir '/suit'];
caretDir        =[baseDir '/surfaceCaret'];
regDir          =[baseDir '/RegionOfInterest/'];
plotDir         =[baseDir '/plots/'];
encodeDir       =[baseDir '/encoding'];


%==========================================================================

% % (2) Hemisphere and Region Names
hem        = {'lh','rh'};
regSide    = [1 2] ;
regType    = [1 2 3 4 5 1 2 3 4 5];
regName    = {'frontal','parietal','occipital','temporal','cerebellum'};
numReg     = length(regName);
subj_name = {'s01','s02','s03','s04','s05','s06','s07','s08','s09','s10','s11','s12','s13','s14','s15','s16','s17','s18','s19','s20','s21','s22'};
goodsubj = [2:22];
reg_timeseries_mat = {'ROIt_lhfrontal.mat',...        % name of output files of region timeseries
    'ROIt_lhparietal.mat',...
    'ROIt_lhoccipital.mat',...
    'ROIt_lhtemporal.mat',...
    'ROIt_rhfrontal.mat',...
    'ROIt_rhparietal.mat',...
    'ROIt_rhoccipital.mat',...
    'ROIt_rhtemporal.mat',...
    };
reg_title = {'lh frontal','rh frontal','lh parietal','rh parietal',...
    'lh occipital','rh occipital','lh temporal','rh temporal'};
atlasA    = 'x';
atlasname = 'fsaverage_sym';
hemName   = {'LeftHem','RightHem'};
dataext   = 'run';

taskNames = {'1.GoNoGo','2.ToM','3.actionObservation','4.affective','5.arithmetic',...
    '6.checkerBoard','7.emotional','8.intervalTiming','9.motorImagery','10.motorSequence',...
    '11.nBack', '12.nBackPic','13.spatialNavigation','14.stroop', '15.verbGeneration',...
    '16.visualSearch','17.rest'};


condNames ={'1.NoGo','2.Go','3.Theory of Mind','4.Video Actions','5.Video Knots',...
    '6.Unpleasant Scenes','7.Pleasant Scenes','8.Math','9.Digit Judgment','10.Checkerboard',...
    '11.Sad Faces','12.Happy Faces','13.Interval Timing','14.Motor Imagery','15.Finger Simple',...
    '16.Finger Sequence','17.Verbal 0-Back','18.Verbal 2-Back','19.Object 0-Back','20.Object 2-Back',...
    '21.Spatial Navigation','22.Stroop Incongruent','23.Stroop Congruent','24.Verb Generation','25.Word Reading',...
    '26.Visual Search - small','27.Visual Search - medium','28.Visual Search - large','29.rest'};

%==========================================================================

switch(what)
    case 'All_ROIstruct'
        type = varargin{1};
        A=[];
        for sn=goodsubj
            % load statistics for subject(s) and GLM(s)
            load(fullfile(regDir,'glm4',subj_name{sn},sprintf('Ttasks_%s.mat',type)));
            A = addstruct(A,Ts);
        end;
        
        % recalculate the RDM from the IPM
        numTasks=28;
        con =indicatorMatrix('allpairs',[1:numTasks+1]);
        for i=1:size(A.IPM,1);
            SMM = rsa_squareIPM(A.IPM(i,:)); % get the squared second moment matrix
            SMM = [SMM zeros(numTasks,1);zeros(1,numTasks+1)];  % Add rest (zero)
            H = eye(numTasks+1)-ones(numTasks+1)/(numTasks+1);  % Build a centering matrix
            SMM = H*SMM*H';                                     % center second moment matrix
            A.IPMc(i,:) = rsa_vectorizeIPM(SMM);                % Vectorize the second moment matrix including rest
            A.RDM(i,:) = diag(con*SMM*con')';                   % Store vectorized version of the RDM
        end;
        
        save(fullfile(regDir,'glm4',['allRDM_' type '.mat']),'-struct','A');
    case 'All_avrgDataStruct'
        subj=[2:17];
        T=[];
        V=spm_vol(fullfile(suitDir,'anatomicals','cerebellarGreySUIT.nii'));
        X= spm_read_vols(V);
        % Check if V.mat is the the same as wdResMS!!!
        grey_threshold = 0.1; % gray matter threshold
        indx=find(X>grey_threshold);
        [i,j,k]= ind2sub(size(X),indx');
        for s=subj
            fprintf('%d\n',s);
            load(fullfile(encodeDir,subj_name{s},'Y_info_glm4_grey_nan.mat'));
            Y.cond = Y.cond-1;
            Y.cond(Y.cond==-1)=29;
            for sess=1:2
                v=ones(29,1);
                S.SN = v*s;
                S.sess = v*sess;
                S.cond = [[1:29]'];
                indx = (Y.sess==sess & Y.cond~=0);
                X=indicatorMatrix('identity',Y.cond(indx,:));
                S.data = pinv(X)*Y.data(indx,:);
                S.data = bsxfun(@minus,S.data,nanmean(S.data));
                T=addstruct(T,S);
            end;
            volIndx = Y.nonZeroInd(1,:);
            clear Y;
        end;
        save(fullfile(encodeDir,'avrgDataStruct.mat'),'T','volIndx','V');
    case 'plot_flatmap'
        x=varargin{1};
        volIndx = varargin{2};
        V = varargin{3};
        X=zeros(V.dim);
        X(volIndx)=x;
        V.fname='tmp.nii';
        spm_write_vol(V,X);
        data=suit_map2surf('tmp.nii','space','SUIT');
        suit_plotflatmap(data,'cscale',[-0.15 0.15]);
        varargout={data};
    case 'plot_averageTasks'
        load(fullfile(encodeDir,'avrgDataStruct.mat'));
        B=zeros(29,size(T.data,2),16);
        for s=1:16
            indx = (T.SN==(s+1));
            X=indicatorMatrix('identity_p',T.cond(indx,1));
            B(:,:,s)=pinv(X)*T.data(indx,:);
        end;
        B=nanmean(B,3);
        for i=1:29
            subplot(6,5,i);
            sc1_imana_jd('plot_flatmap',B(i,:),volIndx,V);
            title(taskNames{i});
        end;
    case 'plot_featureModel'
        load(fullfile(encodeDir,'avrgDataStruct.mat'));
        D=sc1_imana_jd('make_feature_model');
        D=getrow(D,[2:30]);
        B=zeros(32,size(T.data,2),16);
        for s=1:16
            indx = (T.SN==(s+1));
            X=[D.lHand./D.duration D.rHand./D.duration D.saccades./D.duration eye(29)];
            X=bsxfun(@minus,X,mean(X));
            X=bsxfun(@rdivide,X,sum(X.^2));
            X=[X;X];
            B(:,:,s)=(X'*X+eye(32)*0.1)\(X'*T.data(indx,:));
        end;
        B=nanmean(B,3);
        figure(1);
        for i=1:3
            subplot(1,3,i);
            sc1_imana_jd('plot_flatmap',B(i,:),volIndx,V);
        end;
        figure(2);
        
        for i=1:3
            SS =[];
            indx = find(B(i,:)>0.13);
            for s=1:16
                indx = (T.SN==(s+1));
                Xx=indicatorMatrix('identity_p',T.cond(indx,1));
                S.SN = ones(29,1)*s;
                S.task = [1:29]';
                S.act=pinv(Xx)*nanmean(T.data(indx,:),2);
                S.reg = X(1:29,i);
                SS = addstruct(SS,S);
            end;
            subplot(3,1,i);
            SS = tapply(SS,{'task','reg'},{'act'});
            scatterplot(SS.reg,SS.act,'label',taskNames);
        end;
    case 'plot_featureCluster'
        % generate surface maps of the different features and groups
        Bindx={[1],[2],[3],[14 21],[25 15 29]+3,[4 5]+3,[17 18 19 20]+3,[1 2]+3,[3]+3,[24]+3,[6 7 11 12 10]+3,[26 27 28]+3,16+3};
        Bname={'left Hand','right Hand','Saccade','Imagination','Rest','ActionObs','N-Back','NoGo','TOM','verbGen','Pictures','visSearch','Sequences'};
        
        load(fullfile(encodeDir,'avrgDataStruct.mat'));
        D=sc1_imana_jd('make_feature_model');
        D=getrow(D,[2:30]);
        B=zeros(32,size(T.data,2),16);
        for s=1:16
            indx = (T.SN==(s+1));
            X=[D.lHand./D.duration D.rHand./D.duration D.saccades./D.duration eye(29)];
            X=bsxfun(@minus,X,mean(X));
            X=bsxfun(@rdivide,X,sum(X.^2));
            X=[X;X];
            B(:,:,s)=(X'*X+eye(32)*0.1)\(X'*T.data(indx,:));
        end;
        B=nanmean(B,3);
        for i=1:length(Bindx)
            Pat(i,:) = nanmean(B(Bindx{i},:),1);
            subplot(4,4,i);
            DATA(:,i)=sc1_imana_jd('plot_flatmap',Pat(i,:),volIndx,V);
            title(Bname{i});
        end;
        S=caret_struct('metric','data',DATA,'column_name',Bname);
        caret_save(fullfile(caretDir,'suit_flat','cereb.featureCluster.metric'),S);
        keyboard;
    case 'make_feature_model'
        D.duration = [5;15;15;30;15;15;15;15;15;15;30;15;15;30;30;15;15;15;15;15;15;30;15;15;15;15;10;10;10;30];
        D.lHand = [0;0;15;2;0;0;8;7;0;0;0;0;0;0;0;12;12;0;7;0;0;0;3.5;4;0;0;5;5;5;0];
        D.rHand = [0;0;0;0;0;0;0;0;5;5;0;8;7;15;0;12;12;0;0;0;7;0;3.5;4;0;0;0;0;0;0];
        D.saccades = [15 28 28 98 31 31 37 37 29 29 46 38 38 36 41 38 38 20 20 25 25 50 22 22 26 26 32 32 32 45]';
        % complexity
        D.complexity =  [2;1;3;5;5;1;1;1;2;1;1;1;1;3;1;1;5;5;5;5;5;1;3;1;4;1;1;1;2;1];
        % response alternatives
        D.responseAlt = [0;0;1;2;0;0;2;2;2;2;0;2;2;2;0;1;4;1;1;1;1;0;4;4;0;0;2;2;2;0;0];
        % visual
        D.visualStim = [.5;.5;.5;.5;1.5;1.5;1;1;.5;.5;1.5;1;1;0;0;.5;.5;.5;.5;1;1;0;.5;.5;.5;.5;.8;.8;.8;0];
        % auditory
        D.auditoryStim =[0;0;0;0;0;0;0;0;0;0;0;0;0;1;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0];
        % verbal semantics
        D.verbalSem = [0;1;1;1;1;1;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;1;.5;0;0;0;0];
        % working memory
        D.workMem= [1;0;0;.8;1;0;0;0;0;0;0;0;0;0;0;0;0;1;1;1;1;0;0;0;0;0;0;0;0;0];
        % episodic memory
        D.episMem=[1;0;0;0;0;0;0;0;0;0;0;0;0;0;1;0;0;0;0;0;0;1;0;0;1;0;0;0;0;0];
        % visuospatial attention
        D.VisAtt = [0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;.3;.7;1;0];
        % action
        D.action = [0;0;0;0;1;1;0;0;0;0;0;0;0;0;1;0;0;0;0;0;0;0;0;0;.5;0;0;0;0;0];
        
        varargout={D};
    case 'ROI_MDS_overall'              % PLOTTING: Visualise Multidimensional Scaling
        % example: sc1_imana('ROI_MDS_overall',[1:4],1,1,1)
        sn  = varargin{1}; % subjNum
        type = varargin{2};
        reg = varargin{3};
        contrast = varargin{4};
        
        color={[1 1 0] [1 0 1] [0 1 1] [1 0 0] [0 1 0] [0 0 1] [1 1 1] [0 0 0] [1 0.5 0] [0.5 0 1] [0.9 0 0] [1 0.6 0] [0 0.7 0] [0.8 0.5 0] [0.3 0 1] [1 0.4 0.7] [1 1 0] [1 0 1] [0 1 1] [1 0 0] [0 1 0] [0 0 1] [1 1 1] [0 0 0] [1 0.5 0] [0.5 0 1] [0.9 0 0] [1 0.6 0] [0 0.7 0] [0.8 0.5 0] [0.3 0 1] [1 0.4 0.7] };
        CAT.markercolor=color;
        CAT.markerfill=color;
        CAT.markertype='o';
        CAT.markersize=10;
        
        
        numTasks=28;
        
        
        T=load(fullfile(regDir,'glm4',['allRDM_' type '.mat']));
        T=getrow(T,ismember(T.region,reg) & T.method_num ==2 & ismember(T.SN,sn));
        
        % load feature matrix
        F= sc1_imana_jd('make_feature_model');
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
                scatterplot3(Y(:,1),Y(:,2),Y(:,3),'split',tasks,'CAT',CAT,'label',taskNames);
                hold on;
                plot3(0,0,0,'+');
                hold off;
                axis equal;
                
            case 'motor_features'
                
                CF   = [F.lHand./F.duration F.rHand./F.duration F.saccades./F.duration];
                CF = bsxfun(@minus,CF,mean(CF));
                CF=bsxfun(@rdivide,CF,sqrt(sum(CF.^2)));  % Normalize to unit length vectors
                % Call   = eye(numTasks)-ones(numTasks)/numTasks;
                
                [Y,l,V,G] = rsa_classicalMDS(vecRDM,'mode','RDM','contrast',CF);
                scatterplot3(Y(:,1),Y(:,2),Y(:,3),'split',tasks,'CAT',CAT,'label',taskNames,'color',F.lHand./F.duration);
                hold on;
                plot3(0,0,0,'+');
                
                % project the motor features into this space and plot
                yp = Y(:,1:3);
                yp = bsxfun(@rdivide,yp,sqrt(sum(yp.^2)));  % Normalize to unit length vectors
                
                b=pinv(yp)*CF;
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
                
                [Y,l,V,G] = rsa_classicalMDS(vecRDM,'mode','RDM','contrast',Call);
                
                % Reduced Y
                Yr = Y-CF*pinv(CF)*Y;
                
                [V,L]=eig(Yr*Yr');
                [l,i]   = sort(diag(L),1,'descend');           % Sort the eigenvalues
                V       = V(:,i);
                X       = bsxfun(@times,V,sqrt(l'));
                X = real(X);
                scatterplot3(X(:,1),X(:,2),X(:,3),'split',tasks,'CAT',CAT,'label',taskNames,'color',F.visualStim);
                hold on;
                plot3(0,0,0,'+');
                
                hold off;
                axis equal;
                
                
            case 'saccades'
                scatterplot3(Y(:,1),Y(:,2),Y(:,3),'split',tasks,'CAT',CAT,'label',taskNames);
                hold on;
                plot3(0,0,0,'+');
                hold off;
                axis equal;
                
            case 'none'
                Y = rsa_classicalMDS(IPM,'mode','IPM');
        end
    case 'clusterMDS'                   % Does MDS modelling
        % example: sc1_imana_jd('clusterMDS','cerebellum_grey',1)
        sn  = [2:17];
        type = varargin{1};
        reg = varargin{2};
        
        CAT.markertype='o';
        CAT.markersize=10;
        numTasks=28;
        
        
        T=load(fullfile(regDir,['allRDM_' type '.mat']));
        T=getrow(T,T.region==reg & T.method_num ==2 & ismember(T.SN,sn));
        
        % load feature matrix
        F= sc1_imana_jd('make_feature_model');
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
        
        X   = [F.lHand./F.duration F.rHand./F.duration F.saccades./F.duration];
        X   = [X eye(numTasks)];
        X   = bsxfun(@minus,X,mean(X));
        X   = bsxfun(@rdivide,X,sqrt(sum(X.^2)));  % Normalize to unit length vectors
        
        % Reduced Y
        [Y,l,V,G] = rsa_classicalMDS(vecRDM,'mode','RDM');
        B = (X'*X+eye(32)*0.0001)\(X'*Y);
        Yr    = Y  - X(:,1:3)*B(1:3,:);
        clustTree = linkage(Yr,'average');
        numConnections = 15;
        inc = inconsistent(clustTree);
        indx = cluster(clustTree,'cutoff',1);
        
        color={[1 0 0],[0 1 0],[0 0 1],[0.3 0.3 0.3],[1 0 1],[1 1 0],[0 1 1],[0 0 0],[0.8 0.8 0.8],[0.5 0 0]};
        CAT.markercolor= {color{indx}};
        CAT.markerfill = {color{indx}};
        [V,L]   = eig(Yr*Yr');
        [l,i]   = sort(diag(L),1,'descend');           % Sort the eigenvalues
        V       = V(:,i);
        X       = bsxfun(@times,V,sqrt(l'));
        X = real(X);
        scatterplot3(X(:,1),X(:,2),X(:,3),'split',tasks,'CAT',CAT,'label',taskNames);
        hold on;
        plot3(0,0,0,'+');
        
        % Draw connecting lines
        for i=1:15
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
        % view([170 25]);
    case 'compareRDMs'
        type={'cerebellum_grey','cortical_lobes','cortical_lobes','cortical_lobes','cortical_lobes'};
        region=[1,1,2,3,4];
        numTasks=28;
        for i=1:5
            T=load(fullfile(regDir,['allRDM_' type{i} '.mat']));
            for s=1:16
                Ts=getrow(T,T.region==region(i) & T.method_num ==2 & T.SN==s+1);
                IPM = mean(Ts.IPM,1);
                con = indicatorMatrix('allpairs',[1:numTasks]);
                A = rsa_squareIPM(IPM);
                D = rsa.rdm.squareRDM(diag(con*A*con'));
                d = diag(A);  % Distances from zero
                fullRDM(:,:,i,s) = [D d;[d' 0]];
                vecRDM(i,:,s) = rsa.rdm.vectorizeRDM(fullRDM(:,:,i));
            end;
            subplot(3,2,i);
            imagesc(ssqrt(nanmean(fullRDM(:,:,i),4)));
        end;
        
        % Correlations across RDMs
        for s=1:16
            C(:,:,s)=corr(ssqrt(vecRDM(:,:,s)'));
        end;
        subplot(3,2,6);
        
        keyboard;
    case 'compareRDM_cort_cereb'
        T{1}=load(fullfile(regDir,'glm4',['allRDM_162_tessellation_hem.mat']));
        T{2}=load(fullfile(regDir,'glm4',['allRDM_cerebellum_grey.mat']));
        OR=load(fullfile(regDir,'data','162_reorder.mat'));
        ii = OR.regIndx(OR.good==1);
        
        T{1}=getrow(T{1},T{1}.method_num==2 & ismember(T{1}.region,ii));
        T{2}=getrow(T{2},T{2}.method_num==2);
        subj=unique(T{1}.SN)';
        numTasks=29;
        con = indicatorMatrix('allpairs',[1:numTasks]);
        for s=1:length(subj)
            for d=1:2
                D{d}=getrow(T{d},T{d}.SN==subj(s));
                RDM=mean(D{d}.RDM,1);
                S.RDM(:,:,s,d) = squareform(RDM);
            end;
        end;
        subplot(2,2,1);
        imagesc(mean(S.RDM(:,:,:,1),3));
        title('cortex');
        subplot(2,2,2);
        imagesc(mean(S.RDM(:,:,:,2),3));
        title('cerebellum');
        for s=1:length(subj)
            subplot(2,2,3);
            X.d1(s,:)=rsa_vectorizeRDM(S.RDM(:,:,s,1));
            X.d2(s,:)=rsa_vectorizeRDM(S.RDM(:,:,s,2));
            X.b(s,1)=(X.d1(s,:)*X.d2(s,:)')./(X.d1(s,:)*X.d1(s,:)');
            X.pred_d2(s,:)=X.d1(s,:)*X.b(s,:);  % Predicted valued
        end;
        diff_d2=mean(X.d2)-mean(X.pred_d2);
        stderr_d2=stderr(X.d2-X.pred_d2);
        t_d2     = diff_d2./stderr_d2;
        Tdiff    = rsa_squareRDM(t_d2);
        subplot(2,2,4);
        Tdiff(abs(Tdiff)<tinv(0.99,19))=0;
        imagesc(Tdiff);
        keyboard;
    case 'modelCerebRDM'
        TX=load(fullfile(regDir,'glm4',['allRDM_162_tessellation_hem.mat']));
        TY=load(fullfile(regDir,'glm4',['allRDM_cerebellum_grey.mat']));
        OR=load(fullfile(regDir,'data','162_reorder.mat'));
        OR=getrow(OR,OR.good==1);
        ii = OR.regIndx(OR.good==1);
        
        TX=getrow(TX,TX.method_num==2 & ismember(TX.region,ii));
        TY=getrow(TY,TY.method_num==2);
        
        % Set L2 and L1 regularisatio of the regression equation
        lambdaL2 = varargin{1};
        lambdaL1 = varargin{2};
        
        % Just do nonnegative regression using quadratic programming
        subj=unique(TX.SN);
        for s=1:length(subj)
            tyIn=find(TY.SN==subj(s));
            Y=TY.RDM(tyIn,:)';
            X=TX.RDM(TX.SN==subj(s),:)';
            [N,Q]= size(X);
            X =bsxfun(@rdivide,X,sqrt(sum(X.^2,1)));
            XX=X'*X;
            XY=X'*Y;
            A = -eye(Q); % Nonnegativity contraint
            b = zeros(Q,1);
            w = cplexqp(XX+eye(Q)*lambdaL2,ones(Q,1)*lambdaL1-XY,A,b);  % Use ElasticNet
            TY.xx(tyIn,:)   = diag(X'*X)'; % Length of X-vector
            TY.RDMp(tyIn,:) = (X*w)';
            TY.w(tyIn,:)    = w';
        end;
        
        data = ssqrt(mean(TY.w.*sqrt(TY.xx),1));
        for h=1:2
            subplot(2,2,h);
            ii=find(OR.hem==h)';
            sc1_imana_jd('plot_cortex_162',h,data(ii),OR.regIndx(ii)-158*(h-1));
        end;
        subplot(2,2,3);
        scatterplot(mean(TY.RDMp,1)',mean(TY.RDM,1)','identity');
        varargout={TY};
    case 'modelCerebRDM_crossval'  % Crossvalidation across tasks - RDM modelling
        % First find the indices for between-task crossvalidation
        numTask = 29;
        for i=1:numTask
            RDM=zeros(numTask);
            RDM(i,:)=ones(1,numTask);
            RDM(:,i)=ones(numTask,1);
            rdm(i,:)=rsa.rdm.vectorizeRDM(RDM);
        end;
        
        % Load the RDMs
        TX=load(fullfile(regDir,'glm4',['allRDM_162_tessellation_hem.mat']));
        TY=load(fullfile(regDir,'glm4',['allRDM_cerebellum_grey.mat']));
        OR=load(fullfile(regDir,'data','162_reorder.mat'));
        OR=getrow(OR,OR.good==1);
        ii = OR.regIndx(OR.good==1);
        TX=getrow(TX,TX.method_num==2 & ismember(TX.region,ii));
        TY=getrow(TY,TY.method_num==2);
        
        lambdaL2 = varargin{1};
        lambdaL1 = varargin{2};
        
        
        subj=unique(TX.SN);
        
        for s=1:length(subj)
            tyIn=find(TY.SN==subj(s));
            Y=TY.RDM(tyIn,:)';
            X=TX.RDM(TX.SN==subj(s),:)';
            [N,Q]= size(X);
            
            % Now loop across the crossvalidation folds
            for i=1:numTask
                Xtest  = X(rdm(i,:)==1,:);
                Xtrain = X(rdm(i,:)==0,:);
                Ytest  = Y(rdm(i,:)==1,:);
                Ytrain = Y(rdm(i,:)==0,:);
                
                XX=Xtrain'*Xtrain;
                XY=Xtrain'*Ytrain;
                A = -eye(Q); % Nonnegativity contraint
                b = zeros(Q,1);
                w(:,i) = cplexqp(XX+eye(Q)*lambdaL2,ones(Q,1)*lambdaL1-XY,A,b);  % Use ElasticNet
                res = Ytest - Xtest*w(:,i);
                TY.RSS(tyIn,i) = res'*res;
            end;
            TY.xx(tyIn,:)   = diag(X'*X)'; % Length of X-vector
            TY.w(tyIn,:)    = mean(w,2)';
            TY.lambdaL1(tyIn,:) = lambdaL1;
            TY.lambdaL2(tyIn,:) = lambdaL2;
        end;
        varargout={TY};
    case 'modelCerebRDM_crossval_plot'
        T= load(fullfile(baseDir,'RDM_connectivity','modelCerebRDM_crossval.mat'));
        
        OR=load(fullfile(regDir,'data','162_reorder.mat'));
        OR=getrow(OR,OR.good==1);
        ii = OR.regIndx(OR.good==1);
        
        subplot(2,2,1);
        L1L2 = unique([T.lambdaL1 T.lambdaL2],'rows');
        [x,y]=barplot([T.lambdaL1 T.lambdaL2],mean(T.RSS,2));
        
        [~,indx]=min(y);
        L1L2(indx,:)
        Tbest = getrow(T,T.lambdaL1== L1L2(indx,1) & T.lambdaL2== L1L2(indx,2)) ;
        subplot(2,2,2);
        traceplot([1:29],sqrt(Tbest.RSS),'errorfcn','stderr');
        
        data = ssqrt(mean(Tbest.w,1));
        for h=1:2
            subplot(2,2,h+2);
            ii=find(OR.hem==h)';
            sc1_imana_jd('plot_cortex_162',h,data(ii),OR.regIndx(ii)-158*(h-1));
        end;
    case 'corticalRDMeig'
        TX=load(fullfile(regDir,'glm4',['allRDM_162_tessellation_hem.mat']));
        TY=load(fullfile(regDir,'glm4',['allRDM_cerebellum_grey.mat']));
        OR=load(fullfile(regDir,'data','162_reorder.mat'));
        OR=getrow(OR,OR.good==1);
        ii = OR.regIndx(OR.good==1);
        
        TX=getrow(TX,TX.method_num==2 & ismember(TX.region,ii));
        TY=getrow(TY,TY.method_num==2);
        
        
        % Get eigenvalue distribution of the different regions
        subj=unique(TX.SN);
        for s=1:length(subj)
            for i=1:length(ii)
                indx=find(TX.SN==subj(s) & TX.region==ii(i));
                IPM = rsa_squareIPM(TX.IPMc(indx,:));
                TX.IPMeig(indx,:) = eig(IPM)';
            end;
            indx=find(TX.SN==subj(s));
            IPM = rsa_squareIPM(mean(TX.IPMc(indx,:)));
            S.IPMeig(s,:) = eig(IPM)';
        end
        
        TX.numDim = sum(TX.IPMeig>0,2);
        S.numDim = sum(S.IPMeig>0,2);
        
        
        data = TX.numDim;
        for h=1:2
            subplot(2,2,h);
            ii=find(OR.hem==h)';
            sc1_imana_jd('plot_cortex_162',h,data(ii),OR.regIndx(ii)-158*(h-1));
        end;
        
    case 'all162act' % generate summarized data region-by-region data for the betas
        removeInstr = 0;
        condNum = [kron(ones(16,1),[1:29]');ones(16,1)*30];
        partNum = [kron([1:16]',ones(29,1));[1:16]'];
        if (removeInstr)
            idx=condNum>1;
            partNum=partNum(idx,:);
            condNum=condNum(idx,:)-1;
        else
            idx=condNum>0;
        end;
        N=sum(idx);
        
        for s=1:length(goodsubj)
            load(fullfile(encodeDir,'glm4',subj_name{goodsubj(s)},'162_tessellation_hem_glm4_model.mat'));
            Y(:,:,s)=X.Xx(:,idx)';
        end;
        ROI = X.idx';
        
        save(fullfile(encodeDir,'162_tesselation_hem_all.mat'),'Y','partNum','condNum','ROI');
    case 'cortical_covariances' % Covariances between cortical areas in predicted time series
        % variance inflation factor
        load(fullfile(encodeDir,'162_tesselation_hem_all.mat')); % 'Y','partNum','condNum','ROI');
        
        % Figure out the right ones to use
        X=load(fullfile(regDir,'data','162_reorder.mat'));
        Xx=getrow(X,X.newIndx);
        Xx=getrow(Xx,Xx.good==1);
        
        % Make a time series structure
        SPM=load(fullfile(baseDir,'GLM_firstlevel_4','SampleDesignMatrix'));
        for b=1:16
            Tindx(SPM.Sess(b).row,1)=b;
        end;
        runX = indicatorMatrix('identity',Tindx);
        R = eye(size(runX,1))-runX*pinv(runX);
        
        % Calcualte correlations
        numSubj=size(Y,3);
        for s=1:numSubj
            B=Y(:,Xx.regIndx2,s);
            % B(condNum==1,:)=0; % Set Instruction to 0
            predT=SPM.X*B;  % Predicted time series
            predT=R*predT;  % Subtract mean from each run
            
            % Covariance and correlation
            COV(:,:,s)=cov(predT);
            COR(:,:,s)=corrcov(COV(:,:,s));
            
            % Variance inflation factor for each
            T.SN(s,1)=s;
            T.VIF(s,:)=diag(inv(COR(:,:,s)))';
            T.VAR(s,:)=diag(COV(:,:,s));
            T.VARB(s,:)=diag(inv(COV(:,:,s)));
        end;
        
        subplot(2,2,1);
        imagesc(mean(COR,3));
        data=mean(T.VAR,1);
        for h=1:2
            subplot(2,2,h+2);
            ii=find(Xx.hem==h)';
            sc1_imana_jd('plot_cortex_162',h,data(ii),Xx.regIndx(ii)-158*(h-1));
        end;
    case 'encoding_betas'
        % sc1_imana_jd('encoding_betas',[2:15 17:22],'162_tessellation_hem_cplexqp_grey',25);
        sn=varargin{1};
        file = varargin{2};
        lambda=varargin{3};
        X=load(fullfile(regDir,'data','162_reorder.mat'));
        Xx=getrow(X,X.good==1);
        
        for s=1:length(sn)
            load(fullfile(encodeDir,'glm4','encode_1',subj_name{sn(s)},['encode_' file '.mat']));
            B=Yp.betas(Yp.idxLambda==lambda,:);
            B=bsxfun(@rdivide,B,sum(B,1));
            T.meanBeta(s,:)=mean(B,2)';
        end;
        data = mean(T.meanBeta,1);
        for h=1:2
            subplot(1,2,h);
            ii=find(Xx.hem==h)';
            sc1_imana_jd('plot_cortex_162',h,data(Xx.regIndx2(ii)),Xx.regIndx(ii)-158*(h-1));
        end;
        
    case 'plot_cortex_162'
        h=varargin{1};   %
        data=varargin{2};
        indx=varargin{3};
        D=caret_load(fullfile(caretDir,'fsaverage_sym',hemName{h},sprintf([hem{h} '.tessel162_new.metric'])));
        FData=nan(size(D.data));
        for i=1:length(data)
            FData(D.data==indx(i),1)=data(i);
        end;
        coord=fullfile(caretDir,'fsaverage_sym',hemName{h},[hem{h} '.FLAT.coord']);
        topo=fullfile(caretDir,'fsaverage_sym',hemName{h},[hem{h} '.CUT.topo']);
        if (h==1)
            caret_plotflatmap('coord',coord,'topo',topo,'data',FData,'xlims',[-200 150],'ylims',[-140 140]);
        else
            caret_plotflatmap('coord',coord,'topo',topo,'data',FData,'xlims',[-150 200],'ylims',[-140 140]);
        end;
    case 'cortical_pattern_consistency_all'
        load(fullfile(encodeDir,'162_tesselation_hem_all.mat'));
        X=indicatorMatrix('identity',condNum);
        numSubj=length(goodsubj);
        % Project down to condition space
        for s=1:numSubj
            Yc(:,:,s)=X*pinv(X)*Y(:,:,s);
        end;
        C1=intersubj_corr(Y);
        C2=intersubj_corr(Yc);
        C3=intersubj_corr(Y-Yc);
        subplot(3,1,1);
        imagesc(C1);
        title('alldata');
        subplot(3,1,2);
        imagesc(C2);
        title('means');
        subplot(3,1,3);
        imagesc(C3);
        title('residuals');
        varargout={C1,C2};
    case 'cortical_pattern_consistency_session' % Between sessions / subejcts
        load(fullfile(encodeDir,'162_tesselation_hem_all.mat'));
        numSubj=length(goodsubj);
        sessNum = (partNum>8)+1;
        for se=1:2
            indx = find(sessNum==se);
            X=indicatorMatrix('identity',condNum(indx,:));
            for subj = 1:numSubj
                Yp(:,:,subj+(se-1)*numSubj)=X*pinv(X)*Y(indx,:,subj);
                Yf(:,:,subj+(se-1)*numSubj)=Y(indx,:,subj);
            end;
        end;
        Cf=intersubj_corr(Yf);
        Cp=intersubj_corr(Yp);
        Cr=intersubj_corr(Yf-Yp);
        subplot(3,2,1);
        imagesc(Cf);
        title('betas');
        subplot(3,2,2);
        [a1,a2,a3]=bwse_corr(Cf);
        barplot([],[a2 a1 a3],'XTickLabel',{'DiffSess','DiffSubj','DiSeDiSu'});
        subplot(3,2,3);
        imagesc(Cp);
        [a1,a2,a3]=bwse_corr(Cp);
        title('means');
        subplot(3,2,4);
        barplot([],[a2 a1 a3],'XTickLabel',{'DiffSess','DiffSubj','DiSeDiSu'});
        subplot(3,2,5);
        imagesc(Cr);
        [a1,a2,a3]=bwse_corr(Cr);
        title('residuals');
        subplot(3,2,6);
        barplot([],[a2 a1 a3],'XTickLabel',{'DiffSess','DiffSubj','DiSeDiSu'});
    case 'cortical_pattern_consistency_ts' % Consistency between time series
        load(fullfile(regDir,'glm4','ts_162_tessellation_hem_all.mat'));
        Ch=intersubj_corr(Yhat);
        Cr=intersubj_corr(Yres);
        subplot(1,3,1);
        imagesc(Ch);
        subplot(1,3,2);
        imagesc(Cr);
        subplot(1,3,3);
        colorbar;
        fprintf('predicted TS: %2.2f\n',1-mean(squareform(1-Ch)));
        fprintf('residual  TS: %2.2f\n',1-mean(squareform(1-Cr)));
        set(gcf,'PaperPosition',[2 2 6 2]);
    case 'whiteStim'
        secondM = 'mean'; %
        vararginoptions(varargin,{'secondM'});
        load(fullfile(encodeDir,'162_tesselation_hem_all.mat'));
        numSubj=length(goodsubj);
        X=indicatorMatrix('identity',condNum);
        for s=1:numSubj
            for c=1:max(condNum)
                idx= find(condNum==c);
                switch (secondM)
                    case 'mean'
                        B(c,:,s)=mean(Y(idx,:,s));
                    case 'all'
                        B(c,:,s)=Y(idx,:,s);
                end;
            end;
        end;
        
        % Cost: variance Inflation factor
        % B=[1 0;-1 0;2 0;-2 0;0 0;0 1;0 -1];
        numCond=size(B,1);
        
        for s=1:numSubj
            PR.objective = @(x) estimationVariance(x,B(:,:,s));
            PR.solver = 'fminsearch';
            PR.x0    = zeros(numCond,1);
            PR.options.MaxFunEvals = 2000000;
            PR.options.MaxIter = 2000000;
            [x,f]= fminsearch(PR);
            W(s,:)=exp(x)/sum(exp(x))
        end;
        varargout={W};
    case 'ROI_get_meants'                % Get univariately pre-whitened mean times series for each region
        sn=varargin{1}; % subjNum
        glm=varargin{2}; % glmNum
        type=varargin{3}; % 'cortical_lobes','whole_brain','yeo','desikan','cerebellum','yeo_cerebellum'
        
        B = [];
        glmDir =[baseDir sprintf('/GLM_firstlevel_%d',glm)];
        subjs=length(sn);
        
        for s=1:subjs,
            glmDirSubj=fullfile(glmDir, subj_name{sn(s)});
            load(fullfile(glmDirSubj,'SPM_light.mat'));
            
            % load data
            tic;
            load(fullfile(regDir,'data',subj_name{sn(s)},sprintf('regions_%s.mat',type))); % 'regions' are defined in 'ROI_define'
            SPM=spmj_move_rawdata(SPM,fullfile(imagingDir,subj_name{sn(s)}));
            % Get the raw data files
            V=SPM.xY.VY;
            VresMS = spm_vol(fullfile(glmDirSubj,'ResMS.nii'));
            fprintf('Moved %d\n',toc);
            clear SPM;
            % Get time series data
            tic;
            Y = region_getdata(V,R);  % Data is N x P
            resMS = region_getdata(VresMS,R);
            fprintf('Data %d\n',toc);
            
            % Spatially prewhiten and save
            Data=zeros(numel(V),numel(R));
            for r=1:numel(R), % R is the output 'regions' structure from 'ROI_define'
                Y{r}=bsxfun(@rdivide,Y{r},sqrt(resMS{r}));
                Data(:,r)=nanmean(Y{r},2);
            end;
            
            filename=(fullfile(regDir,'data',subj_name{sn(s)},sprintf('ts_%s.mat',type)));
            save(filename,'Data');
            fprintf('ts saved for %s (%s) for %s \n',subj_name{sn(s)},sprintf('glm%d',glm),type);
        end
    case 'ROI_get_ts'                % Get univariately pre-whitened time series for each voxel of a region
        sn=varargin{1}; % subjNum
        glm=varargin{2}; % glmNum
        type=varargin{3}; % 'Cerebellum_grey'
        
        B = [];
        glmDir =[baseDir sprintf('/GLM_firstlevel_%d',glm)];
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
            filename=(fullfile(regDir,'glm4',subj_name{sn(s)},sprintf('ts_%s.mat',type)));
            save(filename,'Yres','Yhatm','Yhatr','B');
            fprintf('ts saved for %s (%s) for %s \n',subj_name{sn(s)},sprintf('glm%d',glm),type);
        end
    case 'ROI_ts_allsubj'   % Make a structure of all cortical time series of all subject - also seperate out residual from
        sn=varargin{1}; % subjNum
        glm=varargin{2}; % glmNum
        type=varargin{3}; % 'cortical_lobes','whole_brain','yeo','desikan','cerebellum','yeo_cerebellum'
        
        glmDir =[baseDir sprintf('/GLM_firstlevel_%d',glm)];
        numSubj=length(sn);
        
        for s=1:numSubj
            fprintf('%d\n',s);
            % load data
            glmDirSubj=fullfile(glmDir, subj_name{sn(s)});
            load(fullfile(glmDirSubj,'SPM_light.mat'));
            T=load(fullfile(glmDirSubj,'SPM_info.mat'));
            % load data
            filename=(fullfile(regDir,'data',subj_name{sn(s)},sprintf('ts_%s.mat',type)));
            load(filename);
            
            reg_interest=[SPM.xX.iH SPM.xX.iC];
            Yfilt = SPM.xX.W*Data;
            B(:,:,s) = SPM.xX.pKX*Yfilt;                              %-Parameter estimates
            Yres(:,:,s) = spm_sp('r',SPM.xX.xKXs,Yfilt);             %-Residuals
            % Decompose betas into mean and residuals
            Z=indicatorMatrix('identity',T.cond);
            Bm = Z*pinv(Z)*B(reg_interest,:,s);   % Mean betas
            Br = B(reg_interest,:,s)-Bm;
            Yhatm(:,:,s) = SPM.xX.xKXs.X(:,reg_interest)*Bm; %- predicted values
            Yhatr(:,:,s) = SPM.xX.xKXs.X(:,reg_interest)*Br; %- predicted values
        end;
        save(fullfile(regDir,sprintf('glm%d',glm),sprintf('ts_%s_all.mat',type)),'Yres','Yhatm','Yhatr','B');
    case 'ROI_interregion_corr'
        load(fullfile(regDir,'glm4','ts_162_tessellation_hem_all.mat'));
        X=load(fullfile(regDir,'data','162_reorder.mat'));
        Xx=getrow(X,X.newIndx);
        ii = Xx.regIndx(Xx.good==1);
        Xx=getrow(Xx,Xx.good==1);
        Yhat=Yhat(:,ii,:);
        Yres=Yres(:,ii,:);
        
        numsubj = size(Yhat,3);
        N = size(Yhat,1);
        Ch = zeros(size(Yhat,2),size(Yhat,2),size(Yhat,3));
        Cr =  zeros(size(Yhat,2),size(Yhat,2),size(Yhat,3));
        for s=1:numsubj
            for se=1:2
                idx = [1:N/2]+(se-1)*N/2;
                Ch(:,:,s,se)=cov(Yhat(idx,:,s));
                Cr(:,:,s,se)=cov(Yres(idx,:,s));
                Rh(:,:,s,se)=corrcov(Ch(:,:,s,se));
                Rr(:,:,s,se)=corrcov(Cr(:,:,s,se));
            end;
            hh(s,1)=mycorr([rsa_vectorizeRDM(Rh(:,:,s,1))',rsa_vectorizeRDM(Rh(:,:,s,2))']);
            rr(s,1)=mycorr([rsa_vectorizeRDM(Rr(:,:,s,1))',rsa_vectorizeRDM(Rr(:,:,s,2))']);
            rh(s,1)=mycorr([rsa_vectorizeRDM(Rh(:,:,s,1))',rsa_vectorizeRDM(Rr(:,:,s,2))']);
            rh(s,2)=mycorr([rsa_vectorizeRDM(Rr(:,:,s,1))',rsa_vectorizeRDM(Rh(:,:,s,2))']);
        end;
        subplot(1,3,1);
        barplot([],[hh mean(rh,2) rr]);
        set(gca,'XTickLabel',{'Fitted','Cross','Resid'})
        drawline(mean(sqrt(hh.*rr)),'dir','horz');
        title('Correlation of Correlation');
        % Plots for lobes
        borders=find(diff(Xx.lobe)~=0);
        
        subplot(1,3,2);
        mRh = mean(mean(Rh,3),4);
        imagesc(mRh);
        drawline(borders);
        drawline(borders,'dir','horz');
        
        title('Fitted');
        subplot(1,3,3);
        mRr = mean(mean(Rr,3),4);
        imagesc(mRr);
        drawline(borders);
        drawline(borders,'dir','horz');
        title('Residuals');
        
        set(gcf,'PaperPosition',[2 2 9 2.5]);
        wysiwyg;
        
        
        varargout={mRr};
        save(fullfile(regDir,'glm4','Covariance_by_session.mat'),...
            'Ch','Cr','Rr','Rh','Xx');
    case 'ROI_interregion_corr_intersubj' % Intersubject corrrelation of connectivity matrix
        load(fullfile(regDir,'glm4','Covariance_by_session.mat'));
        for se=1:2
            
        end;
        
    case 'crossval_space_overlap'   % Determine relative eigenvalues after projection
        load(fullfile(regDir,'glm4','Covariance_by_session.mat'));
        [numReg,~,numSubj,numSess]=size(Ch);
        P=size(Ch,1);
        D=[];
        for i=1:numSubj
            for k=1:2 % Sessions
                [T.ev(1,:),T.ev(5,:)]=sc1_subspace_overlap(Ch(:,:,i,k),Ch(:,:,i,3-k));
                [T.ev(2,:),T.ev(6,:)]=sc1_subspace_overlap(Cr(:,:,i,k),Cr(:,:,i,3-k));
                T.ev(3,:)=sc1_subspace_overlap(Cr(:,:,i,k),Ch(:,:,i,3-k));
                T.ev(4,:)=sc1_subspace_overlap(Ch(:,:,i,k),Cr(:,:,i,3-k));
                T.session1=[k;k;k;k;k;k];
                T.session2=[3-k;3-k;3-k;3-k;k;k];
                T.subj=ones(6,1)*i;
                T.data1 = [1;2;2;1;1;2];
                T.data2 = [1;2;1;2;1;2];
                T.type  = [1;2;3;4;5;6];
                D=addstruct(D,T);
            end;
        end;
        CAT.linestyle={':';':';'-';'-';'--';'--'};
        CAT.linecolor={'r';'b';'r';'b';'r';'b'};
        
        D.cev  = cumsum(D.ev,2);
        D.cevn = bsxfun(@rdivide,D.cev,D.cev(:,end));  % Normalized cumulative eigenvalues
        D.evn  = bsxfun(@rdivide,D.ev,D.cev(:,end));   % Normalized eigenvalues
        A      = 1-[zeros(size(D.cev,1),1) D.cevn(:,1:end-1)];
        D.eevn = bsxfun(@rdivide,A,[P:-1:1]);
        
        subplot(1,2,1);
        traceplot([1:P],D.cevn(:,1:P),'split',D.type,'leg','auto','CAT',CAT);
        subplot(1,2,2);
        traceplot([1:P],D.evn(:,1:P),'split',D.type,'subset',D.type<3);
        hold on;
        traceplot([1:P],D.eevn(:,1:P),'split',D.type,'subset',D.type<3,'linestyle',':');
        hold off;
        set(gcf,'PaperPosition',[2 2 8 4]);
        wysiwyg;
        varargout={D};
    case 'crossval_space_overlap_simulate'   % Check out a couple of different scenarious
        P=200;
        N=1000;
        sigm=0.5;
        eigC=zeros(1,P);
        eigX=zeros(1,P);eigX(1:3)=[100 30 10];
        eigY=zeros(1,P);eigY(1:30)=1;
        D=[];
        for n=1:10
            A=randn(P,P);
            [Wc,l]=eig(A*A');
            C=normrnd(0,1,N,P)*diag(sqrt(eigC))*Wc;
            A=randn(P,P);
            [Wx,l]=eig(A*A');
            X=C+normrnd(0,1,N,P)*diag(sqrt(eigX))*Wx;
            X1=X+normrnd(0,sigm,N,P);
            X2=X+normrnd(0,sigm,N,P);
            
            A=randn(P,P);
            [Wy,l]=eig(A*A');
            Y=C+normrnd(0,1,N,P)*diag(sqrt(eigY))*Wy;
            Y1=Y+normrnd(0,sigm,N,P);
            Y2=Y+normrnd(0,sigm,N,P);
            Cx1=cov(X1);
            Cx2=cov(X2);
            Cy1=cov(Y1);
            Cy2=cov(Y2);
            
            T.ev(1,:)=sc1_subspace_overlap(Cx2,Cx1);
            T.ev(2,:)=sc1_subspace_overlap(Cy2,Cy1);
            T.ev(3,:)=sc1_subspace_overlap(Cy1,Cx1);
            T.ev(4,:)=sc1_subspace_overlap(Cx1,Cy1);
            T.ev(5,:)=sc1_subspace_overlap(Cx1,Cx1);
            T.ev(6,:)=sc1_subspace_overlap(Cy1,Cy1);
            T.data1 = [1;2;2;1;1;2];
            T.data2 = [1;2;1;2;1;2];
            T.type  = [1;2;3;4;5;6];
            D=addstruct(D,T);
        end;
        CAT.linestyle={':';':';'-';'-';'--';'--'};
        CAT.linecolor={'r';'b';'r';'b';'r';'b'};
        D.cev  = cumsum(D.ev,2);
        D.cevn = bsxfun(@rdivide,D.cev,D.cev(:,end));  % Normalized cumulative eigenvalues
        D.evn  = bsxfun(@rdivide,D.ev,D.cev(:,end));   % Normalized eigenvalues
        A      = 1-[zeros(size(D.cev,1),1) D.cevn(:,1:end-1)];
        D.eevn = bsxfun(@rdivide,A,[P:-1:1]);
        
        subplot(1,2,1);
        traceplot([1:P],D.cevn(:,1:P),'split',D.type,'leg','auto','CAT',CAT);
        subplot(1,2,2);
        traceplot([1:P],D.evn(:,1:P),'split',D.type,'subset',D.type<3);
        hold on;
        traceplot([1:P],D.eevn(:,1:P),'split',D.type,'subset',D.type<3,'linestyle',':');
        hold off;
        set(gcf,'PaperPosition',[2 2 8 4 ]);
        wysiwyg;
        varargout={D};
    case 'make_reorder_mat' % consolidates the by-lobe reordering and removal of medial wall
        P=caret_load(fullfile(caretDir,'fsaverage_sym','LeftHem','lh.tessel162.paint'));
        PL=caret_load(fullfile(caretDir,'fsaverage_sym','LeftHem','lh.lobes.paint'));
        PD=caret_load(fullfile(caretDir,'fsaverage_sym','LeftHem','lh.desikan.paint'));
        D.lobe=pivottable(P.data,[],PL.data,'median');
        D.desikan=pivottable(P.data,[],PD.data,'median');
        D.numVert=pivottable(P.data,[],PD.data,'length');
        D.good = (D.numVert<800 | D.numVert>3000)+1;
        [Y,D.newIndx]=sortrows([D.good D.lobe D.desikan]);
        DR = D;
        D.hem=ones(158,1);
        DR.hem=ones(158,1)*2;
        DR.newIndx = D.newIndx+size(D.good,1);
        D=addstruct(D,DR);
        D.regIndx = [1:316]';
        D.regIndx2 = [1:148 NaN 149:305 NaN 306:314]'; % This is the index into the reduced structure!
        
        save(fullfile(regDir,'data','162_reorder.mat'),'-struct','D');
    case 'Correlation_by_task'
        load(fullfile(regDir,'glm4','ts_162_tessellation_hem_all.mat'));
        X=load(fullfile(regDir,'data','162_reorder.mat'));
        Xx=getrow(X,X.newIndx);
        ii = Xx.regIndx(Xx.good==1);
        
        Yhat=Yhat(:,ii,:);
        Yres=Yres(:,ii,:);
        Y = Yhat + Yres;
        [N,P,numSubj] = size(Y);
        
        D=dload(fullfile(behavDir,'s03','sc1_s03.dat'));
        D=getrow(D,D.runNum>=51);
        [taskName,~,T.task]=unique(D.taskName);
        for i=1:length(T.task)
            T.run(i,1) = D.runNum(i)-50;
            T.start(i,1) = D.TRreal(i)+(T.run(i)-1)*N/16+7;
            T.timeIndx(i,:)=[T.start(i,1):T.start(i,1)+29];
        end;
        T.sess = (T.run>8)+1;
        for s=1:numSubj
            for se=1:2
                for t=1:17
                    idx=find(T.sess==se & T.task==t);
                    tidx=vec(T.timeIndx(idx,:));
                    Chat(:,:,t,s,se)=cov(Yhat(tidx,:,s));
                    Cres(:,:,t,s,se)=cov(Yres(tidx,:,s));
                    Mhat(:,t,s,se)=mean(Yhat(tidx,:,s));
                    Mres(:,t,s,se)=mean(Yres(tidx,:,s));
                end;
            end;
        end;
        save(fullfile(regDir,'data','correlation_by_task.mat'),...
            'Chat','Cres','Mhat','Mres','taskName');
    case 'MDS_plot'
        load((fullfile(regDir,'data','correlation_by_task.mat')));
        [numROI,numTask,numSubj,numSess]=size(M);
        for s=1:numSubj
            G(:,:,s)=(Mhat(:,:,s,1)'*Mhat(:,:,s,2)+Mhat(:,:,s,2)'*Mhat(:,:,s,1))/2;
        end;
        Gm=mean(G,3);
        C=indicatorMatrix('allpairs',[1:17]');
        Y=pcm_classicalMDS(Gm,'contrast',C,'rotation','varimax');
        scatterplot3(Y(:,1),Y(:,2),Y(:,3),'label',taskName);
    case 'meanTaskvsRes'
        load((fullfile(regDir,'data','correlation_by_task.mat')));
        [numROI,numTask,numSubj,numSess]=size(Mhat);
        for s=1:numSubj
            for se=1:2
                MM(:,:,s,se)= cov(Mhat(:,:,s,se)');
                RR(:,:,s,se)=mean(Cres(:,:,:,s,se),3);
                HH(:,:,s,se)=mean(Chat(:,:,:,s,se),3);
                rM(:,:,s,se)=corrcov(MM(:,:,s,se));
                rR(:,:,s,se)=corrcov(RR(:,:,s,se));
                rH(:,:,s,se)=corrcov(HH(:,:,s,se));
                R{se}=[rsa_vectorizeRDM(rM(:,:,s,se))',rsa_vectorizeRDM(rH(:,:,s,se))',rsa_vectorizeRDM(rR(:,:,s,se))'];
            end;
            CM(:,:,s)=corrcoef([R{1} R{2}]);
            
        end;
        Cmm=mean(CM,3);
        Cmm=Cmm(1:3,4:6);
        subplot(1,2,1);
        imagesc(Cmm);
        colorbar;
        set(gca,'YTick',[1 2 3],'XTick',[1 2 3]);
        set(gca,'YTickLabel',{'Mean','VarFitted','VarRes'},'XTickLabel',{'Mean','VarFitted','VarRes'});
        area=[Cmm(1,1) Cmm(2,2) Cmm(3,3)];
        area=area./(1-area); % Going from retest correlation to variance
        r12=(Cmm(1,2)+Cmm(2,1))/2;
        r13=(Cmm(1,3)+Cmm(3,1))/2;
        r23=(Cmm(2,3)+Cmm(3,2))/2;
        int12 = r12 * sqrt((area(1)+1)*(area(2)+1));
        int13 = r13 * sqrt((area(1)+1)*(area(3)+1));
        int23 = r23 * sqrt((area(2)+1)*(area(3)+1));
        int123 = min([int12 int13 int23])/3;
        subplot(1,2,2);
        venn(area,[int12 int13 int23 0]);
    case 'Between_task_differences'
        load(fullfile(regDir,'data','correlation_by_task.mat'));
        numSubj = size(Chat,4);
        T=[];
        for s=1:numSubj
            MMhat = [Mhat(:,:,s,1) Mhat(:,:,s,2)];
            MMres = [Mres(:,:,s,1) Mres(:,:,s,2)];
            for i=1:17
                CChat(:,i) = vec(Chat(:,:,i,s,1));
                CChat(:,i+17)= vec(Chat(:,:,i,s,2));
                CCres(:,i) = vec(Cres(:,:,i,s,1));
                CCres(:,i+17)= vec(Cres(:,:,i,s,2));
            end;
            R{1}(:,:,s)=corr(MMhat);
            R{2}(:,:,s)=corr(MMres);
            R{3}(:,:,s)=corr(CChat);
            R{4}(:,:,s)=corr(CCres);
        end;
        titstr={'mean predicted','mean residual','variance predicted','variance residual'};
        
        for i=1:4
            subplot(3,2,i);
            imagesc(mean(R{i},3));
            drawline(17.5,'dir','horz');
            drawline(17.5);
            title(titstr{i});
            
            for s=1:numSubj
                D.type=[i;i];
                D.SN  =[s;s];
                A = R{i}(18:end,1:17,s);
                K=size(A,1);
                D.avrgR(1,1) = mean(diag(A));
                D.avrgR(2,1) = (sum(sum(A))-trace(A))/(K*(K-1));
                D.wb   = [1;2];
                T=addstruct(T,D);
            end;
        end;
        
        subplot(3,2,[5 6]);
        barplot([T.type T.wb],T.avrgR);
        set(gcf,'PaperPosition',[2 2 4 7]);
        wysiwyg;
        varargout={T};
    case 'tsVarianceByTask'
        load(fullfile(regDir,'data','correlation_by_task.mat'));
        [numReg,~,numTask,numSubj,numSess]= size(Chat);
        
        % Before combining tasks, see what the variance introduced by each
        % task in the different regions
        T=[];
        for s=1:numSubj
            for t=1:numTask
                D.SN = s;
                D.task = t;
                mChat = mean(Chat(:,:,t,s,:),5);
                D.varHat = mean(diag(mChat)); % variance introduced by task
                mCres = mean(Cres(:,:,t,s,:),5);
                D.varRes = mean(diag(mCres)); % variance introduced by task
                T=addstruct(T,D);
            end;
        end;
        lineplot(T.task,[T.varHat T.varRes]);
    case 'tsWhiteStim'
        type='mean';
        load(fullfile(regDir,'data','correlation_by_task.mat'));
        [numReg,~,numTask,numSubj,numSess]= size(Chat);
        
        for s=1:numSubj
            for t=1:numTask
                switch (type)
                    case 'mean'
                        B(t,:,s)=mean(Mhat(:,t,s,:),4)';
                end;
            end;
        end;
        
        % Cost: variance Inflation factor
        for s=1:numSubj
            fprintf('subject %d\n',s);
            PR.objective = @(x) estimationVariance(x,B(:,:,s));
            PR.solver = 'fminsearch';
            PR.x0    = zeros(numTask,1);
            PR.options.MaxFunEvals = 2000000;
            PR.options.MaxIter = 2000000;
            [x,f]= fminsearch(PR);
            W(s,:)=exp(x)/sum(exp(x))
        end;
        varargout={W};
    otherwise
        disp('there is no such case.')
end;

function C=intersubj_corr(Y)
numSubj=size(Y,3);
for i=1:numSubj
    for j=1:numSubj
        C(i,j)=nansum(nansum(Y(:,:,i).*Y(:,:,j)))/...
            sqrt(nansum(nansum(Y(:,:,i).*Y(:,:,i)))*...
            nansum(nansum(Y(:,:,j).*Y(:,:,j))));
    end;
end;

function [DiffSubjSameSess,SameSubjDiffSess,DiffSubjDiffSess]=bwse_corr(C);
N=size(C,1);
n=N/2;
sess = [ones(1,n) ones(1,n)*2];
subj = [1:n 1:n];
SameSess = bsxfun(@eq,sess',sess);
SameSubj = bsxfun(@eq,subj',subj);
DiffSubjSameSess=mean(C(~SameSubj & SameSess));
SameSubjDiffSess=mean(C(SameSubj & ~SameSess));
DiffSubjDiffSess=mean(C(~SameSubj & ~SameSess));
ROI
%  Cost function: total estimation variance of stimulation
% after removing the mean activity
function tvar=estimationVariance(x,B)
w=exp(x);
P=size(B,2);
wB=bsxfun(@times,B,w);
m=sum(wB,1)/sum(w);
X=bsxfun(@minus,B,m);
Gr=X'*diag(w)*X/sum(w);
L=eye(P)*0.01;
tvar=trace(inv(Gr+L));

