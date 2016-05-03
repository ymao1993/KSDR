clear 

% load feature points
str='.\data4\video';

T=imread([str,num2str(0,'%.3d'),'.jpg']);

i=128;
I=imread([str,num2str(i,'%.3d'),'.jpg']);


% select feature points
[p1,p2] = cpselect(T,I,'Wait', true); 
p1=[p1,ones(size(p1,1),1)];
p2=[p2,ones(size(p2,1),1)];
A=p1'*p1;
b=p1'*p2;
F=A\b;
[x,y]=meshgrid(1:size(I,2),1:size(I,1));
%u=[x(:)';y(:)';ones(1,length(x(:)))];
temp=F'*[x(:)';y(:)';ones(1,length(x(:)))];
newx=reshape(temp(1,:),size(I,1),size(I,2));
newy=reshape(temp(2,:),size(I,1),size(I,2));
I2=interp2(x,y,double(rgb2gray(I)),newx,newy,'cubic');

figure;imshow(I2,[])
figure;imshow(I)
figure;imshow(T)

