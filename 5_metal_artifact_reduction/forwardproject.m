function sino = forwardproject(i)

    [nrows, ncols] = size(i);
    
    if nrows ~= 520
        error('wrong data, not 736 rows!')
    end

    if ncols~= 520
        error('wrong data. not 576 cols!')
    end
    
    nviews = 576;
    
    theta = 360 * ((1:nviews) - 1) / nviews;

    sino = radon(i, theta);


    sino = sino(2:end-2,:);
end