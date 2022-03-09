function [] = f_print(x0, x, y0, y, V_alpha, longueur_aq, largeur_aq, cerc_isol_X, cerc_isol_Y, cerc_cond_X, cerc_cond_Y)
    quiver(x0,y0,(x-x0),(y-y0));
    hold on;
    scatter(V_alpha(1,:),V_alpha(2,:), 18);
    line([V_alpha(1,1), V_alpha(1,2)], [V_alpha(2,1), V_alpha(2,2)], 'Color','m', 'LineWidth',2);
    line([V_alpha(1,1), V_alpha(1,4)], [V_alpha(2,1), V_alpha(2,4)], 'Color','m', 'LineWidth',2);
    line([V_alpha(1,4), V_alpha(1,2)], [V_alpha(2,4), V_alpha(2,2)], 'Color','m', 'LineWidth',2);
    plot(cerc_isol_X, cerc_isol_Y,'b');
    plot(cerc_cond_X, cerc_cond_Y,'r');
    hold off;
    f_aquarium(longueur_aq,largeur_aq);
    text(3, 3.8, 'Isolants');
    text(2.4, 3.8, '-----', 'Color', 'blue');
    text(3, 3.5, 'Conducteurs');
    text(2.4, 3.5, '-----', 'Color', 'red');
    
end

