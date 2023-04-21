function [tp, btm, lft, rt] = inner_tangent_point_calculator(ROI_msk)
    % this function calculates the four points at which the inner
    % tangential sqaure of the body touches the body outline
    bina_mask = ROI_msk;


    sz = size(ROI_msk);

    row = sz(1);
    col = sz(2);

    % make ROI_msk binary, where the threshold is 50
    for p = 1: row
        for k = 1: col
            if ROI_msk(p, k) < 50
                bina_mask(p, k) = 0;


            else
                bina_mask(p, k) = 255;

            end


        end

    end


    % first, calculate the coordinates of the corner points and the center
    [ltp, rtp, lbp, rbp] = corner_coordinate_calculator(ROI_msk);
    ctp = center_coordinate_calculator(ROI_msk);

    % calculate the top inner-tangential point
    

    % get the rows where the top inner-tangential point can be
    boarder_row = ctp(1);

    % calculate the top point

    
    top_outline = zeros(0, 2); % stores all the points on the top part of the body outline
    top_outline_count = 0; % # points on the top part of the body outline

    for j = ltp(2): rtp(2)
        for i = 1: boarder_row
            if bina_mask(i, j) ~= 0
                top_outline(top_outline_count + 1, 1) = i;
                top_outline(top_outline_count + 1, 2) = j;
                top_outline_count = top_outline_count + 1;

                break;

            end




        end




    end

    tp = [top_outline(1, 1), top_outline(1, 2)];

    for k = 1: top_outline_count
        if top_outline(k, 1) > tp(1)
            tp = [top_outline(k, 1), top_outline(k, 2)];

        end


    end
    



    % calculate the bottom point


    bottom_outline = zeros(0, 2); % stores all the points on the bottom part of the body outline
    bottom_outline_count = 0; % # points on the bottom part of the body outline

    for j = lbp(2): rbp(2)
        for i = 1: (row - ctp(1) + 1)
            q = row - i + 1;
            if bina_mask(q, j) ~= 0
                bottom_outline(bottom_outline_count + 1, 1) = q;
                bottom_outline(bottom_outline_count + 1, 2) = j;
                bottom_outline_count = bottom_outline_count + 1;

                break;

            end




        end




    end
    
    btm = [bottom_outline(1, 1), bottom_outline(1, 2)];

    for k = 1: bottom_outline_count
        if bottom_outline(k, 1) < btm(1)
            btm = [bottom_outline(k, 1), bottom_outline(k, 2)];

        end


    end

    % get the rows where the body pixels are at
    top_boarder_row = ltp(1);
    bottom_boarder_row = lbp(1);



    % calculate the left point

    left_outline = zeros(0, 2); % stores all the points on the left part of the body outline
    left_outline_count = 0; % # points on the left part of the body outline

    for i = top_boarder_row: bottom_boarder_row
        for j = 1: ctp(2)
            if bina_mask(i, j) ~= 0
                left_outline(left_outline_count + 1, 1) = i;
                left_outline(left_outline_count + 1, 2) = j;
                left_outline_count = left_outline_count + 1;
                break;

            end


        end


    end

    lft = [left_outline(1, 1), left_outline(1, 2)];

    for k = 1: left_outline_count
        if left_outline(k, 2) > lft(2)
            lft = [left_outline(k, 1), left_outline(k, 2)];

        end


    end


    % calculate the right point

    right_outline = zeros(0, 2); % stores all the points on the right part of the body outline
    right_outline_count = 0; % # points on the right part of the body outline

    for i = rtp(1): rbp(1)
        for j = 1: (col - ctp(2) + 1)
            q = col - j + 1;
            if bina_mask(i, q) ~= 0
                right_outline(right_outline_count + 1, 1) = i;
                right_outline(right_outline_count + 1, 2) = q;
                right_outline_count = right_outline_count + 1;
                break;

            end


        end


    end

    rt = [right_outline(1, 1), right_outline(1, 2)];

    for k = 1: right_outline_count
        if right_outline(k, 2) < rt(2)
            rt = [right_outline(k, 1), right_outline(k, 2)];

        end


    end

    imshow(bina_msk);
    hold on;

    plot(tp(2), tp(1), 'r+', 'MarkerSize', 5, 'LineWidth', 3);
    plot(btm(2), btm(1), 'r+', 'MarkerSize', 5, 'LineWidth', 3);
    plot(lft(2), lft(1), 'r+', 'MarkerSize', 5, 'LineWidth', 3);
    plot(rt(2), rt(1), 'r+', 'MarkerSize', 5, 'LineWidth', 3);

    %for k = 1: bottom_outline_count
    %    plot(bottom_outline(k, 2), bottom_outline(k, 1), 'r+', 'MarkerSize', 5, 'LineWidth', 3);

     %end


end