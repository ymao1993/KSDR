function [idx]=getKeyShapes(P,k)
%[keyshapes,idx]=getKeyShapes(P,k)
% input:
% P: 2N*F matrix containing feature points [x1,y1...xN,yN]' of F frames
% k: the number of keyshapes

% output:
% keyshapes: k*2N matrix, each row is a keyshape
% idx: k*1 vector, indicating which frame the keyshapes come from

% pca
P=P';
[~,score,~]=pca(P);

% find minimum and maximum k/2 projections
[~,minProj_idx]=min(score);
[~,maxProj_idx]=max(score);

%minProj=P(minProj_idx(1:ceil(k/2)),:);
%maxProj=P(maxProj_idx(1:ceil(k/2)),:);

%keyshapes=[minProj;maxProj];
idx=[minProj_idx(1:ceil(k/2)),maxProj_idx(1:ceil(k/2))]';

% % display keyshapes
% figure;
% for i=1:size(keyshapes,1)
%     im=reshape(keyshapes(i,:),size(I,1),size(I,2));
%     subplot(4,4,i)
%     imshow(im,[]);
% end

% save('keyshapes.mat','keyshapes','idx');
end