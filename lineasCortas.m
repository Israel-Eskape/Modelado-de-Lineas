%E%%%S%%%%K%%LINEAS CORTAS%%A%%%P%%%E%
vL = 34.5;%kV
long = 40;%Km
demanda = 2000;%kW
fp = -0.90 ;
RMG = 0.00136;%m
angulo = 25.84;
resist = 27.84;%ohms
radio = 0.007734;%m
dAB = 0.6;
dBC = 1.2;
dAC = 1.8;
numConduc =1;

DMG = nthroot((dAB*dBC*dAC),3);%m
if numConduc == 2
    RMG = sqrt(radio * diametro);
elseif numConduc == 3
    RMG = nthroot((radio * diametro),3);
elseif numConduc == 4
    RMG = 1.09* nthroot((radio*diametro),4);
end
XL = 0.1736 * log10(DMG/RMG)*long;%ohms
Ir = demanda / (sqrt(3)*vL * abs(fp));%%FALTA POR CONVERTIR
Vr = vL / sqrt(3); %kV

Z = resist + (XL*i);%%FALTA POR CONVERTIR
if numConduc == 2
    Z = Z/2;
elseif numConduc == 3
    Z = Z/3;
elseif numConduc == 4
    Z = Z/4;
end

zModulo = abs(Z)
zArgumento = rad2deg(angle(Z))

IR  = (Ir * resist)/ 1000;%kV
lXl = (Ir * XL)/ 1000;%kV

if fp < 0
    vf = sqrt( ((Vr * cos(angulo)+IR)^2) +( (Vr*sin(angulo)+lXl)^2));
elseif fp == 1
     vf = sqrt(((Vr+IR)^2)+(lXl)^2);
else
    vf = sqrt(((Vr*cos(angulo)+IR)^2)+((lXl-Vr*sin(angulo))^2));
end

reg = ((vf-Vr)/Vr)*100;% en porcentaje
perdidas = 3*(resist*Ir^2)/1000;%kW
eficiencia = (demanda / (demanda+perdidas))*100;%en porcentaje

