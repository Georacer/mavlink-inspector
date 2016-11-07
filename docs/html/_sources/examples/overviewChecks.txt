===========================
Use the Overview checks
===========================

These overview tests report on statistics and properties of the log file. Related data include:

- the name of the log
- the date it was checked
- the date it was recorded
- the file size
- the flight duration
- the firmware properties
- the number of different messages that were observed

Additionally, for this example, another two checks are put on the top of the check list:

- the current `mavlink-inspector` git hash
- whether the parsed `.mat` file is generated with the latest version of the `log2mat` script

Invoking the test vector
========================
On your MATLAB terminal, type

.. code-block:: matlab

	generateReport('df-all',msgs,formats,env)

After the script returns, a cleartext report `.txt` file with the name `report_df-all.txt` will have been created alongside your DataFlash log. Open it to read the test results.

An example output is

.. code-block:: text

	gitBuild: Short git hash of the current branch
	The git hash of the mavlink-inspector test suite is ecc3ce0bb1572ee10ec1ec831372ac4e43d69f93

	isUpdatedMat: Check if the .mat file is up to date
	The stored .mat file is up-to-date with the current log2mat function.

	logName: Name of the current log
	Examining log 68.BIN

	parseDate: Date when this result was extracted
	Current date and time is 07-Nov-2016 22:32:47 UTC

	logDate: Date when the log was recorded
	The log was recorded on 05-Oct-2016 08:33:08 UTC

	logSize: Name of the current log
	Log file size is 60304 kilobytes

	logDuration: Duration between first and last timestamp
	The duration of the log file, based on CPU timestamps is 1472.45 seconds

	fwStats: Firmware related statistics
	Platform: ArduPlane
	Version: V3.5.2
	Git hash: dc9d87fd

	msgStats: Statistics on parsed messages
	Log contains 47 different message types

A few more words on the tests
=============================

`df-all` is a test profile name, passed to the `profiles` script, which is tasked to create a predefined set of tests (in this case, all the tests ported from LogAnalyzer). Each test is an object of a specialized test class.

Each test is passed the `msgs` variable, containing all the messages extraced from the log, the `formats` variable, containing the message definitions and the `env` variable, containing auxiliary data.

The input variables are parsed separately by each test, each time the test method `test` is invoked.

The test result is stored inside the test property (member) `result`.

The test result can be printed by invoking the `printResult` method.