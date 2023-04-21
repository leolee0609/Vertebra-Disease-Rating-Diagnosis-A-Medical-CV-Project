function point_set = draw_line(ROI_msk, a, b)
    % this function draw a linear function y = ax + b, where (0, 0) is the
    % most left-top point in the whole image. x-axis is the row and y-axis
    % is the column. It also returns the set of points constituting the
    % line y = ax + b




    sz = size(ROI_msk);

    row = sz(1);
    col = sz(2);

    if a > 10000
        % in this case, a is too big, it is regarded as a horizontal line.
        point_set = ones(row * col, 1, 2);
        for j = 1: col
            point_set(j, 1) = b;
            point_set(j, 2) = j;

        end

        imshow(ROI_msk);
        hold on;

        for k = 1: col
            plot(point_set(k, 2), point_set(k, 1), 'r+', 'MarkerSize', 2, 'LineWidth', 2);


        end

        

        return;
    end

    point_set = zeros(0, 2);
    set_len = 0;


    for i = 1: row
        for j = 1: col
            if abs(j - floor(a * i + b)) < 1
                point_set(set_len + 1, 1) = i;
                point_set(set_len + 1, 2) = j;

                set_len = set_len + 1;

            end


        end


    end


    for k = 1: set_len
        plot(point_set(k, 2), point_set(k, 1), 'r+', 'MarkerSize', 2, 'LineWidth', 2);
        
        hold on;

    end




end