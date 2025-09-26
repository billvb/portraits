import sys
import json

if __name__ == '__main__':
    lines = [l.strip() for l in open(sys.argv[1]).readlines() if l.strip() and "referrer" in l]
    lines = [l[l.index("{"):] for l in lines]
    entries = [json.loads(l.replace('""', '"')) for l in lines]
    print("\n".join([json.dumps(e, indent=2) for e in entries]))

