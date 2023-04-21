function [a, b] = novel_linear_regression_trainer(feature, label)
    % this function returns trains a simple linear regression model, but
    % the residual (i.e., loss function to be minimized) is the sum of
    % the distances between the sample points to the line. The trained
    % model is expressed in y = a*x + b

    % build an anonymous function specifying the loss function, where w =
    % [a, b], and the regression function is y = ax + b
    loss = @(w) sum((w(1) * feature - label + w(2)).^2 / (w(1)^2 + 1));


    %{
    % initialize a proper w0
    sz = size(feature);
    sz = sz(1);

    count = 0;
    sigma_a = 0;
    sigma_b = 0;

    for i = 1: sz
        for j = 1: sz
            if feature(i) ~= feature(j) && label(i) ~= label(j)

                [this_a, this_b] = line_function([feature(i), label(i)], [feature(j), label(j)]);
                sigma_a = sigma_a + this_a;
                sigma_b = sigma_b + this_b;
                count = count + 1;

            end


        end

    end


    w0(1) = sigma_a / count;
    w0(2) = sigma_b / count;

    disp("a and b are ");
    disp(w0);

    %}

    % initialize an proper w0 by fitting feature = c * label + d
    sz = size(feature);
    sz = sz(1);
    sigma_feature = 0;

    for i = 1: sz

        sigma_feature = sigma_feature + feature(i);

    end

    sigma_label_sq = 0;
    sigma_label = 0;
    sigma_label_feature = 0;

    for i = 1: sz
        sigma_label = sigma_label + label(i);
        sigma_label_sq = sigma_label_sq + label(i)^2;
        sigma_label_feature = sigma_label_feature + feature(i) * label(i);
    end

    d = (sigma_feature * sigma_label_sq - sigma_label * sigma_label_feature) / (sz * sigma_label_sq - sigma_label^2);
    c = (sz * sigma_label_feature - sigma_label * sigma_feature) / (sz * sigma_label_sq - sigma_label^2);

    a0 = 1 / c;
    b0 = -d / c;

    w0 = [a0, b0];

    disp("a and b are ");
    disp(w0);

    % minimize the loss function to get the optimal w
    w = fminunc(loss, w0);




    a = w(1);
    b = w(2);



end