% Simulateur du Sens Électrique 
% Carlos Santos Seisdedos
close all; clc; clear;

phi = 0:0.2:2*pi;
rx = 1*cos(phi);
ry = 1*sin(phi);

% Création de l'aquarium
longueur_aq = 3;
largeur_aq = 3;
figure
f_aquarium(longueur_aq,largeur_aq);

% Création des Isolants
n_isol = 2;
x_isol = [-1, -2]; y_isol = [-1, -2];
r_isol = 0.1;
pos_isol = [x_isol',y_isol']; 
for i = 1:n_isol
    cerc_isol_X(:,i) = x_isol(i) + rx*r_isol;
    cerc_isol_Y(:,i) = y_isol(i) + ry*r_isol;
end
plot(cerc_isol_X, cerc_isol_Y,'b');

% Création des Conducteurs
n_cond = 2;
x_cond= [1, 2]; y_cond = [1, 2];
r_cond = 0.2;
pos_cond = [x_cond',y_cond'];
for i = 1:n_cond
    cerc_cond_X(:,i) = x_cond(i) + rx*r_cond; 
    cerc_cond_Y(:,i) = y_cond(i) + ry*r_cond;
end
plot(cerc_cond_X, cerc_cond_Y,'r');

% Création du poisson
[x0, y0, th0, v_lin, v_ang, V_alpha0] = f_robot();

%% Simulation
% Paramètres de temps de simulation
dt = 0.1;   % Temps d'échantillonage
tf = 8;    % Temps de simulation finale
t = [0:dt:tf]; 
% Paramètres dinamiques du robot : outputs de f_robot()

for pos_isol = t
    % Cinématique du robot
    th = th0 + v_ang*dt;
    x = x0 + v_lin*cos(th)*dt;
    y = y0 + v_lin*sin(th)*dt;

    % Position des electrodes
    V_alpha = f_rotZ(th,x,y)*V_alpha0;
    
    % Affichage
    f_print(x0, x, y0, y, V_alpha, longueur_aq, largeur_aq, cerc_isol_X, cerc_isol_Y, cerc_cond_X, cerc_cond_Y);
    pause(0.1/5);

    % Mise à jour
    x0  = x;
    y0  = y;
    th0 = th;
    
end