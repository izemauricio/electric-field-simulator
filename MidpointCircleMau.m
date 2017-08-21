function i = MidpointCircleMau(i, radius, xc, yc, value)

xc = int16(xc); % xc = 50
yc = int16(yc); % yc = 50

x = int16(0);
y = int16(radius);

d = int16(1 - radius); % 1 - 20 = -19

% plota 4 pontos extremos
i(xc, yc+y) = value; % i(50, 50+raio) = value
i(xc, yc-y) = value; % i(50, 50-raio) = value
i(xc+y, yc) = value; % i(50 + raio, 50) = value
i(xc-y, yc) = value; % i(50 + raio, 50) = value

while ( x < y - 1 ) % x = 0, y = raio-1
    
    x = x + 1; % x = 1
    
    if ( d < 0 ) 
        d = d + x + x + 1; % d = -19 + 1 + 1 + 1 = -16
        
    else 
        y = y - 1;
        a = x - y + 1;
        d = d + a + a;
    end
    
    % plota
    i( x+xc,  y+yc) = value; % V(51, 50+raio)
    i( y+xc,  x+yc) = value; % V(50+raio, 50)
    i( y+xc, -x+yc) = value;
    i( x+xc, -y+yc) = value;
    i(-x+xc, -y+yc) = value;
    i(-y+xc, -x+yc) = value;
    i(-y+xc,  x+yc) = value;
    i(-x+xc,  y+yc) = value;
    
end

