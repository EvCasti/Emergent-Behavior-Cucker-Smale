function A = tmatrix(v1,v2)
    axis = cross(v1,v2);
    angle = asin(norm(axis) / norm(v1) / norm(v2)) ;
    A = axang2rotm([axis'  angle]);
end