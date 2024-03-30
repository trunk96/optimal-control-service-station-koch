function c = assign_cw(p_in,x_cw, c_cw)
    [~,idx] =min(abs(p_in-x_cw));
    c=c_cw(idx);
end

