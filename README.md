# Overview

I will create a program using the Erlang language that will have multiple functions that demonstrate the following:

* Display output to the screen using format
* Pattern Matching in function 
* Recursion
* Guards 
* Lists 
* Using lambda functions with lists:map, lists:filter, or lists:foldl

My goal is to create a functional program by writing code with higher quality due to the strictness of the language. 

* A mochiweb performs with lots of open connections. I will show how to build a comet application using mochiweb, where each mochiweb connection is registered with a router which dispatches messages to various users. I will end up with a working application that can cope with a million concurrent connections, and crucially, knowing how much RAM we need to make it work.

*   In part one:

    * Build a basic comet mochiweb app that sends clients a message every 10 seconds 
    * Tune the Linux kernel to handle lots of TCP connections
    * Build a flood-testing tool to open lots of connections
    * Examine how much memory this requires per connection

[Software Demo Video](http://youtube.link.goes.here)

# Development Environment

* Visual Studio Code 
* Erlang

# Useful Websites

* [A Million-user Comet Application with Mochiweb, Part 1]("https://www.metabrew.com/article/a-million-user-comet-application-with-mochiweb-part-1")
* [What is a Transmission Control Protocol TCP/IP Model?]("https://www.fortinet.com/resources/cyberglossary/tcp-ip")
* [Web Site Name](http://url.link.goes.here)
* [Web Site Name](http://url.link.goes.here)

# Future Work

* Create separate servers under one supervisor so that if one crashes, it doesn't effect the other servers
* Debug and make sure it runs properly
* Add to code 
* Research 