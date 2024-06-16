function varargout=sc1_featureRotationSim(what,varargin) 
% Checking rotation of features to describe cerebellar / cortical 
% cognitive feature maps 
switch(what) 
case 'make_data' 
    P=9000; % Number of voxels 
    Q=10;   % Number of Features 
    K=15;   % Number of tasks 
    W=kron(eye(Q),ones(1,round(P/Q)));
    M=normrnd(0,1,K,Q); 
    M=bsxfun(@rdivide,M,sqrt(sum(M.^2)));
    Y=M*W+normrnd(0,0.01,K,P);
    varargout={Y,M};  
case 'varimaxrotation'
    [Y,M]=sc1_featureRotationSim('make_data'); 
    % Reduce to K features 
    Q=10; 
    [U,S,V]=svds(Y,Q);
    reconErr=sum(sum((Y-U*S*V').^2)); % Reconstruction error 
    
    % Do varimax rotation in feature space 
    [U1,T1] = rotatefactors(U,'method','promax');
    subplot(2,2,1); 
    imagesc((U*T1)');
    subplot(2,2,2); 
    imagesc((V*T1)');
    
    % Do varimax rotation in map space 
    [V2,T2]= rotatefactors(V,'method','promax'); 
    subplot(2,2,3); 
    imagesc((U*T2)');
    subplot(2,2,4); 
    imagesc((V*T2)');
    
    % 
    keyboard; 

end;


% Overall vs. Dynamic
% EEG connectivity
