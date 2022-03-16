% Simulateur du Sens Électrique 
% Carlos Santos Seisdedos

% viscircles requires Image Processing Toolbox. I tried an alternative.
close all; clc; clear;

phi = 0:0.2:2*pi;
rx = 1*cos(phi);
ry = 1*sin(phi);

% Création de l'aquarium
longueur_aq = 3;
largeur_aq = longueur_aq;
f1 = figure;
f_aquarium(longueur_aq, largeur_aq);

% Création des Isolants. Minimum 2
n_isol = 2;
x_isol = [0, 0]; y_isol = [0, 0];
%x_isol = [2.5, 2.5]; y_isol = [2.5, 2.5];
r_isol = 0.05;
pos_isol = [x_isol',y_isol']; 
for i = 1:n_isol
    cerc_isol_X(:,i) = x_isol(i) + rx*r_isol;
    cerc_isol_Y(:,i) = y_isol(i) + ry*r_isol;
end
plot(cerc_isol_X, cerc_isol_Y,'b');
%viscircles(pos_isol,r_isol*ones(n_isol,2),'Color','b');

% Création des Conducteurs. Minimum 2
n_cond = 2;
x_cond= [2.5 2.5]; y_cond = [2.5 2.5];
%x_cond= [0 0]; y_cond = [0 0];
% n_cond = 1;
% x_cond = [1]; y_cond = [0];
r_cond = 0.05;
pos_cond = [x_cond',y_cond'];
for i = 1:n_cond
    cerc_cond_X(:,i) = x_cond(i) + rx*r_cond; 
    cerc_cond_Y(:,i) = y_cond(i) + ry*r_cond;
end
plot(cerc_cond_X, cerc_cond_Y,'r');

% Création du poisson
n_electrodes = 5; % Number of electrodes
[x0, y0, th0, v_lin, v_ang, V_alpha0] = f_robot(n_electrodes);

%% Simulation
% Paramètres de temps de simulation
dt = 0.1;   % Temps d'échantillonage
tf = 5;    % Temps de simulation finale
t = [0:dt:tf]; 

II = []; X_electrodes = []; Y_electrodes = []; X_repere = []; Y_repere = [];
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

    % Mise à jour
    x0  = x;
    y0  = y;
    th0 = th;
end
% Affichage courants
f_plot_currents(X_repere,II)
close(f1);