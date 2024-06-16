function varargout = sc1_encode_test(what,varargin)
% Tests speed and accuracy of encoding models using the
basedir = '/Volumes/MotorControl/data/super_cerebellum/sc1/results/encoding/s03';
basedir = '/Volumes/MotorControl/data/super_cerebellum/sc1/encoding/s02';

switch (what)
    case 'crossval'
        
        load(fullfile,'Y_info.mat');
        load(fullfile,'yeo_glm4_betas_lh.mat');
        
        % Ensure that rest is set to zero
        indx = find(Y.cond==0);
        X(indx,:)=0;
        Y.data(indx,:)=0;
        
        % Now center the data by run
        x=indicatorMatrix('identity',Y.run);
        R=eye(size(Y.run,1))-x*inv(x'*x)*x';
        X = R*X;
        y = R*Y.data;

        sc1_encode_crossval(y(:,1:4),X,Y.run,'nonnegExp_L1');
    case 'model_compare'              % STEP 14.5: Make simulated data for generative models
        methods = {'cplexqp','cplexqp','cplexqp','cplexqp','cplexqp'};
        Lambda  = [0:5:20];
        threshold = {[1e-4],[1e-4],[1e-4],[1e-4],[1e-4]}; 
        numConn = 4;
        numCond=29;
        numRuns = 16;
        P = 30; % Number of voxels
        N = (numCond+1)*numRuns;
        sigma_signal=0.08; % pattern consistency for cerebellum is %10
        sigma_noise=1;
        modelType='sparseP';           % non-negaitive, sparse, etc...

        
        % Utility vectors and matrices 
        D.cond = [kron(ones(numRuns,1),[1:numCond]');ones(numRuns,1)*(numCond+1)];
        Z =    indicatorMatrix('identity',D.cond);
        D.part = [kron([1:numRuns]',ones(numCond,1));[1:numRuns]'];
        B = indicatorMatrix('identity',D.part);
        R  = eye(N)-B*pinv(B);
        
        % design matrix 
        load(fullfile(basedir,'yeo_glm4_model.mat'));
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
        subplot(3,1,1); 
        traceplot(Lambda,T.fR,'errorfcn','stderr');
        subplot(3,1,2); 
        traceplot(Lambda,T.cR,'errorfcn','stderr');
        subplot(3,1,3); 
        traceplot(Lambda,T.relMaxReg,'errorfcn','stderr');
    otherwise
        error('unknown case');    
end;