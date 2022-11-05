      program log_check
!
      implicit none
!
      integer, parameter :: id_log = 11
      integer :: n_line
      character(len=255), allocatable :: log_text(:)
      integer, allocatable :: len_first(:)
!
      integer :: num_runs
      integer, allocatable :: istack_runs(:)
      integer, allocatable :: len_dir(:)
!
!
      character(len=255), parameter :: cdef = '.DEFAULT.'
!
      type INCITE_PARAMS
        character(len=255) :: dir_name
!
        integer :: N_r = -1
        integer :: N_theta = -1
        real*8 :: aspect_ratio = -1.0d0
        real*8 :: shell_depth = -1.0d0
        character(len=255) :: chebyshev = cdef
!
        real*8 :: Ekman_Number = -1.0d0
        real*8 :: Prandtl_Number = -1.0d0
        real*8 :: Magnetic_Prandtl_Number = -1.0d0
        real*8 :: Rayleigh_Number = -1.0d0
        real*8 :: Modified_Rayleigh_Number = -1.0d0
        character(len=255) :: rotation =        cdef
        character(len=255) :: magnetism =       cdef
        character(len=255) :: viscous_heating = cdef
        character(len=255) :: ohmic_heating =   cdef
!
        character(len=255) :: no_slip_boundaries = cdef
        character(len=255) :: fix_tvar_bottom =    cdef
        character(len=255) :: fix_dtdr_bottom =    cdef
        character(len=255) :: fix_tvar_top =       cdef
        character(len=255) :: fix_dtdr_top =       cdef
!
        real*8 :: T_bottom =    -1.0e30
        real*8 :: dTdr_bottom = -1.0e30
        real*8 :: T_top =       -1.0e30
        real*8 :: dTdr_top =    -1.0e30
!
        integer :: reference_type = -1
        integer :: heating_type = -1
        real*8 :: poly_n =       -1.0e30
        real*8 :: poly_Nrho =    -1.0e30
        real*8 :: gravity_power = -1.0e30
        character(len=255) :: dimensional =       cdef
!
        character(len=255) :: hyperdiffusion =       cdef
        real*8 :: hyperdiffusion_alpha =   -1.0e30
        real*8 :: hyperdiffusion_beta =    -1.0e30
      end type INCITE_PARAMS
!
!>      Structure of field label
      type run_def
!>        Field name
        character(len=255) :: name
!>        Math dirctory
        character(len=255) :: dir
!>        Math dirctory
        character(len=4095) :: pubs
      end type run_def
!
      type(INCITE_PARAMS), allocatable :: param(:)
!
      integer :: n_moritz
      type(run_def), allocatable :: moritz_runs(:)
      type(INCITE_PARAMS), allocatable :: moritz_param(:)
!
      integer :: n_rakesh
      type(run_def), allocatable :: rakesh_runs(:)
      type(INCITE_PARAMS), allocatable :: rakesh_param(:)
!
      character(len=11), parameter :: main_input = '/main_input'
      character(len=255), parameter :: hd_Nr = 'n_r'
      character(len=255), parameter :: hd_Nt = 'n_theta'
      character(len=255), parameter :: hd_aspect = 'aspect_ratio'
      character(len=255), parameter :: hd_shell = 'shell_depth'
      character(len=255), parameter :: hd_chebyshev = 'chebyshev'
!
      character(len=255), parameter :: hd_rotation =  'rotation'
      character(len=255), parameter :: hd_magnetism = 'magnetism'
      character(len=255), parameter :: hd_viscous =   'viscous_heating'
      character(len=255), parameter :: hd_ohmic =     'ohmic_heating'
!
      character(len=255), parameter :: hd_Ek = 'Ekman_Number'
      character(len=255), parameter :: hd_Pr = 'Prandtl_Number'
      character(len=255), parameter                                     &
     &                   :: hd_Pm = 'Magnetic_Prandtl_Number'
      character(len=255), parameter :: hd_Ra = 'Rayleigh_Number'
      character(len=255), parameter                                     &
     &                   :: hd_mod_Ra = 'Modified_Rayleigh_Number'
!
      character(len=255), parameter                                     &
     &                   :: hd_no_slip =         'no_slip_boundaries'
      character(len=255), parameter                                     &
     &                   :: hd_fix_tvar_bottom = 'fix_tvar_bottom'
      character(len=255), parameter                                     &
     &                   :: hd_fix_dtdr_bottom = 'fix_dtdr_bottom'
      character(len=255), parameter                                     &
     &                   :: hd_fix_tvar_top =    'fix_tvar_top'
      character(len=255), parameter                                     &
     &                   :: hd_fix_dtdr_top =    'fix_dtdr_top'
!
      character(len=255), parameter                                     &
     &                   :: hd_T_bottom =    'T_bottom'
      character(len=255), parameter                                     &
     &                   :: hd_dTdr_bottom = 'dTdr_bottom'
      character(len=255), parameter                                     &
     &                   :: hd_T_top =       'T_top'
      character(len=255), parameter                                     &
     &                   :: hd_dTdr_top =     'dTdr_top'
!
      character(len=255), parameter                                     &
     &              :: hd_reference_type =  'reference_type'
      character(len=255), parameter                                     &
     &              :: hd_heating_type =  'heating_type'
      character(len=255), parameter                                     &
     &              :: hd_poly_n =  'poly_n'
      character(len=255), parameter                                     &
     &              :: hd_poly_Nrho =  'poly_Nrho'
      character(len=255), parameter                                     &
     &              :: hd_gravity_power =  'gravity_power'
      character(len=255), parameter                                     &
     &              :: hd_dimensional =  'dimensional'
!
      character(len=255), parameter                                     &
     &              :: hd_hyperdiffusion =     'hyperdiffusion'
      character(len=255), parameter                                     &
     &              :: hd_hyperdiffusion_alpha = 'hyperdiffusion_alpha'
      character(len=255), parameter                                     &
     &              :: hd_hyperdiffusion_beta =  'hyperdiffusion_beta'
!
      character(len=255), parameter                                     &
     &              :: hd_publication =  'Publication'
!
      logical :: flag_missing
      integer :: i_line, ist, ied, i, j, icou, l
      character(len=4096) :: file_name
!
!
!
      open(id_log,file = 'moritz_runs.csv')
      read(id_log,*) n_moritz
!
      allocate(moritz_runs(n_moritz))
      allocate(moritz_param(n_moritz))
      do i = 1, n_moritz
        read(id_log,*) moritz_runs(i)%name, moritz_runs(i)%dir
      end do
      close(id_log)
!
      open(id_log,file = 'rakesh_runs.csv')
      read(id_log,*) n_rakesh
!
      allocate(rakesh_runs(n_rakesh))
      allocate(rakesh_param(n_rakesh))
      do i = 1, n_rakesh
        read(id_log,*) rakesh_runs(i)%name, rakesh_runs(i)%dir
      end do
      close(id_log)
!
      write(*,*) 'n_moritz', n_moritz
      do i = 1, n_moritz
        write(*,'(3a)') trim(moritz_runs(i)%name), ': ',                &
     &                  trim(moritz_runs(i)%dir)
      end do
      write(*,*) 'n_rakesh', n_rakesh
      do i = 1, n_rakesh
        write(*,'(3a)') trim(rakesh_runs(i)%name), ': ',                &
     &                  trim(rakesh_runs(i)%dir)
      end do
!
      open(id_log,file = 'log.txt')
      n_line = 0
      do
        read(id_log,*,err=99,end=99)
        n_line = n_line + 1
      end do
  99  continue
      rewind(id_log)
!
      allocate(log_text(n_line))
      allocate(len_first(n_line))
      len_first(1:n_line) = 0
!
      do i_line = 1, n_line
        read(id_log,'(a)') log_text(i_line)
      end do
      close(id_log)
!
!
!
      icou = 0
      do i_line = 1, n_line
        len_first(i_line) = len_trim(log_text(i_line))
        ist = max(1,len_first(i_line)-11)
         if(log_text(i_line)(ist+1:ist+11) .eq. main_input(1:11)) then
          icou = icou + 1
        end if
      end do
      num_runs = icou
      write(*,*) 'num_runs', num_runs
!
      allocate(istack_runs(0:num_runs))
      allocate(len_dir(num_runs))
      istack_runs(0:num_runs) = 0
!
      allocate(param(num_runs))
!
      icou = 0
      do i_line = 1, n_line
        len_first(i_line) = len_trim(log_text(i_line))
        ist = max(1,len_first(i_line)-11)
         if(log_text(i_line)(ist+1:ist+11) .eq. main_input(1:11)) then
          istack_runs(icou) = i_line-1
          icou = icou + 1
          write(param(icou)%dir_name,'(a)') log_text(i_line)(1:ist)
          len_dir(icou) =  ist
        end if
      end do
      istack_runs(num_runs) = n_line
!
      do i = 1, num_runs
        ist = istack_runs(i-1) + 1
        ied = istack_runs(i)
        do l = ist, ied
!          write(*,*) 'line', l
          if(len_first(l) .le. 0) cycle
!
          if(get_int_param(log_text(l), hd_Nr, param(i)%N_r)) cycle
          if(get_int_param(log_text(l), hd_Nt, param(i)%N_theta)) cycle
          if(get_real_param(log_text(l), hd_aspect,                     &
     &                      param(i)%aspect_ratio)) cycle
          if(get_real_param(log_text(l), hd_shell,                      &
     &                      param(i)%shell_depth)) cycle
          if(get_char_param(log_text(l), hd_chebyshev,                  &
     &                      param(i)%chebyshev)) cycle
!
          if(get_char_param(log_text(l), hd_rotation,                   &
     &                      param(i)%rotation)) cycle
          if(get_char_param(log_text(l), hd_magnetism,                  &
     &                      param(i)%magnetism)) cycle
          if(get_char_param(log_text(l), hd_viscous,                    &
     &                      param(i)%viscous_heating)) cycle
          if(get_char_param(log_text(l), hd_ohmic,                      &
     &                      param(i)%ohmic_heating)) cycle
!
          if(get_real_param(log_text(l), hd_Ek,                         &
     &                      param(i)%Ekman_Number)) cycle
          if(get_real_param(log_text(l), hd_Pr,                         &
     &                      param(i)%Prandtl_Number)) cycle
          if(get_real_param(log_text(l), hd_Pm,                         &
     &                      param(i)%Magnetic_Prandtl_Number)) cycle
          if(get_real_param(log_text(l), hd_Ra,                         &
     &                      param(i)%Rayleigh_Number)) cycle
          if(get_real_param(log_text(l), hd_mod_Ra,                     &
     &                      param(i)%Modified_Rayleigh_Number)) cycle
!
          if(get_char_param(log_text(l), hd_no_slip,                    &
     &                      param(i)%no_slip_boundaries)) cycle
          if(get_char_param(log_text(l), hd_fix_tvar_bottom,            &
     &                      param(i)%fix_tvar_bottom)) cycle
          if(get_char_param(log_text(l), hd_fix_dtdr_bottom,            &
     &                      param(i)%fix_dtdr_bottom)) cycle
          if(get_char_param(log_text(l), hd_fix_tvar_top,               &
     &                      param(i)%fix_tvar_top)) cycle
          if(get_char_param(log_text(l), hd_fix_dtdr_top,               &
     &                      param(i)%fix_dtdr_top)) cycle
!
          if(get_real_param(log_text(l), hd_T_bottom,                   &
     &                      param(i)%T_bottom)) cycle
          if(get_real_param(log_text(l), hd_dTdr_bottom,                &
     &                      param(i)%dTdr_bottom)) cycle
          if(get_real_param(log_text(l), hd_T_top,                      &
     &                      param(i)%T_top)) cycle
          if(get_real_param(log_text(l), hd_dTdr_top,                   &
     &                      param(i)%dTdr_top)) cycle
!
          if(get_int_param(log_text(l), hd_reference_type,              &
     &                      param(i)%reference_type)) cycle
          if(get_int_param(log_text(l), hd_heating_type,                &
     &                      param(i)%heating_type)) cycle
          if(get_real_param(log_text(l), hd_poly_n,                     &
     &                      param(i)%poly_n)) cycle
          if(get_real_param(log_text(l), hd_poly_Nrho,                  &
     &                      param(i)%poly_Nrho)) cycle
          if(get_real_param(log_text(l), hd_gravity_power,              &
     &                      param(i)%gravity_power)) cycle
          if(get_char_param(log_text(l), hd_dimensional,                &
     &                      param(i)%dimensional)) cycle
!
          if(get_char_param(log_text(l), hd_hyperdiffusion,             &
     &                      param(i)%hyperdiffusion)) cycle
          if(get_real_param(log_text(l), hd_hyperdiffusion_alpha,       &
     &                      param(i)%hyperdiffusion_alpha)) cycle
          if(get_real_param(log_text(l), hd_hyperdiffusion_beta,        &
     &                      param(i)%hyperdiffusion_beta)) cycle
        end do
!        if(param(i)%aspect_ratio) .eq. -1.0)                           &
!     &                     param(i)%aspect_ratio) = 0.35
!        if(param(i)%shell_depth) .eq. -1.0)                            &
!     &                     param(i)%aspect_ratio) = 1.0
         if(param(i)%magnetism .eq. cdef)                               &
     &       param(i)%magnetism = '.FALSE.'
         if(param(i)%viscous_heating .eq. cdef)                         &
     &       param(i)%viscous_heating = '.TRUE.'
         if(param(i)%ohmic_heating .eq. cdef)                           &
     &       param(i)%ohmic_heating = '.TRUE.'
!
         if(param(i)%no_slip_boundaries .eq. cdef)                      &
     &       param(i)%no_slip_boundaries = '.FALSE.'
         if(param(i)%heating_type .eq. -1)                              &
     &       param(i)%heating_type = 0
         if(param(i)%gravity_power .eq. -1.0d0)                         &
     &       param(i)%gravity_power = 0.0d0
!
         if(param(i)%hyperdiffusion .eq. cdef) then
             param(i)%hyperdiffusion = '.FALSE.'
             param(i)%hyperdiffusion_alpha = 0.0
             param(i)%hyperdiffusion_beta = 0.0
         end if
      end do
!
      do i = 1, n_moritz
        flag_missing = .TRUE.
        do j = 1, num_runs
          if(    trim(moritz_runs(i)%dir)                               &
     &      .eq. trim(param(j)%dir_name)) then
            moritz_param(i) = param(j)
            flag_missing = .FALSE.
            exit
          end if
        end do
        if(flag_missing) write(*,*) 'Directory ',                       &
     &      trim(moritz_runs(i)%dir), ' is missing'
      end do
      write(*,*) 'n_rakesh', n_rakesh
      do i = 1, n_rakesh
        flag_missing = .TRUE.
        do j = 1, num_runs
          if(    trim(rakesh_runs(i)%dir)                               &
     &      .eq. trim(param(j)%dir_name)) then
            rakesh_param(i) = param(j)
            flag_missing = .FALSE.
            exit
          end if
        end do
        if(flag_missing) write(*,*) 'Directory ',                       &
     &      trim(moritz_runs(i)%dir), ' is missing'
      end do
!
!
!
      file_name = 'parameters.csv'
      call write_all_runs__params_csv(file_name, num_runs, param)
!      call write_all_params_for_each_run(num_runs, param)
!
      file_name = 'moritz_parameters.csv'
      call write_moritz_runs_params_csv(file_name, n_moritz,            &
     &                                  moritz_runs, moritz_param)
      call write_params_for_each_moritz(n_moritz, moritz_param)
      call write_doc_for_each_moritz(n_moritz,                          &
     &                               moritz_runs, moritz_param)
!
      file_name = 'rakesh_parameters.csv'
      call write_rakesh_runs_params_csv(file_name, n_rakesh,            &
     &                                  rakesh_runs, rakesh_param)
      call write_params_for_each_rakesh(n_rakesh, rakesh_param)
      call write_doc_for_each_rakesh(n_rakesh,                          &
     &                               rakesh_runs, rakesh_param)
!
!

!
! -----------------------------------------------------------------------
!
      contains
!
! -----------------------------------------------------------------------
!
      logical function get_int_param(line_txt, ref_label, int_param)
!
      character(len=255), intent(in) :: line_txt
      character(len=255), intent(in) :: ref_label
      integer, intent(inout) :: int_param
!
      character(len=255) :: label, equal, tmpchara
!
      get_int_param = .FALSE.
      read(line_txt,*) label
      if(trim(label) .eq. ref_label) then
        read(line_txt,*) tmpchara, equal, int_param
        get_int_param = .TRUE.
      end if
!
      end function get_int_param
!
! -----------------------------------------------------------------------
!
      logical function get_real_param(line_txt, ref_label, real_param)
!
      character(len=255), intent(in) :: line_txt
      character(len=255), intent(in) :: ref_label
      real*8, intent(inout) :: real_param
!
      character(len=255) :: label, equal, tmpchara
!
      get_real_param = .FALSE.
      read(line_txt,*) label
      if(trim(label) .eq. ref_label) then
        read(line_txt,*) tmpchara, equal, real_param
        get_real_param = .TRUE.
      end if
!
      end function get_real_param
!
! -----------------------------------------------------------------------
!
      logical function get_char_param(line_txt, ref_label, char_param)
!
      character(len=255), intent(in) :: line_txt
      character(len=255), intent(in) :: ref_label
      character(len=255), intent(inout) :: char_param
!
      character(len=255) :: label, equal, tmpchara
!
      get_char_param = .FALSE.
      read(line_txt,*) label
      if(trim(label) .eq. ref_label) then
        read(line_txt,*) tmpchara, equal, char_param
        get_char_param = .TRUE.
      end if
!
      end function get_char_param
!
! -----------------------------------------------------------------------
!
      subroutine write_all_runs__params_csv(fname, num_runs, param)
!
      implicit none
!
      character(len = 255), intent(in) :: fname
      integer, intent(in) :: num_runs
      type(INCITE_PARAMS), intent(in) :: param(num_runs)
!
      integer, parameter :: id_out = 16
!
!
      write(*,*) 'output all paramter list in ', trim(fname)
      open(id_out, file=fname)
      write(id_out,'(a, a2)', ADVANCE='NO') 'id, folder', ', '
      write(id_out,'(a, a2)', ADVANCE='NO')  trim(hd_Nr), ', '
      write(id_out,'(a, a2)', ADVANCE='NO')  trim(hd_Nt), ', '
      write(id_out,'(a, a2)', ADVANCE='NO')  trim(hd_aspect), ', '
      write(id_out,'(a, a2)', ADVANCE='NO')  trim(hd_shell), ', '
      write(id_out,'(a, a2)', ADVANCE='NO')  trim(hd_chebyshev), ', '
!
      write(id_out,'(a, a2)', ADVANCE='NO')  trim(hd_rotation), ', '
      write(id_out,'(a, a2)', ADVANCE='NO')  trim(hd_magnetism), ', '
      write(id_out,'(a, a2)', ADVANCE='NO')  trim(hd_viscous), ', '
      write(id_out,'(a, a2)', ADVANCE='NO')  trim(hd_ohmic), ', '
!
      write(id_out,'(a, a2)', ADVANCE='NO')  trim(hd_Ek), ', '
      write(id_out,'(a, a2)', ADVANCE='NO')  trim(hd_Pr), ', '
      write(id_out,'(a, a2)', ADVANCE='NO')  trim(hd_Pm), ', '
      write(id_out,'(a, a2)', ADVANCE='NO')  trim(hd_Ra), ', '
      write(id_out,'(a, a2)', ADVANCE='NO')  trim(hd_mod_Ra), ', '
!
      write(id_out,'(a, a2)', ADVANCE='NO')  trim(hd_no_slip), ', '
      write(id_out,'(a, a2)', ADVANCE='NO')                             &
     &                       trim(hd_fix_tvar_bottom), ', '
      write(id_out,'(a, a2)', ADVANCE='NO')  trim(hd_T_bottom), ', '
      write(id_out,'(a, a2)', ADVANCE='NO')                             &
     &                       trim(hd_fix_dtdr_bottom), ', '
      write(id_out,'(a, a2)', ADVANCE='NO')  trim(hd_dTdr_bottom), ', '
      write(id_out,'(a, a2)', ADVANCE='NO')                             &
     &                       trim(hd_fix_tvar_top), ', '
      write(id_out,'(a, a2)', ADVANCE='NO')  trim(hd_T_top), ', '
      write(id_out,'(a, a2)', ADVANCE='NO')                             &
     &                       trim(hd_fix_dtdr_top), ', '
      write(id_out,'(a, a2)', ADVANCE='NO')  trim(hd_dTdr_top), ', '
!
      write(id_out,'(a, a2)', ADVANCE='NO')                             &
     &                       trim(hd_reference_type), ', '
      write(id_out,'(a, a2)', ADVANCE='NO')                             &
     &                       trim(hd_heating_type), ', '
      write(id_out,'(a, a2)', ADVANCE='NO')                             &
     &                       trim(hd_poly_n), ', '
      write(id_out,'(a, a2)', ADVANCE='NO')                             &
     &                       trim(hd_poly_Nrho), ', '
      write(id_out,'(a, a2)', ADVANCE='NO')                             &
     &                       trim(hd_gravity_power), ', '
      write(id_out,'(a, a2)', ADVANCE='NO')                             &
     &                       trim(hd_dimensional), ', '
!
      write(id_out,'(a, a2)', ADVANCE='NO')                             &
     &                       trim(hd_hyperdiffusion), ', '
      write(id_out,'(a, a2)', ADVANCE='NO')                             &
     &                       trim(hd_hyperdiffusion_alpha), ', '
      write(id_out,'(a, a2)', ADVANCE='NO')                             &
     &                       trim(hd_hyperdiffusion_beta), ', '
!
      write(id_out,*)
      do i = 1, num_runs
        write(id_out,'(i4,a2)', ADVANCE='NO') i, ', '
!        write(id_out,'(i8,a2)', ADVANCE='NO') istack_runs(i),', '
        write(id_out,'(a,a2)', ADVANCE='NO')                            &
     &                        trim(param(i)%dir_name),', '
        write(id_out,'(i8,a2)', ADVANCE='NO') param(i)%N_r,', '
        write(id_out,'(i8,a2)', ADVANCE='NO') param(i)%N_theta,', '
        write(id_out,'(1pe23.12,a2)', ADVANCE='NO')                     &
     &              param(i)%aspect_ratio,', '
        write(id_out,'(1pe23.12,a2)', ADVANCE='NO')                     &
     &              param(i)%shell_depth,', '
        write(id_out,'(a,a2)', ADVANCE='NO')                            &
     &              trim(param(i)%chebyshev), ', '
        write(id_out,'(a,a2)', ADVANCE='NO')                            &
     &               trim(param(i)%rotation),', '
        write(id_out,'(a,a2)', ADVANCE='NO')                            &
     &               trim(param(i)%magnetism),', '
        write(id_out,'(a,a2)', ADVANCE='NO')                            &
     &               trim(param(i)%viscous_heating),', '
        write(id_out,'(a,a2)', ADVANCE='NO')                            &
     &               trim(param(i)%ohmic_heating),', '
!
        write(id_out,'(1pe23.12,a2)', ADVANCE='NO')                     &
     &               param(i)%Ekman_Number,', '
        write(id_out,'(1pe23.12,a2)', ADVANCE='NO')                     &
     &                 param(i)%Prandtl_Number,', '
        write(id_out,'(1pe23.12,a2)', ADVANCE='NO')                     &
     &               param(i)%Magnetic_Prandtl_Number,', '
        write(id_out,'(1pe23.12,a2)', ADVANCE='NO')                     &
     &               param(i)%Rayleigh_Number,', '
        write(id_out,'(1pe23.12,a2)', ADVANCE='NO')                     &
     &                 param(i)%Modified_Rayleigh_Number,', '
!
        write(id_out,'(a,a2)', ADVANCE='NO')                            &
     &               trim(param(i)%no_slip_boundaries),', '
        write(id_out,'(a,a2)', ADVANCE='NO')                            &
     &               trim(param(i)%fix_tvar_bottom),', '
        write(id_out,'(1pe23.12,a2)', ADVANCE='NO')                     &
     &                 param(i)%T_bottom,', '
        write(id_out,'(a,a2)', ADVANCE='NO')                            &
     &               trim(param(i)%fix_dtdr_bottom),', '
        write(id_out,'(1pe23.12,a2)', ADVANCE='NO')                     &
     &                 param(i)%dTdr_bottom,', '
        write(id_out,'(a,a2)', ADVANCE='NO')                            &
     &               trim(param(i)%fix_tvar_top),', '
        write(id_out,'(1pe23.12,a2)', ADVANCE='NO')                     &
     &                 param(i)%T_top,', '
        write(id_out,'(a,a2)', ADVANCE='NO')                            &
     &               trim(param(i)%fix_dtdr_top), ', '
        write(id_out,'(1pe23.12,a2)', ADVANCE='NO')                     &
     &                 param(i)%dTdr_top,', '
!
        write(id_out,'(i8,a2)', ADVANCE='NO')                           &
     &                 param(i)%reference_type,', '
        write(id_out,'(i8,a2)', ADVANCE='NO')                           &
     &                 param(i)%heating_type,', '
        write(id_out,'(1pe23.12,a2)', ADVANCE='NO')                     &
     &                 param(i)%poly_n,', '
        write(id_out,'(1pe23.12,a2)', ADVANCE='NO')                     &
     &                 param(i)%poly_Nrho,', '
        write(id_out,'(1pe23.12,a2)', ADVANCE='NO')                     &
     &                 param(i)%gravity_power,', '
        write(id_out,'(a,a2)', ADVANCE='NO')                            &
     &               trim(param(i)%dimensional), ', '
!
        write(id_out,'(a,a2)', ADVANCE='NO')                            &
     &               trim(param(i)%hyperdiffusion), ', '
        write(id_out,'(1pe23.12,a2)', ADVANCE='NO')                     &
     &                 param(i)%hyperdiffusion_alpha,', '
        write(id_out,'(1pe23.12,a2)', ADVANCE='NO')                     &
     &                 param(i)%hyperdiffusion_beta,', '
!
        write(id_out,*)
      end do
      close(id_out)
!
      end subroutine write_all_runs__params_csv
!
! -----------------------------------------------------------------------
!
      subroutine write_moritz_runs_params_csv                           &
     &         (fname, n_runs, runs, param)
!
      implicit none
!
      character(len = 255), intent(in) :: fname
      integer, intent(in) :: n_runs
      type(run_def), intent(in) :: runs(num_runs)
      type(INCITE_PARAMS), intent(in) :: param(num_runs)
!
      integer, parameter :: id_out = 16
!
!
      write(*,*) 'output Moritz paramter list in ', trim(fname)
      open(id_out, file=fname)
      write(id_out,'(a, a2)', ADVANCE='NO') 'Run name ', ', '
      write(id_out,'(a, a2)', ADVANCE='NO')  trim(hd_Nr), ', '
      write(id_out,'(a, a2)', ADVANCE='NO')  trim(hd_Nt), ', '
      write(id_out,'(a, a2)', ADVANCE='NO')  trim(hd_aspect), ', '
!      write(id_out,'(a, a2)', ADVANCE='NO')  trim(hd_shell), ', '
!      write(id_out,'(a, a2)', ADVANCE='NO')  trim(hd_chebyshev), ', '
!
!      write(id_out,'(a, a2)', ADVANCE='NO')  trim(hd_rotation), ', '
!      write(id_out,'(a, a2)', ADVANCE='NO')  trim(hd_magnetism), ', '
!      write(id_out,'(a, a2)', ADVANCE='NO')  trim(hd_viscous), ', '
!      write(id_out,'(a, a2)', ADVANCE='NO')  trim(hd_ohmic), ', '
!
      write(id_out,'(a, a2)', ADVANCE='NO')  trim(hd_Ek), ', '
      write(id_out,'(a, a2)', ADVANCE='NO')  trim(hd_Pr), ', '
!      write(id_out,'(a, a2)', ADVANCE='NO')  trim(hd_Pm), ', '
!      write(id_out,'(a, a2)', ADVANCE='NO')  trim(hd_Ra), ', '
      write(id_out,'(a, a2)', ADVANCE='NO')  trim(hd_mod_Ra), ', '
!
!      write(id_out,'(a, a2)', ADVANCE='NO')  trim(hd_no_slip), ', '
!      write(id_out,'(a, a2)', ADVANCE='NO')                            &
!     &                       trim(hd_fix_tvar_bottom), ', '
!      write(id_out,'(a, a2)', ADVANCE='NO')  trim(hd_T_bottom), ', '
!      write(id_out,'(a, a2)', ADVANCE='NO')                            &
!     &                       trim(hd_fix_dtdr_bottom), ', '
      write(id_out,'(a, a2)', ADVANCE='NO')  trim(hd_dTdr_bottom), ', '
!      write(id_out,'(a, a2)', ADVANCE='NO')                            &
!     &                       trim(hd_fix_tvar_top), ', '
!      write(id_out,'(a, a2)', ADVANCE='NO')  trim(hd_T_top), ', '
!      write(id_out,'(a, a2)', ADVANCE='NO')                            &
!     &                       trim(hd_fix_dtdr_top), ', '
      write(id_out,'(a, a2)', ADVANCE='NO')  trim(hd_dTdr_top), ', '
!
      write(id_out,'(a, a2)', ADVANCE='NO')                             &
     &                       trim(hd_reference_type), ', '
      write(id_out,'(a, a2)', ADVANCE='NO')                             &
     &                       trim(hd_heating_type), ', '
      write(id_out,'(a, a2)', ADVANCE='NO')                             &
     &                       trim(hd_poly_n), ', '
      write(id_out,'(a, a2)', ADVANCE='NO')                             &
     &                       trim(hd_poly_Nrho), ', '
!      write(id_out,'(a, a2)', ADVANCE='NO')                            &
!     &                       trim(hd_gravity_power), ', '
!      write(id_out,'(a, a2)', ADVANCE='NO')                            &
!     &                       trim(hd_dimensional), ', '
!
      write(id_out,'(a, a2)', ADVANCE='NO')                             &
     &                       trim(hd_hyperdiffusion), ', '
      write(id_out,'(a, a2)', ADVANCE='NO')                             &
     &                       trim(hd_hyperdiffusion_alpha), ', '
      write(id_out,'(a, a2)', ADVANCE='NO')                             &
     &                       trim(hd_hyperdiffusion_beta), ', '
      write(id_out,'(a, a2)', ADVANCE='NO')                             &
     &                       trim(hd_publication), ', '
!
      write(id_out,*)
      do i = 1, n_runs
        write(id_out,'(a,a2)', ADVANCE='NO')                            &
     &                        trim(runs(i)%name),', '
        write(id_out,'(i8,a2)', ADVANCE='NO') param(i)%N_r,', '
        write(id_out,'(i8,a2)', ADVANCE='NO') param(i)%N_theta,', '
        write(id_out,'(1pe10.2,a2)', ADVANCE='NO')                      &
     &              param(i)%aspect_ratio,', '
!        write(id_out,'(1pe10.2,a2)', ADVANCE='NO')                     &
!     &              param(i)%shell_depth,', '
!        write(id_out,'(a,a2)', ADVANCE='NO')                           &
!     &              trim(param(i)%chebyshev), ', '
!        write(id_out,'(a,a2)', ADVANCE='NO')                           &
!     &               trim(param(i)%rotation),', '
!        write(id_out,'(a,a2)', ADVANCE='NO')                           &
!     &               trim(param(i)%magnetism),', '
!        write(id_out,'(a,a2)', ADVANCE='NO')                           &
!     &               trim(param(i)%viscous_heating),', '
!        write(id_out,'(a,a2)', ADVANCE='NO')                           &
!     &               trim(param(i)%ohmic_heating),', '
!
        write(id_out,'(1pe10.2,a2)', ADVANCE='NO')                      &
     &               param(i)%Ekman_Number,', '
        write(id_out,'(1pe10.2,a2)', ADVANCE='NO')                      &
     &                 param(i)%Prandtl_Number,', '
!        write(id_out,'(1pe10.2,a2)', ADVANCE='NO')                     &
!     &               param(i)%Magnetic_Prandtl_Number,', '
!        write(id_out,'(1pe10.2,a2)', ADVANCE='NO')                     &
!     &               param(i)%Rayleigh_Number,', '
        write(id_out,'(1pe10.2,a2)', ADVANCE='NO')                      &
     &                 param(i)%Modified_Rayleigh_Number,', '
!
!        write(id_out,'(a,a2)', ADVANCE='NO')                           &
!     &               trim(param(i)%no_slip_boundaries),', '
!        write(id_out,'(a,a2)', ADVANCE='NO')                           &
!     &               trim(param(i)%fix_tvar_bottom),', '
!        write(id_out,'(1pe10.2,a2)', ADVANCE='NO')                     &
!     &                 param(i)%T_bottom,', '
!        write(id_out,'(a,a2)', ADVANCE='NO')                           &
!     &               trim(param(i)%fix_dtdr_bottom),', '
        write(id_out,'(1pe10.2,a2)', ADVANCE='NO')                      &
     &                 param(i)%dTdr_bottom,', '
!        write(id_out,'(a,a2)', ADVANCE='NO')                           &
!     &               trim(param(i)%fix_tvar_top),', '
!        write(id_out,'(1pe10.2,a2)', ADVANCE='NO')                     &
!     &                 param(i)%T_top,', '
!        write(id_out,'(a,a2)', ADVANCE='NO')                           &
!     &               trim(param(i)%fix_dtdr_top), ', '
        write(id_out,'(1pe10.2,a2)', ADVANCE='NO')                      &
     &                 param(i)%dTdr_top,', '
!
        write(id_out,'(i8,a2)', ADVANCE='NO')                           &
     &                 param(i)%reference_type,', '
        write(id_out,'(i8,a2)', ADVANCE='NO')                           &
     &                 param(i)%heating_type,', '
        write(id_out,'(1pe10.2,a2)', ADVANCE='NO')                     &
     &                 param(i)%poly_n,', '
        write(id_out,'(1pe10.2,a2)', ADVANCE='NO')                     &
     &                 param(i)%poly_Nrho,', '
!        write(id_out,'(1pe10.2,a2)', ADVANCE='NO')                     &
!     &                 param(i)%gravity_power,', '
!        write(id_out,'(a,a2)', ADVANCE='NO')                           &
!     &               trim(param(i)%dimensional), ', '
!
        write(id_out,'(a,a2)', ADVANCE='NO')                            &
     &               trim(param(i)%hyperdiffusion), ', '
        write(id_out,'(1pe10.2,a2)', ADVANCE='NO')                     &
     &                 param(i)%hyperdiffusion_alpha,', '
        write(id_out,'(1pe10.2,a2)', ADVANCE='NO')                     &
     &                 param(i)%hyperdiffusion_beta,', '
!
        write(id_out,*)
      end do
      close(id_out)
!
      end subroutine write_moritz_runs_params_csv
!
! -----------------------------------------------------------------------
!
      subroutine write_rakesh_runs_params_csv                           &
     &         (fname, n_runs, runs, param)
!
      implicit none
!
      character(len = 255), intent(in) :: fname
      integer, intent(in) :: n_runs
      type(run_def), intent(in) :: runs(num_runs)
      type(INCITE_PARAMS), intent(in) :: param(num_runs)
!
      integer, parameter :: id_out = 16
!
!
      write(*,*) 'output Rakesh paramter list in ', trim(fname)
      open(id_out, file=fname)
      write(id_out,'(a, a2)', ADVANCE='NO') 'Run name ', ', '
      write(id_out,'(a, a2)', ADVANCE='NO')  trim(hd_Nr), ', '
      write(id_out,'(a, a2)', ADVANCE='NO')  trim(hd_Nt), ', '
!      write(id_out,'(a, a2)', ADVANCE='NO')  trim(hd_aspect), ', '
!      write(id_out,'(a, a2)', ADVANCE='NO')  trim(hd_shell), ', '
!      write(id_out,'(a, a2)', ADVANCE='NO')  trim(hd_chebyshev), ', '
!
!      write(id_out,'(a, a2)', ADVANCE='NO')  trim(hd_rotation), ', '
!      write(id_out,'(a, a2)', ADVANCE='NO')  trim(hd_magnetism), ', '
!      write(id_out,'(a, a2)', ADVANCE='NO')  trim(hd_viscous), ', '
!      write(id_out,'(a, a2)', ADVANCE='NO')  trim(hd_ohmic), ', '
!
      write(id_out,'(a, a2)', ADVANCE='NO')  trim(hd_Ek), ', '
      write(id_out,'(a, a2)', ADVANCE='NO')  trim(hd_Pr), ', '
      write(id_out,'(a, a2)', ADVANCE='NO')  trim(hd_Pm), ', '
      write(id_out,'(a, a2)', ADVANCE='NO')  trim(hd_Ra), ', '
!      write(id_out,'(a, a2)', ADVANCE='NO')  trim(hd_mod_Ra), ', '
!
!      write(id_out,'(a, a2)', ADVANCE='NO')  trim(hd_no_slip), ', '
!      write(id_out,'(a, a2)', ADVANCE='NO')                            &
!     &                       trim(hd_fix_tvar_bottom), ', '
!      write(id_out,'(a, a2)', ADVANCE='NO')  trim(hd_T_bottom), ', '
!      write(id_out,'(a, a2)', ADVANCE='NO')                            &
!     &                       trim(hd_fix_dtdr_bottom), ', '
!      write(id_out,'(a, a2)', ADVANCE='NO')  trim(hd_dTdr_bottom), ', '
!      write(id_out,'(a, a2)', ADVANCE='NO')                            &
!     &                       trim(hd_fix_tvar_top), ', '
!      write(id_out,'(a, a2)', ADVANCE='NO')  trim(hd_T_top), ', '
!      write(id_out,'(a, a2)', ADVANCE='NO')                            &
!     &                       trim(hd_fix_dtdr_top), ', '
!      write(id_out,'(a, a2)', ADVANCE='NO')  trim(hd_dTdr_top), ', '
!
!      write(id_out,'(a, a2)', ADVANCE='NO')                            &
!     &                       trim(hd_reference_type), ', '
!      write(id_out,'(a, a2)', ADVANCE='NO')                            &
!     &                       trim(hd_heating_type), ', '
!      write(id_out,'(a, a2)', ADVANCE='NO')                            &
!     &                       trim(hd_poly_n), ', '
!      write(id_out,'(a, a2)', ADVANCE='NO')                            &
!     &                       trim(hd_poly_Nrho), ', '
!      write(id_out,'(a, a2)', ADVANCE='NO')                            &
!     &                       trim(hd_gravity_power), ', '
!      write(id_out,'(a, a2)', ADVANCE='NO')                            &
!     &                       trim(hd_dimensional), ', '
!
      write(id_out,'(a, a2)', ADVANCE='NO')                             &
     &                       trim(hd_hyperdiffusion), ', '
      write(id_out,'(a, a2)', ADVANCE='NO')                             &
     &                       trim(hd_hyperdiffusion_alpha), ', '
      write(id_out,'(a, a2)', ADVANCE='NO')                             &
     &                       trim(hd_hyperdiffusion_beta), ', '
      write(id_out,'(a, a2)', ADVANCE='NO')                             &
     &                       trim(hd_publication)
!
      write(id_out,*)
      do i = 1, n_runs
!        write(id_out,'(i4,a2)', ADVANCE='NO') i, ', '
        write(id_out,'(a,a2)', ADVANCE='NO')                            &
     &                        trim(runs(i)%name),', '
        write(id_out,'(i8,a2)', ADVANCE='NO') param(i)%N_r,', '
        write(id_out,'(i8,a2)', ADVANCE='NO') param(i)%N_theta,', '
!        write(id_out,'(1pe10.2,a2)', ADVANCE='NO')                    &
!     &              param(i)%aspect_ratio,', '
!        write(id_out,'(1pe10.2,a2)', ADVANCE='NO')                    &
!     &              param(i)%shell_depth,', '
!        write(id_out,'(a,a2)', ADVANCE='NO')                           &
!     &              trim(param(i)%chebyshev), ', '
!        write(id_out,'(a,a2)', ADVANCE='NO')                           &
!     &               trim(param(i)%rotation),', '
!        write(id_out,'(a,a2)', ADVANCE='NO')                           &
!     &               trim(param(i)%magnetism),', '
!        write(id_out,'(a,a2)', ADVANCE='NO')                           &
!     &               trim(param(i)%viscous_heating),', '
!        write(id_out,'(a,a2)', ADVANCE='NO')                           &
!     &               trim(param(i)%ohmic_heating),', '
!
        write(id_out,'(1pe10.2,a2)', ADVANCE='NO')                      &
     &               param(i)%Ekman_Number,', '
        write(id_out,'(1pe10.2,a2)', ADVANCE='NO')                      &
     &                 param(i)%Prandtl_Number,', '
        write(id_out,'(1pe10.2,a2)', ADVANCE='NO')                      &
     &               param(i)%Magnetic_Prandtl_Number,', '
        write(id_out,'(1pe10.2,a2)', ADVANCE='NO')                      &
     &               param(i)%Rayleigh_Number,', '
!        write(id_out,'(1pe10.2,a2)', ADVANCE='NO')                    &
!     &                 param(i)%Modified_Rayleigh_Number,', '
!
!        write(id_out,'(a,a2)', ADVANCE='NO')                           &
!     &               trim(param(i)%no_slip_boundaries),', '
!        write(id_out,'(a,a2)', ADVANCE='NO')                           &
!     &               trim(param(i)%fix_tvar_bottom),', '
!        write(id_out,'(1pe10.2,a2)', ADVANCE='NO')                    &
!     &                 param(i)%T_bottom,', '
!        write(id_out,'(a,a2)', ADVANCE='NO')                           &
!     &               trim(param(i)%fix_dtdr_bottom),', '
!        write(id_out,'(1pe10.2,a2)', ADVANCE='NO')                    &
!     &                 param(i)%dTdr_bottom,', '
!        write(id_out,'(a,a2)', ADVANCE='NO')                           &
!     &               trim(param(i)%fix_tvar_top),', '
!        write(id_out,'(1pe10.2,a2)', ADVANCE='NO')                    &
!     &                 param(i)%T_top,', '
!        write(id_out,'(a,a2)', ADVANCE='NO')                           &
!     &               trim(param(i)%fix_dtdr_top), ', '
!        write(id_out,'(1pe10.2,a2)', ADVANCE='NO')                    &
!     &                 param(i)%dTdr_top,', '
!
!        write(id_out,'(i8,a2)', ADVANCE='NO')                          &
!     &                 param(i)%reference_type,', '
!        write(id_out,'(i8,a2)', ADVANCE='NO')                          &
!     &                 param(i)%heating_type,', '
!        write(id_out,'(1pe10.2,a2)', ADVANCE='NO')                    &
!     &                 param(i)%poly_n,', '
!        write(id_out,'(1pe10.2,a2)', ADVANCE='NO')                    &
!     &                 param(i)%poly_Nrho,', '
!        write(id_out,'(1pe10.2,a2)', ADVANCE='NO')                    &
!     &                 param(i)%gravity_power,', '
!        write(id_out,'(a,a2)', ADVANCE='NO')                           &
!     &               trim(param(i)%dimensional), ', '
!
        write(id_out,'(a,a2)', ADVANCE='NO')                            &
     &               trim(param(i)%hyperdiffusion), ', '
        write(id_out,'(1pe10.2,a2)', ADVANCE='NO')                      &
     &                 param(i)%hyperdiffusion_alpha,', '
        write(id_out,'(1pe10.2,a2)', ADVANCE='NO')                      &
     &                 param(i)%hyperdiffusion_beta,', '
!
        if(trim(runs(i)%name) .eq. 'Geo-5') then
          write(id_out,'(a)') '"Cao, H. Et al. (2018)"'
        else
          write(id_out,'(a)')
        end if
      end do
      close(id_out)
!
!
      end subroutine write_rakesh_runs_params_csv
!
! -----------------------------------------------------------------------
!
      subroutine write_all_params_for_each_run(num_runs, param)
!
      integer, intent(in) :: num_runs
      type(INCITE_PARAMS), intent(in) :: param(:)
!
      integer, parameter :: id_out = 16
      character(len = 255) :: fname
      integer :: i
!
      do i = 1, num_runs
        write(fname,'(a,a)') trim(param(i)%dir_name), '/param.csv'
        open(id_log, file=fname, err=98)
!
        write(id_log,'(a)')  'Name, Parameter'
        write(id_log,'(a, a2,i8)')  trim(hd_Nr), ', ', param(i)%N_r
        write(id_log,'(a, a2,i8)')  trim(hd_Nt), ', ', param(i)%N_theta
        write(id_log,'(a, a2,1pe23.12)')  trim(hd_aspect), ', ',        &
     &                                  param(i)%aspect_ratio
        write(id_log,'(a, a2,1pe23.12)')  trim(hd_shell), ', ',      &
     &                                  param(i)%shell_depth
        write(id_log,'(a, a2,a)')  trim(hd_chebyshev), ', ',      &
     &                                  trim(param(i)%chebyshev)
!, 
        write(id_log,'(a, a2,a)')  trim(hd_rotation), ', ',      &
     &                                  trim(param(i)%rotation)
        write(id_log,'(a, a2,a)')  trim(hd_magnetism), ', ',      &
     &                                  trim(param(i)%magnetism)
        write(id_log,'(a, a2,a)')  trim(hd_viscous), ', ',              &
     &                                  trim(param(i)%viscous_heating)
        write(id_log,'(a, a2,a)')  trim(hd_ohmic), ', ',                &
     &                                  trim(param(i)%ohmic_heating)
!, 
        write(id_log,'(a, a2,1pe23.12)')  trim(hd_Ek), ', ',            &
     &                            param(i)%Ekman_Number
        write(id_log,'(a, a2,1pe23.12)')  trim(hd_Pr), ', ',            &
     &                            param(i)%Prandtl_Number
        write(id_log,'(a, a2,1pe23.12)')  trim(hd_Pm), ', ',            &
     &                            param(i)%Magnetic_Prandtl_Number
        write(id_log,'(a, a2,1pe23.12)')  trim(hd_Ra), ', ',            &
     &                            param(i)%Rayleigh_Number
        write(id_log,'(a, a2,1pe23.12)')  trim(hd_mod_Ra), ', ',        &
     &                            param(i)%Modified_Rayleigh_Number
!, 
        write(id_log,'(a, a2,a)') trim(hd_no_slip), ', ',               &
     &                            trim(param(i)%no_slip_boundaries)
        write(id_log,'(a, a2,a)') trim(hd_fix_tvar_bottom), ', ',       &
     &                            trim(param(i)%fix_tvar_bottom)
        write(id_log,'(a, a2,1pe23.12)')  trim(hd_T_bottom), ', ',      &
     &                                  param(i)%T_bottom
        write(id_log,'(a, a2,a)')  trim(hd_fix_dtdr_bottom), ', ',      &
     &                                  trim(param(i)%fix_dtdr_bottom)
        write(id_log,'(a, a2,1pe23.12)')  trim(hd_dTdr_bottom), ', ',   &
     &                                  param(i)%dTdr_bottom
        write(id_log,'(a, a2,a)') trim(hd_fix_tvar_top), ', ',          &
     &                                   trim(param(i)%fix_tvar_top)
        write(id_log,'(a, a2,1pe23.12)')  trim(hd_T_top), ', ',         &
     &                                   param(i)%T_top
        write(id_log,'(a, a2,a)') trim(hd_fix_dtdr_top), ', ',          &
     &                                   trim(param(i)%fix_dtdr_top)
        write(id_log,'(a, a2,1pe23.12)')  trim(hd_dTdr_top), ', ',      &
     &                                   param(i)%dTdr_top
!
        write(id_log,'(a, a2,i8)')  trim(hd_reference_type), ', ',      &
     &                                   param(i)%reference_type
        write(id_log,'(a, a2,i8)')  trim(hd_heating_type), ', ',        &
     &                                   param(i)%heating_type
        write(id_log,'(a, a2,1pe23.12)')  trim(hd_poly_n), ', ',        &
     &                                   param(i)%poly_n
        write(id_log,'(a, a2,1pe23.12)')  trim(hd_poly_Nrho), ', ',     &
     &                                   param(i)%poly_Nrho
        write(id_log,'(a, a2,1pe23.12)')  trim(hd_gravity_power), ', ', &
     &                                   param(i)%gravity_power
        write(id_log,'(a, a2,a)') trim(hd_dimensional), ', ',           &
     &                                   trim(param(i)%dimensional)
!
        write(id_log,'(a, a2,a)') trim(hd_hyperdiffusion), ', ',        &
     &                                   trim(param(i)%hyperdiffusion)
        write(id_log,'(a, a2,1pe23.12)')                                &
     &                       trim(hd_hyperdiffusion_alpha), ', ',       &
     &                       param(i)%hyperdiffusion_alpha
        write(id_log,'(a, a2,1pe23.12)')                                &
     &                       trim(hd_hyperdiffusion_beta), ', ',        &
     &                       param(i)%hyperdiffusion_beta
        close(id_log)
  98    continue
      end do
!
      end subroutine write_all_params_for_each_run
!
! -----------------------------------------------------------------------
!
      subroutine write_params_for_each_moritz(num_runs, param)
!
      integer, intent(in) :: num_runs
      type(INCITE_PARAMS), intent(in) :: param(:)
!
      integer, parameter :: id_out = 16
      character(len = 255) :: fname
      integer :: i
!
      do i = 1, num_runs
        write(fname,'(a,a)') trim(param(i)%dir_name), '/param.csv'
        open(id_log, file=fname, err=98)
!
        write(id_log,'(a)')  'Name, Parameter'
        write(id_log,'(a, a2,i8)')  trim(hd_Nr), ', ', param(i)%N_r
        write(id_log,'(a, a2,i8)')  trim(hd_Nt), ', ', param(i)%N_theta
        write(id_log,'(a, a2,1pe10.2)')  trim(hd_aspect), ', ',        &
     &                                  param(i)%aspect_ratio
        write(id_log,'(a, a2,1pe10.2)')  trim(hd_shell), ', ',      &
     &                                  param(i)%shell_depth
        write(id_log,'(a, a2,a)')  trim(hd_chebyshev), ', ',      &
     &                                  trim(param(i)%chebyshev)
!, 
        write(id_log,'(a, a2,a)')  trim(hd_rotation), ', ',      &
     &                                  trim(param(i)%rotation)
        write(id_log,'(a, a2,a)')  trim(hd_magnetism), ', ',      &
     &                                  trim(param(i)%magnetism)
        write(id_log,'(a, a2,a)')  trim(hd_viscous), ', ',              &
     &                                  trim(param(i)%viscous_heating)
        write(id_log,'(a, a2,a)')  trim(hd_ohmic), ', ',                &
     &                                  trim(param(i)%ohmic_heating)
!, 
        write(id_log,'(a, a2,1pe10.2)')  trim(hd_Ek), ', ',            &
     &                            param(i)%Ekman_Number
        write(id_log,'(a, a2,1pe10.2)')  trim(hd_Pr), ', ',            &
     &                            param(i)%Prandtl_Number
        write(id_log,'(a, a2,1pe10.2)')  trim(hd_Pm), ', ',            &
     &                            param(i)%Magnetic_Prandtl_Number
        write(id_log,'(a, a2,1pe10.2)')  trim(hd_Ra), ', ',            &
     &                            param(i)%Rayleigh_Number
        write(id_log,'(a, a2,1pe10.2)')  trim(hd_mod_Ra), ', ',        &
     &                            param(i)%Modified_Rayleigh_Number
!, 
        write(id_log,'(a, a2,a)') trim(hd_no_slip), ', ',               &
     &                            trim(param(i)%no_slip_boundaries)
        write(id_log,'(a, a2,a)') trim(hd_fix_tvar_bottom), ', ',       &
     &                            trim(param(i)%fix_tvar_bottom)
        write(id_log,'(a, a2,1pe10.2)')  trim(hd_T_bottom), ', ',      &
     &                                  param(i)%T_bottom
        write(id_log,'(a, a2,a)')  trim(hd_fix_dtdr_bottom), ', ',      &
     &                                  trim(param(i)%fix_dtdr_bottom)
        write(id_log,'(a, a2,1pe10.2)')  trim(hd_dTdr_bottom), ', ',   &
     &                                  param(i)%dTdr_bottom
        write(id_log,'(a, a2,a)') trim(hd_fix_tvar_top), ', ',          &
     &                                   trim(param(i)%fix_tvar_top)
        write(id_log,'(a, a2,1pe10.2)')  trim(hd_T_top), ', ',         &
     &                                   param(i)%T_top
        write(id_log,'(a, a2,a)') trim(hd_fix_dtdr_top), ', ',          &
     &                                   trim(param(i)%fix_dtdr_top)
        write(id_log,'(a, a2,1pe10.2)')  trim(hd_dTdr_top), ', ',      &
     &                                   param(i)%dTdr_top
!
        write(id_log,'(a, a2,i8)')  trim(hd_reference_type), ', ',      &
     &                                   param(i)%reference_type
        write(id_log,'(a, a2,i8)')  trim(hd_heating_type), ', ',        &
     &                                   param(i)%heating_type
        write(id_log,'(a, a2,1pe10.2)')  trim(hd_poly_n), ', ',        &
     &                                   param(i)%poly_n
        write(id_log,'(a, a2,1pe10.2)')  trim(hd_poly_Nrho), ', ',     &
     &                                   param(i)%poly_Nrho
        write(id_log,'(a, a2,1pe10.2)')  trim(hd_gravity_power), ', ', &
     &                                   param(i)%gravity_power
        write(id_log,'(a, a2,a)') trim(hd_dimensional), ', ',           &
     &                                   trim(param(i)%dimensional)
!
        write(id_log,'(a, a2,a)') trim(hd_hyperdiffusion), ', ',        &
     &                                   trim(param(i)%hyperdiffusion)
        write(id_log,'(a, a2,1pe10.2)')                                &
     &                       trim(hd_hyperdiffusion_alpha), ', ',       &
     &                       param(i)%hyperdiffusion_alpha
        write(id_log,'(a, a2,1pe10.2)')                                &
     &                       trim(hd_hyperdiffusion_beta), ', ',        &
     &                       param(i)%hyperdiffusion_beta
        close(id_log)
  98    continue
      end do
!
      end subroutine write_params_for_each_moritz
!
! -----------------------------------------------------------------------
!
      subroutine write_params_for_each_rakesh(num_runs, param)
!
      integer, intent(in) :: num_runs
      type(INCITE_PARAMS), intent(in) :: param(:)
!
      character(len = 255) :: fname
      integer, parameter :: id_out = 16
      integer :: i
!
      do i = 1, num_runs
        write(fname,'(a,a)') trim(param(i)%dir_name), '/param.csv'
        open(id_log, file=fname, err=98)
!
        write(id_log,'(a)')  'Name, Parameter'
        write(id_log,'(a, a2,i8)')  trim(hd_Nr), ', ', param(i)%N_r
        write(id_log,'(a, a2,i8)')  trim(hd_Nt), ', ', param(i)%N_theta
        write(id_log,'(a, a2,1pe10.2)')  trim(hd_aspect), ', ',        &
     &                                  param(i)%aspect_ratio
        write(id_log,'(a, a2,1pe10.2)')  trim(hd_shell), ', ',      &
     &                                  param(i)%shell_depth
        write(id_log,'(a, a2,a)')  trim(hd_chebyshev), ', ',      &
     &                                  trim(param(i)%chebyshev)
!, 
        write(id_log,'(a, a2,a)')  trim(hd_rotation), ', ',      &
     &                                  trim(param(i)%rotation)
        write(id_log,'(a, a2,a)')  trim(hd_magnetism), ', ',      &
     &                                  trim(param(i)%magnetism)
        write(id_log,'(a, a2,a)')  trim(hd_viscous), ', ',              &
     &                                  trim(param(i)%viscous_heating)
        write(id_log,'(a, a2,a)')  trim(hd_ohmic), ', ',                &
     &                                  trim(param(i)%ohmic_heating)
!, 
        write(id_log,'(a, a2,1pe10.2)')  trim(hd_Ek), ', ',            &
     &                            param(i)%Ekman_Number
        write(id_log,'(a, a2,1pe10.2)')  trim(hd_Pr), ', ',            &
     &                            param(i)%Prandtl_Number
        write(id_log,'(a, a2,1pe10.2)')  trim(hd_Pm), ', ',            &
     &                            param(i)%Magnetic_Prandtl_Number
        write(id_log,'(a, a2,1pe10.2)')  trim(hd_Ra), ', ',            &
     &                            param(i)%Rayleigh_Number
        write(id_log,'(a, a2,1pe10.2)')  trim(hd_mod_Ra), ', ',        &
     &                            param(i)%Modified_Rayleigh_Number
!, 
        write(id_log,'(a, a2,a)') trim(hd_no_slip), ', ',               &
     &                            trim(param(i)%no_slip_boundaries)
        write(id_log,'(a, a2,a)') trim(hd_fix_tvar_bottom), ', ',       &
     &                            trim(param(i)%fix_tvar_bottom)
        write(id_log,'(a, a2,1pe10.2)')  trim(hd_T_bottom), ', ',      &
     &                                  param(i)%T_bottom
        write(id_log,'(a, a2,a)')  trim(hd_fix_dtdr_bottom), ', ',      &
     &                                  trim(param(i)%fix_dtdr_bottom)
        write(id_log,'(a, a2,1pe10.2)')  trim(hd_dTdr_bottom), ', ',   &
     &                                  param(i)%dTdr_bottom
        write(id_log,'(a, a2,a)') trim(hd_fix_tvar_top), ', ',          &
     &                                   trim(param(i)%fix_tvar_top)
        write(id_log,'(a, a2,1pe10.2)')  trim(hd_T_top), ', ',         &
     &                                   param(i)%T_top
        write(id_log,'(a, a2,a)') trim(hd_fix_dtdr_top), ', ',          &
     &                                   trim(param(i)%fix_dtdr_top)
        write(id_log,'(a, a2,1pe10.2)')  trim(hd_dTdr_top), ', ',      &
     &                                   param(i)%dTdr_top
!
        write(id_log,'(a, a2,i8)')  trim(hd_reference_type), ', ',      &
     &                                   param(i)%reference_type
        write(id_log,'(a, a2,i8)')  trim(hd_heating_type), ', ',        &
     &                                   param(i)%heating_type
        write(id_log,'(a, a2,1pe10.2)')  trim(hd_poly_n), ', ',        &
     &                                   param(i)%poly_n
        write(id_log,'(a, a2,1pe10.2)')  trim(hd_poly_Nrho), ', ',     &
     &                                   param(i)%poly_Nrho
        write(id_log,'(a, a2,1pe10.2)')  trim(hd_gravity_power), ', ', &
     &                                   param(i)%gravity_power
        write(id_log,'(a, a2,a)') trim(hd_dimensional), ', ',           &
     &                                   trim(param(i)%dimensional)
!
        write(id_log,'(a, a2,a)') trim(hd_hyperdiffusion), ', ',        &
     &                                   trim(param(i)%hyperdiffusion)
        write(id_log,'(a, a2,1pe10.2)')                                &
     &                       trim(hd_hyperdiffusion_alpha), ', ',       &
     &                       param(i)%hyperdiffusion_alpha
        write(id_log,'(a, a2,1pe10.2)')                                &
     &                       trim(hd_hyperdiffusion_beta), ', ',        &
     &                       param(i)%hyperdiffusion_beta
        close(id_log)
  98    continue
      end do
!
      end subroutine write_params_for_each_rakesh
!
! -----------------------------------------------------------------------
!
      subroutine write_doc_for_each_moritz(n_runs, runs, param)
!
      integer, intent(in) :: n_runs
      type(run_def), intent(in) :: runs(n_runs)
      type(INCITE_PARAMS), intent(in) :: param(n_runs)
!
      character(len = 255) :: fname
      integer, parameter :: id_out = 16
      integer :: i
!
!
      do i = 1, n_runs
        write(fname,'(a,a)') trim(param(i)%dir_name),                   &
     &                        '/Case_doc.rst'
        write(*,*) 'Output Sphinx document ', trim(fname)
        open(id_out, file=fname, err=95)
        write(id_out,'(a)')                                             &
     &    '-----------------------------------------------------------'
        write(id_out,'(a)') trim(runs(i)%name)
        write(id_out,'(a)')                                             &
     &    '-----------------------------------------------------------'
        write(id_out,'(a)')
        write(id_out,'(a)') 'Links for data directories.'
        write(id_out,'(a)') '========================================='
        write(id_out,'(a)') 'Here is the link to access data directory:'
        write(id_out,'(a)')
        write(id_out,'(a)') '(Add Hyperlink to directory)'
        write(id_out,'(a)')
        write(id_out,'(a)') 'Parameters.'
        write(id_out,'(a)') '========================================='
        write(id_out,'(a)')
        write(id_out,'(a)') 'The following parameters are used:'
        write(id_out,'(a)')
        write(id_out,'(a)') '.. csv-table::'
        write(id_out,'(a)') '   :file: param.csv'
        write(id_out,'(a)') '   :encoding: UTF-8'
        write(id_out,'(a)') '   :header-rows: 1'
        write(id_out,'(a)')
        write(id_out,'(a)') 'Avaiable data.'
        write(id_out,'(a)') '=========================================='
        write(id_out,'(a)')
        write(id_out,'(a)')                                             &
     &              'The following data for analysis are aviable:'
        write(id_out,'(a)')
        write(id_out,'(a)') '.. csv-table::'
        write(id_out,'(a)') '   :file: ../../../outputs.csv'
        write(id_out,'(a)') '   :encoding: UTF-8'
        write(id_out,'(a)') '   :header-rows: 1'
        write(id_out,'(a)')
        write(id_out,'(a)')
!
        if(param(i)%dir_name(1:1) .eq. 'm') then
        else if(param(i)%dir_name(1:1) .eq. 'r') then
          write(id_out,'(a)') 'Examples of visualized images.'
          write(id_out,'(a)') '======================================='
          write(id_out,'(a)') 
          write(id_out,'(a)') '.. figure:: ./Images/KE_vs_time.png'
          write(id_out,'(a)') '   :scale: 200%'
          write(id_out,'(a)') '   :height: 200px'
          write(id_out,'(a)') '   :width: 300px'
          write(id_out,'(a)') '   :align: center'
          write(id_out,'(a)')    
          write(id_out,'(5a)')                                          &
     &            'Time evolution of kinetic energy density',           &
     &            ' :math:`E_{kin} = \frac{1}{2} v^{2}`',               &
     &            ' in the spherical shell as function of time',        &
     &            ' normalized by the magnetic diffusion time',         &
     &            ' :math:`\tau_{\eta} = L^{2} / \eta`.'

          write(id_out,'(a)')    
          write(id_out,'(a)') '.. figure:: ./Images/Ur_equator.png'
          write(id_out,'(a)') '   :scale: 200%'
          write(id_out,'(a)') '   :height: 240px'
          write(id_out,'(a)') '   :width: 300px'
          write(id_out,'(a)') '   :align: center'
          write(id_out,'(a)') '   :alt: Alternate Text'

          write(id_out,'(a)')    
          write(id_out,'(2a)')                                          &
     &           'Radial velocity :math:`u_r` at',                      &
     &           ' the equatorial plane :math:`z = 0`.'

          write(id_out,'(a)')    
          write(id_out,'(a)') '.. figure:: ./Images/U_spectr_l.png'
          write(id_out,'(a)') '   :scale: 200%'
          write(id_out,'(a)') '   :height: 240px'
          write(id_out,'(a)') '   :width: 300px'
          write(id_out,'(a)') '   :align: center'
          write(id_out,'(a)') '   :alt: Alternate Text'
   
          write(id_out,'(2a)')                                          &
     &           'Kinetic energy density spectra as a function',        &
     &           ' of spherical harmonic degree :math:`l`.'
        end if
!
        close(id_out)
  95    continue
      end do
!
      end subroutine write_doc_for_each_moritz
!
! -----------------------------------------------------------------------
!
      subroutine write_doc_for_each_rakesh(n_runs, runs, param)
!
      integer, intent(in) :: n_runs
      type(run_def), intent(in) :: runs(n_runs)
      type(INCITE_PARAMS), intent(in) :: param(n_runs)
!
      character(len = 255) :: fname
      integer, parameter :: id_out = 16
      integer :: i
!
!
      do i = 1, n_runs
        write(fname,'(a,a)') trim(param(i)%dir_name),                   &
     &                        '/Case_doc.rst'
        write(*,*) 'Output Sphinx document ', trim(fname)
        open(id_out, file=fname, err=95)
        write(id_out,'(a)')                                             &
     &    '-----------------------------------------------------------'
        write(id_out,'(a)') trim(runs(i)%name)
        write(id_out,'(a)')                                             &
     &    '-----------------------------------------------------------'
        write(id_out,'(a)')
        write(id_out,'(a)') 'Links for data directories.'
        write(id_out,'(a)') '========================================='
        write(id_out,'(a)') 'Here is the link to access data directory:'
        write(id_out,'(a)')
        write(id_out,'(a)') '(Add Hyperlink to directory)'
        write(id_out,'(a)')
        write(id_out,'(a)') 'Parameters.'
        write(id_out,'(a)') '========================================='
        write(id_out,'(a)')
        write(id_out,'(a)') 'The following parameters are used:'
        write(id_out,'(a)')
        write(id_out,'(a)') '.. csv-table::'
        write(id_out,'(a)') '   :file: param.csv'
        write(id_out,'(a)') '   :encoding: UTF-8'
        write(id_out,'(a)') '   :header-rows: 1'
        write(id_out,'(a)')
        write(id_out,'(a)') 'Avaiable data.'
        write(id_out,'(a)') '=========================================='
        write(id_out,'(a)')
        write(id_out,'(a)')                                             &
     &              'The following data for analysis are aviable:'
        write(id_out,'(a)')
        write(id_out,'(a)') '.. csv-table::'
        write(id_out,'(a)') '   :file: ../../outputs.csv'
        write(id_out,'(a)') '   :encoding: UTF-8'
        write(id_out,'(a)') '   :header-rows: 1'
        write(id_out,'(a)')
        write(id_out,'(a)')
!
        if(param(i)%dir_name(1:1) .eq. 'm') then
        else if(param(i)%dir_name(1:1) .eq. 'r') then
          write(id_out,'(a)') 'Examples of visualized images.'
          write(id_out,'(a)') '======================================='
          write(id_out,'(a)') 
          write(id_out,'(a)') '.. figure:: ./Images/KE_vs_time.png'
          write(id_out,'(a)') '   :scale: 200%'
          write(id_out,'(a)') '   :height: 200px'
          write(id_out,'(a)') '   :width: 300px'
          write(id_out,'(a)') '   :align: center'
          write(id_out,'(a)')    
          write(id_out,'(5a)')                                          &
     &            'Time evolution of kinetic energy density',           &
     &            ' :math:`E_{kin} = \frac{1}{2} v^{2}`',               &
     &            ' in the spherical shell as function of time',        &
     &            ' normalized by the magnetic diffusion time',         &
     &            ' :math:`\tau_{\eta} = L^{2} / \eta`.'
          write(id_out,'(a)')    
          write(id_out,'(a)') '.. figure:: ./Images/ME_vs_time.png'
          write(id_out,'(a)') '   :scale: 200%'
          write(id_out,'(a)') '   :height: 200px'
          write(id_out,'(a)') '   :width: 300px'
          write(id_out,'(a)') '   :align: center'

          write(id_out,'(5a)')                                          &
     &             'Time evolution of magnetic energy density',         &
     &             ' :math:`E_{mag} = \frac{1}{2Pm E} B^{2}`',          &
     &             ' in the spherical shell as function of time',       &
     &             ' normalized by the magnetic diffusion time',        &
     &             ' :math:`\tau_{\eta} = L^{2} / \eta`.'

          write(id_out,'(a)')    
          write(id_out,'(a)') '.. figure:: ./Images/Br_CMB.png'
          write(id_out,'(a)') '   :scale: 200%'
          write(id_out,'(a)') '   :height: 150px'
          write(id_out,'(a)') '   :width: 300px'
          write(id_out,'(a)') '   :align: center'
!
          write(id_out,'(a)')    
          write(id_out,'(2a)')                                          &
     &             'Radial magnetic field :math:`B_r`',                 &
     &             ' at the outer boundary :math:`r = r_o`.'

          write(id_out,'(a)')    
          write(id_out,'(a)')  '.. figure:: ./Images/Bz_equator.png'
          write(id_out,'(a)') '   :scale: 200%'
          write(id_out,'(a)') '   :height: 240px'
          write(id_out,'(a)') '   :width: 300px'
          write(id_out,'(a)') '   :align: center'
          write(id_out,'(a)') '   :alt: Alternate Text'
   
          write(id_out,'(a)')    
          write(id_out,'(2a)')                                          &
     &            ':math:`z`-component of the magnetic field',          &
     &            ' :math:`B_z` at the equatorial plane :math:`z = 0`.'

          write(id_out,'(a)')    
          write(id_out,'(a)') '.. figure:: ./Images/Ur_equator.png'
          write(id_out,'(a)') '   :scale: 200%'
          write(id_out,'(a)') '   :height: 240px'
          write(id_out,'(a)') '   :width: 300px'
          write(id_out,'(a)') '   :align: center'
          write(id_out,'(a)') '   :alt: Alternate Text'

          write(id_out,'(a)')    
          write(id_out,'(2a)')                                          &
     &           'Radial velocity :math:`u_r` at',                      &
     &           ' the equatorial plane :math:`z = 0`.'

          write(id_out,'(a)')    
          write(id_out,'(a)') '.. figure:: ./Images/B_spectr_l.png'
          write(id_out,'(a)') '   :scale: 200%'
          write(id_out,'(a)') '   :height: 240px'
          write(id_out,'(a)') '   :width: 300px'
          write(id_out,'(a)') '   :align: center'
          write(id_out,'(a)') '   :alt: Alternate Text'
   
          write(id_out,'(a)')    
          write(id_out,'(2a)')                                          &
     &           'Magnetic energy density spectra as a function',       &
     &           ' of spherical harmonic degree :math:`l`.'

          write(id_out,'(a)')    
          write(id_out,'(a)') '.. figure:: ./Images/U_spectr_l.png'
          write(id_out,'(a)') '   :scale: 200%'
          write(id_out,'(a)') '   :height: 240px'
          write(id_out,'(a)') '   :width: 300px'
          write(id_out,'(a)') '   :align: center'
          write(id_out,'(a)') '   :alt: Alternate Text'
   
          write(id_out,'(2a)')                                          &
     &           'Kinetic energy density spectra as a function',        &
     &           ' of spherical harmonic degree :math:`l`.'
        end if
!
        close(id_out)
  95    continue
      end do
!
      end subroutine write_doc_for_each_rakesh
!
! -----------------------------------------------------------------------
!
      end program log_check
