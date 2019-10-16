function q = iiwa_inverse(R, x, y, z, alpha, beta, gamma)
%     roll = deg2rad(roll);
%     pitch = deg2rad(pitch);
%     yaw = deg2rad(yaw);
%     T07 = transl(x,y,z)*trotx(roll)*troty(pitch)*trotz(yaw);
%     
    d1 = R.d(1);
    d3 = R.d(3);
    d5 = R.d(5);
    d7 = R.d(7);
%     
%     P0W = [
%         T07(1,4) - d7 * T07(1,3);
%         T07(2,4) - d7 * T07(2,3);
%         T07(3,4) - d7 * T07(3,3);
%         1];
%     
%     P_ = T07 * transl(0, 0, -d7);
%     
%     s = P0W(3) - d1;
%     r = sqrt(P0W(1)^2 + P0W(2)^2);
%     b_ = atan2(s, r);
%     rp = sqrt(s^2 + r^2);
%     a_ = real(acos((d3^2 + rp^2 - d5^2)/(2 * rp * d3)));
%     
%     q1 = atan2(P0W(2), P0W(1));
%     q2 = -(b_ + a_) + pi/2;
%     q3 = 0;
%     
%     T01 = R.links(1).A(q1).T;
%     T12 = R.links(2).A(q2).T;
%     T23 = R.links(3).A(q3).T;
%     
%     P3w = inv(T01 * T12 * T23) * P0W;
%     
%     q4 = atan2(P3w(2),P3w(1)) + pi/2;
%     
%     T34 = R.links(4).A(q4).T;
%     
%     T47 = inv(T01 * T12 * T23 * T34) * T07;
%     
%     q6 = -atan2(sqrt(T47(3,1)^2 + T47(3,2)^2), T47(3,3));
%     q7 = atan2(-T47(3,2), T47(3,1))+0;
%     q5 = atan2(T47(2,3), T47(1,3))+pi;
%     
%     q = [q1 q2 q3 q4 q5 q6 q7];

    q1 = atan2(y + d7*cos(beta)*sin(alpha), x + d7*sin(beta));
    q2 = pi/2 - atan2(z - d1 - d7*cos(beta)*cos(alpha), ((y + d7*cos(beta)*sin(alpha))^2 + (x + d7*sin(beta))^2)^(1/2)) - acos(((d1 - z + d7*cos(alpha)*cos(beta))^2 + (y + d7*cos(beta)*sin(alpha))^2 + d3^2 - d5^2 + (x + d7*sin(beta))^2)/(2*d3*((d1 - z + d7*cos(alpha)*cos(beta))^2 + (y + d7*cos(beta)*sin(alpha))^2 + (x + d7*sin(beta))^2)^(1/2)));
    q3 = 0;
    q4 = acos(((d1 - z + d7*cos(alpha)*cos(beta))^2 + (y + d7*cos(beta)*sin(alpha))^2 - d3^2 - d5^2 + (x + d7*sin(beta))^2)/(2*d3*d5));
    
    q = [real(q1) real(q2) q3 real(q4) 0 0 0];
end