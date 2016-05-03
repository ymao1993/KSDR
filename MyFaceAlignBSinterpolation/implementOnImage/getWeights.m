function w=getWeights(keyshapes,I)
% input:
% keyshapes: each row is a keyshape
% I: image needs to be decomposed

% output:
% w: the weights of each keyshapes


% solve least square problem with linear constrains
C=keyshapes';
d=reshape(double(rgb2gray(I)),1,size(keyshapes,2));
A=diag(-1*ones(size(keyshapes,1),1));
b=zeros(size(keyshapes,1),1);
w=lsqlin(C,d,A,b);

% reconstruction
reconsI=reshape(keyshapes'*w,size(I,1),size(I,2));
subplot(121)
imshow(reconsI,[]);
subplot(122)
imshow(I)
end
