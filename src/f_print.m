function [] = f_print(x0, x, y0, y, V_alpha, longueur_aq, largeur_aq, cerc_isol_X, cerc_isol_Y, cerc_cond_X, cerc_cond_Y, X_repere, Y_repere)
    quiver(x0,y0,(x-x0),(y-y0), 10);
    hold on;
    quiver(x0,y0,(y-y0),(x-x0), 10);
    scatter(V_alpha(1,:),V_alpha(2,:), 9);
    line([V_alpha(1,1), V_alpha(1,2)], [V_alpha(2,1), V_alpha(2,2)], 'Color','m', 'LineWidth',1.5);
    line([V_alpha(1,1), V_alpha(1,4)], [V_alpha(2,1), V_alpha(2,4)], 'Color','m', 'LineWidth',1.5);
    line([V_alpha(1,4), V_alpha(1,2)], [V_alpha(2,4), V_alpha(2,2)], 'Color','m', 'LineWidth',1.5);
    plot(cerc_isol_X, cerc_isol_Y,'b');
    plot(cerc_cond_X, cerc_cond_Y,'r');
    plot(X_repere, Y_repere, 'y');
    hold off;
    f_aquarium(longueur_aq,largeur_aq);
    text(3, 3.8, 'Isolants');
    text(2.4, 3.8, '-----', 'Color', 'blue');
    text(3, 3.5, 'Conducteurs');
    text(2.4, 3.5, '-----', 'Color', 'red');
    text(3, 3.2, 'Trajectoire');
    text(2.4, 3.2, '-----', 'Color', 'y');
end

