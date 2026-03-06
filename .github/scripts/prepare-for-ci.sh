#!/bin/bash
# Script to prepare project for CI

echo "Checking project structure..."

# Create package-lock.json if missing
if [ -f "package.json" ] && [ ! -f "package-lock.json" ] && [ ! -f "yarn.lock" ] && [ ! -f "pnpm-lock.yaml" ]; then
    echo "No lock file found. Creating package-lock.json..."
    npm install --package-lock-only
fi

# Check Android setup
if [ ! -f "./gradlew" ] && [ -d "android" ]; then
    echo "Android directory found but no gradlew..."
    if [ -f "android/gradlew" ]; then
        echo "Using android/gradlew"
    fi
fi

# Check for required files
if [ ! -f "app/build.gradle" ] && [ ! -f "android/app/build.gradle" ]; then
    echo "Warning: No Android build.gradle found"
fi