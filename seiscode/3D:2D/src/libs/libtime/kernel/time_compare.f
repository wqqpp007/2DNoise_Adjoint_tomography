c this is <time_compare.f> (extracted from ../libtime.f)
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
c compare two time records
c
c REVISIONS and CHANGES
c    05/08/2000   V1.0   Thomas Forbriger
c                 V2.0   call language specific warning wrapper
c
c ============================================================================
cS
      integer function time_compare(date1, date2)
c
c Compare values of date1 and date2. 
c Both must be absolute or both must be relative.
c
c result = 0   for   date1 = date2
c result = -1  for   date1 < date2
c result = 1   for   date1 > date2
c
c input:
c   date1:  primary time record
c   date2:  secondary time record
c
c last change: V2.00 (05/08/2000)
c
      integer date1(7), date2(7)
cE
      integer result, i
c 
      if (((date1(1).eq.0).and.(date2(1).eq.0)).or.
     &    ((date1(1).ne.0).and.(date2(1).ne.0))) then
        result=0
        i=1
    1   if (date1(i).gt.date2(i)) then
          result=1
        elseif (date1(i).lt.date2(i)) then
          result=-1
        else
          i=i+1
          if (i.lt.8) goto 1
        endif
      else
        call time_util_warning('time_compare',
     &                         'do not mix absolute and relative times')
        call time_util_warning('time_compare',
     &                         'routine skipped... (result=-2)')
        result=-2
      endif
      time_compare=result
      return
      end
c
c ----- END OF <time_compare.f> -----
