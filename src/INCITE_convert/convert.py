#!/usr/bin/env python3

import sys
import os

from INCITE_lut_mapping import *
from lut_mapping import *
import rayleigh as ra

old_to_new = {
        'enth_flux_radial': 'enth_flux_r',
        'thermale_flux_radial': 'rhot_vrm_sm',
        # famon values
        'magnetic_torque_r': 'famom_magtor_r',
        'magnetic_torque_theta': 'famom_magtor_theta',
        'maxwell_stress_r': 'famom_maxstr_r',
        'maxwell_stress_theta': 'famom_maxstr_theta',
        'amom_fluct_r': 'famom_fluct_r',
        'amom_fluct_theta': 'famom_fluct_theta',
        'amom_dr_r': 'famom_dr_r',
        'amom_dr_theta': 'famom_dr_theta',
        'amom_mean_r': 'famom_mean_r',
        'amom_mean_theta': 'famom_mean_theta',

        # induction -> induct
        'induction_shear_r': 'induct_shear_r',
        'induction_comp_r': 'induct_comp_r',
        'induction_advec_r': 'induct_advec_r',
        'induction_r': 'induct_r',
        'induction_diff_r': 'induct_diff_r',
        'induction_shear_theta': 'induct_shear_theta',
        'induction_comp_theta': 'induct_comp_theta',
        'induction_advec_theta': 'induct_advec_theta',
        'induction_theta': 'induct_theta',
        'induction_diff_theta': 'induct_diff_theta',
        'induction_shear_phi': 'induct_shear_phi',
        'induction_comp_phi': 'induct_comp_phi',
        'induction_advec_phi': 'induct_advec_phi',
        'induction_phi': 'induct_phi',
        'induction_diff_phi': 'induct_diff_phi',
        'induction_shear_vmbm_r': 'induct_shear_vmbm_r',
        'induction_comp_vmbm_r': 'induct_comp_vmbm_r',
        'induction_advec_vmbm_r': 'induct_advec_vmbm_r',
        'induction_vmbm_r': 'induct_vmbm_r',
        'induction_diff_bm_r': 'induct_diff_bm_r',
        'induction_shear_vmbm_theta': 'induct_shear_vmbm_theta',
        'induction_comp_vmbm_theta': 'induct_comp_vmbm_theta',
        'induction_advec_vmbm_theta': 'induct_advec_vmbm_theta',
        'induction_vmbm_theta': 'induct_vmbm_theta',
        'induction_diff_bm_theta': 'induct_diff_bm_theta',
        'induction_shear_vmbm_phi': 'induct_shear_vmbm_phi',
        'induction_comp_vmbm_phi': 'induct_comp_vmbm_phi',
        'induction_advec_vmbm_phi': 'induct_advec_vmbm_phi',
        'induction_vmbm_phi': 'induct_vmbm_phi',
        'induction_diff_bm_phi': 'induct_diff_bm_phi',
        'induction_shear_vmbp_r': 'induct_shear_vmbp_r',
        'induction_comp_vmbp_r': 'induct_comp_vmbp_r',
        'induction_advec_vmbp_r': 'induct_advec_vmbp_r',
        'induction_vmbp_r': 'induct_vmbp_r',
        'induction_diff_bp_r': 'induct_diff_bp_r',
        'induction_shear_vmbp_theta': 'induct_shear_vmbp_theta',
        'induction_comp_vmbp_theta': 'induct_comp_vmbp_theta',
'induction_advec_vmbp_theta': 'induct_advec_vmbp_theta',
        'induction_vmbp_theta': 'induct_vmbp_theta',
        'induction_diff_bp_theta': 'induct_diff_bp_theta',
        'induction_shear_vmbp_phi': 'induct_shear_vmbp_phi',
        'induction_comp_vmbp_phi': 'induct_comp_vmbp_phi',
        'induction_advec_vmbp_phi': 'induct_advec_vmbp_phi',
        'induction_vmbp_phi': 'induct_vmbp_phi',
        'induction_diff_bp_phi': 'induct_diff_bp_phi',
        'induction_shear_vpbm_r': 'induct_shear_vpbm_r',
        'induction_comp_vpbm_r': 'induct_comp_vpbm_r',
        'induction_advec_vpbm_r': 'induct_advec_vpbm_r',
        'induction_vpbm_r': 'induct_vpbm_r',
'induction_shear_vpbm_theta': 'induct_shear_vpbm_theta',
'induction_comp_vpbm_theta': 'induct_comp_vpbm_theta',
'induction_advec_vpbm_theta': 'induct_advec_vpbm_theta',
'induction_vpbm_theta': 'induct_vpbm_theta',
'induction_shear_vpbm_phi': 'induct_shear_vpbm_phi',
'induction_comp_vpbm_phi': 'induct_comp_vpbm_phi',
'induction_advec_vpbm_phi': 'induct_advec_vpbm_phi',
'induction_vpbm_phi': 'induct_vpbm_phi',
'induction_shear_vpbp_r': 'induct_shear_vpbp_r',
'induction_comp_vpbp_r': 'induct_comp_vpbp_r',
'induction_advec_vpbp_r': 'induct_advec_vpbp_r',
'induction_vpbp_r': 'induct_vpbp_r',
'induction_shear_vpbp_theta': 'induct_shear_vpbp_theta',
'induction_comp_vpbp_theta': 'induct_comp_vpbp_theta',
'induction_advec_vpbp_theta': 'induct_advec_vpbp_theta',
'induction_vpbp_theta': 'induct_vpbp_theta',
'induction_shear_vpbp_phi': 'induct_shear_vpbp_phi',
'induction_comp_vpbp_phi': 'induct_comp_vpbp_phi',
'induction_advec_vpbp_phi': 'induct_advec_vpbp_phi',
'induction_vpbp_phi': 'induct_vpbp_phi',
        }

old_code_to_new_code = dict([(k, code_given_name[old_to_new.get(v,v)]) for k, v in INCITE_name_given_code.items()])

def each_convert(f):
    f = os.path.abspath(f)
    print('file to convert: ', f)
    # get type of output from path
    type = os.path.basename(os.path.dirname(f))
    fobj = getattr(ra, type + '_file')(f)
    # overwrite qv in place
    fobj.qv[:] = [old_code_to_new_code[k] for k in fobj.qv]
    return


if __name__ == '__main__':
    for f in sys.argv[1:]:
        each_convert(f)
