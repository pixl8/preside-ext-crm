# Preside Extension: Basic CRM functionality

This is an extension for [Preside](https://www.preside.org) that adds basic CRM functionality.
It adds objects to manage organisations and persons along with various lookup types, statuses, etc.
As of version 2.0.0 of this extension, Preside 10.10 is required because it makes use of the new data manager features that have been introduced recently.

## Installation

From the root of your application, type the following command:

    box install preside-ext-crm

## Upgrade / Permissions

If you upgrade from an earlier version please make sure that your user roles include the new `presideobject.person.*` and `presideobject.organisation.*` permissions instead of the now _retired_ `personmanager.*` and `organisationmanager.*` permissions.

## Contribution

We are happy to receive pull requests. Any feedback is appreciated as well. See you on Slack!