function err = calculateError(originalImg, decompressedImg)
  originalImg = double(imread(originalImg));
  decompressedImg = double(imread(decompressedImg));
  dif = originalImg - decompressedImg;
  errR = norm(dif(:,:,1))/norm(originalImg(:,:,1));
  errG = norm(dif(:,:,2))/norm(originalImg(:,:,2));
  errB = norm(dif(:,:,3))/norm(originalImg(:,:,3));
  err = (errR + errG + errB)/3;
  return
endfunction