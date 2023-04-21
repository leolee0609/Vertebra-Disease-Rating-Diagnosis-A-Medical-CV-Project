function ctp = center_coordinate_calculator(ROI_msk)

    % this function returns the coordinator of the center point of the body
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

    % find the center point in the ROI

    ctp = [0, 0];

    % the number of pixels in the ROI
    pix_count = 0;

    for i = 1: row
        for j = 1: col
            if bina_mask(i, j) ~=0
                ctp(1) = ctp(1) + i;
                ctp(2) = ctp(2) + j;

                pix_count = pix_count + 1;

            end

        end
    end

    ctp(1) = floor(ctp(1) / pix_count);

    ctp(2) = floor(ctp(2) / pix_count);


    imshow(ROI_msk);

    plot(ctp(2), ctp(1), 'r+', 'MarkerSize', 5, 'LineWidth', 3);

end