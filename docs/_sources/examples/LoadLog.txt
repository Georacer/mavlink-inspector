================
Load a .log file
================

This example shows you how to load a DataFlash log file into your MATLAB workspace.

You need a binary DataFlash log file (with the `.BIN` extension).

Create a new log directory
==========================

Under the `logs` directory of the `mavlink-inspector` folder, create a new folder for your log. The folder name **must** be a 3 character number, with padded zeros, e.g. 045.

.. note::
    It is advisable that you start your log numbering from a high offset, so that when new logs are added upstream on the `mavlink-inspector` repository, there will be no merge conflicts if you try to pull a newer version.

    The number 501 should be a good starting index for your log folder names.

Place your binary DataFlash log file inside that folder.


Convert the DataFlash log
=========================

Currently, `Mission Planner <http://ardupilot.org/planner/docs/mission-planner-overview.html>`_ is used to convert DataFlash logs into ASCII `.csv` files, which `mavlink-inspector` is able to parse. Mission Planner is free software but is available only on Windows. Even though this is a limiting factor, there currently is no alternative method of log conversion.

Open Mission Planner and navigate to the `DataFlash Logs` tab. Click the `PX4 .Bin to .Log` button and navigate to the location of your log file, inside the `mavlink-inspector` directory tree.

.. figure:: ../figures/loadLogMP1.*

Wait until the conversion is finished. This may take a while, depending on the size of the log file.

.. figure:: ../figures/loadLogMP2.*

The clear-text log file, should have the extension `.log` and be stored alongside your `.BIN` log file.


Import the log to the workspace
===============================

Open MATLAB and navigate to the `mavlink-inspector` directory.

On the MATLAB console, add all the subfolders on the current path, if they are not already added

.. code-block:: matlab

    matlabAddFolders

Use the `log2mat` script to convert the `<logIndex>.log` into MATLAB variables. For this part, let's assume that your log index is 1.

.. code-block:: matlab

    log2mat(1)

A waitbar will appear, tracking the parsing progres. This operation may take several minutes for large logs.

After the conversion is complete, a few variables will have appeared in your workspace:

* `formats`, a cell array containing the DataFlash log protocol definition, as provided at the start of the log file.
* `msgs`, a struct with either cell or numerical array members. Each member will be named after a message type and will contain all the messages of this type that appear in the log, one per line.
* `env`, a struct with members:
    - `logID`, containing the parsed log file index
    - `msgsSeen`, a cell array containing the names of the messages which appeared at least once in the log file

A `.mat` file, containing those variables will also be saved in your log directory automatically.

These 3 files are the core data containers for all the algorithms provided by `mavlink-inspector`.

What you can do from here
=========================
You can now apply the provided checks and algorithms on the newly-created variables. You can follow these tutorials next:

- `ArduPilot's LogAnalyzer tutorial <LogAnalyzer.html>`_
- `Overview checks <overviewChecks.html>`_

Already converted the `.log` file?
==================================
If you have converted the DataFlash `.log` file once and created the corresponding `.mat` file, you don't have to re-parse it the next time you want to work with it.

You can type

.. code-block:: matlab

    open_mat(1)

to load the already saved `.mat` file. This doesn't take more than a few moments to load.

.. note::

    `.gitignore` is set to not track the `.mat` files, because they are very large and potentially changing, overloading the repository Git with very large deltas.