clc
close all;
clear all;
                                
length_plate = 60;  % Comprimento do prato
position_plate = 15; % Tamanho do espaço a partir do centro

P1 = -100;
P2 = 100;

Nx = 100; % Número de colunas
Ny = 100; % Número de linhas
Ni = 400; % Número de iterações para a equação de poisson

mpx = ceil(Nx/2); % Mid-point of x  ceil(101/2) = 51
mpy = ceil(Ny/2); % Mid point of y

V = zeros(Nx,Ny); % Matriz de potencial elétrico [Volts]

% INICIALIZA O POTENCIAL DAS PAREDES
T = 0;
B = 0;
L = 0;
R = 0;
V(1,:) = L;  % fixa x em 1 (coluna) e percorre y = parede esquerda
V(Nx,:) = R; % fixa x em Nx e percorre y = parede direita
V(:,1) = B;  % fixa 1 em y e percore x = teto
V(:,Ny) = T; % fixa Ny em y e percorre x = chao

% Quinas tem a média de dois vizinhos em vez de quatro
V(1,1) = 0.5 * (V(1,2) + V(2,1));
V(Nx,1) = 0.5 * (V(Nx-1,1) + V(Nx,2));
V(1,Ny) = 0.5 * (V(1,Ny-1) + V(2,Ny));
V(Nx,Ny) = 0.5 * (V(Nx,Ny-1) + V(Nx-1,Ny));

%-------------------------------------------------------------------------%

lp = floor(length_plate/2); % Tamanho de metade do prato

pp1 = mpx+position_plate; % prato 1
pp2 = mpx-position_plate; % prato 2

altura = 20;

pxi = Nx/2;
pyi = Ny/2-(altura/2);
pxf = Nx;
pyf = Ny/2+altura/2;

for z=1:Ni
    for i=2:Nx-1
        for j=2:Ny-1
            % mantem o valor dos pratos durante todas as iteracoes
            %RectangleMau(V,pxi,pyi,pxf,pyf,99);
            V(((Nx/2):Nx),(Ny/2)-10) = P1;
            
            %V(((Nx/2):Nx),((Ny/2)-1:(Ny/2)+1)) = 50;
            V((Nx/2):Nx,Ny/2) = P2;
            
            V(((Nx/2):Nx),(Ny/2)+10) = P1;
            
            % calcula o potencial pela media dos vizinhos
            V(i,j) = 0.25 * (V(i+1,j)+V(i-1,j)+V(i,j+1)+V(i,j-1));
        end
    end
end

% a transposta é util para achar a inversa 
V = V';

% a funca gradient os componentes X e Y do gradient da matrix V
% Ey = Matriz da derivada parcial de cada valor de V com relacao a dY
[Ex,Ey] = gradient(V);
Ex = -Ex;
Ey = -Ey;

% Modulo do campo eletrico

 E = sqrt(Ex .^ 2 + Ey .^ 2); % Raiz quadrada do quadrado de cada elemento Ex + quadrado de cada elemento
% Ey

% subtrai mpx de cada elemento do array (1:Nx) e coloca no array x
%x = (1:Nx)-mpx;
%y = (1:Ny)-mpy;
x = (1:Nx);
y = (1:Ny);


% cria uma janela para mostrar figura
figure(1)
contour(x,y,V,(P1:0.5:P2),'linewidth',0.5);
axis([min(x) max(x) min(y) max(y)]); % Escala os eixos
colorbar('location','eastoutside','fontsize',14);
title('Potencial Elétrico V(x,y) [Volts]','fontsize',14);
xlabel('X-axis','fontsize',14);
ylabel('Y-axis','fontsize',14);
set(gca,'fontsize',10);












% figure(2)
% contour_range_E = -20:0.05:20;
% contour(x,y,E,contour_range_E,'linewidth',0.5);
% 
% axis([min(x) max(x) min(y) max(y)]);
% colorbar('location','eastoutside','fontsize',14);
% xlabel('x-axis in meters','fontsize',14);
% ylabel('y-axis in meters','fontsize',14);
% title('Electric field distribution, E (x,y) in V/m','fontsize',14);
% h2=gca;
% set(h2,'fontsize',14);
% fh2 = figure(2); 
% set(fh2, 'color', 'white')

% Quiver Display for electric field Lines
% inicia uma outra janela
figure(3)

contour(x,y,E,'linewidth',0.5);

% hold on = nao faz o quiver apagar o que a funcao contour desenhou na tela
hold on, quiver(x,y,Ex,Ey,2)

% title('Electric field Lines, E (x,y) in V/m','fontsize',14);
% axis([min(x) max(x) min(y) max(y)]);
% colorbar('location','eastoutside','fontsize',14);
% xlabel('x-axis in meters','fontsize',14);
% ylabel('y-axis in meters','fontsize',14);
% h3=gca;
% set(h3,'fontsize',14);
% fh3 = figure(3); 
% set(fh3, 'color', 'white')


% Quiver Display for electric field Lines
% inicia uma outra janela
% figure(4)
% contour(x,y,E,'linewidth',0.5);
% hold on, quiver(x,y,Ex,Ey,1)
% title('E','fontsize',14);
% axis([min(x) max(x) min(y) max(y)]);
% colorbar('location','eastoutside','fontsize',14);
% xlabel('x-axis in meters','fontsize',14);
% ylabel('y-axis in meters','fontsize',14);
% h3=gca;
% set(h3,'fontsize',14);
% fh3 = figure(4); 
% set(fh3, 'color', 'white')

%-------------------------------------------------------------------------%
% REFERENCE
%           SADIKU, ELEMENTS OF ELECTROMAGNETICS, 4TH EDITION, OXFORD
%-------------------------------------------------------------------------%