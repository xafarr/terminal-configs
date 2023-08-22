#!/usr/bin/env python

import sys
import os
import subprocess


def get_host_icon(url):
    icon = " "
    if "github.com" in url:
        icon = " "
    elif "gitlab.com" in url:
        icon = " "
    elif "bitbucket.com" in url:
        icon = " "
    elif any([host in url for host in ["azure.com", "visualstudio.com"]]):
        icon = "󰿕 "
    elif "git" in url:
        icon = " "
    return icon


def is_git_repo(path="."):
    return os.path.isdir(os.path.join(path, ".git"))


def main():
    path = sys.argv[1]
    if is_git_repo(path):
        try:
            url = subprocess.check_output(
                ["git", "-C", path, "ls-remote", "--get-url"], stderr=subprocess.DEVNULL
            )
            url = url.decode("utf-8")
        except subprocess.CalledProcessError:
            url = ""
        print(get_host_icon(url))
    else:
        print("Error")


if __name__ == "__main__":
    main()
