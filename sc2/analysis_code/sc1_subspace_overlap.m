function [l21,l]=sc1_subspace_overlap(C1,C2,numEig); 
% function [l21,l]=sc1_subspace_overlap(C1,C2,numEig); 
% Subspace overlap between covariance C1 and C2 
% The function determines the X Eigenvectors on C1 and then projects 
% C2 onto them, calculating the variance after projection. 
[V,l]=eig(C1); 
[l,indx]=sort(diag(l),'descend'); 
V=V(:,indx); 
l21=sum((V'*C2).*(V'),2); % Variance after projecting 
l21=l21'; 
l=l';