# Spec Delta

## Purpose

Defines what `mise bootstrap` provisions on a machine beyond dotfile links and packages, such as separately versioned config repos.

## ADDED Requirements

### Requirement: Neovim config cloned from its own repo
Bootstrap SHALL clone the user's kickstart.nvim fork to `~/.config/nvim` when absent, and SHALL NOT overwrite an existing checkout.

#### Scenario: Fresh machine
- **WHEN** `mise bootstrap` runs and `~/.config/nvim` does not exist
- **THEN** the fork is cloned there with its git history, so upstream kickstart can be merged later

#### Scenario: Existing checkout
- **WHEN** `~/.config/nvim` already exists
- **THEN** bootstrap leaves it untouched
