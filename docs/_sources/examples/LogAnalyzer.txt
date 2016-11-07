===========================
Use the Log Analyzer checks
===========================

`Log Analyzer <https://github.com/ArduPilot/ardupilot/tree/master/Tools/LogAnalyzer>`_ is a Python toolbox, part of the ArduPilot project, used to parse and perform rudimentary tests on DataFlash log files, primarily for ArduCopter logs.

The tests relevant to the AruPlane logs have been ported in `mavlink-inspector` and can be invoked from within it.

Invoking the test vector
========================
On your MATLAB terminal, type

.. code-block:: matlab

	generateReport('log-analyzer-all',msgs,formats,env)

After the script returns, a cleartext report `.txt` file with the name `report_log-analyzer-all.txt` will have been created alongside your DataFlash log. Open it to read the test results.

An example output is

.. code-block:: text

	TestBrownout: Test for a log that has been truncated in flight - Ported from ArduPilot LogAnalyzer
	No brownout detected | Warning: This check is discouraged - barometer drift may affect results

	TestEmpty: Test for empty or near-empty logs - Ported from ArduPilot LogAnalyzer
	PASSED: Throttle maximum value is 75

	TestGPSGlitch: Test for GPS glitch reporting or bad GPS data (satellite count, hdop) - Ported from ArduPilot LogAnalyzer
	PASSED: Min Satellites: 7 | Max HDop: 1.06

	TestVCC: Test for VCC within recommendations, or abrupt end to log in flight - Ported from ArduPilot LogAnalyzer
	PASSED: Vcc is within bounds

	TestCompass: Test for compass offsets and throttle interference - Ported from ArduPilot LogAnalyzer
	FAILED: | Measured magnetic field out of bounds

	TestDupeLogData: Test for duplicated data in log, which has been happening on PX4/Pixhawk - Ported from ArduPilot LogAnalyzer
	FAILED: Duplicate data found in the log

	TestIMUMatch: Test compatibility between IMU1 and IMU2 - Ported from ArduPilot LogAnalyzer
	PASSED: Mismatch: 0.468257, WARN: 0.75, FAIL: 1.5



A few more words on the tests
=============================

`log-analyzer-all` is a test profile name, passed to the `profiles` script, which is tasked to create a predefined set of tests (in this case, all the tests ported from LogAnalyzer). Each test is an object of a specialized test class.

Each test is passed the `msgs` variable, containing all the messages extraced from the log, the `formats` variable, containing the message definitions and the `env` variable, containing auxiliary data.

The input variables are parsed separately by each test, each time the test method `test` is invoked.

The test result is stored inside the test property (member) `result`.

The test result can be printed by invoking the `printResult` method.