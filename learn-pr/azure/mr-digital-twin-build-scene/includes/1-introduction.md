In this Module, you will learn how to build a Scene in Unity.  A Scene is like a canvas where you will set up an experience for your end user.  Typically, these experiences start with broader data sets and supporting information to provide context in your immersive experience.  In your wind farm use case, you will explore the use of two types of geographical scene data:

- Static terrain
- Dynamic terrain

Static terrain is loaded into the Scene once and is loaded at build time.  It isn't updated unless the source file is updated and the Scene is refreshed.  In contrast, dynamic terrain is loaded into Scene on demand at run time.  Both static and dynamic terrains are valuable, depending on the needs of the use case.  Static terrain is useful for disconnected experiences, or experiences where bandwidth concerns are present, or where data consistency is important (that is, the static terrain never changes).  Dynamic terrain is most useful when used to ingest data that morphs or is updated, or when a developer doesn't have access to static data and would like to use a mapping service.

In this module, you'll load terrain data from a static source and then replace it with satellite imagery from the Bing Maps service via Maps SDK.  You'll use this dynamic image basemap to locate and interact with your wind turbines and associated operations data.

## Learning objectives

In this module, you'll learn how to:
- Create a 3D scene in Unity using static terrain data
- Create a dynamic 3D scene in Unity using Microsoft’s Maps SDK

## Prerequisites

- Introduction to Mixed Reality, Azure Digital Twin, and Unity Module
- Fundamental understanding of raster data / imagery
- Awareness of the Microsoft Maps SDK
- Bing Maps Account and Dev Key
