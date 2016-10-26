function compress(originalImg, k)
  originalImg = imread(originalImg);
  nlin = (size(originalImg)(1)+k)/(k+1);
  ncol = (size(originalImg)(2)+k)/(k+1);
  for x = 1:nlin
    for y = 1:ncol
      compressedImg(x,y,:) = originalImg((x-1)*(k+1)+1,(y-1)*(k+1)+1,:);
    endfor
  endfor
  imwrite(compressedImg, "compressed.png");
endfunction