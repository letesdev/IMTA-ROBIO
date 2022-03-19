function [x0, y0, th0, v_lin, v_ang, V_alpha] = f_robot(n_electrodes)
    %% Outputs: 
    % x0, y0    : initial position of the robot (m)
    % th0       : initial orientation of the robot (radians)
    % v_lin     : vitesse linéaire (constante) (m/s)
    % v_ang     : vitesse angulaire (radians/s)
    % V_alpha   : Matrice des electrodes

    % Paramètres dinamiques du robot
    v_lin = 0.5;
    v_ang = 0;
    

    L = 0.5; % Longueur (m), soit 50 cm
    l = 0.1; % Largeur  (m), soit 10 cm
    h = 0.2; % Hauteur  (m), soit 20 cm

    % Initial position and orientation of the robot
    x0 = -2.2; y0 = 0; th0 = 0;
    
    % Position of electrodes
    x_alpha_A = [-0.2   0.2     0.2     0.2     0.2     ];
    y_alpha_A = [0      0.06    0       -0.06   0       ];
    % z_alpha_A = [0      0       0.06    0       -0.06   ]; % Copied to f_currents

    V_alpha = [x_alpha_A; y_alpha_A; ones(1, n_electrodes)];
    
    % gamma = 0; % Copied to f_currents
    % Matrice de conductances (conductivité) entre chaque electroque
    % C0 = gamma* [   0.2557 -0.0639 -0.0639 -0.0639 -0.0639; 
    %                -0.0639 0.1218 -0.0203 -0.0173 -0.0203;
    %                -0.0639 -0.0203 0.1218 -0.0203 -0.0173;
    %                -0.0639 -0.0173 -0.0203 0.1218 -0.0203;
    %                -0.0639 -0.0203 -0.0173 -0.0203 0.1218]; % Copied to f_currents

    
end