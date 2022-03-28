import os
import glob
import re

PATH = os.path.abspath(os.path.join(__file__, os.pardir))


files = (glob.glob(PATH + '/**/*.h', recursive=True) +
         glob.glob(PATH + '/**/*.cc', recursive=True) +
         glob.glob(PATH + '/**/*.cpp', recursive=True) +
         glob.glob(PATH + '/**/*.hpp', recursive=True))

pattern = R'^((?!(external|build)).*)$'

for file in files:
    m = re.search(pattern, file)
    if m:
        print(m.group(0))
