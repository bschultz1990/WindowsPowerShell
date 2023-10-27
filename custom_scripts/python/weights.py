#!/usr/bin/env python3
"""Fill me with good documentation later."""

import colorful as cf
import glob
import os
# import pathlib
# import re
import shutil

# Global variables
working_dir = ""

# Functions
def get_working_dir():
    """
    Retrieves the working directory from the user and sets it as the global variable `working_dir`.
    """
    global working_dir
    dir_assigned = False
    while dir_assigned == False:
        matching_dirs = glob.glob(input("Enter the path to your working directory: "))

        if not matching_dirs:
            print("Directory does not exist or was mistyped. Double-check your path and try again.")
        
        working_dir = os.path.abspath(matching_dirs[0])
        dir_assigned = True
    
    print("Working directory set to: " + working_dir)


def check_backup_dir():
    """ Creates a backup of all PDF files in the current directory. """

    if not os.path.exists(working_dir + "/backup"):
        print("Creating backup directory.")
        os.mkdir(working_dir + "/backup")


def check_invoices():
    """ 
    Get invoice numbers and check if their
    corresponding files exist in the current directory.
    """
    invoices = []
    print ("Enter a list of invoices: ")
    while True:
        line = input()
        if line == "":
            break
        invoices.append(line)

    for i in invoices:
        print("Checking invoice: " + i, end=" ")

        found_file = glob.glob(working_dir + "/*" + i + "*.pdf")[0]

        if not found_file:
            print(cf.yellow("Not found"))
            print ("One or more invoices were not found. Double-check your files list and try again.")
            return 1

        if found_file:
            print(cf.green("Found!"), end=" ")
            print(cf.green("copying..."), end=" ")
            # print("Copying ", found_file)
            # print(" to ", working_dir + "/" + "backup")
            shutil.copy(found_file, working_dir + "/" + "backup") 
            print(cf.gray(os.path.basename(found_file)))

        print()


# Executable Code
if __name__ == "__main__":
    get_working_dir()
    check_backup_dir()
    check_invoices()