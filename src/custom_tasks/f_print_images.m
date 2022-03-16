function [] = f_print_images(images_pos)
for i = 1:size(images_pos, 3)
    scatter(images_pos(:,1,i),images_pos(:,2,i), 9); hold on;
end
end

