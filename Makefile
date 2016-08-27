# Makefile for commandline compilation of iOS project timemachine

BUILD=xcodebuild
SCHEME=timemachine
PROJECT=timemachine.xcodeproj
SRCDIR=timemachine
SRC=	$(SRCDIR)/ViewController.swift \
	$(SRCDIR)/AppDelegate.swift \
	$(SRCDIR)/DestinationViewController.swift \
	$(SRCDIR)/Moment.swift \
	$(SRCDIR)/Time.swift
DESTINATION= 'platform=iOS Simulator,name=iPhone 6,OS=10.0'
XCPRETTY=xcpretty
XCPRETTYFLAGS= --no-color
BUILDARGS= -project $(PROJECT) -scheme $(SCHEME) -destination $(DESTINATION) | $(XCPRETTY) $(XCPRETTYFLAGS)

TESTDIR=timemachineTests
TESTSRC=$(TESTDIR)/timemachineTests.swift

timemachine : $(SRC)
	$(BUILD) $(BUILDARGS)

test : $(TESTSRC) $(SRC)
	$(BUILD) test $(BUILDARGS)

clean :
	$(BUILD) clean $(BUILDARGS)

# this command won't return
# in emacs halt with C-c C-k
run :
	ios-sim launch --devicetypeid "iPhone-6, 10.0" /Users/mannd/Library/Developer/Xcode/DerivedData/timemachine-avursipbudhdchabfgotlxvkmpjt/Build/Products/Debug-iphonesimulator/timemachine.app

