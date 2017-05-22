# Preside Extension: Basic CRM functionality

This is an extension for [Preside](https://www.preside.org) that adds basic CRM functionality.
It adds objects to manage organisations, persons, contacts along with various lookup types, statuses, etc.

## Installation

Install the extension to your application via either of the methods detailed below (Git submodule / CommandBox) and then enable the extension by opening up the Preside developer console and entering:

    extension enable preside-ext-crm
    reload all

### Git Submodule method

From the root of your application, type the following command:

    git submodule add https://github.com/pixl8/preside-ext-crm.git application/extensions/preside-ext-crm

### CommandBox (box.json) method

From the root of your application, type the following command:

    box install preside-ext-crm

## Contribution

We are happy to receive pull requests. Any feedback is appreciated as well. See you on Slack!