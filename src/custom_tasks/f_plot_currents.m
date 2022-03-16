function [] = f_plot_currents(X_repere,II)
ax1 = gca;
fnew = figure('Position',[300 125 1000 600]);
ax1_copy = copyobj(ax1, fnew);
subplot(2,2,[1,3], ax1_copy)
xlabel("$x [cm]$", 'Interpreter', 'latex')
ylabel("$y [cm]$", 'Interpreter', 'latex')
%xticks([-3 -2 -1 0 1 2 3])
axis(3.5*[-1 1 -1 1])
legend('', '',  '', '', '', '', 'Isolants', '', 'Conducteurs', '', 'Trajectoire', '', 'Position',[0.31 0.31 0.12 0.08]);
% Affichage courans
subplot(2,2,2)
plot(X_repere, (II(2,:)-II(2,1) + II(4,:)-II(4,1))/2);
title("$\delta I_{ax} = \frac{1}{2} \cdot \left (\delta I_2 + \delta I_4 \right )$", 'Interpreter', 'latex')
xlabel("$x [cm]$", 'Interpreter', 'latex')
ylabel("$I [A]$", 'Interpreter', 'latex')
grid on

subplot(2,2,4)
plot(X_repere, (II(2,:)-II(2,1) - II(4,:)-II(4,1))/2);
title("$\delta I_{lat} = \frac{1}{2} \cdot \left (\delta I_2 - \delta I_4 \right )$", 'Interpreter', 'latex')
xlabel("$x [cm]$", 'Interpreter', 'latex')
ylabel("$I [A]$", 'Interpreter', 'latex')
grid on


% f = figure;
% f.Position(3:4) = [1000 600];
% 
% subplot(3,3,4)
% %plot(X_electrodes(1,:),II(1,:));
% plot(X_repere, II(1,:));
% title('Electrode #1: queue')
% xlabel('$x$[m]', 'Interpreter','latex')
% ylabel('$I$ [A]', 'Interpreter','latex')
% grid on
% 
% subplot(3,3,3)
% %plot(X_electrodes(2,:),II(2,:));
% plot(X_repere, II(2,:));
% title('Electrode #2')
% xlabel('$x$[m]', 'Interpreter','latex')
% ylabel('$I$ [A]', 'Interpreter','latex')
% grid on
% 
% subplot(3,3,6)
% %plot(X_electrodes(3,:),II(3,:));
% plot(X_repere, II(3,:));
% title('Electrode #3: tête')
% xlabel('$x$[m]', 'Interpreter','latex')
% ylabel('$I$ [A]', 'Interpreter','latex')
% grid on
% 
% subplot(3,3,9)
% %plot(X_electrodes(4,:),II(4,:));
% plot(X_repere, II(4,:));
% title('Electrode #4')
% xlabel('$x$[m]', 'Interpreter','latex')
% ylabel('$I$ [A]', 'Interpreter','latex')
% grid on
% 
% 
% subplot(3,3,5)
% %plot(X_electrodes(1,:)+0.2,II(1,:)+II(2,:)+II(3,:)+II(4,:)+II(5,:));
% plot(X_repere, II(1,:)+II(2,:)+II(3,:)+II(4,:)+II(5,:));
% title('Somme des courants')
% xlabel('$x$[m]', 'Interpreter','latex')
% ylabel('$I$ [A]', 'Interpreter','latex')
% grid on
end

