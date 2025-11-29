#!/bin/bash
# Generate TypeScript type definitions for .NET BCL
# This script assumes tsbindgen is a sibling directory: ../tsbindgen

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTNET_DIR="$(dirname "$SCRIPT_DIR")"
TSBINDGEN_DIR="$DOTNET_DIR/../tsbindgen"
TSBINDGEN_CSPROJ="$TSBINDGEN_DIR/src/tsbindgen/tsbindgen.csproj"

# .NET runtime path (adjust version as needed)
DOTNET_VERSION="10.0.0-rc.1.25451.107"
DOTNET_RUNTIME="$HOME/dotnet/shared/Microsoft.NETCore.App/$DOTNET_VERSION"

# Verify tsbindgen exists
if [ ! -f "$TSBINDGEN_CSPROJ" ]; then
    echo "Error: tsbindgen not found at $TSBINDGEN_CSPROJ"
    echo "Expected directory structure:"
    echo "  parent/"
    echo "    tsbindgen/   <- tsbindgen repo"
    echo "    dotnet/      <- this repo"
    exit 1
fi

# Verify .NET runtime exists
if [ ! -d "$DOTNET_RUNTIME" ]; then
    echo "Error: .NET runtime not found at $DOTNET_RUNTIME"
    echo "Please install .NET $DOTNET_VERSION or update DOTNET_VERSION in this script"
    exit 1
fi

echo "Generating TypeScript definitions..."
echo "  Source: $DOTNET_RUNTIME"
echo "  Output: $DOTNET_DIR"
echo "  Tool:   $TSBINDGEN_CSPROJ"
echo ""

# Run tsbindgen with JS naming conventions (camelCase)
dotnet run --project "$TSBINDGEN_CSPROJ" -- generate \
    -d "$DOTNET_RUNTIME" \
    -o "$DOTNET_DIR" \
    --method-names camelCase \
    --property-names camelCase

echo ""
echo "Generation complete!"
