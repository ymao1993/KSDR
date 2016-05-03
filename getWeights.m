function w=getWeights(keyshapes,p)
% input:
% keyshapes: 2N*k matrix, each column is a keyshape
% p: 2N*1 vector, feature points position [x1,y1...xN,yN]' of an image

% output:
% w: k*1 vector, the weights of each keyshapes


% solve least square problem with linear constrains
C=keyshapes;
d=p;
A=diag(-1*ones(size(keyshapes,2),1));
b=zeros(size(keyshapes,2),1);
w=lsqlin(C,d,A,b);

% % reconstruction
% reconsI=reshape(keyshapes'*w,size(p,1),size(p,2));
% subplot(121)
% imshow(reconsI,[]);
% subplot(122)
% imshow(p)
end
