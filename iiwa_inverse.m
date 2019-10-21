%function [q] = iiwa_inverse(q3_in, xyz, rpy, R)
function [q] = iiwa_inverse(q3_in, T, R)

q = zeros(7, 8);
d1 = R.d(1); d3 = R.d(3); d5 = R.d(5); d7 = R.d(7);

% T0_7 = transl(xyz)*rpy2tr(rpy, 'deg');
T0_7 = T;

P0_7 = T0_7(1:3, 4);

P0_W = P0_7 - d7*T0_7(1:3,3);     % Wrist

% Ubicación de la articulación 1 - Independiente de qi
T0_1 = R.links(1).A(0).T;
P0_1 = T0_1(1:3, 4);

r1_4 = norm(P0_1 - P0_W);

q4(1) = pi - acos( (d3^2 + d5^2 - r1_4^2) / ...
                (2*d3*d5) );

q4(2) = pi + acos( (d3^2 + d5^2 - r1_4^2) / ...
                (2*d3*d5) );

q3 = q3_in;

q(3, :) = q3;
q(4, 1:2) = [q4(1), q4(1)];
q(4, 3:4) = [q4(2), q4(2)];
q(4, 5:8) = q(4, 1:4);

xw = P0_W(1);
yw = P0_W(2);
zw = P0_W(3);

n = 1;

for u=1:2
    
    T25 = R.A([3 4 5], [0 0 q3 q4(u) 0 0 0]).T;

    a = T25(3, 4);
    b = -T25(1, 4);
    R_ab = (a^2 + b^2)^0.5;
    alpha_conv = atan2(b, a);

    q2(1) = alpha_conv - acos((zw - d1)/R_ab);
    q2(2) = alpha_conv + acos((zw - d1)/R_ab);

    for v=1:2
        T15 = R.links(2).A(q2(v)).T*T25;     % T15 = T12*T25

        a = T15(1, 4);
        b = -T15(3, 4);
        R_ab = (a^2 + b^2)^0.5;
        alpha_conv = atan2(b, a);

        q1(1) = alpha_conv - acos(xw/R_ab);
        q1(2) = alpha_conv + acos(xw/R_ab);
        
        for w = 1:2
            T04_actual = R.A([1 2 3 4 5], [q1(w), q2(v), q3, q4(u), 0, 0, 0]).T;

            if (abs(norm(T04_actual(1:3, 4) - [xw, yw, zw]')) < 1e-3)

                q(1, n) = q1(w);
                q(2, n) = q2(v);
                q(1, n + 4) = q1(w);    % Solución igual para segunda muñeca
                q(2, n + 4) = q2(v);
                
                % Muñeca
                T0_4 = R.A([1 2 3 4], ...
                    [q(1, n), q(2, n), q(3, n), q(4, n), 0 0 0]).T;
                T4_7 = inv(T0_4) * T0_7;
                
                q6 = -atan2(sqrt(T4_7(3,1)^2 + T4_7(3,2)^2), T4_7(3,3));
                q7 = atan2(-T4_7(3,2), T4_7(3,1));
                q5 = atan2(T4_7(2,3), T4_7(1,3)) + pi;
                q(5, n) = q5;
                q(6, n) = q6;
                q(7, n) = q7;
                
                q6 = atan2(sqrt(T4_7(3,1)^2 + T4_7(3,2)^2), T4_7(3,3));
                q7 = atan2(-T4_7(3,2), T4_7(3,1)) - pi;
                q5 = atan2(T4_7(2,3), T4_7(1,3));
                q(5, n + 4) = q5;
                q(6, n + 4) = q6;
                q(7, n + 4) = q7;
                
                n = n + 1;
                break
            end
        end
    end
end

for u = 1:7     % Normalización de ángulos a [-pi, pi]
    for v = 1:8
        if q(u, v) > pi
            q(u, v) = q(u, v) - 2*pi;
        elseif q(u, v) < -pi
            q(u, v) = q(u, v) + 2*pi;
        end
    end
end

end