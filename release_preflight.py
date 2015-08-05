import io
import json
import os
import shutil
import subprocess
import sys

# Read in the version number from the package.json file
with io.open('package.json', 'r', encoding='utf-8') as data_file:
    packageInfo = json.loads(data_file.read())
versionNumber = packageInfo["version"]

# Clean and build the java portion
subprocess.check_call("ant -Dplatforms.JDK_1.7.home=/usr/lib/jvm/java-7-openjdk-amd64 -f java/build.xml clean jar", shell=True)

# We're in the root level of a git repo. 
# So make a copy of this entire directory and cd to it.
# Append -versionNumber to the copy's name
sourceDir = os.getcwd()
os.chdir('..')
releaseName = 'missing-http-' + versionNumber
destDir = os.getcwd() + '/' + releaseName
shutil.copytree(sourceDir, destDir)
os.chdir(destDir)

# Delete git-related files
if os.path.exists('.gitignore'):
    os.remove('.gitignore')
if os.path.exists('.git'):
    shutil.rmtree('.git')

# Delete the releasebot_preflight.py file
os.remove('release_preflight.py')

# Delete everything in java subdir except for dist/missing-http.jar
shutil.rmtree('java/build')
shutil.rmtree('java/lib')
if os.path.exists('java/test'):
    shutil.rmtree('java/test')
if os.path.exists('java/coverage'):
    shutil.rmtree('java/coverage')
shutil.rmtree('java/nbproject')
shutil.rmtree('java/src')
os.remove('java/build.xml')
