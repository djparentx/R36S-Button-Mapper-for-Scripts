# R36S Button Mapper for Scripts

v1.0 by djparent

A lightweight button mapping tool for the R36S, designed for ArkOS and dArkOS, providing a simple, controller-friendly interface to modify A/B behavior and enable B-as-Back functionality across scripts.

---

## Overview

This script simplifies button behavior customization on the R36S by modifying the `keys.gptk` configuration used by gptokeyb.

It allows users to quickly toggle common usability improvements such as swapping A/B buttons or enabling the B button as a back action in menus and scripts.

---

## Features

- B button can function as Back (ESC)
- Toggle A/B button swap
- Restore original button configuration at any time
- Automatic backup of original config on first run
- Safe toggle system using flag files
- Fully controller-driven interface
- Uses dialog-based UI
- Lightweight and fast execution
- Compatible with existing gptokeyb setups

---

## Button Modes

### B for Back

- Maps B → ESC (back)
- Maps A → ENTER (confirm)
- Improves navigation consistency in scripts

---

### Switch A/B

- Swaps A and B button behavior
- Useful for users preferring alternate layouts

---

### Combined Modes

- Handles interaction between both toggles safely
- Maintains correct mappings when both features are enabled

---

## How It Works

### Configuration File

The script modifies:

/opt/inttools/keys.gptk

This file is used by gptokeyb to translate controller input into keyboard actions.

---

### Backup System

- On first modification, creates:

/opt/inttools/keys.gptk.bak

- Additional temporary backups are created when combining modes:

/opt/inttools/keys.gptk.bbak  
/opt/inttools/keys.gptk.switchbak  

---

### Flag System

State is tracked using:

/var/cache/B_for_Back  
/var/cache/Switch_AB  

These determine which modes are currently active.

---

### Input Handling

- Uses gptokeyb for controller input
- Automatically restarts input handler when needed
- Ensures compatibility with dialog menus

---

## Menu Options

- Enable/Disable B for Back
- Enable/Disable A/B Switch
- Restore original configuration
- Exit

---

## Installation

1. Copy the script to your R36S Tools folder

2. Run it

Root privileges will be granted automatically if needed.

---

## Requirements

- R36S running ArkOS or dArkOS  

Required tools:

- dialog  
- gptokeyb  
- setfont  

---

## File Locations

Main config:

/opt/inttools/keys.gptk  

Backup files:

/opt/inttools/keys.gptk.bak  
/opt/inttools/keys.gptk.bbak  
/opt/inttools/keys.gptk.switchbak  

Flags:

/var/cache/B_for_Back  
/var/cache/Switch_AB  

---

## Notes

- Safe to re-run multiple times  
- Does not overwrite original config without backup  
- Designed specifically for R36S input system  
- Changes apply system-wide to scripts using gptokeyb  

---

## Credits

- Created by djparent  

---
