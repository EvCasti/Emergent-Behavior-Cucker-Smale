function plot_sphere(cnf)
    colormap white
    [x,y,z] = sphere(30);
    surf(x,y,z,'EdgeAlpha',.3,'FaceAlpha',.8)
    hold on
    pplot(cnf)
    hold off
end

function pplot(cnf)
    color = 'b';
    msize = 12;

    if size(cnf,1) > size(cnf,2)
        cnf = cnf';
    end
    msize = ceil(max(1, 22-3.5*log10(size(cnf,2)) ));
    colormap white
    plot3(cnf(1,:),cnf(2,:),cnf(3,:),['.' color],'MarkerSize',msize)
    pbaspect([1 1 1])
    daspect([1 1 1])
    set(gca, 'Clipping', 'off')
    axis vis3d
    box on
    grid on
end