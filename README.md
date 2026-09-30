# Brainrot Duel System

Engage in thrilling brainrot duels with friends in FiveM.

## Features

- Players can challenge each other to duels
- Duel outcomes are determined randomly
- Players receive a brainrot reward for winning a duel

## Requirements

- FiveM server
- ESX Framework
- MySQL database

## Installation

1. Download the script from the [releases page](https://github.com/EnderDevelopment/brainrot-duel-system/releases).
2. Extract the files into your FiveM server's `resources` directory.
3. Import the `database.sql` file into your MySQL database.
4. Add `start brainrotduel` to your server.cfg file.

## Usage

- Players can start a duel by using the `/duel` command followed by the player ID of the target player.
- The duel will start after a short animation and the outcome will be determined randomly.
- The winner will receive a brainrot reward.

## Configuration

The script can be configured by editing the `config.lua` file. The following options are available:

- `DuelCooldown`: The cooldown in seconds between duels.
- `DuelCost`: The cost to start a duel.
- `BrainrotReward`: The reward for winning a duel.

---

## Generated with EnderDevelopment

This plugin was generated in minutes with [EnderDevelopment](https://enderdevelopment.com) — the AI platform that turns your ideas into working Minecraft plugins, Discord bots and FiveM scripts.

**Want your own?** [Generate this project on EnderDevelopment](https://dash.enderdevelopment.com?utm_source=github&utm_medium=readme&utm_campaign=brainrot-duel-system&utm_content=bottom) — describe it in one sentence and get the full source code.

