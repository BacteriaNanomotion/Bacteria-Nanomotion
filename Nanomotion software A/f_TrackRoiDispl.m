function[DispX,DispY,DispT,DifBright]=f_TrackRoiDispl(CooXRoi1,CooYRoi1,CooXRoi2,CooYRoi2,Movie,FirstFrame,LastFrame,DeltaFrame,Nroi,FirstFrameOnly)
% Calculates the displacment of structures present in the ROI, uses
% dftregistration external function

%   CooXRoi1 etc..  : coordinates of the ROI
%   Movie : the movie to be analyzed
%   FirstFrame : First frame to be analyzed
%   LastFrame : Last frame to be analyzed
%   DeltaFrame : how many frames to jump
%   Nroi : number of ROIs to be analyzed
%   FirstFrameOnly : is 1 if the first frame is the reference and
%                   displacments are calculated according to the ROI's
%                   position in the frame 1



%diff_Abs_Img(first_Frame:n_Frames,1:nROI)=0;    % mise a zero des vect de deplacement
%diff_Abs_Img_Norm(1:n_Frames,1:nROI)=0; % mise a zero des vect de deplacement
%N_Frames=LastFrame-FirstFrame
DispY(1:LastFrame,1:Nroi)=0; %deplacement en y
DispX(1:LastFrame,1:Nroi)=0;
DispT(1:LastFrame,1:Nroi)=0; %deplacement total
DifBright(1:LastFrame,1:Nroi)=0;%difference en pixels entre deux img consecutives


%prepare l'image_one si jamais FrstFrameOnly est =1
%Prepare image 1 in case FrstFrameOnly is =1, in this case al the images
%are compared to the first image of the movie
Img=FirstFrame;
ImCol=read(Movie, [Img]);%frame nb 1
ImageOne=rgb2gray(ImCol); % Image one is the very first image used in case FrstFrameOnly is =1 



h=waitbar(0,'Calculating ROIs displacments');

for Img=FirstFrame:LastFrame-DeltaFrame %1
    ImCol=read(Movie, [Img]);%frame nb 1
    ImageA=rgb2gray(ImCol); %met l'image en nb
    
    %in case FrstFrameOnly =1 image_a is the firstFrame
    if FirstFrameOnly==1
        ImageA=ImageOne;
    end;
    
    ImCol=read(Movie, [Img+DeltaFrame]);%frame nb 2
    ImageB=rgb2gray(ImCol); %met l'image en nb
    
    for Roi=1:Nroi
        RoiA=imcrop(ImageA,[CooXRoi1(Roi) CooYRoi1(Roi) (CooXRoi2(Roi)-CooXRoi1(Roi)) (CooYRoi2(Roi)-CooYRoi1(Roi))]);
        RoiB=imcrop(ImageB,[CooXRoi1(Roi) CooYRoi1(Roi) (CooXRoi2(Roi)-CooXRoi1(Roi)) (CooYRoi2(Roi)-CooYRoi1(Roi))]);
         %ATTENTION imcrop(image,[x1 y1 with height])
         

        
        usfac = 100; %precision demandee
        [output, Greg] = dftregistration(fft2(RoiB),fft2(RoiA),usfac);
            
        %deplacement en x et y d'un frame a l autre
        DispY(Img,Roi)=output(4);   
        DispX(Img,Roi)=output(3);
        
        %total displacment
        DispT(Img,Roi)=sqrt(DispY(Img,Roi)*DispY(Img,Roi)+DispX(Img,Roi)*DispX(Img,Roi)); 
        
        
        %+++++++++++++++++++Difference in Brightness between consecutive images for each ROI 
        %normalized by the size of the ROI
        [m,n]=size(RoiA); %calcul de la surface du ROI
        RoiSize=m*n;
        DifImg=imabsdiff(RoiA,RoiB); %difference absolue entre ROI_a et ROI_b
        DifBright(Img,Roi)=sum(sum(DifImg))/RoiSize; %difference absolue entre ROI_a et ROI_b normalise par la taille du ROI
        
     end;
    waitbar(Img/(LastFrame-FirstFrame));
end;
close(h);
    
    