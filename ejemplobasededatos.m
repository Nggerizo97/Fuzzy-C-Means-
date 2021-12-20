clc 
close all
clear all

ciclo=0;
grupo=[database(1),database(2)];% valores de la base de datos
k=6;% diferentes centroides... Hacerlo para 10 centroides maximo... 
centro=randi([1,20000],k,2); %como son dos grupos dejo el 2 indicado
valores2=centro; %guardo los valores en otra variable para graficarlos
e=0.000001 % error

while e && ciclo <= 100
    v=[];
    vc1=[];
    for t=1:length(grupo)
        for j=1:length(centro)
            c=sum((grupo(t,:)-centro(j,:)).^2);
            v(t,j)=c;
        end
    end
    
    %ciclo en que la suma de su fila da 1
    for t=1:length(v)
        for j=1:length(centro)
            cx=1/sum(((v(t,:)))/v(t,j));
            vc1(t,j)=cx;
            vcx=fliplr(vc1);
        end
    end
    %procedimineto de suma de nuevos pesos
    vt=[];
    for f=1:length(v)
        for g=1:length(centro)
            v1x=sum(vcx(:,g).^2.*grupo(:,:,1))/sum(vcx(:,g).^2);
            vt(g,:)=v1x;
        end
    end
   
    
    %operaciones para el error
    r1=sum(vt,2);
    rr1=sum(r1);
    r2=sum(centro,2);
    rr2=sum(r2);
    e=abs(rr2-rr1);
    centro=vt;
    ciclo=ciclo+1
    
    %graficas
    scatter(grupo(:,1),grupo(:,2),'+')
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