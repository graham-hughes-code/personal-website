---
title: "Why You Need Cookiecutter Project Templates In Your Life"
description: "Cookiecutter is a cli tool that make creating new projects easy."
date: 2022-10-24T19:36:07-04:00
tags: ["software engineering", "python", "productivity"]
---

The creation or copying of dockerfiles, Infrastructure-as-a-code, CICD, tests, lint, and other configuration files can take a good chunk of time when starting a new project. This can be very tedious at best and error prone at worst. Cookiecutter is a CLI templating tool that makes this part of starting a project fast, easy, and repeatable. This repeatedly allows for projects to start from a standard that your team has agreed upon. The benefit of speed is that you get to coding much faster. Not wasting time and energy on boilerplate.

## Basic usage

To use Cookiecutter you will need to have python3 and pip installed.
After that installing Cookiecutter is as easy as:
``` bash
pip install --user cookiecutter
```

Cookiecutter can use a Git repository, a folder or a Zip file as its template source.
``` bash
cookiecutter https://github.com/cookiecutter/sometemplate
```

There are a bunch of template available under the github topic [#cookiecutter-template](https://github.com/topics/cookiecutter-template). 

Once cookiecutter is done downloading your template it will ask for some input.
``` bash
full_name [Audrey Roy Greenfeld]: Graham Hughes
email [audreyr@example.com]: example@example.com
github_username [audreyr]: graham-hughes-code
project_name [Python Boilerplate]: Example Project
project_slug [example_project]:
project_short_description [Python Boilerplate contains all the boilerplate you need to create a Python package.]: Short decription
pypi_username [graham-hughes-code]: Example
version [0.1.0]:
use_pytest [n]: y
use_black [n]: n
use_pypi_deployment_with_travis [y]: n
add_pyup_badge [n]: n
Select command_line_interface:
1 - Click
2 - Argparse
3 - No command-line interface
Choose from 1, 2, 3 [1]: 3
create_author_file [y]: n
Select open_source_license:
1 - MIT license
2 - BSD license
3 - ISC license
4 - Apache Software License 2.0
5 - GNU General Public License v3
6 - Not open source
Choose from 1, 2, 3, 4, 5, 6 [1]: 1
```
Example above from https://github.com/audreyfeldroy/cookiecutter-pypackage Audrey Roy Greenfeld is the creator of Cookiecutter.

After running this is what the project should look like:
``` bash
.
├── CONTRIBUTING.rst
├── docs
│   ├── conf.py
│   ├── contributing.rst
│   ├── history.rst
│   ├── index.rst
│   ├── installation.rst
│   ├── make.bat
│   ├── Makefile
│   ├── readme.rst
│   └── usage.rst
├── example_project
│   ├── example_project.py
│   └── __init__.py
├── HISTORY.rst
├── LICENSE
├── Makefile
├── MANIFEST.in
├── README.rst
├── requirements_dev.txt
├── setup.cfg
├── setup.py
├── tests
│   ├── __init__.py
│   └── test_example_project.py
└── tox.ini

3 directories, 23 files
```

## Making your own template

Where the real power of CookieCutter comes through is when you create your own template. A very basic template repo consists of a cookiecutter.json file which is used to set the parameters that you are asked when generating the project. A folder named  ‘{{ cookiecutter.project_name }}’ or cookiecutter dot another name of a parameter in your cookiecutter.json. This folder should contain files that you wish to include in your template. As you might have noticed that the folder name is very interesting this is because Cookiecutter is using Jinja2 templating engine under the hood. If your Familiar with Django templating engine Jinja2 will be very easy to pick up because of its similarity. I recommend checking out [Jinja2 documentation](https://jinja.palletsprojects.com/en/3.1.x/) if you are planning to create your own template. 
Generally you end up using Jinja2 in two ways, changing names with Jinja2 parmenter's surrounded with two curly brackets and using curly bracket percent with if statements for sections you conditionally want to include.
``` python
# Example of name replacement:
setup(
  name="{{cookiecutter.project_slug}}",
  tests_require=['pytest', 'flake8'],
  setup_requires=['pytest-runner'],
  packages=(find_packages()),
  install_requires=REQUIRES,
  include_package_data=True)

# Example of conditionally including line of file:
{%- if cookiecutter.project_type == 'lambda' %}
import boto3
{%- endif %}
import logging
import json

# Example of adding year to Copyright automatically:
# Copyright (c) {% now 'local', '%Y' %} Your Company All Rights Reserved.
```
Optionally you can include a hooks folder which can include two python scripts a pre_gen_project.py and a post_gen_project.py. These scripts are called before project generation and after generation respectively. A couple ways I found the post_gen_project.py script usefully was adding git submodules to the given project. 

## Conclusion

Even though I have just implemented a custom Cookiecutter template for my current position, I have already reaped the time saving benefit from starting a new project using the template. I expect this time saving benefit to increase over time. Although Cookiecutter is great at keeping project standards from the creation of a repo, it does not help in the case of exciting repos that have drifted away from the standards or where created with old standards. Thank you for reading this small introduction to Cookiecutter. 
