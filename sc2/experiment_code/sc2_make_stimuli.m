function sc2_make_stimuli(what,varargin)

% Set-Up Directories
fileDir = '/Users/mking/Dropbox (Diedrichsenlab)/Cerebellum_Cognition/matlab/sc2/task_stimuli';

switch (what)
    
    case 'CPRO'
        % make task sets
        logic={'Both','Not Both','Either','Neither'};
        sensory={'Red','Vertical','Blue','Horizontal'};
        motor={'Left Index','Left Middle','Right Index','Right Middle'};
        logicNum=[1:4];
        sensoryNum=[5:8];
        motorNum=[9:12];
        
        % figure out task-sets
        idx=1;
        for l=1:numel(logic),
            for s=1:numel(sensory),
                for m=1:numel(motor),
                    taskSetsName(idx,:)={logic{l};sensory{s};motor{m}};
                    taskSetNum(idx,:)=[logicNum(l),sensoryNum(s),motorNum(m)];
                    idx=idx+1;
                end
            end
        end
        [~,I]=Shuffle([1:length(taskSetNum)]);
        T.Name1=taskSetsName(I',1);
        T.Name2=taskSetsName(I',2);
        T.Name3=taskSetsName(I',3);
        T.Num1=taskSetNum(I',1);
        T.Num2=taskSetNum(I',2);
        T.Num3=taskSetNum(I',3);
        CPRODir=fullfile(fileDir,'CPRO');
        filename=fullfile(CPRODir,'CPRO_taskSets.txt');
        dsave(filename,T);
    case 'match2sample'
        taskNum=varargin{1};
        
        % original
        mat=[zeros(4,9);ones(5,9)];
        mat1=Shuffle(mat);
        mat2=mat1;
        mat3=mat2;
        [r,c] = size(mat1);
        
        % easy
        I=find(mat2==0);
        easy=randsample(I,round(length(I)*50/100));
        mat2(easy)=1;
        
        % difficult
        hard=randsample(I,round(length(I)*20/100));
        mat3(hard)=1;
        
        matFiles={mat1,mat2,mat3};
        matNames={'orig','easy','difficult'};
        
        % make figures
        for f=1:length(matFiles),
            FigHandle = figure(f);
            whitebg(gcf,[0 0 0])
            fig=gcf;
            set(FigHandle, 'Position', [700, 700, 640, 360]);
            fig.InvertHardcopy='off'; 
            imagesc((1:c)+0.5,(1:r)+0.5,matFiles{f});
            axis equal
            %     colormap(gray);
            set(gca,'XTick',1:(c+1),'YTick',1:(r+1),...
                'XLim',[1 c+1],'YLim',[1 r+1],...
                'GridLineStyle','-','XGrid','on','YGrid','on','xticklabel',{[]},'yticklabel',{[]});
            fig.PaperPositionMode='auto'; 
            filename=fullfile(fileDir,'match2sample'); 
            print(fullfile(filename,sprintf('%d_%s',taskNum,matNames{f})),'-dpng','-r0')
        end
        
end