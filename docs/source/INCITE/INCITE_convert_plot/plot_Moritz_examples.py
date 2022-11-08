import sys
import os
import shutil

from plot_G_Avgs_moritz import s_plot_G_Avgs_moritz, write_G_Avgs_moritz_captions
from plot_Shell_Spectra_moritz import s_plot_Shell_Spectra_moritz
from plot_Shell_Slices_moritz import s_plot_Shell_Slices_moritz
from plot_AZ_Avgs_moritz import s_plot_AZ_Avgs_moritz, write_AZ_Avgs_moritz_captions
from convert_main_input import s_convert_main_input
from convert import each_convert


def plot_each_Moritz_examples(d):
#    Directory setting for Farm
#  source_dir = '/group/cigfs3-incite/' + d
#  dest_dir = '/home/hrmatsui/git/INCITE_data_docs/docs/source/INCITE/' + d
#    Directory setting for local Mac
  source_dir = '/Users/matsui/Desktop/FARM_INCITE/' + d
  dest_dir = '/Users/matsui/git/INCITE_data_docs/docs/source/INCITE/' + d
  
  print('source:',  source_dir)
  print('destination', dest_dir)
  
  orglist = []
  orglist = os.listdir(source_dir)
#  print('files in original: ', orglist)
  destlist = []
  destlist = os.listdir(dest_dir)
#  print('files in destination: ', destlist)
  
  dir_G_Avgs =        'G_Avgs/'
  dir_Shell_Avgs =    'Shell_Avgs/'
  dir_Shell_Spectra = 'Shell_Spectra/'
  dir_Shell_Slices =  'Shell_Slices/'
  dir_AZ_Avgs =       'AZ_Avgs/'
  
  main_input =     'main_input'
  main_input_org = 'main_input.org'
  
  dir_images =       'images/'
  
  G_Avgs_caption_file =          'G_Avgs_caption.rst'
  AZ_Avgs_caption_file =         'AZ_Avgs_caption.rst'
  Shell_Slices_caption_prefix =  'Shell_Slices_caption_'
  Shell_Spectra_caption_prefix = 'Spectr_caption_'
  
#  Copy volume average
  org_G_Avgs = source_dir + dir_G_Avgs
  dest_G_Avgs = dest_dir + dir_G_Avgs
  if(os.path.isdir(dest_G_Avgs) == False):
    shutil.copytree(org_G_Avgs, dest_G_Avgs)
  
  filelist = []
  filelist = os.listdir(dest_G_Avgs)
#  print('files in volume average: ', filelist)
  if(len(filelist) > 0):
    for f in filelist:
      filename = dest_G_Avgs + f
      each_convert(filename)
  
#  Copy shell average
  org_Shell_Avgs = source_dir + dir_Shell_Avgs
  dest_Shell_Avgs = dest_dir + dir_Shell_Avgs
  if(os.path.isdir(dest_Shell_Avgs) == False):
    shutil.copytree(org_Shell_Avgs, dest_Shell_Avgs)
  
  filelist = []
  filelist = os.listdir(dest_Shell_Avgs)
#  print('files in shell average: ', filelist)
  if(len(filelist) > 0):
    for f in filelist:
      filename = dest_Shell_Avgs + f
      each_convert(filename)
  
#  Convert shell spectra
  org_Shell_Spectra = source_dir + dir_Shell_Spectra
  dest_Shell_Spectra = dest_dir + dir_Shell_Spectra
  filelist = []
  filelist = os.listdir(org_Shell_Spectra)
  nfile=len(filelist)
  max_step = int(filelist[0])
  lastfile = filelist[0]
  for fname in filelist:
    istep = int(fname)
    if(istep > max_step):
      max_step = istep
      lastfile = fname
  Shell_Spectra_lastfile = lastfile
  print('Last file in ', org_Shell_Spectra, ':   ', Shell_Spectra_lastfile)
  if(os.path.isdir(dest_Shell_Spectra) == False):
    os.makedirs(dest_Shell_Spectra)
  
  org_filepath = org_Shell_Spectra + Shell_Spectra_lastfile
  dest_filepath = dest_Shell_Spectra + Shell_Spectra_lastfile
  shutil.copy(org_filepath, dest_filepath)
  each_convert(dest_filepath)
  
  
#  Convert shell slice
  org_Shell_Slices = source_dir + dir_Shell_Slices
  dest_Shell_Slices = dest_dir + dir_Shell_Slices
  filelist = []
  filelist = os.listdir(org_Shell_Slices)
  nfile=len(filelist)
  max_step = int(filelist[0])
  lastfile = filelist[0]
  for fname in filelist:
    istep = int(fname)
    if(istep > max_step):
      max_step = istep
      lastfile = fname
  Shell_Slices_lastfile = lastfile
  print('Last file in ', org_Shell_Slices, ':   ', Shell_Slices_lastfile)
  if(os.path.isdir(dest_Shell_Slices) == False):
    os.makedirs(dest_Shell_Slices)
  
  org_filepath = org_Shell_Slices + Shell_Slices_lastfile
  dest_filepath = dest_Shell_Slices + Shell_Slices_lastfile
  shutil.copy(org_filepath, dest_filepath)
  each_convert(dest_filepath)
  
  
#  Convert zonal mean
  org_AZ_Avgs = source_dir + dir_AZ_Avgs
  dest_AZ_Avgs = dest_dir + dir_AZ_Avgs
  filelist = []
  filelist = os.listdir(org_AZ_Avgs)
  nfile=len(filelist)
  max_step = int(filelist[0])
  lastfile = filelist[0]
  for fname in filelist:
    istep = int(fname)
    if(istep > max_step):
      max_step = istep
      lastfile = fname
  AZ_Avgs_lastfile = lastfile
  print('Last file in ', org_AZ_Avgs, ':   ', AZ_Avgs_lastfile)
  if(os.path.isdir(dest_AZ_Avgs) == False):
    os.makedirs(dest_AZ_Avgs)
  
  org_filepath = org_AZ_Avgs + AZ_Avgs_lastfile
  dest_filepath = dest_AZ_Avgs + AZ_Avgs_lastfile
  shutil.copy(org_filepath, dest_filepath)
  each_convert(dest_filepath)

#  Convert main_input
  org_filepath = source_dir +  main_input
  dest_filepath = dest_dir + main_input_org
  shutil.copy(org_filepath, dest_filepath)
  
  print('current directory', os.getcwd())
  os.chdir(dest_dir)
  print('new current directory', os.getcwd())

#  make image directory
  dest_dir_images = dest_dir + dir_images
  if(os.path.isdir(dir_images) == False):
    os.makedirs(dir_images)
  
  init_time = s_plot_G_Avgs_moritz(dest_G_Avgs)
  time_AZ = s_plot_AZ_Avgs_moritz(dest_AZ_Avgs, init_time)
  
  file_prefix = dest_dir + Shell_Slices_caption_prefix
  s_plot_Shell_Slices_moritz(dest_Shell_Slices, file_prefix, init_time)
  file_prefix = dest_dir + Shell_Spectra_caption_prefix
  s_plot_Shell_Spectra_moritz(dest_Shell_Spectra, file_prefix, init_time)
  
  s_convert_main_input(main_input_org, main_input)
  
  file_name = dest_dir + G_Avgs_caption_file
  write_G_Avgs_moritz_captions(file_name)
  file_name = dest_dir + AZ_Avgs_caption_file
  write_AZ_Avgs_moritz_captions(file_name, time_AZ)
  
  shutil.rmtree(dest_AZ_Avgs)
  shutil.rmtree(dest_Shell_Slices)
  shutil.rmtree(dest_Shell_Spectra)
  shutil.rmtree(dest_Shell_Avgs)
  shutil.rmtree(dest_G_Avgs)
  
  return

if __name__ == '__main__':
  args = sys.argv
  if 2 <= len(args):
    for d in args[1:]:
      print(d)
      plot_each_Moritz_examples(d)
  else:
    print('Set directory names for runs from "mheimpel"')
