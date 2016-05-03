str_v='.\data4\video\video'; % path to vedio frames
str_p='.\data4\point\'; % path to feature points

F=731; % number of frames
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
    subplot(4,4,i);
    imshow(I);
    hold on;
    scatter(xy(1,:),xy(2,:),'.');
    hold off
end

% do decomposition for each frame
writerObj = VideoWriter('results.mov');
writerObj.FrameRate = 10;
open(writerObj);

figure;
for i=1:F

I=imread([str_v,num2str(i,'%.3d'),'.jpg']);
p=reshape(points(:,i),2,N);

% get decomposition weights
w=getWeights(keyshapes,points(:,i));

% get reconstructed points and images
[re_I,re_p]=getReconstruction(I,p,w,keyshapes,keyidx,str_v);

% display
subplot(121)
imshow(I);
hold on
scatter(p(1,:),p(2,:),'b.')
%hold on
%scatter(re_p(1,:),re_p(2,:),'r.')
title('original frame and points')

subplot(122)
imshow(re_I);
hold on
scatter(re_p(1,:),re_p(2,:),'.')
hold off
title('reconstructed frame and points')
drawnow

% save as avi file
writeVideo(writerObj, getframe(gcf));

end
close(writerObj)
