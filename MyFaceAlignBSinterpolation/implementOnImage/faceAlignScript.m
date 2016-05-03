str='.\data4\video';
N=731;
k=12;

T=imread([str,num2str(0,'%.3d'),'.jpg']);
i=1;
I=imread([str,num2str(i,'%.3d'),'.jpg']);

% adjust image
[I1,F]=removeAffine(I,p1,p2);



% % image decomposition 
% get keyshapes
[keyshapes]=getKeyShapes(str,N,k);

% get weights
w=getWeights(keyshapes,I);


% % feature points decomposition