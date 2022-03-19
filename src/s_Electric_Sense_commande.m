% Simulateur du Sens Électrique 
% Carlos Santos Seisdedos

% viscircles requires Image Processing Toolbox. I tried an alternative.
close all; clc; clear;
addpath('custom_tasks');

phi = 0:0.2:2*pi;
rx = 1*cos(phi);
ry = 1*sin(phi);

% Création de l'aquarium
longueur_aq = 3;
largeur_aq = longueur_aq;
figure
f_aquarium(longueur_aq, largeur_aq);

% Création des Isolants. Minimum 2
n_isol = 2;
%x_isol = [1, 1]; y_isol = [1, 1];
x_isol = [1, 1]; y_isol = [-1, -1];
r_isol = 0.05;
pos_isol = [x_isol',y_isol']; 
for i = 1:n_isol
    cerc_isol_X(:,i) = x_isol(i) + rx*r_isol*2;
    cerc_isol_Y(:,i) = y_isol(i) + ry*r_isol*2;
end
plot(cerc_isol_X, cerc_isol_Y,'b');
%viscircles(pos_isol,r_isol*ones(n_isol,2),'Color','b');

% Création des Conducteurs. Minimum 2
n_cond = 2;
%x_cond= [1 1]; y_cond = [-1 -1];
x_cond= [1 1]; y_cond = [1 1];
% n_cond = 1;
% x_cond = [1]; y_cond = [0];
r_cond = 0.05;
pos_cond = [x_cond',y_cond'];
for i = 1:n_cond
    cerc_cond_X(:,i) = x_cond(i) + rx*r_cond*2; 
    cerc_cond_Y(:,i) = y_cond(i) + ry*r_cond*2;
end
plot(cerc_cond_X, cerc_cond_Y,'r');

% Création du poisson
n_electrodes = 5; % Number of electrodes
[x0, y0, th0, v_lin, v_ang, V_alpha0] = f_robot(n_electrodes);

%% Simulation
% Paramètres de temps de simulation
dt = 0.1;   % Temps d'échantillonage
tf = 30;    % Temps de simulation finale
t = [0:dt:tf]; 

II = []; X_electrodes = []; Y_electrodes = []; X_repere = []; Y_repere = []; DI2 = []; DI4 = []; V_ang = [];
for i = t
    % Cinématique du robot
    th = th0 + v_ang*dt;
    x = x0 + v_lin*cos(th)*dt;
    y = y0 + v_lin*sin(th)*dt;

    % Position des electrodes
    V_alpha = f_rotZ(th,x,y)*V_alpha0;
    
    % Calcul des courants
    I = f_currents(n_electrodes, V_alpha(1,:), V_alpha(2,:), r_isol, pos_isol, r_cond, pos_cond);
    
    II = [II I];
    X_electrodes = [X_electrodes V_alpha(1,:)'];
    Y_electrodes = [Y_electrodes V_alpha(2,:)'];
    X_repere = [X_repere x];
    Y_repere = [Y_repere y];

    % Affichage
    f_print(x0, x, y0, y, V_alpha, longueur_aq, largeur_aq, cerc_isol_X, cerc_isol_Y, cerc_cond_X, cerc_cond_Y, X_repere, Y_repere);
    pause(0.1/5);

    % Loi de commande
    dI2 = I(2) - II(2,1);
    dI4 = I(4) - II(4,1);
    
    % v_ang = -(I(2)-I(4))/abs((II(2,1)-II(4,1)))*0.03;
    %v_ang = -(I(2)-I(4))/abs((II(2,1)-II(4,1)))*1e10;
	v_ang = 1e10*(dI4 - dI2);
    
    % Mise à jour
    x0  = x;
    y0  = y;
    th0 = th;
end

xlabel("$x [cm]$", 'Interpreter', 'latex')
ylabel("$y [cm]$", 'Interpreter', 'latex')
%xticks([-3 -2 -1 0 1 2 3])
axis(3.5*[-1 1 -1 1])
legend('', '',  '', '', '', '', 'Isolants', '', 'Conducteurs', '', 'Trajectoire', '', 'Position',[0.28,0.19,0.21,0.13]);