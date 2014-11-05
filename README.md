Author does not hold any liability whatsoever for hair torn while reading, running or editing consequent script.

--GITHUB REPO: 
https://github.com/plasidu/phoenix4iraf  (Some sample output and input files are included)

--INTENDED USE: 
Script is intented for processing variable object(s) observations and it is meant to be extension of IRAF. Script takes the observed magnitudes and plot them agains time, which is given as heliocentric julian date in output graphs.

--DEPENDENCIES: 
Script requires installed vi(m), gnuplot, bash(-like environment with cat, wget and grep), python3 with numpy, jdcal and extra library from python2.7 (not requred for script itself) astrolibpy (https://code.google.com/p/astrolibpy/source/browse/astrolib/?r=b90f64233933fbe9392cc0e3c3ccaa6edf86696e) forked amateurishly into python3 version availible in github repo, and get_date.py in script's directory. In order to get objects coordinates fromSIMBAD database the computer has to be connected to internet. If this dependency is not met, user will be asked to enter the coordinates.

--INSTALLATION:
Install numpy and jdcal with pip or easy_install into python3 (sudo python3 -m easy_install jdcal).
Download phoenix4iraf.tar.gz from github.
Extract phoenix4iraf.tar.gz with tar -xzf phoenix4iraf.gz.tar. This creates working directory phoenix4iraf.
Cd into phoenix4iraf and make install and starting script executable with chmod 744 install start.
Then use sudo ./install .
That copies astrolibpy into python3 libraries directory at /usr/lib/python3/dist-packages/. WARNING: if your puthon3 is instaled elsewhere, copy astrolibpy into its libraries directory manualy and edit third line of ../astrolibpy/astrolib/helcorr.py so that it matches its current directory. Install then creates link into script's working directory (ln -s /usr/lib/python3/dist-package/astrolibpy/astrolib/helcorr.py . ). 

--INPUT: 
Input file should be in format "HH:MM:SS  MAG  ID", which is default for IRAF's "pdump files*mag* "otime, mag, id"", time is UT. One comparison object (C) and at least one check object (K) are required in data.

--STARTING THE SCRIPT: 
If all dependencies are met, run ./start . Optionaly, input file may be copied or linked to script's working directory. In the script itself, user input may be disabeled and variables may be set manualy. After running the script, files output.dat, plot_output.gp and various amount of .png graphs should be generated, as well as tmp directory, which is used for storing simbad output and is deleted in the process. Output.dat also include heliocentic correction in minutes.


--KNOWN BUGS: 
Data including midnight of from 29 Feb to 1 Mar will generate date 30 Feb instead.



2014 November 5, Yunnan observatory, plasidu at email dot cz
