function err = calculateError(originalImg, decompressedImg)
  originalImg = double(imread(originalImg));
  decompressedImg = double(imread(decompressedImg));
  dif = originalImg - decompressedImg;
  err = (norm(dif(:,:,1)) + norm(dif(:,:,2)) + norm(dif(:,:,3)))/3;
  return
endfunction