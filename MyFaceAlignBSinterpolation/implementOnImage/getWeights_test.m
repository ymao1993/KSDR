load('keyshapes.mat');
str='.\data4\video';

N=731;
for i=1:N
   I=imread([str,num2str(i,'%.3d'),'.jpg']);
   C=keyshapes';
   d=reshape(double(rgb2gray(I)),1,size(keyshapes,2));
   A=diag(-1*ones(size(keyshapes,1),1));
   b=zeros(size(keyshapes,1),1);
   % The trust-region-reflective algorithm
   w(:,i)=lsqlin(C,d,A,b);
   % % active-set algorithm
   % options = optimoptions('lsqlin','Algorithm','active-set');
   % w0=[]; Aeq = [];beq = [];lb = [];ub = [];
   % w(:,i)=lsqlin(C,d,A,b,Aeq,beq,lb,ub,w0,options);
   
   % reconstruction
   reconsI=reshape(keyshapes'*w(:,i),size(I,1),size(I,2));
   subplot(121)
   imshow(reconsI,[]);
   subplot(122)
   imshow(I)
   drawnow
end
save('weights2.mat','w');
