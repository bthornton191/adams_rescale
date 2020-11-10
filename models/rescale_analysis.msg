
-------------------------------------------------------------------------------
|        ..          ..                                                       |
|       ####*.      ####.                                                     |
|         `###*.       `#.              MSC Software                          |
|            `###.       #.             ------------                          |
|               `##.     ##                                                   |
|                 `##.   ##                                                   |
|                   `## ##'             A d a m s   C++   S o l v e r         |
|                     ####              Build:   2020.1.0-CL748966            |
|                     ###.              Version: Adams 2020 FP1               |
|                    ###`#.                                                   |
|                  .###  `#                                                   |
|                 ####    `#                                                  |
|                ####      #.                                                 |
|              #####       `#           http://www.mscsoftware.com            |
|            .#####                                                           |
|           #####'                                                            |
|           ####                                                              |
|                                                                             |
|    *********************************************************************    |
|    *                                                                   *    |
|    *                      MSC Software Corporation                     *    |
|    *                                                                   *    |
|    *                             A d a m s                             *    |
|    *                                                                   *    |
|    *          Automatic Dynamic Analysis of Mechanical Systems         *    |
|    *                                                                   *    |
|    *********************************************************************    |
|    *                                                                   *    |
|    *                         LEGAL INFORMATION                         *    |
|    *                                                                   *    |
|    *  Warning:  This computer  program is protected  by copyright law  *    |
|    *  and  international  treaties.    Unauthorized  reproduction  or  *    |
|    *  distribution  of this  computer program, or any  portion of it,  *    |
|    *  may result in severe civil and criminal penalties.               *    |
|    *                                                                   *    |
|    *  Copyright (C) 2020 MSC Software Corporation and  its licensors.  *    |
|    *                        All rights reserved.                       *    |
|    *                                                                   *    |
|    *********************************************************************    |
|                                                                             |
|-----------------------------------------------------------------------------|
|                                                                             |
|    *********************************************************************    |
|    *                                                                   *    |
|    *   Local Time: 2020-10-31 11:19:27                                 *    |
|    *    Host Name: L010582-2                                           *    |
|    *        Uname: MS Windows NT                                       *    |
|    *      OS Info: 6.2                                                 *    |
|    *         User: bthornt                                             *    |
|    *  Customer ID: 9a3c7a00-G38D4D97                                   *    |
|    *  Current dir: (See below)                                         *    |
|    *   Process ID: 37388                                               *    |
|    *                                                                   *    |
|    *********************************************************************    |
|                                                                             |
-------------------------------------------------------------------------------

 Current dir:
    C:\Users\bthornt\OneDrive - Hexagon\Projects\rescale_testing\test_model

 command: FILE/COMMAND=rescale_analysis.acf
 command: 
 command: file/model=rescale_analysis

-------------------------------------------------------------------------------
|                                 Model Title                                 |
|=============================================================================|
|                                                                             |
|                   Adams View model name: rescale_analysis                   |
|                                                                             |
-------------------------------------------------------------------------------

 command: ! Insert ACF commands here:
 command: SIMULATE/STATIC


  Begin Static Solution


 STATICS: Original static solver will be used with the Sparse linear solver.

  Static Solution converged in 7 iterations
  Residual imbalance is less than 0.00000E+00

  End Static Solution
 command: SIMULATE/DYNAMIC, END=5.0, DTOUT=1.0E-02


  Begin Simulation

  ****** Performing Dynamic Simulation using Gstiff I3 Integrator ******
   The system is modelled with INDEX-3 DAEs.
   The integrator is GSTIFF, CORRECTOR = original
   Integration error =    1.000000E-03

   Simulation      Step        Function    Cumulative   Integration     CPU
      Time         Size       Evaluations  Steps Taken    Order        time
   ___________  ___________   ___________  ___________   _________    ________
   0.00000E+00  5.00000E-04            0            0       1            0.00 
   5.00000E-01  1.00000E-02           55           55       1            0.00 
   1.00000E+00  1.00000E-02          105          105       1            0.03 
   1.50000E+00  1.00000E-02          155          155       1            0.03 
   2.00000E+00  1.00000E-02          205          205       1            0.06 
   2.50000E+00  1.00000E-02          255          255       1            0.06 
   3.00000E+00  1.00000E-02          305          305       1            0.09 
   3.50000E+00  1.00000E-02          355          355       1            0.09 
   4.00000E+00  1.00000E-02          405          405       1            0.13 
   4.50000E+00  1.00000E-02          455          455       1            0.13 
   5.00000E+00  1.00000E-02          505          505       1            0.14 

  End Simulation
 command: stop


Finished -----
Elapsed time = 0.11s,  CPU time = 0.14s,  126.69%

