!>@file   rayleigh99_rst_param_IO.f90
!!@brief  module rayleigh99_rst_param_IO
!!
!!@author H. Matsui
!!@date   Programmed  H. Matsui in 2004
!
!>@brief  Set file extension
!!
!!@verbatim
!!      subroutine read_rayleigh99_restart_params(dir, i_step, ra_rst)
!!        integer(kind = kint), intent(in) :: i_step
!1        character(len = kchara), intent(in) :: dir
!!        type(rayleigh_restart), intent(inout) :: ra_rst
!!      character(len = kchara) function set_rayleigh99_file_name       &
!!     &                               (dir, int_id, postfix)
!!        integer(kind = kint), intent(in) :: int_id
!!        character(len=kchara), intent(in) :: dir, postfix
!!@endverbatim
!
      module rayleigh99_rst_param_IO
!
      use m_precision
      use t_rayleigh_restart_IO
!
      implicit  none
!
!-----------------------------------------------------------------------
!
      contains
!
!-----------------------------------------------------------------------
!
      subroutine convert_checkpoint_set(read_dir, write_top,            &
     &                                  i_step, ra_rst)
!
      character(len = kchara), intent(in) :: read_dir, write_top
      integer(kind = kint), intent(in) :: i_step
      type(rayleigh_restart), intent(inout) :: ra_rst
!
      integer(kind = kint) :: ierr
      character(len = kchara) :: write_dir
!
!
        call read_rayleigh99_restart_params(read_dir, i_step,           &
     &                                      ra_rst, ierr)
        if(ierr .ne. 0) return
!
        write_dir = set_rayleigh_folder_name(write_top, i_step)
        call cmkdir_f(write_dir)
!
        call write_rayleigh_restart_params(write_top, i_step, ra_rst)
!        call check_rayleigh_rst_params(6, ra_rst)
!
        call convert_each_checkpoint_data(read_dir, write_top, i_step,  &
     &                                  wchar, ra_rst)
        call convert_each_checkpoint_data(read_dir, write_top, i_step,  &
     &                                  zchar, ra_rst)
        call convert_each_checkpoint_data(read_dir, write_top, i_step,  &
     &                                  pchar, ra_rst)
        call convert_each_checkpoint_data(read_dir, write_top, i_step,  &
     &                                  tchar, ra_rst)
        call convert_each_checkpoint_data(read_dir, write_top, i_step,  &
     &                                  cchar, ra_rst)
        call convert_each_checkpoint_data(read_dir, write_top, i_step,  &
     &                                  achar, ra_rst)
!
        call convert_each_checkpoint_data(read_dir, write_top, i_step,  &
     &                                  wabchar, ra_rst)
        call convert_each_checkpoint_data(read_dir, write_top, i_step,  &
     &                                  zabchar, ra_rst)
        call convert_each_checkpoint_data(read_dir, write_top, i_step,  &
     &                                  pabchar, ra_rst)
        call convert_each_checkpoint_data(read_dir, write_top, i_step,  &
     &                                  tabchar, ra_rst)
        call convert_each_checkpoint_data(read_dir, write_top, i_step,  &
     &                                  cabchar, ra_rst)
        call convert_each_checkpoint_data(read_dir, write_top, i_step,  &
     &                                  aabchar, ra_rst)
!
      end subroutine convert_checkpoint_set
!
!-----------------------------------------------------------------------
!-----------------------------------------------------------------------
!
      subroutine read_rayleigh99_restart_params(dir, i_step,            &
     &                                          ra_rst, ierr)
!
      use byte_swap_f
!
      integer(kind = kint), intent(in) :: i_step
      character(len = kchara), intent(in) :: dir
!
      type(rayleigh_restart), intent(inout) :: ra_rst
      integer(kind = kint), intent(inout) :: ierr
!
      integer, parameter :: id_file = 15
      character(len = kchara) :: file_name
      integer :: i4_tmp(3)
      real(kind = kreal) :: r_tmp(1)
      integer(kind = kint_gl), parameter :: ione_8 = 1
      integer(kind = kint_gl), parameter :: ithree_8 = 3
      integer(kind = kint_gl) :: l8
!
!
      file_name =  set_rayleigh99_file_name(dir, i_step, paramchar)
!
      ierr = 1
      if(check_file_exist(file_name) .eqv. .FALSE.) return
!
      write(*,*) 'read Rayleigh checkpoint paramter file: ',            &
     &          trim(file_name)
        open(id_file, FILE=file_name, STATUS='OLD',                     &
     &       FORM='UNFORMATTED', ACCESS='STREAM')
!
      ra_rst%flag_swap = .FALSE.
      read(id_file) i4_tmp(1)
      if(i4_tmp(1) .ne. 4) ra_rst%flag_swap = .TRUE.
!
      read(id_file) i4_tmp(2:3)
      if(ra_rst%flag_swap) call byte_swap_int4_f(ithree_8, i4_tmp)
      ra_rst%nri_org = i4_tmp(2)
!
      read(id_file) i4_tmp(1:3)
      if(ra_rst%flag_swap) call byte_swap_int4_f(ithree_8, i4_tmp)
      ra_rst%iflag_rtype = i4_tmp(2)
!
      read(id_file) i4_tmp(1:3)
      if(ra_rst%flag_swap) call byte_swap_int4_f(ithree_8, i4_tmp)
      ra_rst%ltr_org = i4_tmp(2)
!
      read(id_file) i4_tmp(1), r_tmp(1), i4_tmp(1)
      if(ra_rst%flag_swap) call byte_swap_real_f(ione_8, r_tmp)
      ra_rst%dt_org = r_tmp(1)
!
      read(id_file) i4_tmp(1), r_tmp(1), i4_tmp(1)
      if(ra_rst%flag_swap) call byte_swap_real_f(ione_8, r_tmp)
      ra_rst%dt_new = r_tmp(1)
!
      call alloc_rayleigh_radial_grid(ra_rst)
!
      read(id_file)                                                     &
     &          i4_tmp(1), ra_rst%r_org(1:ra_rst%nri_org), i4_tmp(1)
      if(ra_rst%flag_swap) then
        l8 = ra_rst%nri_org
        call byte_swap_real_f(l8, ra_rst%r_org)
      end if
!
      read(id_file) i4_tmp(1), r_tmp(1), i4_tmp(1)
      if(ra_rst%flag_swap) call byte_swap_real_f(ione_8, r_tmp)
      ra_rst%time_org = r_tmp(1)
!
      close(id_file)
      ierr = 0
!
      end subroutine read_rayleigh99_restart_params
!
!-----------------------------------------------------------------------
!-----------------------------------------------------------------------
!
      subroutine convert_each_checkpoint_data(read_dir, write_dir,      &
     &                                        i_step, f_label, ra_rst)
!
      use byte_swap_f
!
      character(len = kchara), intent(in) :: read_dir, write_dir
      integer(kind = kint), intent(in) :: i_step
      character(len = kchara), intent(in) :: f_label
      type(rayleigh_restart), intent(in) :: ra_rst
!
      integer, parameter :: id_read = 15
      integer, parameter :: id_write = 16
      character(len = kchara) :: read_file, write_file
      logical :: check_raylegh_rst_field
!
      integer(kind = kint_gl) :: ist, count, isize
      integer(kind = kint_gl) :: ilen_in
!
      integer, parameter :: maxbuf = 32768
      real(kind = kreal) :: realbuf(maxbuf)
!
!
      read_file = set_rayleigh99_file_name(read_dir, i_step, f_label)
      write_file = set_rayleigh_file_name(write_dir, i_step, f_label)
      check_raylegh_rst_field = check_file_exist(read_file)
!      write(*,*) check_raylegh_rst_field, ' ', trim(read_file)
      if(check_raylegh_rst_field .eqv. .FALSE.) return
!
      open(id_read, file=read_file, STATUS='OLD',                       &
     &     FORM='UNFORMATTED', ACCESS='STREAM')
!
      open(id_write, file=write_file,                                   &
     &     FORM='UNFORMATTED', ACCESS='STREAM')
      inquire(id_read, size = isize)

      count = isize / kreal
      ist = 0
      do
        ilen_in = int(min(count-ist, maxbuf))
        read(id_read) realbuf(1:ilen_in)
        if(ra_rst%flag_swap) call byte_swap_real_f(ilen_in, realbuf)
        write(id_write) realbuf(1:ilen_in)
        ist = ist + ilen_in
!        write(*,*) ist, '-th data of ',  count, ' are done.'
        if(ist .ge. count) exit
      end do
      close(id_read)
      close(id_write)
      write(*,*) 'Data file ', trim(read_file),                         &
     &          ' is converted to ', trim(write_file)
!
      end subroutine convert_each_checkpoint_data
!
!-----------------------------------------------------------------------
!-----------------------------------------------------------------------
!
      character(len = kchara) function set_rayleigh99_file_name         &
     &                               (dir, int_id, postfix)
!
      integer(kind = kint), intent(in) :: int_id
      character(len=kchara), intent(in) :: dir, postfix
!
!
      write(set_rayleigh99_file_name,1000)                              &
     &                        trim(dir), int_id, trim(postfix)
 1000 format(a, '/', i8.8, '_', a)
!
      end function set_rayleigh99_file_name
!
!-----------------------------------------------------------------------
!
      end module rayleigh99_rst_param_IO
