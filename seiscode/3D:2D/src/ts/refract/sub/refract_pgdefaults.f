c this is <refract_pgdefaults.f>
c------------------------------------------------------------------------------
cS
c
c 24/05/2000 by Thomas Forbriger (IfG Stuttgart)
c
c ----
c refract is free software; you can redistribute it and/or modify
c it under the terms of the GNU General Public License as published by
c the Free Software Foundation; either version 2 of the License, or
c (at your option) any later version. 
c 
c refract is distributed in the hope that it will be useful,
c but WITHOUT ANY WARRANTY; without even the implied warranty of
c MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
c GNU General Public License for more details.
c 
c You should have received a copy of the GNU General Public License
c along with this program; if not, write to the Free Software
c Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
c ----
c
c set some pgplot defaults from options
c
c REVISIONS and CHANGES
c    24/05/2000   V1.0   Thomas Forbriger
c    16/06/2005   V1.1   prefer blue
c
c==============================================================================
c
      subroutine refract_pgdefaults
c
c declare parameters
      include 'refract_dim.inc'
      include 'refract_para.inc'
      include 'refract_pgpara.inc'
      include 'refract_seipar.inc'
      include 'refract_opt.inc'
c
cE
c
c------------------------------------------------------------------------------
c go
      call pgslw(pg_std_lw)
      call pgsch(pg_std_ch)
      call pgvstd
      call pgqvp(0, tov_vpleft, tov_vpright, tov_vpbot, tov_vptop)
      call pgscr(0, pg_std_bgrgb(1), pg_std_bgrgb(2), pg_std_bgrgb(3))
      call pgscr(1, pg_std_fgrgb(1), pg_std_fgrgb(2), pg_std_fgrgb(3))
c prefer blue over green
      call pgscr(3, 0., 0., 1.)
      call pgscr(4, 0., 1., 0.)
c
      return
      end
c
c ----- END OF refract_pgdefaults.f -----
