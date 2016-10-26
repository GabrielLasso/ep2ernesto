function compress(originalImg, k)
  originalImg = imread(originalImg);
  nlin = size(originalImg)(1)/(k+1);
  ncol = size(originalImg)(2)/(k+1);
  for x = 1:nlin
    for y = 1:ncol
      compressedImg(x,y,:) = originalImg(x*(k+1),y*(k+1),:);
    endfor
  endfor
  imwrite(compressedImg, "compressed.png");
endfunction

# 1 ou 0 mod k+1 ???