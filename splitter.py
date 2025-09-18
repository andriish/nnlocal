import sys
import os

BREAK_CHARS = set(" \t+-/(),=")


SRC_DIR = "src"
MAX_LENGTH = 132

def has_long_line(filepath):
    try:
        with open(filepath, 'r', errors='ignore') as f:
            for line in f:
                if len(line.rstrip('\n')) > MAX_LENGTH:
                    return True
    except Exception as e:
        print(f"Could not read {filepath}: {e}")
    return False

def llist():
    a=[]
    for root, _, files in os.walk(SRC_DIR):
        for file in files:
            full_path = os.path.join(root, file)
            if has_long_line(full_path):
                a.append(full_path)
    return a

def find_split_index(line, max_len):
    if len(line) <= max_len:
        return len(line)
    for i in range(max_len, 0, -1):
        if line[i - 1] in BREAK_CHARS:
            return i
    return max_len

def process_line(line):
    chunks = []
    first_chunk_len = 132
    other_chunk_len = 120

    line = line.rstrip()
    remaining = line

    split_idx = find_split_index(remaining, first_chunk_len)
    chunks.append(remaining[:split_idx])
    remaining = remaining[split_idx:]

    while remaining:
        split_idx = find_split_index(remaining, other_chunk_len)
        chunk = remaining[:split_idx]
        chunks.append("     &" + chunk)
        remaining = remaining[split_idx:]

    return chunks


def change(filename):
    new=[]
    try:
        with open(filename, 'r') as f:
            for line in f:
                if len(line.rstrip()) <= 132 or line.lstrip().startswith(("C", "c", "!")):
                    new.append(line.rstrip('\n'))
                else:
                    for chunk in process_line(line):
                        new.append(chunk)
    except FileNotFoundError:
        print(f"Error: File '{filename}' not found.")
        sys.exit(1)
    with open(filename, "w") as file:
      for line in new:
        file.write(line + "\n")
    
def main():
    for a in llist():
      change(a)



if __name__ == "__main__":
    print(llist())
    main()
