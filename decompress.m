function decompress (compressedImg, method, k)
  switch method
    case 1
      for cor = 1:3 
        for i = 1:size(compressedImg)(1)
          for j = 1:size(compressedImg)(2)
            if (i == size(compressedImg)(1) && j == size(compressedImg)(2))
              I(1+(i-1)*(k+1),1+(j-1)*(k+1),cor) = compressedImg(i,j,cor);
            elseif (i == size(compressedImg)(1))
              A = double ([1,j;1,j+1]);
              B = double ([compressedImg(i,j,cor);compressedImg(i,j+1,cor)]);
              f = @(x) double (dot (A\B, [1,x]));
              for x = 1:k+1
                I((i-1)*k+i,(j-1)*(k+1)+x,cor) = f(j+x/k);
              endfor
            elseif (j == size(compressedImg)(2))
              A = double ([1,i;1,i+1]);
              B = double ([compressedImg(i,j,cor);compressedImg(i+1,j,cor)]);
              f = @(x) double (dot (A\B, [1,x]));
              for x = 1:k+1
                I((i-1)*(k+1)+x,(j-1)*k+j,cor) = f(i+x/k);
              endfor
            else
              A = double([1,i,j,i*j;1,i,j+1,i*(j+1);1,i+1,j,(i+1)*j;1,i+1,j+1,(i+1)*(j+1)]);
              B = double([compressedImg(i,j,cor);compressedImg(i,j+1,cor);compressedImg(i+1,j,cor);compressedImg(i+1,j+1,cor)]);
              f = @(x,y) double (dot (A\B, [1,x,y,x*y]));
              for x = 1:k+1
                for y = 1:k+1
                  I((i-1)*(k+1)+x,(j-1)*(k+1)+y,cor) = f(i+x/k,j+y/k);
                endfor
              endfor
            endif
          endfor
        endfor
      endfor
    case 2
      
  endswitch
  I = uint8(I);
  imwrite(I, "decompressed.png");
endfunction
