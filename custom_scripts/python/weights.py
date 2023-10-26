#!/usr/bin/env python3
"""Fill me with good documentation later."""

import colorful as cf
import glob
import os
# import pathlib
# import re
import shutil

# Global Variables


# Functions
def make_backup():
    """ Creates a backup of all PDF files in the current directory. """

    if not os.path.exists("backup"):
        print("Creating backup directory.")
        os.mkdir("backup")

    # if glob.glob("*.pdf"):
    #     print("Copying to ./backup:")

    # for file in os.listdir("."):
    #     if file.endswith(".pdf"):
    #         print(file)
    #         shutil.copy(file, "backup")

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

# Executable Code
if __name__ == "__main__":
    # make_backup()
    check_invoices()
