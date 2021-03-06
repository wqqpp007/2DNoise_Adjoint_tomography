c this is <time_sub.f> (extracted from ../libtime.f)
c automatically generated by "SPLITF.PL   V1.0   SPLIT Fortran source code"
c----------------------------------------------------------------------
c
c Copyright 2000 by Thomas Forbriger (IfG Stuttgart)
c
c ----
c libtime is free software; you can redistribute it and/or modify
c it under the terms of the GNU General Public License as published by
c the Free Software Foundation; either version 2 of the License, or
c (at your option) any later version. 
c 
c This program is distributed in the hope that it will be useful,
c but WITHOUT ANY WARRANTY; without even the implied warranty of
c MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
c GNU General Public License for more details.
c 
c You should have received a copy of the GNU General Public License
c along with this program; if not, write to the Free Software
c Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
c ----
c
c  calculate difference between time records
c
c REVISIONS and CHANGES
c    05/08/2000   V2.0   Thomas Forbriger
c
c ============================================================================
cS
      subroutine time_sub(date1, date2, date3)
c
c date3=abs(date1-date2)
c 
c This routine will only return the absolute value of the result.
c We do not handle signs. Therefore in any case the smaller time
c value will be subtracted from the larger one.
c
c relative - relative -> relative   case 1
c absolute - relative -> absolute   case 2
c absolute - absolute -> relative   case 3
c
c NOTICE: This version of time_sub disregards leap-seconds!
c
c input:
c   date1:  date record
c   date2:  date record
c output:
c   date3:  fully qualified and regularized absolute difference between
c           input date values (maybe r�lative or absolute - see above)
c
c last change: V2.00 (05/08/2000)
c
      integer date1(7), date2(7), date3(7)
cE
      integer i, larger(7), smaller(7), case, time_compare
      logical time_isleapyear
c
      call time_norm(date1)
      call time_norm(date2)
c find out case and set larger and smaller
      if ((date1(1).eq.0).or.(date2(1).eq.0)) then
        if (date1(1).eq.date2(1)) then
          case=1
        else
          case=2
          if (date1(1).eq.0) then
            call time_copy(date2, larger)
            call time_copy(date1, smaller)
          else
            call time_copy(date1, larger)
            call time_copy(date2, smaller)
          endif
        endif
      else
        case=3
      endif
c 
      if (case.ne.2) then
        if (time_compare(date1, date2).gt.0) then
          call time_copy(date1, larger)
          call time_copy(date2, smaller)
        else
          call time_copy(date2, larger)
          call time_copy(date1, smaller)
        endif
      endif
c handle year boundaries of absolute times
      if (case.eq.3) then
    1   if (larger(1).eq.smaller(1)) goto 2        
          larger(1)=larger(1)-1
          larger(2)=larger(2)+365
          if (time_isleapyear(larger(1))) larger(2)=larger(2)+1
          goto 1
    2   continue
      endif
c build difference
      do i=1,7
        date3(i)=larger(i)-smaller(i)
      enddo
      call time_norm(date3)
      return
      end
c
c ----- END OF <time_sub.f> -----
