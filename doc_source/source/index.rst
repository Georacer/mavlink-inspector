.. mavlink-inspector documentation master file, created by
   sphinx-quickstart on Wed Sep 16 16:56:01 2015.
   You can adapt this file completely to your liking, but it should at least
   contain the root ``toctree`` directive.

=================================================
Welcome to the documentation of mavlink-inspector
=================================================
Utilities for MAVLink log inspection
====================================

`mavlink-inspector` is a package for processing and analyzing MAVLink logs as well as ArduPilot DataFlash logs. Currently, the development efforts are based on the MATLAB framework. Ports to other languages may be adopted in the future, as need arizes.
Developoment efforts are targeted around the ArduPlane firmware. ArduCopter and ArduRover are not supported.

Why Use MATLAB?
===============
Other tools exist for MAVLink log parsing and analysis. Notable examples are:
 * the ArduPilot LogAnalyzer toolbox, for DataFlash logs, in Python
 * the MAVExplorer utility of the MAVProxy package, in Python
 * Dronekit's LogAnalyzer (Dronekit-LA), for MAVLink and DataFlash logs, in C++

On the one hand, I am not adequately familiar with Python to use it for rapid development. On the other hand, C++, while fast, it is simply too cumbersome for code prototyping.
Contrarily, I am fluent in MATLAB and, to be honest, nothing can beat it for churning out working algorithms quickly.

Workflow
========
The basis of the workflow is the transcript of a `.bin` or `.tlog` log file, which usually has a `.log` ending. This is a simple `.csv` file.
Each flight log is given a separate folder under the `logs` directory.

This is then parsed to produce the `.mat` data file, containing the message arrays and other helper variables.

The `.mat` file is finally loaded into the workspace and its contents are parsed by the various test functions.

.. note::

    | **How about Mission Planner's "convert to .mat"?**
    | Mission Planner has a utility to conver a `.bin` file to a `.mat` file, but sadly it does not carry string fields over. Instead, the messages containing strings (such as MSG) are converted to `double` arrays with the strings replaced with 0.

Afterwords, the message arrays are parsed to extract information and statistics. The data is not processed in one pass. Instead separate functions go over the data separately.

A Quick Example
===============

You can find instructions for running the ArduPilot's LogAnalyzer tests on an example dataset in the `Examples <examples/index.html>`_ section.

Current Progress
================
Log types
---------
Initially, only ArduPlane DataFlash logs (`.bin`) will be supported. MAVLink logs (`.tlog`) support will follow.

Available tests
---------------
At the time, ArduPilot's LogAnalyzer test functions are ported in.
Afterwards, Dronekit-LA will be ported and after that new tests will be developed.

Requirements
============

In order to utilize `mavlink-inspector` you need both Windows and Linux environments, and the following software:

- `Mission Planner <http://ardupilot.org/planner/docs/mission-planner-overview.html>`_, available on Windows.
- A **Linux** MATLAB installation
- Git installed in your Linux environment

Instructions for Use
====================
TBA

Licence
=======
The `mavlink-inspector` software project, which is a MAVLink log parser and processor, uses the `GPLv3 license <http://choosealicense.com/licenses/gpl-3.0/>`_.

.. toctree::
	:hidden:

	examples/index
	contributors

