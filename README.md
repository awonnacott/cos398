# Resources for COS 445 Programming Assignments ("Problem 4")

## History
This repository was created in Spring 2018 for use by Andrew Wonnacott '19.

Cyril Zhang had maintained these assignments in Spring 2017 and the initial commit (`ee0c50a`) had previously been maintained by him.
This contained Prisoner's Dilemma, Ultimatum, Centipede, and Bidder.

## Outline of an assignment
* Code for the simulator, in a base file of a Java class. The 'base file' differs from a normal Java class in that it has specially formatted comments which will be replaced by one line per student later on. Important methods include `runTrial`, which takes a list of student strategies and then performs assignment-specific scoring computations, and the main method which describes what trials to run and how to calculate student grades.
* A student interface which describes the methods required for a student strategy.
* A sample student strategy implementing the interface in order to test compile with the above files.
* A csv file listing all the student strategies which should be included in the simulation, with the first line `netID` and subsequent lines listing strategy names.
* `formatBase.py` turns the base file of the simulator into the full Java class by rewriting it with the list of netIDs provided in the csv file. The resulting Java class can be compiled with the interface and student strategies and will run the simulation.
* `Makefile` puts all of these files together so students do not have to memorize a bunch of commands. Important targets include `all`, which formats the base simulator using the csv file (call to `formatBase`), then compiles the simulator to evaluate these strategies, and `test`, which does the above and then runs the simulator and saves the output to `results.csv`.
* A bash script to use in Dropbox system for Check All Submitted Files. It copies preset files (including a makefile) and the student strategies into the temporary directory used for the Dropbox system, then calls the preset makefile.
* `Makefile_Scripts` which should be placed instead of `Makefile` when setting up the Dropbox system. This will regenerate the strategies list csv file before running the test.
* `csv2html.py` turns the `results.csv` file outputted by the simulator class into an HTML table.
* `Makefile_leaderboard` will draw in all the student submissions from the appropriate Dropbox folder, generate the strategies `csv` file, and compile and run the simulator, then turn the output csv file into an HTML table and place it in the course web page.
* A bash script added to the crontab as the `cos445` user on some `cycles.cs` machine which calls `make` using `Makefile_leaderboard`, to allow the leaderboard to refresh with some frequency.

## How to make a new assignment
* Copy a previous assignment. Ideally, no copying would be necessary and the reusable components would be factored out as abstract classes, parameterized scripts, etc... but I didn't do that yet.
* Rename files appropriately (e.g. renaming Admissions to Elections and Student to Voter) and find-and-replace in the file contents. Use a text editor with case-sensitive find-and-replace and use `grep` to find what you missed.
* Build the new student interface.
* Build the new student sample strategy and put it in the csv file listing strategies.
* Rewrite `runTrial` function in the base file of the Java class to describe how to simulate the given game with the student strategies.
* Distribute to the students:
    * Base file of Java class
    * Interface for strategies
    * Sample strategy
    * Default csv file listing only the sample strategy
    * `formatBase.py`
    * `Makefile`
* Place anywhere on `cycles` and then set up the crontab to run a leaderboard:
    * Base file of Java class
    * Interface of strategies
    * `formatBase.py`
    * `csv2html.py`
    * `Makefile_leaderboard` named `Makefile` and with the appropriate output settings --- make sure you change the output results HTML page between assignments.
    * Submit the sample strategy to the leaderboard through the Dropbox system
    * The leaderboard bash script to be added to the crontab
* Place in `RunScript/Scripts/a$asgnmt` on `cycles` and then enable the Check All Submitted Files button on Dropbox:
    * Base file of Java class
    * Interface of strategies
    * Sample strategy
    * `formatBase.py`
    * `Makefile_Scripts` named `Makefile`
    * The Dropbox bash script to be run
    * Symlink from `RunScript/Scripts/$DROPBOX_ASGNMT_NAME` to the Dropbox bash script in the `Scripts` subfolder.
* Write instructor strategies to compare student performance against.
* Customize the `main` function of the simulator to change simulation parameters or iterate through a variety of simulation parameters, to iterate through instructor strategies and add them each to the simulation using `withExtraTrials` instead of `oneEachTrials` and to compare results between students and instructors and output the grade as a function of those comparisons.
* Use for grading: Exactly what was distributed to students, but with a modified `main` and the instructor strategies manually listed in the `main`. Manually run a command like the one used in `Makefile_leaderboard` to copy in the student strategies from the zip downloaded from the CS Dropbox. This step cannot be automated because you must manually handle non-compiling student submissions when present.

## Current repository contents
1. Admissions/Student simulates stable matching, but with a twist: students can only apply to ten schools. Student strategies were very similar to the sample strategies.
2. Elections/Voter simulates a simple election with three candidates where all voters have preference orderings with the same parity. This was less popular due to the lower depth of strategies.
3. Simulator/Ultimatum simulates the Ultimatum game as in the 2017 problem set 3.
4. Auctioneer/Bidder simulates the Bidder game as in 2017 problem set 5.
