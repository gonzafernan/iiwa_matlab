%     q = [0 R.qlim(2, 1) 0 R.qlim(4, 1) 0 R.qlim(6, 1) 0];
%     dq = deg2rad(2);
%     lstQ = joint_move(6, R.qlim(6, 1), 0, q, dq);
%     q = lstQ(length(lstQ(:, 1)), :);
%     aux = joint_move(4, R.qlim(4, 1), 0, q, dq);
%     lstQ = [
%         lstQ;
%         aux];
%     q = lstQ(length(lstQ(:, 1)), :);
%     aux = joint_move(2, R.qlim(2, 1), R.qlim(2, 2), q, dq);
%     lstQ = [
%         lstQ;
%         aux];
t = 1;
for i = -2.9671:0.0175:2.9671
    wo(t,:) = [i pi/2 0 0 0 0 0];
    t = t + 1;
end

for i =  pi/2:0.0175:2.0944
    wo(t,:) = [2.9671 i 0 0 0 0 0];
    t = t + 1;
end

for i =  0:0.0175:2.0944
    wo(t,:) = [2.9671 2.0944 0 i 0 0 0];
    t = t + 1;
end

for i =  -2.0944:0.0175:0
    wo(t,:) = [2.9671 -2.0944 0 i 0 0 0];
    t = t + 1;
end

for i =  -2.0944:0.0175:0
    wo(t,:) = [2.9671 i 0 0 0 0 0];
    t = t + 1;
end

for i =  0:0.0175:2.0944
    wo(t,:) = [2.9671 i 0 0 0 0 0];
    t = t + 1;
end

for i =  0:0.0175:2.0944
    wo(t,:) = [2.9671 2.0944 0 i 0 0 0];
    t = t + 1;
end

for i =  -2.0944:0.0175:2.0944
    wo(t,:) = [2.9671 i 0 -2.0944 0 2.0944 0];
    t = t + 1;
end

for i =  0:0.0175:2.0944
    wo(t,:) = [2.9671 i 0 2.0944 0 -2.0944 0];
    t = t + 1;
end


% function lstJ = joint_move(n, theta1, theta2, q, dq)
%     lstJ = zeros(length(theta1:dq:theta2), 7);
%     iter = 1;
%     for i=theta1:dq:theta2
%         q(n) = i;
%         lstJ(iter, :) = q; 
%         iter = iter + 1;
%     end
% end