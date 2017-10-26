# /usr/bin/env python
# _*_ coding:utf-8 _*_

import os
import getopt
import sys

inFile = ''
try:
        opts, args = getopt.getopt(sys.argv[1:],"i:")
except getopt.GetoptError as e:
        print(e.msg)
        print("Please check your options!")
        sys.exit()
for opt,arg in opts:
        if opt == '-i':
                inFile = arg
if inFile == '':
        print("Please providing files in fastq format! and using -i options.")
        sys.exit()

work_path = os.path.dirname(os.path.abspath(inFile))
#print(work_path)
out_path = work_path + '/Base-Calling_Profiles'

if not os.path.exists(out_path):
        os.makedirs(out_path)
outfile = out_path + '/base_quality_profile.R2'

base_score = {}

f = open(inFile, "r")
lines = f.readlines()

i = 0
for line in lines:
    if len(line) == 0:
        break
    else:
        i += 1
    if i % 4 == 0:
        for j in range(0, len(line)):
                if (j,line[j]) in base_score:
                    base_score[j,line[j]] += 1
                else:
                    base_score[j, line[j]] = 1
    else:
        continue
f.close()
out = open(outfile, 'w')

score_list = ['!', '"', '#', '$', '%', '&', "'", "(", ')', '*', '+', '-', '.', '/', '0', '1', '2', '3', '4', '5', '6',
              '7', '8', '9', ':', ';', '<', '=', '>', '?', '@', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J']
score_title = ('\t').join(score_list)
out.write('position' + '\t' + score_title + '\n')
for i in range(0, 100):
    out.write(str(i))
    for j in range(0, len(score_list)):
	if (i, score_list[j]) in base_score:	
        	out.write('\t' + str(base_score[i,score_list[j]]))
	else:
		out.write('\t' + str(0))
    out.write('\n')
out.close()
