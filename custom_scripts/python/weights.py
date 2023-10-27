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
invoice_list = []
net_weights = []
gross_weights = []

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
    found_files = []
    not_found_files = []
    print ("Enter a column of invoice numbers. Press [ENTER] when finished: ")
    while True:
        line = input()
        if line == "":
            break
        invoices.append(line)

    
    print("Checking invoices...")

    for i in invoices:
        file_check = glob.glob(working_dir + "/*" + i + "*.pdf")

        if not file_check:
            not_found_files.append(i)

        if file_check:
            found_files.append(file_check[0])

    if len(not_found_files) > 0:
        print(cf.red("The following invoices were not found. Please check your data and try again."))
        for i in not_found_files:
            print(i)
        return 1
    
    for i in found_files:
        print(cf.green("Found!"), end=" ")
        print(cf.gray(os.path.basename(i)))
        shutil.copy(i, working_dir + "/" + "backup")

    print()

def get_weights(weight_type):
    """
    Get weights and format them to floating point numbers with two decimal places.
    Use this function to assign global variables `net_weights` and `gross_weights`.
    """

    weights = []

    print("Enter a column of " + cf.cyan(weight_type) + " weights. Press [ENTER] when finished: ")
    while True:
        line = input()
        if line == "":
            break
        line = "{:.2f}".format(float(line))
        weights.append(line)
    return weights
    

# Executable Code
if __name__ == "__main__":
    # get_working_dir()
    # check_backup_dir()
    # check_invoices()
    net_weights = get_weights("net")
    gross_weights = get_weights("gross")