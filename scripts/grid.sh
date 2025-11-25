#!/bin/bash

# Default values
GRID_SPACING=50
LINE_COLOR="red"
LINE_WIDTH=1

usage() {
    echo "Usage: $0 -i input.jpg -o output.jpg [-s spacing] [-c color] [-w width]"
    echo "  -i: Input image file (required)"
    echo "  -o: Output image file (required)"
    echo "  -s: Grid spacing in pixels (default: 50)"
    echo "  -c: Line color (default: red)"
    echo "  -w: Line width (default: 1)"
    exit 1
}

# Parse arguments
while getopts "i:o:s:c:w:h" opt; do
    case $opt in
        i) INPUT="$OPTARG" ;;
        o) OUTPUT="$OPTARG" ;;
        s) GRID_SPACING="$OPTARG" ;;
        c) LINE_COLOR="$OPTARG" ;;
        w) LINE_WIDTH="$OPTARG" ;;
        h) usage ;;
        *) usage ;;
    esac
done

# Check required arguments
if [[ -z "$INPUT" || -z "$OUTPUT" ]]; then
    usage
fi

if [[ ! -f "$INPUT" ]]; then
    echo "Error: Input file '$INPUT' not found"
    exit 1
fi

# Get image dimensions
WIDTH=$(identify -format %w "$INPUT")
HEIGHT=$(identify -format %h "$INPUT")

# Build draw commands
DRAW_CMDS=""
for ((x=0; x<=WIDTH; x+=GRID_SPACING)); do
    DRAW_CMDS="$DRAW_CMDS -draw \"line $x,0 $x,$HEIGHT\""
done
for ((y=0; y<=HEIGHT; y+=GRID_SPACING)); do
    DRAW_CMDS="$DRAW_CMDS -draw \"line 0,$y $WIDTH,$y\""
done

# Apply grid
eval convert \"$INPUT\" -stroke \"$LINE_COLOR\" -strokewidth $LINE_WIDTH $DRAW_CMDS \"$OUTPUT\"

echo "Grid applied: $OUTPUT"