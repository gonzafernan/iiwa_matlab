function updatePlot(handles)
global R q J E;
R.plot(q);
C = R.fkine(q).t';
if get(handles.checkEllipseV, 'Value') == 1
    if isgraphics(E)
        plot_ellipse(ellipsoid(J, 'tras'), C, 'alter', E);
    else
        E = plot_ellipse(ellipsoid(J, 'tras'), C, 'alpha', 0);
    end
elseif get(handles.checkEllipseW, 'Value') == 1
    if isgraphics(E)
        plot_ellipse(ellipsoid(J, 'rot'), C, 'alter', E, 'r');
    else
        E = plot_ellipse(ellipsoid(J, 'rot'), C, 'alpha', 0);
    end
else
    delete(E);
end

function E = ellipsoid(J, tag)
    switch tag
        case 'tras'
            E = J(1:3, :);
        case 'rot'
            E = J(4:6, :);
    end
    E = E*E';