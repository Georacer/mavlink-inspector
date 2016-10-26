# mavlink-inspector
Utilities for MAVLink log inspection

`mavlink-inspector` is a package for processing and analyzing MAVLink logs. Currently, the development efforts are based on the MATLAB framework. Ports to other languages may be adopted in the future, as need arizes.

## Why MATLAB?
Other tools exist for MAVLink log parsing and analysis. Notable examples are:
* the Pymavlink toolbox, in Python
* the MAVExplorer utility of the MAVProxy package, in Python
* Dronekit's LogAnalyzer in C++

On the one hand, I am not adequately familiar with Python to use it for rapid development. On the other hand, C++, while fast, it is simply too cumbersome for code prototyping.
Contrarily, I am fluent in MATLAB and, to be honest, nothing can beat it for churning out working algorithms quickly.

## Workflow
The basis of the workflow is the transcript of a `.bin` or `.tlog` log file, which usually has a `.log` ending. This is a simple `.csv` file.
Each flight log is given a separate folder under the `logs` directory.

This is then parsed to produce the `.mat` data file, containing the message type arrays and other helper variables.

### How about Mission Planner's "convert to .mat"?
Mission Planner has a utility to conver a `.bin` file to a `.mat` file, but sadly it does not carry string fields over. Instead, the messages containing strings (such as MSG) are converted to `double` arrays with the strings replaced with 0.

Afterwords, the message arrays are parsed to extract information and statistics. The data is not processed in one pass. Instead separate functions go over the data separately.

At the time, Pymavlink and Dronekit test functions are ported in and after that new tests will be added.

## Instructions for Use
TBA

## Licence
The `mavlink-inspector` software project, which is a MAVLink log parser and processor, uses the [GPLv3 license](http://choosealicense.com/licenses/gpl-3.0/).