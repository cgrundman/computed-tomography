function r = reconstruct(sino)
    
    [ndexel, nviews] = size(sino);
    
    if ndexel ~= 736
        error('wrong data, not 736 dexel!')
    end

    if nviews ~= 576
        error('wrong data. not 576 views!')
    end

    theta = 360 * ((1:nviews) - 1) / nviews;

    r = iradon(sino, theta);
end