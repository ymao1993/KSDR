function [re_I,re_p,error]=getReconstruction(I,p,w,keyshapes,keyidx,str_v)
%[re_I,re_p]=getReconstruction(I,p,w,keyshapes,keyframes)
% reconstruct feature points by linear combination of keyshapes
% reconstruct frame by image morphing

% input
% I: H*W matrix; original image
% p: 2*N matrix; feature points detected from original image
% keyshapes: 2N*k matrix; each column is a keyshape (vectorized feature points)
% keyfrmaes: HW*k matrix; each column is a key frame
% keyidx: k*1 vector, indicating which frame the keyshapes come from
% str_v:  % path to vedio frames
% w: k*1 vector; the decomposition weights

% output
% re_I: H*W matrix; the reconstructed frame
% re_p: 2*N matrix; the reconstructed points

N=size(p,2);
% reconstruct feature points
re_p=reshape(keyshapes*w,[2,N]);

% reconstruct frame
re_I=zeros(size(I));
% re_I=zeros(size(I,1),size(I,2));
% image morphing by landmark-based affine transformation
for i=1:length(w)
    keyframe=imread([str_v,num2str(keyidx(i),'%.3d'),'.jpg']);
    [warpI,F]=affineWarp(keyframe,re_p,reshape(keyshapes(:,i),[2,N]));
    re_I=re_I+warpI*w(i);
end

re_I=uint8(re_I);

% calculate reconstruction error
idx=find(re_I);
diff=im2double(re_I)-im2double(I);  
error=sum(abs(diff(idx)).^2);
end

