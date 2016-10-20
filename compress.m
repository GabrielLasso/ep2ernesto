function compress (ImgName, k)
  OriginalImg = imread (ImgName);
  for x = 0:size(OriginalImg)(1)/(k+1)-1
    for y = 0:size(OriginalImg)(2)/(k+1)-1
      I(x+1,y+1,:) = OriginalImg (x*(k+1)+1,y*(k+1)+1,:);
    endfor
  endfor
  imwrite (I, "compressed.png");
endfunction
