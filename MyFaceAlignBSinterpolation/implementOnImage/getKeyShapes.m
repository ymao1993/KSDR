function [keyshapes]=getKeyShapes(str,N,k)
% input:
% str: the path to image sequences
% N:  the number of images
% k: the number of keyshapes

% output:
% keyshapes: each row is a keyshape


for i=1:N
I=imread([str,num2str(i,'%.3d'),'.jpg']);
data(i,:)=reshape(double(rgb2gray(I)),1,size(I,1)*size(I,2));
end


% pca
[coeff,score,latent]=pca(data);

[~,minProjI_idx]=min(score);
[~,maxProjI_idx]=max(score);
minProjI=data(minProjI_idx(1:ceil(k/2)),:);
maxProjI=data(maxProjI_idx(1:ceil(k/2)),:);
keyshapes=[minProjI;maxProjI];

% display keyshapes
figure;
for i=1:size(keyshapes,1)
    im=reshape(keyshapes(i,:),size(I,1),size(I,2));
    subplot(4,4,i)
    imshow(im,[]);
end

save('keyshapes.mat','keyshapes');
end