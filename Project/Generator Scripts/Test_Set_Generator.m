clear, clc; addpath(genpath('Functions'));

% Delete existing patches.
deleteTrainingPatches('Network Data\Test Set\Positive');
deleteTrainingPatches('Network Data\Test Set\Negative');
disp('Patches deleted');

positives=1;
negatives=1;

for c=1:1 % (1-20 DRIVE) || (20-34 CHASE).
    
  imageName=sprintf('%d.tif', c);
  imageName2=sprintf('%d.gif', c);
  
  fullFileName = fullfile('Assets\DB Test', imageName);
  fullFileName2 = fullfile('Assets\DB Test Ground Truth', imageName2);
  
  image=imread(fullFileName);
  gtImage=imread(fullFileName2);
  
  enhanced=imageEnhancement(image); % Green channel & CLAHE normalization.
  
  [positive,negative]=pickPatchesTest(enhanced,gtImage,3,5,8,positives,negatives); % Auto Extract Patches (image,gt,stride,patchSize).
  positives=positive;
  negatives=negative;
  
  msg=sprintf('Patches extracted for the image %d.',c);
  disp(msg);
  
end

disp('All patches extracted.');