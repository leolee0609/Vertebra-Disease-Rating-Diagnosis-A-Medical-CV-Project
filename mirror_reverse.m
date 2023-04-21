function reversed_msk = mirror_reverse(ROI_msk)
    % this function mirror-reverses ROI_msk.
    msksz = size(ROI_msk);
    M = msksz(1);
    N = msksz(2);

    reversed_msk = zeros(msksz);

    for t = 1: 3

        for i = 1: M
            for j = 1: N


                reversed_msk(i, j, t) = ROI_msk(i, N - j + 1, t);

            end
        end

    end




end