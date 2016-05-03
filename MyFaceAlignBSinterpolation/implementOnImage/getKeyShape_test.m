
str='.\data4\video';

% vectorize images
N=731;
for i=1:N
I=imread([str,num2str(i,'%.3d'),'.jpg']);
data(i,:)=reshape(double(rgb2gray(I)),1,size(I,1)*size(I,2));
end

% pca
[coeff,score,latent]=pca(data);

% % use k priciple components to reconstruct image i
% i=20;
% k=12;
% recons=score(i,1:k)*coeff(:,1:k)';
% reconsI=reshape(recons,size(I,1),size(I,2));
% imshow(reconsI,[])
% I=imread([str,num2str(i,'%.3d'),'.jpg']);
% figure;imshow(I)


% get k keyshapes (k/2 priciple components)
k=12;

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







