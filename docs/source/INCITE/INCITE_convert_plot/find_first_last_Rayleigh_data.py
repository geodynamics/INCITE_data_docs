#
#    File copy routines from INCITE data
#
#  find_last2_Rayleigh_data(dir_name)
#    Find last two indexing files in directoryr [dir_name].
#    [find_last2_Rayleigh_data[0]] is the file name of the last step.
#    [find_last2_Rayleigh_data[1]] is the file name of one befor the last step.
#
#  find_first_last2_Rayleigh_data(dir_name)
#    Find the fiext inxex file and last two indexing files in directoryr [dir_name].
#    [find_first_last2_Rayleigh_data[1]] is the file name of the first step.
#    [find_first_last2_Rayleigh_data[1]] is the file name of the last step.
#    [find_first_last2_Rayleigh_data[2]] is the file name of one befor the last step.

import sys
import os
import shutil

def find_last2_Rayleigh_data(dir_name):
  filelist = []
  filelist = os.listdir(dir_name)
  nfile=len(filelist)
  
  last_files = []
  if(nfile < 1):
    print('No file in ', dir_name)
    last_files[0] = last_files.append('NO_FILE')
    last_files[1] = last_files.append('NO_FILE')
    return last_files
  
  last_files[0] = last_files.append(filelist[0])
  last_files[1] = last_files.append(filelist[0])
  max_step = int(filelist[0])
  for fname in filelist:
    istep = int(fname)
    if(istep > max_step):
      max_step =  istep
      last_files[0] = fname
  
  max_step = int(filelist[0])
  for fname in filelist:
    if(fname == last_files[0]):
      continue
    
    istep = int(fname)
    if(istep > max_step):
      max_step =  istep
      last_files[1] = fname
  
  return last_files


def find_first_last2_Rayleigh_data(dir_name):
  filelist = []
  filelist = os.listdir(dir_name)
  nfile=len(filelist)
#  print('Number of files: ", nfile)
  
  files = []
  if(nfile < 1):
    print('No file in ', dir_name)
    files[0] = files.append('NO_FILE')
    files[1] = files.append('NO_FILE')
    files[2] = files.append('NO_FILE')
    return files
  
  files[0] = files.append(filelist[0])
  files[1] = files.append(filelist[0])
  files[2] = files.append(filelist[0])
  min_step = int(filelist[0])
  max_step = int(filelist[0])
  for fname in filelist:
    istep = int(fname)
    if(istep > max_step):
      max_step =  istep
      files[1] = fname
    if(istep < min_step):
      min_step =  istep
      files[0] = fname
  
  max_step = int(filelist[0])
  for fname in filelist:
    if(fname == files[1]):
      continue
    
    istep = int(fname)
    if(istep > max_step):
      max_step =  istep
      files[2] = fname
  
  return files


if __name__ == '__main__':
  args = sys.argv
  if 2 <= len(args):
    for d in args[1:]:
      f1 = find_first_last2_Rayleigh_data(d)
      print('First file by find_first_last2_Rayleigh_data:           ', f1[0])
      print('one before last file by find_first_last2_Rayleigh_data: ', f1[2])
      print('Last file by find_first_last2_Rayleigh_data:            ', f1[1])
      f2 = find_last2_Rayleigh_data(d)
      print('one before last file by find_last2_Rayleigh_data: ', f2[1])
      print('Last file by find_last2_Rayleigh_data:            ', f2[0])
  else:
    print('Set directory names for Rayleigh data time series')
