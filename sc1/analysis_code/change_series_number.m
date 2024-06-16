function change_series_number

subj_name  = {'s1_1'};   

fscanNum_old = {[2,3,4]};
fscanNum_new = {[10,11,12]};

NiiRawName = {'160413101535DST131221107524367007',...
              }; 
          
baseDir         = sprintf('/Users/mking/Documents/Cerebellum_Cognition/data/results'); dircheck(baseDir);
dicomDir        =[baseDir '/imaging_data_dicom'];          dircheck(dicomDir);

sn = 1; 

numDummys = 3;                                                        
numTRs    = 601; 

for i=1:length(fscanNum_old{sn})
    
    for j=1:numTRs-numDummys,
        oldfile{j} = fullfile(dicomDir,subj_name{sn},sprintf('series%2.2d',fscanNum_new{sn}(i)),...
            sprintf('f%s-%4.4d-%5.5d-%6.6d-01.nii',NiiRawName{sn},fscanNum_old{sn}(i),j+numDummys,j+numDummys));
        newfile{j} = fullfile(dicomDir,subj_name{sn},sprintf('series%2.2d',fscanNum_new{sn}(i)),...
            sprintf('f%s-%4.4d-%5.5d-%6.6d-01.nii',NiiRawName{sn},fscanNum_new{sn}(i),j+numDummys,j+numDummys));

    movefile(oldfile{j},newfile{j});  
    end
end