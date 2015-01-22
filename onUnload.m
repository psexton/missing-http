%ONUNLOAD Script for unloading MissingHTTP.
function onUnload()
  packagePath = fileparts(mfilename('fullpath'));
  rmpath(fullfile(packagePath, 'matlab'));

  % Remove the jar from the dynamic classpath
  jarPath = fullfile(packagePath, 'java', 'dist', 'missing-http.jar');
  if any(strcmp(javaclasspath('-dynamic'), jarPath))
    javarmpath(jarPath);
  end
end
