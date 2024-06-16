function varargout=sc1sc2_imana_jd(what,varargin)
% Matlab script to do joint analyses for sc1 and sc2 experiments
%==========================================================================
type=[];
% % (1) Directories
rootDir           = '/Users/jdiedrichsen/Data/super_cerebellum';
sc1Dir            = [rootDir '/sc1'];
sc2Dir            = [rootDir '/sc2'];
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

%==========================================================================

switch(what)
    case 'RDM_reliability' 
        load(fullfile(sc2Dir,regDir,'glm4','G_hat_sc1_sc2_sess_cerebellum.mat')); 
        D=dload(fullfile(rootDir,'sc1_sc2_taskConds.txt')); 
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
        myboxplot([],[T.within1 T.within2 T.across],'style_tukey');
        set(gca,'XTickLabel',{'SC1','SC2','across'}); 
        set(gcf,'PaperPosition',[2 2 4 3]); 
        wysiwyg; 
        ttest(sqrt(T.within1.*T.within2),T.across,2,'paired'); 
        varargout={T}; 
    otherwise
        disp('there is no such case.')
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

