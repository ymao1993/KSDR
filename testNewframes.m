str_v='.\data4\video\video'; % path to vedio frames
str_p='.\data4\point\'; % path to feature points

load('keyshapes_trained.mat')

writerObj = VideoWriter('results_train.mov');
writerObj.FrameRate = 10;
open(writerObj);

figure;
% reconstruct test frames
Error=0;

start=1;
stop=500;
for i=start:stop
    
% load test frames and feature points
I=imread([str_v,num2str(i,'%.3d'),'.jpg']);
p=load([str_p,num2str(i),'.shape'])';

% get decomposition weights
w=getWeights(keyshapes,p(:));

% get reconstructed points and images
[re_I,re_p,error]=getReconstruction(I,p,w,keyshapes,keyidx,str_v);

Error=Error+error;
% display
subplot(121)
imshow(I);
hold on
scatter(p(1,:),p(2,:),'.')
hold off
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
Error=Error/(stop-start);


