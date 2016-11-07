Updating the last_letter software
-----------------------------------

last_letter is in continuous development and it is recommended that you check back often for updates in bug fixes and new features at https://github.com/Georacer/last_letter/commits/master.

In order to update your local last_letter code repository switch to the corresponding Github repo directory:

.. code-block:: bash

	roscd last_letter
	cd ..

Afterwards, perform a pull from the ``master`` branch:

.. code-block:: bash

	git pull origin master

It is recommended that you use the ``master`` branch, since this is the most stable software version.

Finally, compile the updated code at the catkin root directory:

.. code-block:: bash

	roscd
	cd ..
	catkin_make

Your updated last_letter version is ready to run!
