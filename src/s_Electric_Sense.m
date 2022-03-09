% Simulateur du Sens Électrique 
% Carlos Santos Seisdedos
close all; clc; clear;

phi = 0:0.2:2*pi;
rx = 1*cos(phi);
ry = 1*sin(phi);

% Création de l'aquarium
longueur_aq = 3;
largeur_aq = longueur_aq;
figure
f_aquarium(longueur_aq, largeur_aq);

% Création des Isolants
n_isol = 2;
x_isol = [-1, -2]; y_isol = [0, -2];
r_isol = 0.1;
pos_isol = [x_isol',y_isol']; 
for i = 1:n_isol
    cerc_isol_X(:,i) = x_isol(i) + rx*r_isol;
    cerc_isol_Y(:,i) = y_isol(i) + ry*r_isol;
end
plot(cerc_isol_X, cerc_isol_Y,'b');

% Création des Conducteurs
n_cond = 2;
%x_cond= [1, 2]; y_cond = [1, 2];
x_cond= [1 2]; y_cond = [2 2];
r_cond = 0.2;
pos_cond = [x_cond',y_cond'];
for i = 1:n_cond
    cerc_cond_X(:,i) = x_cond(i) + rx*r_cond; 
    cerc_cond_Y(:,i) = y_cond(i) + ry*r_cond;
end
plot(cerc_cond_X, cerc_cond_Y,'r');

% Création du poisson
n = 5; % Number of electrodes
[x0, y0, th0, v_lin, v_ang, V_alpha0] = f_robot(n);

%% Simulation
% Paramètres de temps de simulation
dt = 0.1;   % Temps d'échantillonage
tf = 8;    % Temps de simulation finale
t = [0:dt:tf]; 

II = []; X_electrodes = []; Y_electrodes = [];
for i = t
    % Cinématique du robot
    th = th0 + v_ang*dt;
    x = x0 + v_lin*cos(th)*dt;
    y = y0 + v_lin*sin(th)*dt;

    % Position des electrodes
    V_alpha = f_rotZ(th,x,y)*V_alpha0;
    
    % Calcul des courants
    I = f_currents(n, V_alpha(1,:), V_alpha(2,:), pos_isol, pos_cond);
    II = [II I];
    X_electrodes = [X_electrodes V_alpha(1,:)'];
    Y_electrodes = [Y_electrodes V_alpha(2,:)'];

    % Affichage
    f_print(x0, x, y0, y, V_alpha, longueur_aq, largeur_aq, cerc_isol_X, cerc_isol_Y, cerc_cond_X, cerc_cond_Y);
    pause(0.1/5);

    % Mise à jour
    x0  = x;
    y0  = y;
    th0 = th;
    
end

% Affichage courants
figure

subplot(3,2,1)
plot(X_electrodes(1,:),II(1,:));
title('Ie1')
xlabel('x[m]')
ylabel('I [A]')
grid on
text(max(X_electrodes(1,:))*0.8,(max(II(1,:))+min(II(1,:)))*0.5, "\DeltaI = " + num2str((max(II(1,:))-min(II(1,:)))*0.5))

subplot(3,2,2)
plot(X_electrodes(2,:),II(2,:));
title('Ie2')
xlabel('x[m]')
ylabel('I [A]')
grid on
text(max(X_electrodes(2,:))*0.8,(max(II(2,:))+min(II(2,:)))*0.5, "\DeltaI = " + num2str((max(II(2,:))-min(II(2,:)))*0.5))

subplot(3,2,3)
plot(X_electrodes(3,:),II(3,:));
title('Ie3')
xlabel('x[m]')
ylabel('I [A]')
grid on
text(max(X_electrodes(3,:))*0.8,(max(II(3,:))+min(II(3,:)))*0.5, "\DeltaI = " + num2str((max(II(3,:))-min(II(3,:)))*0.5))

subplot(3,2,4)
plot(X_electrodes(4,:),II(4,:));
title('Ie4')
xlabel('x[m]')
ylabel('I[A]')
grid on
text(max(X_electrodes(4,:))*0.8,(max(II(4,:))+min(II(4,:)))*0.5, "\DeltaI = " + num2str((max(II(4,:))-min(II(4,:)))*0.5))


subplot(3,2,5)
plot(X_electrodes(5,:),II(5,:));
title('Ie5')
xlabel('x[m]')
ylabel('I[A]')
grid on
text(max(X_electrodes(5,:))*0.8,(max(II(5,:))+min(II(5,:)))*0.5, "\DeltaI = " + num2str((max(II(5,:))-min(II(5,:)))*0.5))


subplot(3,2,6)
plot(X_electrodes(1,:)+0.2,II(1,:)+II(2,:)+II(3,:)+II(4,:)+II(5,:));
title('Iet')
xlabel('x[m]')
ylabel('I[A]')
grid on


