function J = iiwa_jacobian(R, q, tag)
switch tag
    case 'simplify'
        if q(3) == 0
            J = R.jacob0(q);
            J = [J(:, 1:2) J(:, 4:7)];
        else
            J = eye(6);
            msg = "Error. q3 is not equal to 0.";
            disp(msg);
            %error(msg);
        end
    otherwise
        J = R.jacob0(q);
end