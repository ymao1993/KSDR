function [I1,F]=affineWarp(I,p1,p2)
% input
% I:  image 
% p1: 2*N landmarks in target image
% p2: 2*N landmarks in image I

% output:
% I1: warped image
% F:  affine transform (F(T)->I)



p1=[p1;ones(1,size(p1,2))];
p2=[p2;ones(1,size(p2,2))];

A=p1*p1';
b=p1*p2';
F=A\b;
F=F';


[x,y]=meshgrid(1:size(I,2),1:size(I,1));
temp=F*[x(:)';y(:)';ones(1,length(x(:)))];

newx=reshape(temp(1,:),size(I,1),size(I,2));
newy=reshape(temp(2,:),size(I,1),size(I,2));

% warp image channel by channel
for i=1:size(I,3)
    I1(:,:,i)=interp2(x,y,double(I(:,:,i)),newx,newy,'cubic');
end
%I1=interp2(x,y,double(rgb2gray(I)),newx,newy,'cubic');
end