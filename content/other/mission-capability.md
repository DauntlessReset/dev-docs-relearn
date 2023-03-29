---
title: Mission Capability (MC) App
description: A brief overview of the Mission Capability App in development
---

### Purpose

The Mission Capability application is a web application being developed by the team to allow soldiers in the field to easily complete vehicle capability assessments from a mobile device accessing a web page. The assessment is based on four key components:

- Lethality: The offensive ability of the vehicle (main and secondary armament).
- Mobility: The ability of the vehicle to traverse terrain as described in its specification.
- Survivability: The ability of the vehicle to withstand attack and protect crew and other occupants using both passive (e.g. armour) and active defence systems, as well as recovery systems such as the winch. 
- Connectivity: The ability of the vehicle to communicate with the outside world using onboard comms. 

Each subsystem can be classified as Capable, Incomplete, or Not Capable (using a traffic light system). A capability will be classed as Not Capable if a critical subsystem in that capability is not functional, or a number of non-critical subsystems under within that capability are not functional (based on a points system). 

As an example - a vehicle may still be mobile despite having some damage to a non-essential mobility subsystem, but a non-functional engine will mean a vehicle is complete immobile. 

A vehicle may also be considered to be operational by training standards, but not by battle standards (e.g. if a main turret is not working a vehicle may still be useful for driver training while awaiting repairs).

### Vehicles

This app was initially designed based around the Boxer platform only, but has since been expanded to include the Hawkei (both four door and two door variants).

The app was designed so that future onboarding of new and existing vehicle platforms will be relatively easy. 

### Technologies

The production version of the Mission Capability app is built using Python, Flask, SQLAlchemy and IBM DB2 (replaced from SQLite in the Dev version) for the API. 

The front end is built using React/Typescript, with SCSS for styling. Javascript XML (JSX) is also used. 

Mock-ups of new pages or changes to the existing design are built using figma. 

### Current State

Various bugfixes are underway currently. In the future, a list view will be implemented for greater usability on smaller screens, and more vehicle will be onboarded. 