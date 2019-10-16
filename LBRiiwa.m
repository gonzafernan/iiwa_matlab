classdef LBRiiwa < SerialLink
    methods
        function r =  LBRiiwa(varargin)
            d1 = 0.340; d3 = 0.400; d5 = 0.400; d7 = 0.126;
            DH = [
                0   d1  0   -pi/2   0;
                0   0   0   pi/2    0;
                0   d3  0   -pi/2   0;
                0   0   0   pi/2    0;
                0   d5  0   -pi/2   0;
                0   0   0   pi/2    0;
                0   d7  0   0       0];
            r = r@SerialLink(DH, 'name', 'LBR iiwa 7 R800 (KUKA)');
            r.qlim = [
                -deg2rad(170)   deg2rad(170);
                -deg2rad(120)   deg2rad(120);
                -deg2rad(170)   deg2rad(170);
                -deg2rad(120)   deg2rad(120);
                -deg2rad(170)   deg2rad(170);
                -deg2rad(120)   deg2rad(120);
                -deg2rad(175)   deg2rad(175)];
        end
    end
end