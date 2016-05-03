function [I1,F]=removeAffine(I,p1,p2)
% input
% I:  image 
% p1: landmarks in image T
% p2: landmarks in image I

% output:
% I1: ajusted image by removing the affine motion
% F:  affine transform (F(T)->I)

A=p1'*p1;
b=p1'*p2;
F=A\b;
F=F';

[x,y]=meshgrid(1:size(I,2),1:size(I,1));
temp=F*[x(:)';y(:)';ones(1,length(x(:)))];

newx=reshape(temp(1,:),size(I,1),size(I,2));
newy=reshape(temp(2,:),size(I,1),size(I,2));

I1=interp2(x,y,double(rgb2gray(I)),newx,newy,'cubic');

end