=======================
Python project skeleton
=======================

At the moment this repository contains one thing only: reusable Makefile rules
for ``make release`` that I use in all `Python projects I maintain`__.

__ https://projects.gedmin.as

Automating releases is the best thing I've ever done as a maintainer.  I know
that I can take any of my projects and run ::

    make release

and this will help me push a new release to the Python Package Index without
having to remember all the steps.

It's not exactly automation -- more of a checklist that tells me what steps I
need to take, like:

- update version numbers (to strip off the ``.dev0`` suffix)
- update changelog files (to mention the correct version number and release date)
- the full command to build an sdist (and a wheel) and upload to PyPI
- the command to create a git tag
- increment version numbers for the next relase

Some of these steps can be automated with tools like zest.releaser_, so what
usually happens is I do ::

    make release
    prerelease   # zest.releaser's command to remove .dev and update changelog
    make release
    # copy/paste the sdist/bdist/twine upload step and git tag command
    postrelease  # zest.releaser's command to increment version, update
                 # changelog for the next version, and git push

I'm not currently using zest.releaser's ``release`` or ``fullrelease`` commands
because my makefiles do a bit more for my peace of mind:

- check that I git pulled the latest merges from GitHub (I have forgotten
  this step after merging PRs via GitHub's web interface!)
- check that the test suite passes for all supported Python versions
- check that MANIFEST.in is correct (this Makefile rule predates
  check-manifest_, which I should be using instead)
- check that long_description in setup.py is valid ReStructuredText
  (this predates ``twine check``, which I should be using instead)

Besides, some of my packages use historical changelog filenames/date formats
that zest.releaser doesn't (currently) support.

The shared makefile also implements a ``make help``, generated from comments
in the project Makefile, inspired by `Self-Documented Makefile
<https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html>`_.

.. _check-manifest: https://pypi.python.org/pypi/check-manifest
.. _zest.releaser: https://pypi.python.org/pypi/zest.releaser
