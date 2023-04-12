function [ x1,y1,x2,y2 ] = f_SelectROI(nROI)
%Selection avec la souris de la ROI
%Tracage d un carree autours du ROI
%Affichage du numero de la selection
%Retour des coordonees des ROI
%x1...coordonees des carrees
%nROI numero de la selection
%25_10_2019 ok

    n_points=2;
    pos1_x(1:n_points)=0;
    pos1_y(1:n_points)=0;
    for i=1:n_points
        [x,y] = ginput(1);
        pos1_x(i)=int16(x);
        pos1_y(i)=int16(y); 
        
        %Tracage d'une ligne entre deux points
        %Trace un point a l une des extremitees du carree
        plot([x-10,x+10],[y,y],'r','LineWidth',2)
        plot([x,x],[y-10,y+10],'r','LineWidth',2)    
    end;
    n=int2str(nROI);
    text(x-30,y-30,n,'Color','r');
    
    %Tracage d'un carre entre deux points
    plot([pos1_x(1),pos1_x(1)],[pos1_y(1),pos1_y(2)],'r','LineWidth',1);%vertG
    plot([pos1_x(2),pos1_x(2)],[pos1_y(1),pos1_y(2)],'r','LineWidth',1);%vertD
    plot([pos1_x(1),pos1_x(2)],[pos1_y(1),pos1_y(1)],'r','LineWidth',1);%horiz
    plot([pos1_x(1),pos1_x(2)],[pos1_y(2),pos1_y(2)],'r','LineWidth',1);%horiz

    %Affectation des variables de sortie de la fonction
    x1=pos1_x(1);
    y1=pos1_y(1);
    x2=pos1_x(2);
    y2=pos1_y(2);
    
    
    
end

