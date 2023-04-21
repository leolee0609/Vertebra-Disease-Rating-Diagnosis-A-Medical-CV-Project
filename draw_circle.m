function point_set = draw_circle(ROI_msk, x0, y0, r, epsilon)
    % this function draw a circle (x - x0)^2 + (y - y0)^2 = r^2, where (0, 0) is the
    % most left-top point in the whole image. x-axis is the row and y-axis
    % is the column. It also returns the set of points constituting the
    % line y = ax + b




    sz = size(ROI_msk);

    row = sz(1);
    col = sz(2);

    % gather the set of points constituting the circle
    point_set = zeros(0, 2);
    set_len = 0;

    for i = 1: row
        for j = 1: col
            if abs(((i - x0)^2 + (j - y0)^2 - floor(r^2))) < epsilon
                point_set(set_len + 1, 1) = i;
                point_set(set_len + 1, 2) = j;

                set_len = set_len + 1;

            end


        end


    end

    disp(set_len);

    imshow(ROI_msk);
    hold on;

    for k = 1: set_len
        plot(point_set(k, 2), point_set(k, 1), 'r+', 'MarkerSize', 2, 'LineWidth', 2);

    end




end