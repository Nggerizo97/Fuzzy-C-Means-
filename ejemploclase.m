clc 
close all
clear all

rapidez=[0.58 0.90 0.68 0.11 0.47 0.24 0.09 0.82 0.65 0.09 0.98];
resistencia=[0.33 0.11 0.17 0.44 0.81 0.83 0.18 0.11 0.5 0.63 0.24];
%defensa=[0.57 0.8 0.37 0.63 0.1 0.98 0.67 0.17 0.21 0.78 0.5];
ciclo=0;
grupo=[rapidez',resistencia'];
k=2;
centro=rand(k,2);
valores2=centro;
e=0.000001

while e && ciclo <= 100
    v=[];
    vc1=[];
    for t=1:length(grupo)
        for j=1:length(centro)
            c=sum((grupo(t,:)-centro(j,:)).^2);
            v(t,j)=c;
        end
    end
    
    for t=1:length(v)
        for j=1:length(centro)
            cx=1/sum(((v(t,:)))/v(t,j));
            vc1(t,j)=cx;
            vcx=fliplr(vc1);
        end
    end
    vt=[];
    for f=1:length(v)
        for g=1:length(centro)
            v1x=sum(vcx(:,g).^2.*grupo(:,:,1))/sum(vcx(:,g).^2);
            vt(g,:)=v1x;
        end
    end
    
    r1=sum(vt,2);
    rr1=sum(r1);
    r2=sum(centro,2);
    rr2=sum(r2);
    e=abs(rr2-rr1)
    centro=vt;
    ciclo=ciclo+1;
    
    scatter(rapidez,resistencia,30,'*')
    hold on
    scatter(centro(:,1),centro(:,2),'d')
    scatter(valores2(:,1),valores2(:,2),'filled')
    
end     
    
 
 %coeficiente de particion... hacer una tabla con los valores de K...
    %este valor debe de dar cercano a 1
    valor1=[];
    for h=1:length(vcx)
        for u=1:length(centro)
           pc=sum(vcx(:,u).^2);
           valor1(:,u)=pc;
           resultado1=sum(valor1)/length(vcx)
        end
    end
    %coeficiente de entropia se debe de hacer lo mismo pero su valor debe
    %de estar cerca de 0
    valor2=[];
    valor3=[];
    for h=1:length(vcx)
        for u=1:length(centro)
            ce=sum(vcx(h,u));
            valor2(:,u)=ce;
        end
    end
    for f=1:length(vcx)
        for z=1:length(centro)
             ce1=sum(log10(vcx(f,z)));
             valor3(:,z)=ce1;
        end
    end
  resultado2=-sum(valor2.*valor3)/length(vcx)

    