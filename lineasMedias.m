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
yc = yc*cosd(90)+(i*yc*sin(90));% se convierte a numero complejo forma binomica

z = (resistencia+(XL*i));

if numConduc == 2
    z = z/2;
elseif numConduc == 3
    z = z/3;
elseif numConduc == 4
    z = z /4;
end

vr = (vL/sqrt(3))*1000;%vR
Ir = demanda / (sqrt(3)*vL * abs(fp));
Ir = Ir*cosd(-angulo)+(i*Ir*sind(-angulo));%conversión a numero complejo 

vF = vr*(1+((z*yc)/2))+z*Ir;
vFModulo = abs(vF);%Modulo en su forma polar 
vFArgumento = rad2deg(angle(vF));%argumento en su forma polar

iF = Ir*(1+((z*yc)/2))+vr*yc*(1+((z*yc)/4));
iFModulo = abs(iF);
iFArgumento = rad2deg(angle(iF));

Reg = ((vFModulo-vr)/vr)*100;
iX = Ir + (yc/2)*vr;
iXModulo = abs(iX);
iXArgumento = rad2deg(angle(iX));
perdidas = (3*resistencia*(iXModulo^2))/1000;
eficiencia = (demanda/(demanda+perdidas))*100;

toString = sprintf('\tModelo de lineas\n\n ');
toString = toString + sprintf("DMG : %f \n RMG : %f \n XL : %f \n ",DMG,RMG,XL);
toString = toString + sprintf("yc : %f \n Z : %f \n vr : %f \n Ir : %f \n ",yc,z,vr,Ir);
toString = toString + sprintf("vF : %f < %f ° \n iF : %f < %f °\n iX : %f < %f °\n ",vFModulo,vFArgumento,iFModulo,iFArgumento,iXModulo,iXArgumento);
toString = toString + sprintf("reg : %f \n perdidas : %f \n eficiencia : %f ",Reg,perdidas,eficiencia);

toString
end