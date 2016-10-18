function I = decompress (compressedImg, method, k)
  compressedImg = double (compressedImg);
  n = size (compressedImg);
  switch method
    case 1
      for cor = 1:3 
        for i = 1:n(1)
          for j = 1:n(2)
            if (i == n(1) && j == n(2))
              I(1+(i-1)*(k+1),1+(j-1)*(k+1),cor) = compressedImg(i,j,cor);
            elseif (i == n(1))
              A = double ([1,j;1,j+1]);
              B = double ([compressedImg(i,j,cor);compressedImg(i,j+1,cor)]);
              f = @(x) double (dot (A\B, [1,x]));
              for x = 1:k+1
                I((i-1)*k+i,(j-1)*(k+1)+x,cor) = f(j+x/k);
              endfor
            elseif (j == n(2))
              A = double ([1,i;1,i+1]);
              B = double ([compressedImg(i,j,cor);compressedImg(i+1,j,cor)]);
              f = @(x) double (dot (A\B, [1,x]));
              for x = 1:k+1
                I((i-1)*(k+1)+x,(j-1)*k+j,cor) = f(i+x/k);
              endfor
            else
              A = [1,i,j,i*j;1,i,j+1,i*(j+1);1,i+1,j,(i+1)*j;1,i+1,j+1,(i+1)*(j+1)];
              B = [compressedImg(i,j,cor);compressedImg(i,j+1,cor);compressedImg(i+1,j,cor);compressedImg(i+1,j+1,cor)];
              f = @(x,y) dot (A\B, [1,x,y,x*y]);
              for x = 1:k+1
                for y = 1:k+1
                  I((i-1)*(k+1)+x,(j-1)*(k+1)+y,cor) = f(i+(x-1)/k,j+(y-1)/k);
                endfor
              endfor
            endif
          endfor
        endfor
      endfor
    case 2
      B = [1,0,0,0;0,0,1,0;-3,3,-1,-1;2,-2,1,1];
      for cor = 1:3 
        for i = 1:n(1)
          for j = 1:n(2)
            if (i == n(1) && j == n(2))
              I(1+(i-1)*(k+1),1+(j-1)*(k+1),cor) = compressedImg(i,j,cor);
            elseif (i == n(1))
              
            elseif (j == n(2))

            else
              M = [compressedImg(i,j,cor), compressedImg(i,j+1,cor), dfdy(compressedImg, i, j, cor), dfdy(compressedImg, i, j+1, cor);
                   compressedImg(i+1,j,cor), compressedImg(i+1,j+1,cor), dfdy(compressedImg, i+1, j, cor), dfdy(compressedImg, i+1, j+1, cor);
                   dfdx(compressedImg,i,j,cor), dfdx(compressedImg,i,j+1,cor), d2fdxdy(compressedImg, i, j, cor), d2fdxdy(compressedImg, i, j+1, cor);
                   dfdx(compressedImg,i+1,j,cor), dfdx(compressedImg,i+1,j+1,cor), d2fdxdy(compressedImg, i+1, j, cor), d2fdxdy(compressedImg, i+1, j+1, cor)];
              v = @(x,y) [1,x,x^2,x^3]*B*M*transpose(B)*[1;y;y^2;y^3];
              for x = 1:k+1
                for y = 1:k+1
                  I((i-1)*(k+1)+x,(j-1)*(k+1)+y,cor) = v((x-1)/k,(y-1)/k);
                endfor
              endfor
            endif
          endfor
        endfor
      endfor
  endswitch
  I = uint8(I);
  imwrite(I, "decompressed.png");
  return
endfunction

function d = dfdx (I, x, y, cor)
  n = size(I)(1);
  if (x == 1)
    d = I(2,y,cor) - I(1,y,cor);
  elseif (x == n)
    d = I(n,y,cor) - I(n-1,y,cor);
  else
    d = (I(x+1,y,cor) - I(x-1,y,cor))/2;
  endif
  return
endfunction

function d = dfdy (I, x, y, cor)
  n = size(I)(2);
  if (y == 1)
    d = I(x,2,cor) - I(x,1,cor);
  elseif (y == n)
    d = I(x,n,cor) - I(x,n-1,cor);
  else
    d = (I(x,y+1,cor) - I(x,y-1,cor))/2;
  endif
  return
endfunction

function d = d2fdxdy (I, x, y, cor)
  n = size(I)(1);
  if (x == 1)
    d = dfdy (I, 2, y, cor) - dfdy (I, 1, y, cor);
  elseif (x == n)
    d = dfdy (I, n, y, cor) - dfdy (I, n-1, y, cor);
  else
    d = (dfdy (I, x+1, y, cor) - dfdy (I, x-1, y, cor))/2;
  endif
  return
endfunction
