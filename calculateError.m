function err = calculateError(originalImg, decompressedImg)
  originalImg = double(imread(originalImg));
  decompressedImg = double(imread(decompressedImg));
  dif = originalImg - decompressedImg;
  ncolors = 1;
  if (ndims(originalImg) > 3 && ndims(decompressedImg) > 3)
    ncolors = size(compressedImg)(3);
  endif
  err = 0;
  for c = 1:ncolors
    err = err + norm(dif(:,:,c))/norm(originalImg(:,:,c));
  endfor
  err = err/ncolors;
  return
endfunction