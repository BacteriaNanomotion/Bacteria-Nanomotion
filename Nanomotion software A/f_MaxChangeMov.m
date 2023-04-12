function [im_diff,change_a_b] = f_MaxChangeMov(video,first_frame, last_frame)
%Displays the pixels that change the most
%Displays a graph that shows the difference between two consecutive frames
%en prenant la premiere image du film et en la soustrayant de la seconde et
%en cummulant les differences

%im_diff: image qui montre les zones qui changent le plus
%cette image a subi une egalisation d'histogramme

%video: video ? analyser
%first_frame: premiere image
%n_frames: nombre d images a analyser

% %01_11_2019 ok


%lecture premi?re image
im_col=read(video, [first_frame]);%first frame 
image_a=rgb2gray(im_col); %met l'image en nb
im_diff=immultiply(image_a,0); %creation d une image zero

%display('Lancement s_MaxChange_3 du YeastOnMobile')


h=waitbar(0,'Calculating pixels that change the most');
for n=first_frame:last_frame
    im_col=read(video, [n]);%frame nb 1
    image_b=rgb2gray(im_col);
    
    %soustraie deux images
    im_absdiff=imabsdiff(image_a, image_b); 
    
    change_a_b(n)=sum(sum(im_absdiff)); %stores the number of pixels that have changed between image a and b
    
    im_diff=imadd(im_absdiff,im_diff);
    %permet de ne pas saturer si il y a bcp d'images
    im_diff=immultiply(im_diff,0.6); %(0.5)
    
    image_a=image_b;
    
    waitbar(n / (last_frame-first_frame));
end;
close(h);



im_diff = imadjust(im_diff,stretchlim(im_diff),[]);


