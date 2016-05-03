str_v='.\data4\video\video'; % path to vedio frames
str_p='.\data4\point\'; % path to feature points

F=500; % number of train frames
k=12; % number of keyshapes


% load and vectorize feature points
for i=1:F
   %I=imread([str_v,num2str(i,'%.3d'),'.jpg']);
   p=load([str_p,num2str(i),'.shape'])';
   points(:,i)=p(:);
   %imshow(I);
   %hold on
   %scatter(p(1,:),p(2,:),'.')
   %hold off
   %drawnow
end
% the number of feature points
N=size(points,1)/2;

% get keyshpes 
keyidx=getKeyShapes(points,k);
keyshapes=points(:,keyidx); % each column is a keyshape


% display keyshapes
figure
for i=1:size(keyshapes,2)
    I=imread([str_v,num2str(keyidx(i),'%.3d'),'.jpg']);
    %keyframes(:,i)=reshape(double(rgb2gray(I)),[size(I,1)*size(I,2),1]);
    
    xy=keyshapes(:,i);
    xy=reshape(xy,2,N);
    subplot(3,4,i);
    imshow(I);
    hold on;
    scatter(xy(1,:),xy(2,:),'.');
    hold off
end

save('keyshapes_trained.mat','keyidx','keyshapes','points');
