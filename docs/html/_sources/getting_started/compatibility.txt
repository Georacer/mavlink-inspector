Compatibility
=============

ROS version
-----------

This package was originally developed under ROS Hydro. As of March 20, 2014 (commit `<https://github.com/Georacer/last_letter/commit/3e1d32a9c3544fca77fdafe86dd21643f9d37577>`_ ) development has migrated into ROS Indigo and this is the officially supported version.
However, given that the migration from Hydro to Indigo required absolutely no changes in the source files, Hydro installations may very well work.

System requirements
-------------------

Since this is a native ROS Indigo package, there are restrictions in the OS you can install it. See `here <http://wiki.ros.org/indigo/Installation>`_ for the OS's where ROS Indigo can be installed in.

Mainly **Ubuntu Linux** 13.10 and 14.04 are supported by ROS Indigo.

last_letter is being developed and tested under **Ubuntu 14.04 64-bit** on a laptop equipped with
* Intel® Core™ i7-4700MQ CPU @ 2.40GHz × 8
* 24GB RAM
where it runs at a capped rate of 1000Hz

Prior to migration to ROS Indigo, `last_letter` has been tested successfully on:
* An Ubuntu 12.04 64-bit laptop equipped with Intel® Core™ i7-4700MQ CPU @ 2.40GHz × 8 and 24GB RAM
* An Ubuntu 12.04.5 32-bit virtual machine with 2GB RAM and 2CPU cores of an i7-3630qm 2.4GHz running @ 950Hz
* An Ubuntu  12.04 64-bit virtual machine with 2GB RAM and 2CPU cores of an Intel Core i5-3317U CPU @ 1.70GHz running @ 900Hz, **which may be sub-optimal**
* An Ubuntu 12.04 virtual machine running on a Mac laptop and OSX