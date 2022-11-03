!INCITE_checkpoint_converter.f90
!
!-----------------------------------------------------------------------
      module getarg_fortran
      implicit none
!
!-----------------------------------------------------------------------
      contains
!-----------------------------------------------------------------------
      subroutine getarg_k(i, argc)
!
      integer, intent(in) :: i
      character(len=*), intent(out) :: argc
!
      call getarg(0, argc)
      if(argc == "") then
        call getarg(i + 1, argc)
      else
        call getarg(i, argc)
      end if
      end subroutine getarg_k
!   --------------------------------------------------------------------
      integer function iargc_kemo() result(oresult)
!
      integer :: iargc
      character(len=8) :: argc
      oresult = iargc()
      call getarg(0, argc)
      if(argc == "") then
        oresult = oresult - 1
      end if
      end function iargc_kemo
!   --------------------------------------------------------------------
!
      end module getarg_fortran
!
!-----------------------------------------------------------------------
!
      program INCITE_checkpoint_converter
!
      use m_precision
      use t_rayleigh_restart_IO
      use rayleigh99_rst_param_IO
      use getarg_fortran
!
      implicit none
!
!>      Directory name for INCITE Checkpoint files
      character(len = kchara) :: read_dir
!>      Top directory name for converted Checkpoint files
      character(len = kchara) :: write_top
!>      Start step to convert
      integer(kind = kint) :: istart
!>      End step to convert
      integer(kind = kint) :: iend
!
      character(len = kchara) :: textbuf
      integer(kind = kint) :: icount
      integer(kind = kint) :: i_step
!
      type(rayleigh_restart), save :: ra_rst1
!
      icount = iargc_kemo()
      if(icount .ne. 4) then
        write(*,*)                                                      &
     &  'convert_checkpoint INCITE_CHECKPOINT_DIS NEW_CHECKPOINT_DIR',  &
     &  ' START_STEP  END_STEP'
        stop
      end if
!
      call getarg_k(1, textbuf)
      write(read_dir,'(a)') trim(textbuf)
      call getarg_k(2, textbuf)
      write(write_top,'(a)') trim(textbuf)
      call getarg_k(3, textbuf)
      read(textbuf,*) istart
      call getarg_k(4, textbuf)
      read(textbuf,*) iend
!
      write(*,*) 'Directory for INCITE checkpoint data: ',              &
    &           trim(read_dir)
      write(*,*) 'Directory for converted checkpoint data: ',           &
    &           trim(write_top)
      write(*,*) 'start and end steps: ', istart, iend
!
      call cmkdir_f(write_top)
      do i_step = istart, iend
        call convert_checkpoint_set(read_dir, write_top,                &
     &                              i_step, ra_rst1)
      end do
!
!   --------------------------------------------------------------------
!
      end program INCITE_checkpoint_converter
