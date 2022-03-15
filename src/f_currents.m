function [I] = f_currents(n_electrodes, x_electrodes, y_electrodes, r_isol, pos_isol, r_cond, pos_cond)
z_alpha_A = [0      0       0.06    0       -0.06   ];
gamma = 0.04;
% Matrice de conductances (conductivité) entre chaque electroque
C0 = gamma * [   0.2557 -0.0639 -0.0639 -0.0639 -0.0639;
                -0.0639 0.1218 -0.0203 -0.0173 -0.0203;
                -0.0639 -0.0203 0.1218 -0.0203 -0.0173;
                -0.0639 -0.0173 -0.0203 0.1218 -0.0203;
                -0.0639 -0.0203 -0.0173 -0.0203 0.1218];

% Vecteur des tensions, une seule electrode alimentée
U = [1, zeros(1,n_electrodes-1)];
%e = [x_electrodes', y_electrodes', z_alpha_A'];
e(:,1) = x_electrodes';
e(:,2) = y_electrodes';
e(:,3) = z_alpha_A';

% Objets isolants 
for i = 1:length(pos_isol)
    pos_isol_n (:,:,i) = [pos_isol(i,:), 0.5];
end
pos_isol_size = size(pos_isol_n);

% Axial reflection matrix for isolants
k_isol = zeros(n_electrodes, n_electrodes);
P_isol = -0.5*(r_isol)^3*eye(3);               % Tenseur de polarisation d'une sphere totalement isolante
for k = pos_isol_size(3)
    for j = 1:n_electrodes
        for n = 1:n_electrodes
            r_alpha = pos_isol_n(:,:,k) - e(j,:); % distance entre le centre de l'objet isolant et l'électrode j
            r_beta  = pos_isol_n(:,:,k) - e(n,:); % distance entre le centre de l'objet isolant et l'électrode n
            k_isol(j,n) = k_isol(j,n) - (r_alpha*P_isol*r_beta')/(4*pi*gamma*norm(r_alpha,3)*norm(r_beta,3));
        end
    end
end

% Objets conducteurs
for i = 1:length(pos_cond)
    pos_cond_n (:,:,i) = [pos_cond(i,:), 1];
end
pos_cond_size = size(pos_cond_n);

% Axial reflection matrix for conducteurs
k_cond = zeros(n_electrodes, n_electrodes);
P_cond = 1*(r_isol)^3*eye(3);               % Tenseur de polarisation d'une sphere totalement conductrice
for k = pos_cond_size(3)
    for j = 1:n_electrodes
        for n = 1:n_electrodes
            r_alpha = pos_cond_n(:,:,k) - e(j,:); % distance entre le centre de l'objet conducteur et l'électrode j
            r_beta  = pos_cond_n(:,:,k) - e(n,:); % distance entre le centre de l'objet conducteur et l'électrode n
            k_cond(j,n) = k_cond(j,n) - (r_alpha*P_cond*r_beta')/(4*pi*gamma*norm(r_alpha,3)*norm(r_beta,3));
        end
    end
end

% Axial reflection matrix for walls
m = 10;
k_murs = zeros(n_electrodes,n_electrodes);
pos_image(:,1,1)= abs(e(:,1)-m)+m;     pos_image(:,2,1) = e(:,2);             pos_image(:,3,1)=e(:,3);   % vertical      right   wall 
pos_image(:,1,2)= -m - abs(e(:,1)+m);  pos_image(:,2,2) = e(:,2);             pos_image(:,3,2)=e(:,3);   % vertical      left    wall
pos_image(:,1,3)= e(:,1);              pos_image(:,2,3) = abs(e(:,2)-m)+m;    pos_image(:,3,3)=e(:,3);   % horizontal    top     wall
pos_image(:,1,4)= e(:,1);              pos_image(:,2,4) = -m - abs(e(:,2)+m); pos_image(:,3,4)=e(:,3);   % horizontal    bottom  wall
pos_image(:,1,5)= pos_image(:,1,1);    pos_image(:,2,5) = pos_image(:,2,3);   pos_image(:,3,5)=e(:,3);   % right         top     corner
pos_image(:,1,6)= pos_image(:,1,1);    pos_image(:,2,6) = pos_image(:,2,4);   pos_image(:,3,6)=e(:,3);   % right         bottom  corner
pos_image(:,1,7)= pos_image(:,1,2);    pos_image(:,2,7) = pos_image(:,2,4);   pos_image(:,3,7)= e(:,3);  % left          top     corner
pos_image(:,1,8)= pos_image(:,1,2);    pos_image(:,2,8) = pos_image(:,2,3);   pos_image(:,3,8) = e(:,3); % left          bottom  corner
% f_print_images(er); % To print reflection robots

for k = 1:size(pos_image, 3)
    for j=1:n_electrodes
        for n=1:n_electrodes
           r_alpha_beta = e(j,:) - pos_image(n,:,k); % distance between electrode j and wall electrode image n
           k_murs(j,n) = k_murs(j,n) + 1/(4*pi*gamma*norm(r_alpha_beta));
        end
     end
end
K= k_murs +  k_cond + k_isol;
% K = K_ins+ K_cond;
% K = K_ins + K_wall*0.05;
% K =K_ins +  K_cond;
%K = k_cond*1.3 - k_isol*1.2 + k_murs*0.006;
%K = k_cond*1.3 + k_isol*1.2 + k_murs*0.006;
I = C0*K*C0*U';
end