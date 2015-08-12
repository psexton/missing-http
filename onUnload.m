%ONUNLOAD Hook for unloading Missing HTTP.

function onUnload()
  packagePath = fileparts(mfilename('fullpath'));
  rmpath(fullfile(packagePath, 'matlab'));

  % Remove the jar from the dynamic classpath
  jarPath = fullfile(packagePath, 'java', 'dist', 'missing-http.jar');
  if any(strcmp(javaclasspath('-dynamic'), jarPath))
    javarmpath(jarPath);
  end
  
  % Remove the release information dir, if it exists
  % (See more detailed note in onLoad.m)
  releaseInformationPath = fullfile(packagePath, 'missing-http');
  if exist(releaseInformationPath, 'dir') == 7
    rmpath(releaseInformationPath);
  end
end
