# mavlink-inspector
Utilities for MAVLink and ArduPilot DataFlash log inspection

`mavlink-inspector` is a package for processing and analyzing MAVLink logs as well as ArduPilot DataFlash logs. Currently, the development efforts are based on the MATLAB framework. Ports to other languages may be adopted in the future, as need arizes.
Developoment efforts are targeted around the ArduPlane firmware. ArduCopter and ArduRover are not supported.

## Why MATLAB?
Other tools exist for MAVLink and ArduPilot DataFlash log parsing and analysis. Notable examples are:
* the ArduPilot LogAnalyzer toolbox, for DataFlash logs, in Python
* the MAVExplorer utility of the MAVProxy package, in Python
* Dronekit's LogAnalyzer (Dronekit-LA), for MAVLink and DataFlash logs, in C++

On the one hand, I am not adequately familiar with Python to use it for rapid development. On the other hand, C++, while fast, it is simply too cumbersome for code prototyping.
Contrarily, I am fluent in MATLAB and, to be honest, nothing can beat it for churning out working algorithms quickly.

## Workflow
The basis of the workflow is the transcript of a `.bin` or `.tlog` log file, which usually has a `.log` ending. This is a simple `.csv` file.
Each flight log is given a separate folder under the `logs` directory.

This is then parsed to produce the `.mat` data file, containing the message arrays and other helper variables.

The `.mat` file is finally loaded into the workspace and its contents are parsed by the various test functions.

### How about Mission Planner's "convert to .mat"?
Mission Planner has a utility to conver a `.bin` file to a `.mat` file, but sadly it does not carry string fields over. Instead, the messages containing strings (such as MSG) are converted to `double` arrays with the strings replaced with 0.

Afterwords, the message arrays are parsed to extract information and statistics. The data is not processed in one pass. Instead separate functions go over the data separately.

## Current Progress
### Log types
Initially, only ArduPlane DataFlash logs (`.bin`) will be supported. MAVLink logs (`.tlog`) support will follow.
### Available tests
At the time, Pymavlink LogAnalyzer test functions are ported in.
Afterwards, Dronekit-LA will be ported and after that new tests will be developed.

## Instructions for Use
TBA

## Licence
The `mavlink-inspector` software project, which is a UAV flight log parser and processor, uses the [GPLv3 license](http://choosealicense.com/licenses/gpl-3.0/).