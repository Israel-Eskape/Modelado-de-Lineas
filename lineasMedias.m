function lineasMedias
vL = 115;%kV
longitud = 100;%km
demanda = 100000;%kw
fp= -0.85;
RMG = 0.00895;%m
angulo = 31.79;
resistencia = 13.42;%ohms
radio = 0.0109;%m 
dAB=4.2;%m
dBC=4.2;%m
dAC=dAB+dBC;
numConduc =1;
global z;
DMG = nthroot((dAB*dBC*dAC),3);%m

if numConduc == 2
    RMG = sqrt(radio * diametro);
elseif numConduc == 3
    RMG = nthroot((radio * diametro),3);
elseif numConduc == 4
    RMG = 1.09* nthroot((radio*diametro),4);
end

XL = 0.1736 * log10(DMG/RMG)*longitud;%ohms

yc = (0.000009085/(log10(DMG/radio)))*100;%convertir con angulo de 90
yc = yc*cosd(90)+(i*yc*sin(90));

z = (resistencia+(XL*i));

if numConduc == 2
    z = z/2;
elseif numConduc == 3
    z = z/3;
elseif numConduc == 4
    z = z /4;
end
%%FORMA POLAR DE Z
%zModulo = abs(z);
%zArgumento = rad2deg(angle(z));

vr = (vL/sqrt(3))*1000;%vR
Ir = demanda / (sqrt(3)*vL * abs(fp));%%FALTA POR CONVERTIR angulo -angulo 
Ir = Ir*cosd(-angulo)+(i*Ir*sind(-angulo));


%zR = zModulo*cos(zArgumento);
%zI = zModulo*sin(zArgumento);
%a=(z*yc)
%b=(z*yc)/2
%a=1+b
%c = vr*a
%d = z*Ir
%f = c+d

vF = vr*(1+((z*yc)/2))+z*Ir
vFModulo = abs(vF)
vFArgumento = rad2deg(angle(vF))

iF = Ir*(1+((z*yc)/2))+vr*yc*(1+((z*yc)/4))
iFModulo = abs(iF)
iFArgumento = rad2deg(angle(iF))

Reg = ((vFModulo-vr)/vr)*100
iX = Ir + (yc/2)*vr
iXModulo = abs(iX)
iXArgumento = rad2deg(angle(iX))

perdidas = (3*resistencia*(iXModulo^2))/1000
eficiencia = (demanda/(demanda+perdidas))*100

%vFModulo = abs(vF);
%vFArgumento = rad2deg(angle(vF));
%a = zModulo*ycModulo;
%b = zArgumento+ycArgumento;
%a = (a+1)/2;
DMG;
XL;
yc;
z;
vr;
Ir;
end