# Copyright (c) 2020-2021 SUSE LLC
# Licensed under the terms of the MIT license.
#
#  1) bootstrap a new Ubuntu minion via salt-ssh
#  2) subscribe it to a base channel for testing

@ubuntu1804_ssh_minion
Feature: Bootstrap a Ubuntu 18.04 Salt SSH Minion

  Scenario: Clean up sumaform leftovers on a 18.04 Salt SSH Minion
    When I perform a full salt minion cleanup on "ubuntu1804_ssh_minion"

  Scenario: Bootstrap a SSH-managed Ubuntu 18.04 minion
    Given I am authorized
    When I go to the bootstrapping page
    Then I should see a "Bootstrap Minions" text
    When I enter the hostname of "ubuntu1804_ssh_minion" as "hostname"
    And I enter "root" as "user"
    And I enter "linux" as "password"
    And I enter "22" as "port"
    And I select "1-ubuntu1804_ssh_minion_key" from "activationKeys"
    And I select the hostname of "proxy" from "proxies"
    And I check "manageWithSSH"
    And I click on "Bootstrap"
    Then I wait until I see "Successfully bootstrapped host!" text
    And I wait until onboarding is completed for "ubuntu1804_ssh_minion"

  # WORKAROUND bsc#1181847
  Scenario: Import the GPG keys for 18.04 Salt SSH Minion
    When I import the GPG keys for "ubuntu1804_ssh_minion"

  Scenario: Check events history for failures on SSH-managed Ubuntu 18.04 minion
    Given I am on the Systems overview page of this "ubuntu1804_ssh_minion"
    Then I check for failed events on history event page