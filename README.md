Author does not hold any liability whatsoever for hair torn while reading, running or editing consequent script.

--GITHUB REPO--
https://github.com/plasidu/phoenix4iraf  (Some sample output files are included)

--INTENDED USE--
Script is intented for processing variable object(s) observations and it is meant to be extension of IRAF. Script takes the observed magnitudes and plot them agains time, which is given as heliocentric julian date in output graphs.

--DEPENDENCIES--
Script requires installed vi(m), gnuplot, bash(-like environment), python3 with numpy, jdcal and extra library from python2.7 (not requred for script itself) astrolibpy (https://code.google.com/p/astrolibpy/source/browse/astrolib/?r=b90f64233933fbe9392cc0e3c3ccaa6edf86696e) forked amateurishly into python3 version availible in github repo, and get_date.py in script's directory.

--INSTALLATION--
Copy astrolibpy (from github) into python3 libraries directory, usualy /usr/lib/python3/dist-packages/ or such and edit third line of ../astrolibpy/astrolib/helcorr.py so that it matches its current directory. Then create link into script's working directory, for example ln -s /usr/lib/python3/dist-package/astrolibpy/astrolib/helcorr.py ~/programs/phoenix4iraf/ . Then install numpy and jdcal with pip or easy_install into python3. 

--INPUT--
Input file should be in format "HH:MM:SS  MAG  ID", which is default for IRAF's "pdump files*mag* "otime, mag, id"", time is UT. One comparison object (C) and at least one check object (K) are required in data.

--STARTING THE SCRIPT--
If all dependencies are met, place input data (or link) in script's directory and run ./start . Files output.dat, plot_output.gp and various amount of .png graphs should be generated. Output.dat also include heliocentic correction in minutes.


--KNOWN BUGS--
Data including midnight of from 29 Feb to 1 Mar will generate date 30 Feb instead.



2014 November 5, Yunnan observatory, plasidu@github.com
