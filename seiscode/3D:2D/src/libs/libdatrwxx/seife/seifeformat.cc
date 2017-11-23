/*! \file seifeformat.cc
 * \brief seife format specific structures (implementation)
 * 
 * ----------------------------------------------------------------------------
 * 
 * \author Thomas Forbriger
 * \date 30/11/2010
 * 
 * seife format specific structures (implementation)
 * 
 * Copyright (c) 2010 by Thomas Forbriger (BFO Schiltach) 
 *
 * ----
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version. 
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
 * ----
 * 
 * REVISIONS and CHANGES 
 *  - 30/11/2010   V1.0   Thomas Forbriger
 * 
 * ============================================================================
 */
#define DATRW_SEIFEFORMAT_CC_VERSION \
  "DATRW_SEIFEFORMAT_CC   V1.0   "

#include <datrwxx/seife.h>

namespace datrw {

  /*! \brief all the stuff to read and write seife data
   *
   * \defgroup group_seife I/O module for seife data
   *
   * \sa \ref page_seife_format
   */

  /*! \brief Format properties
   * \ingroup group_seife
   * @{
   */
  const bool seife::isbinary=false;
  const char* const seife::streamID="seife";
  /**@}*/

} // namespace datrw
  
/*======================================================================*/

  /*! \page page_seife_format Definition of the seife format
   *
   * This format is defined by E. Wielandt for his time series analysis
   * programs.
   * You can find a copy of the source code at
   * http://www.software-for-seismometry.de
   *
   * \section sec_seife_formatdefinition The format description taken from seife.doc
   *
   * This format was defined prior to most other presently used data formats,
   * and I am still adhering to it although it is now obsolete. The structure
   * of the data files is as follows:
   *
   * - one header line, arbitrary (will be echoed but not evaluated) 
   * - up to 48 comment or protocol lines marked with a  % character in the
   *   first column. Protocol lines are automatically generated by SEIFE
   *   unless seife.par contains the code ‘ncl’ (no comment lines).
   * - one line containing the number of samples, the FORTRAN format in which
   *   they are listed, the sampling interval, and an optional time stamp as
   *   described below.
   * - data in the specified format (here 5f10.3, that is, five entries like
   *   123456.789 per line).
   *
   * The entries in the last header line (which is the second line if there
   * are no comments)  must be in the FORTRAN format (i10,a20,f10.x). It may
   * contain a time stamp, in which case the format is (i10,a20,3f10.x). The
   * time stamp consists of two numbers: minutes and seconds after midnight.
   * No date can be encoded, except by expressing it in minutes. The whole
   * line might read:         
   *
   * \code
   * 12000     (5f10.3)            0.01      617.      23.45
   * \endcode
   * The strings begin at positions 1, 11, 31, 41, 51. The time of the first
   * sample is 10:17:23.45.
   *
   * The SEIFE format applies only to files read with the ‘fil infile outfile’
   * command line, and to the output files. Other ASCII data formats can be
   * read with the asc, asl, bdf and mar commands; seife, gnuplot, and
   * headerless single-column ASCII formats can be specified for the output.
   * Miniseed files can be converted into ASL format with Quanterra’s CIMARRON
   * software, and then read with SEIFE. A converter from GSE to ASCII format
   * named CODECO written by Urs Kradolfer is also available. I am offering a
   * WINDOWS executable of this program.
   *
   * \section sec_seife_format_libdatrwxx Specific format supported by this library
   *
   * Since we do not provide a full featured Fortran format parser, we limit
   * the supported data format to an arbitrary sequence of floating point
   * numbers separated by whitespace. This is any sequence, which can be read
   * sequentially by the C++ input streams. If your data has no whitespace
   * separating individual values (which is possible with fixed formats in
   * Fortran), you should use the Fortran seife.f program itself to convert
   * the data.
   *
   * The appropriate data format for output is
   * \code
   * 50 format (6(g12.5,1x))
   * \endcode
   * This produces
   * \code
 0.84147E+34  0.90930E+34  0.14112E+34 -0.75680E+34 -0.95892E+34 -0.27942E+34
 0.65699E+34  0.98936E+34  0.41212E+34 -0.54402E+34 -0.99999E+34 -0.53657E+34
 0.42017E+34  0.99061E+34  0.65029E+34 -0.28790E+34 -0.96140E+34 -0.75099E+34
 0.14988E+34  0.91295E+34
   * \endcode
   *
   * Similar output is produced by
   * \code
  int j=0;
  for (int i=0;i<30;++i)
  {
    cout << setprecision(6) << setw(12);
    cout << 1.e34*std::sin(i) << " ";
    ++j;
    if (j==5)
    {
      j=0;
      cout << endl;
    }
  }
  j=0;
  for (int i=0;i<30;++i)
  {
   cout.setf(ios::scientific,ios::floatfield);
    cout << setprecision(5) << setw(12);
    cout << 0.4*std::sin(i) << " ";
    ++j;
    if (j==5)
    {
      j=0;
      cout << endl;
    }
  }
   * \endcode
   *
   * namely:
   * \code 
           0  8.41471e+33  9.09297e+33   1.4112e+33 -7.56802e+33 
-9.58924e+33 -2.79415e+33  6.56987e+33  9.89358e+33  4.12118e+33 
-5.44021e+33  -9.9999e+33 -5.36573e+33  4.20167e+33  9.90607e+33 
 6.50288e+33 -2.87903e+33 -9.61397e+33 -7.50987e+33  1.49877e+33 
 9.12945e+33  8.36656e+33 -8.85131e+31  -8.4622e+33 -9.05578e+33 
-1.32352e+33  7.62558e+33  9.56376e+33  2.70906e+33 -6.63634e+33 
 0.00000e+00  3.36588e-01  3.63719e-01  5.64480e-02 -3.02721e-01 
-3.83570e-01 -1.11766e-01  2.62795e-01  3.95743e-01  1.64847e-01 
-2.17608e-01 -3.99996e-01 -2.14629e-01  1.68067e-01  3.96243e-01 
 2.60115e-01 -1.15161e-01 -3.84559e-01 -3.00395e-01  5.99509e-02 
 3.65178e-01  3.34662e-01 -3.54052e-03 -3.38488e-01 -3.62231e-01 
-5.29407e-02  3.05023e-01  3.82550e-01  1.08362e-01 -2.65454e-01 
   * \endcode
   *
   */

/* ----- END OF seifeformat.cc ----- */
