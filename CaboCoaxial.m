clc
close all;
clear all;

RaioE = 40;
RaioI = 15;

CargaE = -100; % cargaE must be < than cargaI
CargaI = 100;

Nx = 100;
Ny = 100;
Ni = 100;

V = zeros(Nx,Ny);

mpx = ceil(Nx/2);
mpy = ceil(Ny/2);

T = 0;
B = 0;
L = 0;
R = 0;
V(1,:) = L;
V(Nx,:) = R;
V(:,1) = B;
V(:,Ny) = T;
V(1,1) = 0.5 * (V(1,2) + V(2,1));
V(Nx,1) = 0.5 * (V(Nx-1,1) + V(Nx,2));
V(1,Ny) = 0.5 * (V(1,Ny-1) + V(2,Ny));
V(Nx,Ny) = 0.5 * (V(Nx,Ny-1) + V(Nx-1,Ny));

for z = 1:Ni
    disp(z)

    for i=2:Nx-1
        for j=2:Ny-1
            V = MidpointCircleMau(V, RaioE, mpx, mpy, CargaE);
            V = MidpointCircleMau(V, RaioI, mpx, mpy, CargaI);
            V(i,j) = 0.25 * ( V(i+1,j) + V(i-1,j) + V(i,j+1) + V(i,j-1) );
        end
    end
end

% CALCULA CAMPO ELETRICO
V = V';
[Ex,Ey] =    gradient(V);
Ex = -Ex;
Ey = -Ey;
E = sqrt(Ex.^ 2 + Ey.^2);  
x = (1:Nx);
y = (1:Ny);

% FIGURA DO POTENCIAL
figure(1)
contour(x,y,V,(min([CargaI CargaE]):1:max([CargaI CargaE])),'linewidth',0.5);
axis([min(x) max(x) min(y) max(y)]); % Escala os eixos
colorbar('location','eastoutside','fontsize',14);
title('Potencial Elétrico V(x,y) [Volts]','fontsize',14);
xlabel('X-axis','fontsize',14);
ylabel('Y-axis','fontsize',14);
set(gca,'fontsize',10);

figure(3)

contour(x,y,E,'linewidth',0.5);

% hold on = nao faz o quiver apagar o que a funcao contour desenhou na tela
hold on, quiver(x,y,Ex,Ey,0.5)