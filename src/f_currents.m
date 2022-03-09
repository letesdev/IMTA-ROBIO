function [I] = f_currents(n_electrodes, x_electrodes, y_electrodes, pos_isol, pos_cond)
z_alpha_A = [0      0       0.06    0       -0.06   ];
gamma = 0.04;
% Matrice de conductances (conductivité) entre chaque electroque
C0 = gamma * [   0.2557 -0.0639 -0.0639 -0.0639 -0.0639;
                -0.0639 0.1218 -0.0203 -0.0173 -0.0203;
                -0.0639 -0.0203 0.1218 -0.0203 -0.0173;
                -0.0639 -0.0173 -0.0203 0.1218 -0.0203;
                -0.0639 -0.0203 -0.0173 -0.0203 0.1218];

U = [1, zeros(1,n_electrodes-1)];
e = [x_electrodes', y_electrodes', z_alpha_A'];

% Objets isolants 
newcol = zeros(length(pos_isol), 1);
pos_isol = [pos_isol newcol];
%ins_objs = size(pos_isol);

k_isol = zeros(n_electrodes, n_electrodes);
P_isol = eye(3)*(0.1)^3*-0.5;
for k = size(pos_isol, 1)
    for j = 1:n_electrodes
        for n = 1:n_electrodes
            r_alpha = pos_isol(k,:) - e(j,:);
            r_beta  = pos_isol(k,:) - e(n,:);
            k_isol(j,n) = k_isol(j,n) - (r_alpha*P_isol*r_beta')/(4*pi*gamma*norm(r_alpha,3)*norm(r_beta,3));
        end
    end
end

% Objets conducteurs
newcol = zeros(length(pos_cond), 1);
pos_cond = [pos_cond newcol];
%cond_objs = size(pos_cond);

k_cond = zeros(n_electrodes, n_electrodes);
P_cond = eye(3)*(0.1)^3*1;
for k = size(pos_cond, 1)
    for j = 1:n_electrodes
        for n = 1:n_electrodes
            r_alpha = pos_cond(k,:) - e(j,:);
            r_beta  = pos_cond(k,:) - e(n,:);
            k_cond(j,n) = k_cond(j,n) - (r_alpha*P_cond*r_beta')/(4*pi*gamma*norm(r_alpha,3)*norm(r_beta,3));
        end
    end
end

% Murs
m = 3.2;
k_murs = zeros(n_electrodes,n_electrodes);
er(:,1,1)= abs(e(:,1)-m)+m; er(:,2,1) = e(:,2); er(:,3,1)=e(:,3); %vertical 1 
er(:,1,2)= -m - abs(e(:,1)+m); er(:,2,2) = e(:,2); er(:,3,2)=e(:,3); %vertical -1
er(:,1,3)= e(:,1); er(:,2,3) = abs(e(:,2)-m)+m; er(:,3,3)=e(:,3); %horizontal 1
er(:,1,4)= e(:,1);  er(:,2,4) = -m - abs(e(:,2)+m);  er(:,3,4)=e(:,3); %horizontal -1
er(:,1,5)= er(:,1,1); er(:,2,5) = er(:,2,3); er(:,3,5)=e(:,3);  %corner (1,1)
er(:,1,6)= er(:,1,1); er(:,2,6) = er(:,2,4); er(:,3,6)=e(:,3); %corner (1,-1)
er(:,1,7)= er(:,1,2); er(:,2,7) = er(:,2,4); er(:,3,7)= e(:,3); %corner (-1,-1)
er(:,1,8)= er(:,1,2); er(:,2,8) = er(:,2,3); er(:,3,8) = e(:,3); %corner (-1,1)

for k = 1:size(er, 3)
    for j=1:n_electrodes
        for n=1:n_electrodes
           r_alpha_beta = e(j,:)- er(n,:,k);
           k_murs(j,n) = k_murs(j,n)+ 1/(4*pi*gamma*norm(r_alpha_beta));
        end
     end
end
% K= K_wall +  K_cond + K_ins;
% K = K_ins+ K_cond;
% K = K_ins + K_wall*0.05;
% K =K_ins +  K_cond;
K = k_cond*1.3 - k_isol*1.2 + k_murs*0.006;
I = C0*K*C0*U';
end