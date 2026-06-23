function [idx1, idx2, maxDist] = findFarthestPoints(points)
    % Finds the two farthest points in a 3D point cloud.
    % Input:
    % points - Nx3 matrix containing the x, y, and z coordinates of the points.
    % Outputs:
    % idx1, idx2 - indices of the two farthest points.
    % maxDist - maximum Euclidean distance found between two points.
    
    N = size(points, 1); % Number of points.
    maxDist = 0;
    idx1 = 1;
    idx2 = 1;
    
    % Loop through all point pairs to find the maximum distance.
    for i = 1:N-1
        for j = i+1:N
            dist = norm(points(i,:) - points(j,:)); % Euclidean distance.
            if dist > maxDist
                maxDist = dist;
                idx1 = i;
                idx2 = j;
            end
        end
    end
end