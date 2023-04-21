function [ltp, rtp, lbp, rbp] = corner_coordinate_calculator(ROI_msk)
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

    % find the most left-top point in the ROI

    ltp = [99999, 99999];

    for i = 1: row
        for j = 1: col
            if bina_mask(i, j) ~=0
                if sqrt((i - 0)^2 + (j - 0)^2) < sqrt((ltp(1) - 0)^2 + (ltp(2) - 0)^2)
                    ltp = [i, j];


                end

            end

        end
    end



    % find the most right-top point in the ROI

    rtp = [99999, 99999];

    for i = 1: row
        for j = 1: col
            if bina_mask(i, j) ~=0
                if sqrt((i - 0)^2 + (j - col)^2) < sqrt((rtp(1) - 0)^2 + (rtp(2) - col)^2)
                    rtp = [i, j];


                end

            end

        end
    end


    imshow(ROI_msk);




    % find the most left-bottom point in the ROI

    lbp = [99999, 99999];

    for i = 1: row
        for j = 1: col
            if bina_mask(i, j) ~=0
                if sqrt((i - row)^2 + (j - 0)^2) < sqrt((lbp(1) - row)^2 + (lbp(2) - 0)^2)
                    lbp = [i, j];


                end

            end

        end
    end


    imshow(ROI_msk);



    % find the most right-bottom point in the ROI

    rbp = [99999, 99999];

    for i = 1: row
        for j = 1: col
            if bina_mask(i, j) ~=0
                if sqrt((i - row)^2 + (j - col)^2) < sqrt((rbp(1) - row)^2 + (rbp(2) - col)^2)
                    rbp = [i, j];


                end

            end

        end
    end

    %{
    imshow(ROI_msk);

    plot(ltp(2), ltp(1), 'r+', 'MarkerSize', 5, 'LineWidth', 3);
    plot(rtp(2), rtp(1), 'r+', 'MarkerSize', 5, 'LineWidth', 3);
    plot(lbp(2), lbp(1), 'r+', 'MarkerSize', 5, 'LineWidth', 3);
    plot(rbp(2), rbp(1), 'r+', 'MarkerSize', 5, 'LineWidth', 3);
    %}

end