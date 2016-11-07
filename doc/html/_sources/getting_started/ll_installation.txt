Installation
============

Like any other ROS set of packages, last_letter and its companion library packages uav_utils and math_utils require the `Robotics Operating System <http://www.ros.org/>`_ to be present on your system.
If you have previous experience with ROS, installation is as simple as cloning the package files in your workspace.
If you are a ROS novice, the following instructions will try to guide you through the process.

ROS version restrictions
------------------------

Currently, last_letter is developed under ROS Indigo version. It is not guaranteed that it runs smoothly or at all on any other ROS version.

Operating system restrictions
-----------------------------

Since ROS Indigo is compatible only with Ubuntu 13.10 and 14.04, you need an Ubuntu Linux machine running one of those Ubuntu versions. It is recommended that you use Ubuntu 14.04, since this is the platform where this package is developed right now.

ROS installation
----------------
Follow the `instructions on the ROS website <http://wiki.ros.org/indigo/Installation/Ubuntu>`_ to install ROS Indigo in your machine.

Catkin workspace creation
-------------------------

Afterwards, you need to create a ROS Workspace. This is the directory where custom software packages (which are not part of the official ROS repository) are created, copied or edited and this is where the ROS compiler (called ``catkin`` after ROS version Groovy) looks for your code.
Follow `these instructions <http://wiki.ros.org/ROS/Tutorials/InstallingandConfiguringROSEnvironment#Create_a_ROS_Workspace>`_ to create your workspace. They instruct you to create your workspace under your home folder, but it can also be created elsewhere. Just be sure you have full rights to this folder, so a subfolder in your home folder is a good choice.
Make sure ``$ROS_PACKAGE_PATH`` sees your ``catkin_ws/src`` folder.

.. note::

	You probably don't want to source your workspace path every time you open a new console. To avoid this, add the following line to your ``/home/<username>/.bashrc`` file, assuming that you create your catkin workspace directly under your home folder.

	.. code-block:: bash

		source ~/catkin_ws/devel/setup.bash

Cloning the last_letter simulator files
---------------------------------------

Execute the following commands in your console:

.. code-block:: bash

	roscd
	cd ../src #Navigate in your ROS user source files directory
	git clone https://github.com/Georacer/last_letter.git #Clone the simulator files
	roscd
	cd .. #Navigate in your ROS workspace
	catkin_make #Compile the files

Compilation may take a while.

Installing dependencies
-----------------------

last_letter requires various ROS packages to work properly. You should install them using the `rosdep` utility, typing

.. code-block:: bash

	rosdep update
	rosdep install --from-paths /path/to/catkin/ws/src/last_letter --ignore-src

*thanks `gvdhoorn! <http://answers.ros.org/question/205557/dependencies-on-user_packages/>`_

Testing everything is installed properly
----------------------------------------

In a console, run:

.. code-block:: bash

	roslaunch last_letter launcher.launch

This should start the simulator and open a 3D simulation environment using an application called RViz.
``rqt_gui`` application will start as well, where the avionics instruments are displayed.

If everything went smoothly, you can close everything and proceed to the instruction manual to learn how to use the last_letter simulator.
