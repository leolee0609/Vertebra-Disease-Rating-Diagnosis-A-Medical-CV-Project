function bina_mask = bina(ROI_msk, epsilon)
    % this function makes ROI_msk binary based on threshold epsilon.
    % epsilon is default to be 50.
    
    bina_mask = ROI_msk;


    sz = size(ROI_msk);

    row = sz(1);
    col = sz(2);

    % make ROI_msk binary, where the threshold is epsilon
    for p = 1: row
        for k = 1: col
            if ROI_msk(p, k) < epsilon
                bina_mask(p, k) = 0;


            else
                bina_mask(p, k) = 255;

            end


        end

    end




end