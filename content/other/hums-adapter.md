---
title: HUMS Adapter
description: A description of the HUMS adapter purpose and structure
---

## HUMS enabled Equipment 

Health and Usage Monitoring Systems (HUMS) is a generic term given to data collection and analysis activities that are used to help ensure the availability, reliability and safety of vehicles. 

A number of vehicle fleets (e.g M113, some tanks and G-wagons - soon Bushmasters) are equipped with sensors that feed into the CAN bus (Controller Area Network). A HUMS device sits in front of the CAN bus, duplicating the information required from the data stream. Data measured may relate to oil viscosity, vibration, measured speed and so on. This is telemetry data (telemetry means to measure at a distance).

The mobile network is used to offload data from vehicles (when in range). If not in range the data packets will queue onboard the vehicle, and will release when a connection is made. The use of the mobile network has to be taken into account regarding OPSEC - e.g. vehicles deployed overseas are stripped of the telemetry computer. 

This data, coming from many varied IP addresses due to the many vehicles and the nature of the mobile network, is sent to an IBM cloud server that is not hosted by Defence (this is in some ways a great benefit, as once data enters the Defence network it can be very tricky to get it back out again for any purpose). The primary purpose of this middle-man is to consolidate all the incoming information from vehicles into a single entity and IP address to facilitate ingress to the Defence network. Secondary functions are certificate management and some minor data processing. 

## Certificate Management

A certificate on the middle-man device acts as a private Certificate Authority (CA). Certificates can be generated for the vehicles and loaded onto them. When a vehicle (client) is making contact with the server it must produce a valid certificate, and so must the server - mutual TLS. 

## Definitions

Edge computing is an emerging computing paradigm which refers to a range of networks and devices at or near the user. Edge is about processing data closer to where it's generated - an example of this would be a HUMS device on a vehicle performing data processing before sending the information to the server. 

### Java Key Store (JKS) 

The Nexus-Bridge uses a Java Key Store to store certificates. 

### Active MQ

An open source message broken written in Java. A message broker is a program that translates a message from the formal messaging protocol of the sender to the formal messaging protocol of the receiver. 
### GTFS

General Transit Feed Specification (GTFS). A GTFS feed is composed of a series of text files collected into a ZIP file. 

#### Other notes

boolean flag changed to revoked: true:

nexus bridge prod and non prod 

nexus-bridge-non-prod-cluster

SOA -Backbone 

ssl - tls 

topology 
