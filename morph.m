function morphI=morph(keyI,keyshapes,re_p,p,w,H,W)
% input:
% keyI: HW*k matrix, each column is a vectorized image
% keyshapes: k*2N matrix, each row is a keyshape
% w: k*1 vector
% output:
% morphI: H*W image

% generate intermediate image
% aveI=reshape(keyI*w,[size(I,1),size(I,2)]);

H=168;
W=273;
morphI=zeros(H,W);
for i=1:size(keyI,2) 
    I=reshape(keyI(:,i),H,W);
    p=reshape(keyshapes(i,:),[2,size(keyshapes,2)/2]);
    [I1,~]=removeAffine(I,re_p',p');
    morphI=morphI+w(i)*I1;
    imshow(morphI,[]);
    hold on
    scatter(re_p(1,:),re_p(2,:),'.')
end
