rootDir = '/Users/mking/Dropbox (Diedrichsenlab)/Cerebellum_Cognition/data/sc2';
fileDir = '/Users/mking/Dropbox (Diedrichsenlab)/Cerebellum_Cognition/matlab/sc2/task_stimuli';

fileNames=dir(fullfile(fileDir,'emotionProcess','*.avi*'));

fileNums=[1:length(fileNames)];

% sort files
for i=1:length(fileNames),
    % determine condition
    if ~isempty(strfind(fileNames(i).name,'Scram'))
        conditionIdx(i)=2;
    else
        conditionIdx(i)=1;
    end
end

for t=1:24,
    
    if (mod(t,2)==0)
        conditionOrder = kron([1;2],ones(5,1)); % 1-intact; 2-scrambled
        idx=[randsample(fileNums(conditionIdx==1),5),randsample(fileNums(conditionIdx==2),5)]; 
    else
        conditionOrder = kron([2;1],ones(5,1));
        idx=[randsample(fileNums(conditionIdx==2),5),randsample(fileNums(conditionIdx==1),5)];
    end;
    
    for i=1:10,
        outFileNames=char(fileNames(idx(i)).name);
        T.outFileNames{i,1}=fullfile(fileDir,'emotionProcess',outFileNames); 
    end
    
    filename = fullfile(fileDir,'emotionProcess',sprintf('/emotionProcess%d.txt',t));
    dsave(filename, T);
    
end