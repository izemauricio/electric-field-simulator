clc
close all;
clear all;                    

P1 = -200;
P2 = 200;

Nx = 100;
Ny = 100;
Ni = 10;

mpx = ceil(Nx/2);
mpy = ceil(Ny/2);

V = zeros(Nx,Ny);

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


Largura = 80;
MetadeLargura = Largura/2;
Xi = (Nx/2)-MetadeLargura;
Xf = (Nx/2)+MetadeLargura;

EspacoFromTopo = 10;
AlturaDente = 54;
Espaco = 0;
Incremento = 20;
Segundo = 20;
LarguraDente = 6;
EspacoEntreDente = 6;
Xio = Xi;

for z=1:Ni
    for i=2:Nx-1
        for j=2:Ny-1
            
             Xi = Xio;
            % SUPORTE
            V((Xi:Xf),(10:20)) = P1;
            
            
            % DENTES
            Espaco = 0;
            EspacoFromTopo = 20;
           
            
            V((Espaco+Xi:Espaco+Xi+LarguraDente),(EspacoFromTopo:EspacoFromTopo+AlturaDente)) = P1;
          
            Espaco = Espaco + EspacoEntreDente + EspacoEntreDente + LarguraDente + LarguraDente;
            V((Espaco+Xi:Espaco+Xi+LarguraDente),(EspacoFromTopo:EspacoFromTopo+AlturaDente)) = P1;
            
            Espaco = Espaco + EspacoEntreDente + EspacoEntreDente + LarguraDente + LarguraDente;
            V((Espaco+Xi:Espaco+Xi+LarguraDente),(EspacoFromTopo:EspacoFromTopo+AlturaDente)) = P1;
            
            Espaco = Espaco + EspacoEntreDente + EspacoEntreDente + LarguraDente + LarguraDente;
            V((Espaco+Xi:Espaco+Xi+LarguraDente),(EspacoFromTopo:EspacoFromTopo+AlturaDente)) = P1;

            
            Espaco = LarguraDente+EspacoEntreDente;
            EspacoFromTopo = 80;
            Xi = Xi +3;
            
            V((Espaco+Xi:Espaco+Xi+LarguraDente), (EspacoFromTopo-AlturaDente:EspacoFromTopo+2)) = P2;
            
            Espaco = Espaco + EspacoEntreDente + EspacoEntreDente + LarguraDente + LarguraDente;
            V((Espaco+Xi:Espaco+Xi+LarguraDente), (EspacoFromTopo-AlturaDente:EspacoFromTopo+2)) = P2;
            
            Espaco = Espaco + EspacoEntreDente + EspacoEntreDente + LarguraDente + LarguraDente;
            V((Espaco+Xi:Espaco+Xi+LarguraDente), (EspacoFromTopo-AlturaDente:EspacoFromTopo+2)) = P2;

            V((Xi:Xf),(80:90)) = P2;
            
            
            
            
            V(i,j) = 0.25 * (V(i+1,j)+V(i-1,j)+V(i,j+1)+V(i,j-1));
        end
    end
end

V = V';
[Ex,Ey] = gradient(V);
Ex = -Ex;
Ey = -Ey;
E = sqrt(Ex .^ 2 + Ey .^ 2);

x = (1:Nx);
y = (1:Ny);

figure(1)
contour(x,y,V,(P1:0.5:P2),'linewidth',0.5);
axis([min(x) max(x) min(y) max(y)]); % Escala os eixos
colorbar('location','eastoutside','fontsize',14);
title('Potencial Elétrico V(x,y) [Volts]','fontsize',14);
xlabel('X-axis','fontsize',14);
ylabel('Y-axis','fontsize',14);
set(gca,'fontsize',10);

figure(2)
contour(x,y,E,'linewidth',0.5);
hold on, quiver(x,y,Ex,Ey,0.5)