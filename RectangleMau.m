function i = RectangleMau(i, xi, yi, xf, yf, v)

    i((xi:xf),yi) = v;
    i((xi:xf),yf) = v;
    i(xi,(yi:yf)) = v;
    i(xf,(yi:yf)) = v;
   
end

