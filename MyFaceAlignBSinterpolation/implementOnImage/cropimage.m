clear

str='.\data3\video (';
n=5;
i=1;
for idx=round(linspace(13,743,n))
im=imread([str,num2str(idx),').jpg']);
imshow(im)
drawnow
rect(i,:)=getrect;
i=i+1;
end

ave_rect=mean(rect);

str2='.\data4\video';
for i=13:743
im=imread([str,num2str(i),').jpg']);
im2=imcrop(im,ave_rect);
imwrite(im2,[str2,num2str(i-12,'%.3d'),'.jpg'])
end
