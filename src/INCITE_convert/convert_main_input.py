import sys
from rayleigh_diagnostics import main_input
from convert import old_code_to_new_code

def convert_field_list(list_string):
  arr = list_string.split(',')
  int_list = []
  for astr in arr:
    id_old = int(astr)
    id_new = old_code_to_new_code[id_old]
    int_list.append(int(id_new))
  
  new_list_string = ",".join(map(str, int_list))
  return new_list_string


args = sys.argv
print(len(args))
if len(args) % 3:
  print("python convert_main_input.py [ORIGINAL main_input file name] [Converted main_input file name]")
  exit()

org_file = args[1]
new_file = args[2]

in_list = main_input(org_file)

# print(in_list)

nml="Output_Namelist"
nml_lower = nml.strip().lower()
# print(in_list.namelists)
# print(in_list.vals)

in_output = in_list.vals['output']
# print(in_output)

if('shellslice_values' in in_output):
    in_shellslice = in_output['shellslice_values']
    print('shellslice_values: ', in_shellslice)
    new_str = convert_field_list(in_shellslice)
    main_input.set(self=in_list, nml="output",var="shellslice_values",
                   val=new_str, force = True)
    print('To: ', new_str)
else:
    print("'shellslice_values' is missing... skip")

if('shellspectra_values' in in_output):
    in_shellspectra = in_output['shellspectra_values']
    print('shellspectra_values: ', in_shellspectra)
    new_str = convert_field_list(in_shellspectra)
    main_input.set(self=in_list, nml="output",var="shellspectra_values",
                   val=new_str, force = True)
    print('To: ', new_str)
else:
    print("'shellspectra_values' is missing... skip")

if('azavg_values' in in_output):
    in_azavg = in_output['azavg_values']
    print('azavg_values: ', in_azavg)
    new_str = convert_field_list(in_azavg)
    main_input.set(self=in_list, nml="output",var="azavg_values",
                   val=new_str, force = True)
    print('To: ', new_str)
else:
    print("'azavg_values' is missing... skip")

if('shellavg_values' in in_output):
    in_shellavg_values = in_output['shellavg_values']
    print('shellavg_values: ', in_shellavg_values)
    new_str = convert_field_list(in_shellavg_values)
    main_input.set(self=in_list, nml="output",var="shellavg_values",
                   val=new_str, force = True)
    print('To: ', new_str)
else:
    print("'shellavg_values' is missing... skip")

if ('equatorial_values' in in_output):
    in_equatorial_values = in_output['equatorial_values']
    print('equatorial_values: ', in_equatorial_values)
    new_str = convert_field_list(in_equatorial_values)
    main_input.set(self=in_list, nml="output",var="equatorial_values",
                   val=new_str, force = True)
    print('To: ', new_str)
else:
    print("'equatorial_values' is missing... skip")

if('globalavg_values' in in_output):
    in_globalavg_values = in_output['globalavg_values']
    print('globalavg_values: ', in_globalavg_values)
    new_str = convert_field_list(in_globalavg_values)
    main_input.set(self=in_list, nml="output",var="globalavg_values",
                   val=new_str, force = True)
    print('To: ', new_str)
else:
    print("'globalavg_values' is missing... skip")


main_input.write(self=in_list, verbose = False, file=new_file, ndecimal=6, namelist=in_list)
