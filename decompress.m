function decompress(compressedImg, method, k, h)
  compressedImg = double(imread(compressedImg));
  switch method
    case 1
      decompressedImg = bilinearMethod(compressedImg, k, h);
    case 2
      decompressedImg = bicubicMethod(compressedImg, k, h);
  endswitch
  decompressedImg = uint8(decompressedImg);
  imwrite(decompressedImg, "decompressed.png");
endfunction

function decompressedImg = bilinearMethod(compressedImg, k, h)
  nlin = size(originalImg)(1);
  ncol = size(originalImg)(2);
  H = [1,0,0,0;1,0,h,0;1,h,0,0;1,h,h,h^2]
  for c = 1:3
    for i = 1:nlin-1
      for j = 1:ncol-1
        f = [compressedImg(i,j,c);compressedImg(i,j+1,c);compressedImg(i+1,j,c);compressedImg(i+1,j+1,c)];
        p = @(x,y) dot(H\f, [1,x-i*h,y-j*h,(x-i*h)*(y-j*h)];
        for x = 1:k+2
          for y = 1:k+2
            decompressedImg((i-1)*(k+1)+x,(j-1)*(k+1)+y,c) = p(i*h+(x-1)*h/(k+1), j*h+(y-1)*h/(k+1));
          endfor
        endfor
      endfor
    endfor
  endfor
  return
endfunction

function decompressedImg = bicubicMethod(compressedImg, k, h)
  nlin = size(originalImg)(1);
  ncol = size(originalImg)(2);
  B = [1,0,0,0;0,0,1,0;-3/h^2,3/h^2,-2/h,-1/h;2/h^3,-2/h^3,1/h^2,1/h^2];
  for c = 1:3
    for i = 1:nlin-1
      for j = 1:ncol-1
        f = [compressedImg(i,j,c),compressedImg(i,j+1,c),dfdy(compressedImg,i,j,c),dfdy(compressedImg,i,j+1,c);
            compressedImg(i+1,j,c),compressedImg(i+1,j+1,c),dfdy(compressedImg,i+1,j,c),dfdy(compressedImg,i+1,j+1,c);
            dfdx(compressedImg,i,j,c),dfdx(compressedImg,i,j+1,c),d2fdxdy(compressedImg,i,j,c),d2fdxdy(compressedImg,i,j+1,c);
            dfdx(compressedImg,i+1,j,c),dfdx(compressedImg,i+1,j+1,c),d2fdxdy(compressedImg,i+1,j,c),d2fdxdy(compressedImg,i+1,j+1,c)];
        p = @(x,y) [1,(x-i*h),(x-i*h)^2,(x-i*h)^3]*B*f*transpose(B)*[1;(y-j*h);(y-j*h)^2;(y-j*h)^3];
        for x = 1:k+2
          for y = 1:k+2
            decompressedImg((i-1)*(k+1)+x,(j-1)*(k+1)+y,c) = p(i*h+(x-1)*h/(k+1), j*h+(y-1)*h/(k+1));
          endfor
        endfor
      endfor
    endfor
  endfor
  return
endfunction

function der = dfdx(f, x, y, color)
  n = size(f)(1);
  if (x == 1)
    der = (-3*f(x,y,color) + 4*f(x+1,y,color) - f(x+2,y,color))/(2*h);
  elseif (x == n)
    der = (-3*f(x,y,color) + 4*f(x-1,y,color) - f(x-2,y,color))/(2*h);
  else
    der = (f(x+1,y,color) - f(x-1,y,color))/(2*h);
  endif
  return
endfunction

function der = dfdy(f, x, y, color)
  n = size(f)(2);
  if (y == 1)
    der = (-3*f(x,y,color) + 4*f(x,y+1,color) - f(x,y+2,color))/(2*h);
  elseif (y == n)
    der = (-3*f(x,y,color) + 4*f(x,y-1,color) - f(x,y-2,color))/(2*h);
  else
    der = (f(x,y+1,color) - f(x,y-1,color))/(2*h);
  endif
  return
endfunction

function der = d2fdxdy(f, x, y, color)
  n = size(f)(1);
  if (x == 1)
    der = (-3*dfdy(f,x,y,color) + 4*dfdy(f,x+1,y,color) - dfdy(f,x+2,y,color))/(2*h);
  elseif (x == n)
    der = (-3*dfdy(f,x,y,color) + 4*dfdy(f,x-1,y,color) - dfdy(f,x-2,y,color))/(2*h);
  else
    der = (dfdy(f,x+1,y,color) - dfdy(f,x-1,y,color))/(2*h);
  endif
  return
endfunction

# verificar derivadas! linear para d2fdxdy e quadratica p/ primeira derivada
