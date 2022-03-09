function [] = f_aquarium(Longueur,Largueur)
line(Longueur*[-1,-1,1,1,-1],Largueur*[-1,1,1,-1,-1],'Color','b','LineStyle','-');
xlim([-(Longueur+1),(Longueur+1)])
ylim([-(Largueur+1),(Largueur+1)])
axis equal
grid on
end

