function [a, b] = line_function(p1, p2)
    % this function calculates a line passing through 2 points p1 and p2
    a = (p1(2) - p2(2)) / (p1(1) - p2(1));
    

    b = p1(2) - a * p1(1);



end